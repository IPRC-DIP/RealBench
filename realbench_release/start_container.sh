#!/bin/bash
# 单 task 模拟 run.sh stage1，或进交互式容器调试
#
# 用法:
#   bash start_container.sh <task_dir>              # 跑单 task（与 run.sh stage1 同款 claude-trace 命令），输出到终端
#   bash start_container.sh <task_dir> --save       # 同上，但 stdout→run.traj.json stderr→run.traj.stderr（与 run.sh 一致）
#   bash start_container.sh -i [task_dir]           # 交互式 bash（调试），可选挂 task_dir 为 /workspace
#   bash start_container.sh -i                      # 交互式 bash，不挂 workspace
#
# 例:
#   bash start_container.sh ./workdir/aes_sbox
#   bash start_container.sh ./workdir/aes_sbox --save
#   bash start_container.sh -i ./workdir/aes_sbox
#
# 注意: 不要挂 RealBench 仓库目录（含 golden RTL 参考答案 .v），会破坏 benchmark 隔离
cd "$(dirname "$0")"

# shellcheck disable=SC1090
[ -f ~/.bashrc ] && source ~/.bashrc || true

# --- 参数解析 ---
INTERACTIVE=0
SAVE=0
TASK_DIR=""
for arg in "$@"; do
    case "$arg" in
        -i|--interactive) INTERACTIVE=1 ;;
        --save) SAVE=1 ;;
        -*) echo "[error] 未知选项: $arg"; exit 1 ;;
        *) [ -z "$TASK_DIR" ] && TASK_DIR="$arg" || { echo "[error] 多余的位置参数: $arg"; exit 1; }
    esac
done

# --- 与 run.sh 一致的路径 ---
NPM_ROOT_GLOBAL="${NPM_ROOT_GLOBAL:-$(npm root -g 2>/dev/null)}"
CLAUDE_CODE_PKG="${CLAUDE_CODE_PKG:-${NPM_ROOT_GLOBAL}/@anthropic-ai}"
CLAUDE_TRACE_PKG="${CLAUDE_TRACE_PKG:-${NPM_ROOT_GLOBAL}/@mariozechner}"
SETTINGS_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/claude-settings.json"
ENTRYPOINT_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/docker-entrypoint.sh"

: "${ANTHROPIC_BASE_URL:?请设置 ANTHROPIC_BASE_URL}"
: "${ANTHROPIC_AUTH_TOKEN:?请设置 ANTHROPIC_AUTH_TOKEN}"
# ANTHROPIC_CUSTOM_HEADERS 可选（仅当端点需要自定义 header 时设置）

# 与 run.sh 一致的默认值（可被 env 覆盖）
CLAUDE_MODEL="${CLAUDE_MODEL:-${ANTHROPIC_MODEL:-claude-sonnet-4-6}}"
MAX_BUDGET_USD="${MAX_BUDGET_USD:-1}"
ANTHROPIC_CUSTOM_HEADERS="${ANTHROPIC_CUSTOM_HEADERS:-}"

# --- 网络 guard：解析 API host 的 IP（去掉端口，避免带端口的 URL 解析失败）---
TOKEN_HOST="$(echo "${ANTHROPIC_BASE_URL}" | sed -E 's#^https?://##; s#[:/].*$##')"
TOKEN_IPS="$(python3 -c 'import socket,sys; host = sys.argv[1]; print(" ".join(sorted({x[4][0] for x in socket.getaddrinfo(host, None, socket.AF_INET)})))' "$TOKEN_HOST" 2>/dev/null || true)"
NETWORK_GUARD_ARGS=""
if [ -n "$TOKEN_IPS" ]; then
    NETWORK_GUARD_ARGS="--add-host ${TOKEN_HOST}:$(echo "$TOKEN_IPS" | awk '{print $1}')"
else
    echo "[warn] 未能解析 $TOKEN_HOST 的 IP，容器内 entrypoint 会再用 getent 试一次"
fi

# --- workspace 挂载 ---
WORKSPACE_MOUNT=()
WORKDIR_OPT=()
if [ -n "$TASK_DIR" ]; then
    [ -d "$TASK_DIR" ] || { echo "[error] task_dir 不存在: $TASK_DIR"; exit 1; }

    # benchmark 隔离守卫：RealBench 仓库含 golden RTL 参考答案（.v），禁止作为 workspace 挂载。
    # 若设置了 REALBENCH_REPO 环境变量，拒绝挂载其下的任何路径。
    TASK_DIR_ABS="$(cd "$TASK_DIR" && pwd)"
    if [ -n "${REALBENCH_REPO:-}" ]; then
        case "$TASK_DIR_ABS" in
            "$REALBENCH_REPO"|"$REALBENCH_REPO"/*)
                echo "[error] 拒绝挂载 RealBench 仓库目录: $TASK_DIR_ABS"
                echo "        该目录含 golden RTL 参考答案（.v），挂载会破坏 benchmark 隔离。"
                echo "        应使用 mk_bench 生成的 task dir（位于 workdir/<module>/）。"
                exit 1
                ;;
        esac
    fi
    # 兜底：若 task_dir 本身含 .v 文件，也拒绝（可能是参考答案目录）
    if find "$TASK_DIR_ABS" -maxdepth 2 -name '*.v' -print -quit | grep -q .; then
        echo "[error] task_dir 含 .v 文件，疑似参考答案目录，拒绝挂载: $TASK_DIR_ABS"
        echo "        task dir 应只含 task.md/Makefile/doc 等，不应有 .v。"
        exit 1
    fi

    WORKSPACE_MOUNT=(-v "$TASK_DIR:/workspace")
    WORKDIR_OPT=(-w /workspace)
fi

# --- 模式判定 ---
if [ "$INTERACTIVE" = "1" ]; then
    MODE="interactive"
    CMD=(bash)
    IT_FLAG=(-it)
elif [ -n "$TASK_DIR" ]; then
    MODE="single-task"
    CMD=(claude-trace --log trace --no-open \
        --claude-path /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js \
        --run-with --settings /claude-settings.json --dangerously-skip-permissions \
        --model "$CLAUDE_MODEL" \
        -p "solve the task in ./task.md" \
        --output-format json \
        --max-budget-usd "$MAX_BUDGET_USD")
    # --save 模式无 -t（输出重定向到文件，不需要 tty）；否则 -it 直连终端看实时输出
    if [ "$SAVE" = "1" ]; then
        IT_FLAG=(-i)
    else
        IT_FLAG=(-it)
    fi
else
    echo "[error] 非交互模式必须传 task_dir: bash start_container.sh <task_dir>"
    echo "        交互调试: bash start_container.sh -i [task_dir]"
    exit 1
fi

echo "[info] mode=$MODE task_dir=${TASK_DIR:-<none>} model=$CLAUDE_MODEL budget=$MAX_BUDGET_USD save=$SAVE"
echo "[info] network guard: host=$TOKEN_HOST ips=${TOKEN_IPS:-<pending>}"
echo "[info] run as: $(id -u):$(id -g) (host UID, 非 root → --dangerously-skip-permissions 可用)"

# --- 启动 ---
if [ "$MODE" = "single-task" ] && [ "$SAVE" = "1" ]; then
    # 与 run.sh stage1 一致：stdout→run.traj.json, stderr→run.traj.stderr
    docker run --rm "${IT_FLAG[@]}" \
        "${WORKSPACE_MOUNT[@]}" \
        -v "$ENTRYPOINT_FILE:/docker-entrypoint.sh:ro" \
        -v "$CLAUDE_CODE_PKG:/usr/local/lib/node_modules/@anthropic-ai:ro" \
        -v "$CLAUDE_TRACE_PKG:/usr/local/lib/node_modules/@mariozechner:ro" \
        -v "$SETTINGS_FILE:/claude-settings.json:ro" \
        "${WORKDIR_OPT[@]}" \
        -e HOME=/tmp \
        -e ANTHROPIC_API_KEY="$ANTHROPIC_AUTH_TOKEN" \
        -e ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_AUTH_TOKEN" \
        -e ANTHROPIC_BASE_URL="$ANTHROPIC_BASE_URL" \
        -e ANTHROPIC_CUSTOM_HEADERS="$ANTHROPIC_CUSTOM_HEADERS" \
        -e ANTHROPIC_MODEL="$ANTHROPIC_MODEL" \
        -e ANTHROPIC_DEFAULT_HAIKU_MODEL="${ANTHROPIC_DEFAULT_HAIKU_MODEL:-$ANTHROPIC_MODEL}" \
        -e ANTHROPIC_DEFAULT_SONNET_MODEL="${ANTHROPIC_DEFAULT_SONNET_MODEL:-$ANTHROPIC_MODEL}" \
        -e ANTHROPIC_DEFAULT_OPUS_MODEL="${ANTHROPIC_DEFAULT_OPUS_MODEL:-$ANTHROPIC_MODEL}" \
        -e CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
        -e NETWORK_ALLOWLIST=1 \
        -e NETWORK_ALLOWED_HOST="$TOKEN_HOST" \
        -e NETWORK_ALLOWED_IPS="$TOKEN_IPS" \
        -e RUN_AS_USER="$(id -u):$(id -g)" \
        --cap-add=NET_ADMIN \
        $NETWORK_GUARD_ARGS \
        claude-runner:latest \
        "${CMD[@]}" \
        > "$TASK_DIR/run.traj.json" \
        2> "$TASK_DIR/run.traj.stderr"
    rc=$?
    echo "[info] docker exit=$rc, stdout→$TASK_DIR/run.traj.json, stderr→$TASK_DIR/run.traj.stderr"
    if [ ! -s "$TASK_DIR/.claude-trace/trace.jsonl" ]; then
        echo "[warn] trace.jsonl 为空，检查 $TASK_DIR/run.traj.stderr 的 API/auth 错误"
    else
        echo "[info] trace.jsonl $(wc -l < "$TASK_DIR/.claude-trace/trace.jsonl") 行"
    fi
    exit $rc
else
    exec docker run --rm "${IT_FLAG[@]}" \
        "${WORKSPACE_MOUNT[@]}" \
        -v "$ENTRYPOINT_FILE:/docker-entrypoint.sh:ro" \
        -v "$CLAUDE_CODE_PKG:/usr/local/lib/node_modules/@anthropic-ai:ro" \
        -v "$CLAUDE_TRACE_PKG:/usr/local/lib/node_modules/@mariozechner:ro" \
        -v "$SETTINGS_FILE:/claude-settings.json:ro" \
        "${WORKDIR_OPT[@]}" \
        -e HOME=/tmp \
        -e ANTHROPIC_API_KEY="$ANTHROPIC_AUTH_TOKEN" \
        -e ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_AUTH_TOKEN" \
        -e ANTHROPIC_BASE_URL="$ANTHROPIC_BASE_URL" \
        -e ANTHROPIC_CUSTOM_HEADERS="$ANTHROPIC_CUSTOM_HEADERS" \
        -e ANTHROPIC_MODEL="$ANTHROPIC_MODEL" \
        -e ANTHROPIC_DEFAULT_HAIKU_MODEL="${ANTHROPIC_DEFAULT_HAIKU_MODEL:-$ANTHROPIC_MODEL}" \
        -e ANTHROPIC_DEFAULT_SONNET_MODEL="${ANTHROPIC_DEFAULT_SONNET_MODEL:-$ANTHROPIC_MODEL}" \
        -e ANTHROPIC_DEFAULT_OPUS_MODEL="${ANTHROPIC_DEFAULT_OPUS_MODEL:-$ANTHROPIC_MODEL}" \
        -e CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
        -e NETWORK_ALLOWLIST=1 \
        -e NETWORK_ALLOWED_HOST="$TOKEN_HOST" \
        -e NETWORK_ALLOWED_IPS="$TOKEN_IPS" \
        -e RUN_AS_USER="$(id -u):$(id -g)" \
        --cap-add=NET_ADMIN \
        $NETWORK_GUARD_ARGS \
        claude-runner:latest \
        "${CMD[@]}"
fi
