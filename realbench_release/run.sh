#!/bin/bash
#
# RTL Generation + Evaluation Pipeline
# ====================================
#
# Usage:  bash run.sh [STAGES]
#   STAGES is a comma-separated list: 0,1,2,3
#   Default: all stages (0,1,2,3)
#
#   Stage 0: mk_bench  — create benchmark task dirs from RealBench
#   Stage 1: run       — run Claude Code on all modules (find | xargs -P)
#   Stage 2: collect   — gather .v files into JSONL
#   Stage 3: evaluate+report — verilator verification + markdown report
#
# Quick start:
#   1. Edit the variables below.
#   2. Run:  bash run.sh
#
set -exo pipefail

# ==============================================================================
# Configuration — change these as needed
# ==============================================================================
STAGES="${1:-0,1,2,3}"

# --- Paths ---
EVAL_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/evaluation.py"
# RealBench 仓库根目录（含 golden RTL 参考答案，仅 stage0 读取，绝不挂进容器）
REALBENCH_REPO="${REALBENCH_REPO:?请设置 REALBENCH_REPO 指向 RealBench 仓库}"
# 允许外部覆盖（多模型批量跑时每个模型用独立 workdir，避免 .v 互相覆盖）
PROJECT_DIR="${PROJECT_DIR:-$(pwd)/workdir}"

# --- Claude Code config ---
# claude-code 的 JS bundle（npm @anthropic-ai/claude-code@2.1.77，cli.js）；
# 必须用 JS 版，claude-trace 才能在 node 进程内 require() 它来插桩 fetch。
# 原生 ELF 二进制无法被 claude-trace 加载。
# 默认从 `npm root -g` 推断，也可显式覆盖。
NPM_ROOT_GLOBAL="${NPM_ROOT_GLOBAL:-$(npm root -g 2>/dev/null)}"
export CLAUDE_CODE_PKG="${CLAUDE_CODE_PKG:-${NPM_ROOT_GLOBAL}/@anthropic-ai}"
export CLAUDE_TRACE_PKG="${CLAUDE_TRACE_PKG:-${NPM_ROOT_GLOBAL}/@mariozechner}"
# 限制 claude code 的 settings（禁用 WebSearch/WebFetch/curl/wget）；deny 规则优先于 bypass
export SETTINGS_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/claude-settings.json"
# 修复版 entrypoint（让 gosu 保留 HOME=/tmp）；bind-mount 覆盖镜像里的旧版，免重建镜像
export ENTRYPOINT_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/docker-entrypoint.sh"
# API 鉴权：标准 Anthropic API 或任意兼容端点
export ANTHROPIC_BASE_URL="${ANTHROPIC_BASE_URL:?请设置 ANTHROPIC_BASE_URL}"
export ANTHROPIC_AUTH_TOKEN="${ANTHROPIC_AUTH_TOKEN:?请设置 ANTHROPIC_AUTH_TOKEN}"
export ANTHROPIC_API_KEY="$ANTHROPIC_AUTH_TOKEN"
# 可选：若端点需要自定义 header（如企业网关的鉴权 header），在此设置；否则留空
export ANTHROPIC_CUSTOM_HEADERS="${ANTHROPIC_CUSTOM_HEADERS:-}"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
MAX_BUDGET_USD="${MAX_BUDGET_USD:-1}"
CLAUDE_WORKERS="${CLAUDE_WORKERS:-4}"
# 允许外部覆盖（多模型批量跑时由 wrapper 注入每个模型名）
CLAUDE_MODEL="${CLAUDE_MODEL:-${ANTHROPIC_MODEL:-claude-sonnet-4-6}}"
# 可选：把子 agent 的 haiku/sonnet/opus 都映射到同一模型（单一模型端点需要）
export ANTHROPIC_DEFAULT_HAIKU_MODEL="${ANTHROPIC_DEFAULT_HAIKU_MODEL:-$CLAUDE_MODEL}"
export ANTHROPIC_DEFAULT_SONNET_MODEL="${ANTHROPIC_DEFAULT_SONNET_MODEL:-$CLAUDE_MODEL}"
export ANTHROPIC_DEFAULT_OPUS_MODEL="${ANTHROPIC_DEFAULT_OPUS_MODEL:-$CLAUDE_MODEL}"

# --- Conda env (for numpy, joblib) ---
CONDA_BASE="${CONDA_BASE:-$(conda info --base 2>/dev/null)}"
CONDA_ENV="${CONDA_ENV:-base}"

# --- Evaluation config ---
SOLUTION_NAME="${SOLUTION_NAME:-${CLAUDE_MODEL}_cc_result}"
VERILATOR_WORKERS="${VERILATOR_WORKERS:-4}"
OUTPUT_DIR="${PROJECT_DIR}/eval_output"

# --- Network guard: only the API host is allowed out ---
# 从 ANTHROPIC_BASE_URL 解析主机名（去掉协议/端口/路径）
TOKEN_HOST="$(echo "${ANTHROPIC_BASE_URL}" | sed -E 's#^https?://##; s#[:/].*$##')"
TOKEN_IPS="$(python3 -c 'import socket,sys; host = sys.argv[1]; print(" ".join(sorted({x[4][0] for x in socket.getaddrinfo(host, None, socket.AF_INET)})))' "$TOKEN_HOST" 2>/dev/null || true)"

if [ -n "$TOKEN_IPS" ]; then
    TOKEN_IP="$(echo "$TOKEN_IPS" | awk '{print $1}')"
    NETWORK_GUARD_ARGS="--add-host ${TOKEN_HOST}:${TOKEN_IP}"
else
    echo "[warn] resolve failed for $TOKEN_HOST on host, resolve in container later"
    TOKEN_IPS=""
    NETWORK_GUARD_ARGS=""
fi
export NETWORK_ALLOWED_HOST="$TOKEN_HOST"
export NETWORK_ALLOWED_IPS="$TOKEN_IPS"
export NETWORK_ALLOWLIST=1
export NETWORK_GUARD_ARGS
# host UID 与容器内 claudeuser(1001) 可能不匹配；用 host UID:GID 跑 gosu，
# 这样容器内进程以 host UID 运行 → 可写 task_dir（属主 host UID），
# 且 claude code 非 root → --dangerously-skip-permissions 可用（root 下被 claude 拒绝）。
# 不挂 ~/.claude.json：API key 走环境变量，claude 自己在 HOME=/tmp 下建配置。
# gosu 对数字 UID（不在 /etc/passwd）会把 HOME 重置成 /，entrypoint 里用 env HOME=… 绕过。
export RUN_AS_USER="$(id -u):$(id -g)"

has_stage() {
    IFS=',' read -ra arr <<< "$STAGES"
    for s in "${arr[@]}"; do [[ "$s" == "$1" ]] && return 0; done
    return 1
}

# ==============================================================================
# Stage 0: mk_bench — create benchmark tasks from RealBench
# ==============================================================================
if has_stage 0; then
    echo "[start] stage 0: mk_bench"
    source "${CONDA_BASE}/bin/activate" "$CONDA_ENV"
    python "$EVAL_SCRIPT" mk_bench \
        --projects-dir "$REALBENCH_REPO" \
        --target "$PROJECT_DIR"
    echo "[end] stage 0: mk_bench"
fi

# ==============================================================================
# Stage 1: run — parallel Claude Code via Docker (isolated per-task)
# ==============================================================================
if has_stage 1; then
    echo "[start] stage 1: run claude code (${CLAUDE_WORKERS} workers)"
    export CLAUDE_MODEL MAX_BUDGET_USD

    find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | \
        xargs -0 -P "$CLAUDE_WORKERS" -I {} bash -c '
            task_dir="$1"
            task_name=$(basename "$task_dir")
            if [ ! -f "$task_dir/run.traj.json" ]; then
                echo "Processing: $task_name"
                docker_cmd_rc=0
                if ! docker run --rm \
                    -v "$task_dir:/workspace" \
                    -v "$ENTRYPOINT_FILE:/docker-entrypoint.sh:ro" \
                    -v "$CLAUDE_CODE_PKG:/usr/local/lib/node_modules/@anthropic-ai:ro" \
                    -v "$CLAUDE_TRACE_PKG:/usr/local/lib/node_modules/@mariozechner:ro" \
                    -v "$SETTINGS_FILE:/claude-settings.json:ro" \
                    -w /workspace \
                    -e HOME=/tmp \
                    -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
                    -e ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_AUTH_TOKEN" \
                    -e ANTHROPIC_BASE_URL="$ANTHROPIC_BASE_URL" \
                    -e ANTHROPIC_CUSTOM_HEADERS="$ANTHROPIC_CUSTOM_HEADERS" \
                    -e ANTHROPIC_MODEL="$ANTHROPIC_MODEL" \
                    -e ANTHROPIC_DEFAULT_HAIKU_MODEL="$ANTHROPIC_DEFAULT_HAIKU_MODEL" \
                    -e ANTHROPIC_DEFAULT_SONNET_MODEL="$ANTHROPIC_DEFAULT_SONNET_MODEL" \
                    -e ANTHROPIC_DEFAULT_OPUS_MODEL="$ANTHROPIC_DEFAULT_OPUS_MODEL" \
                    -e CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1" \
                    -e NETWORK_ALLOWED_IPS \
                    -e NETWORK_ALLOWED_HOST \
                    -e NETWORK_ALLOWLIST \
                    -e RUN_AS_USER \
                    --cap-add=NET_ADMIN \
                    $NETWORK_GUARD_ARGS \
                    claude-runner:latest \
                    claude-trace --log trace --no-open \
                        --claude-path /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js \
                        --run-with --settings /claude-settings.json --dangerously-skip-permissions \
                        --model "$CLAUDE_MODEL" \
                        --effort max \
                        -p "solve the task in ./task.md" \
                        --output-format json \
                        --max-budget-usd "$MAX_BUDGET_USD" \
                        > "$task_dir/run.traj.json" \
                        2> "$task_dir/run.traj.stderr"; then
                    docker_cmd_rc=$?
                fi

                if [ "$docker_cmd_rc" -ne 0 ]; then
                    echo "[run-fail] $task_name docker rc=$docker_cmd_rc"
                    echo "  stderr saved: $task_dir/run.traj.stderr"
                    exit $docker_cmd_rc
                fi

                if [ ! -s "$task_dir/.claude-trace/trace.jsonl" ]; then
                    echo "[run-empty] $task_name trace.jsonl is empty"
                    echo "  check $task_dir/run.traj.stderr for API/auth errors"
                fi
            else
                echo "Skipping: $task_name"
            fi
        ' _ {}

    echo "[end] stage 1: run claude code"
fi

# ==============================================================================
# Stage 2: collect — gather .v files into JSONL
# ==============================================================================
if has_stage 2; then
    echo "[start] stage 2: collect"
    source "${CONDA_BASE}/bin/activate" "$CONDA_ENV"
    python "$EVAL_SCRIPT" collect \
        --source "$PROJECT_DIR" \
        --output-dir "$OUTPUT_DIR" \
        --solution-name "$SOLUTION_NAME"
    echo "[end] stage 2: collect"
fi

# ==============================================================================
# Stage 3: evaluate + report — verilator verification + markdown report
# ==============================================================================
if has_stage 3; then
    echo "[start] stage 3: evaluate + report in docker"
    docker run --rm \
        --network none \
        -e RUN_AS_USER="$(id -u):$(id -g)" \
        -e HOME=/tmp \
        -e SOLUTION_NAME="$SOLUTION_NAME" \
        -e VERILATOR_WORKERS="$VERILATOR_WORKERS" \
        -v "$ENTRYPOINT_FILE:/docker-entrypoint.sh:ro" \
        -v "$EVAL_SCRIPT:/workspace/evaluation.py:ro" \
        -v "$PROJECT_DIR:/workspace/workdir" \
        -v "$REALBENCH_REPO:/workspace/realbench:ro" \
        claude-runner:latest \
        bash -lc '
            set -e

            python3 /workspace/evaluation.py evaluate \
                --output-dir /workspace/workdir/eval_output \
                --solution-name "$SOLUTION_NAME" \
                --bench-repo /workspace/realbench \
                --workers "$VERILATOR_WORKERS"

            python3 /workspace/evaluation.py report \
                --output-dir /workspace/workdir/eval_output \
                --solution-name "$SOLUTION_NAME"
        '
    echo "[end] stage 3: evaluate + report in docker"
fi
