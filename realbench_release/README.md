# RealBench Agent Eval

RTL/Verilog 代码生成 LLM benchmark：在隔离的 Docker 容器中运行 Claude Code（经 `claude-trace` 插桩）对每个模块生成 `.v` 文件，再用 Verilator 验证、汇总成 markdown 报告。

## 目录结构

```
realbench_agent_eval/
├── Dockerfile              # 构建 claude-runner:latest 镜像
├── docker-entrypoint.sh    # 容器 entrypoint：iptables 白名单 + gosu 降权 + claude 软链
├── claude-settings.json    # Claude Code settings（禁 WebSearch/WebFetch/curl/wget）
├── run.sh                  # 全流程 pipeline（stage 0/1/2/3）
├── run_models.sh           # 多模型批量跑 run.sh
├── start_container.sh      # 单 task 调试 / 交互式进容器
└── evaluation.py           # mk_bench / collect / evaluate / report 子命令
```

## 前置条件

### 1. 构建 docker 镜像

```bash
cd realbench_agent_eval
docker build -t claude-runner:latest .
```

镜像基于 `node:20-slim`，源码编译 Verilator 5.030，创建 `claudeuser`(UID 1001)，并装好 `gosu` / `iptables` / `yosys`。entrypoint 已 `chmod +x`。

### 2. Python 环境（stage 0/2/3 用）

`evaluation.py` 依赖 `numpy` / `joblib`。可用 conda 或 venv：

```bash
conda create -n realbench python=3.11 -y
conda activate realbench
pip install numpy joblib
```

或任意已装好这些包的 Python 环境均可。脚本通过 `CONDA_BASE` / `CONDA_ENV` 环境变量定位 conda，未装 conda 时直接用当前 PATH 里的 `python` 也可（需自行保证依赖）。

### 3. API 凭证（环境变量）

支持任意 Anthropic 兼容端点（官方 API、自建网关、第三方代理等）。在 shell 或 `~/.bashrc` 设置：

```bash
export ANTHROPIC_BASE_URL="<your_api_endpoint>"      # 如 https://api.anthropic.com
export ANTHROPIC_AUTH_TOKEN="<your_api_key>"
export ANTHROPIC_MODEL="claude-sonnet-4-6"           # 主模型名
# 可选：若端点需要自定义 header（如网关），在此设置；标准 Anthropic API 无需
# export ANTHROPIC_CUSTOM_HEADERS="x-your-header: value"
# 可选：单一模型端点需把子 agent 的 haiku/sonnet/opus 都映射到同一模型
export ANTHROPIC_DEFAULT_HAIKU_MODEL="$ANTHROPIC_MODEL"
export ANTHROPIC_DEFAULT_SONNET_MODEL="$ANTHROPIC_MODEL"
export ANTHROPIC_DEFAULT_OPUS_MODEL="$ANTHROPIC_MODEL"
```

### 4. claude-code / claude-trace（npm 全局安装）

```bash
npm -g install @anthropic-ai/claude-code@2.1.77   # 必须 JS 版(cli.js)，ELF binary 无法被 claude-trace require
npm -g install @mariozechner/claude-trace          # 1.0.9
```

脚本默认用 `npm root -g` 推断两者的安装路径，也可用 `CLAUDE_CODE_PKG` / `CLAUDE_TRACE_PKG` 显式覆盖。两者以只读 bind-mount 进容器，无需重建镜像即可换 claude-code 版本。

## 隔离设计（重要）

| 路径 | 用途 | 是否可挂为 /workspace |
|------|------|----------------------|
| RealBench 仓库根（`$REALBENCH_REPO`） | 含 **golden RTL 参考答案 (.v)** | **禁止** |
| workdir（`$PROJECT_DIR`，默认 `./workdir`） | `mk_bench` 生成的 task dir（仅 task.md/Makefile/doc） | 允许 |

`start_container.sh` 内置守卫：若设置了 `REALBENCH_REPO`，拒绝挂载其下任何路径；同时兜底检查 task_dir 内是否含 `.v` 文件，疑似参考答案目录则拒绝。`run.sh` 的 stage1 通过 `find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d` 只取 workdir 下的 task dir，天然不会越界。

## 各脚本用法

### `run.sh` — 全流程 pipeline

```bash
bash run.sh [STAGES]    # 默认 0,1,2,3
```

| Stage | 动作 |
|-------|------|
| 0 | `mk_bench` — 从 RealBench 仓库生成 task dir 到 `$PROJECT_DIR` |
| 1 | `run` — `find \| xargs -P $CLAUDE_WORKERS` 并发在每 task_dir 起一个 docker 跑 claude-trace，输出 `run.traj.json` / `run.traj.stderr` / `.claude-trace/trace.jsonl` |
| 2 | `collect` — 汇总各 task 的 `.v` 成 JSONL |
| 3 | `evaluate` + `report` — Verilator 验证 + markdown 报告 |

环境变量覆盖（均可选）：

```bash
REALBENCH_REPO=/path/to/RealBench \
PROJECT_DIR=./workdir \
SOLUTION_NAME=my_model_cc_result \
CLAUDE_MODEL=claude-sonnet-4-6 \
CLAUDE_WORKERS=4 \
VERILATOR_WORKERS=4 \
MAX_BUDGET_USD=1 \
bash run.sh 1     # 只跑 stage 1
```

> `REALBENCH_REPO` 仅 stage 0 需要（读取仓库生成 task dir）；只跑 stage 1/2/3 时可不设。

已存在 `run.traj.json` 的 task 会被跳过（断点续跑）。

### `run_models.sh` — 多模型批量

```bash
bash run_models.sh [STAGES] [MODEL]
# 默认对 DEFAULT_MODELS 列表里的模型各跑一遍全流程
bash run_models.sh 1 "your-model-name"   # 只跑 stage1，指定单模型
```

每个模型用独立 workdir（`./workdir/<sanitized_model>/`）与独立 solution 名，避免 `.v` 互相覆盖；某个模型失败不影响后续。默认模型列表在脚本顶部 `DEFAULT_MODELS` 数组，按需修改。

### `start_container.sh` — 单 task / 交互式调试

```bash
# 单 task 模拟 run.sh stage1（claude-trace 命令完全一致），输出直连终端
bash start_container.sh <task_dir>

# 同上，但 stdout→run.traj.json, stderr→run.traj.stderr（与 run.sh 一致）
bash start_container.sh <task_dir> --save

# 交互式 bash（调试），挂 task_dir 为 /workspace
bash start_container.sh -i <task_dir>

# 交互式 bash，不挂 workspace
bash start_container.sh -i
```

例：

```bash
bash start_container.sh ./workdir/aes_sbox --save
bash start_container.sh -i ./workdir/aes_sbox
```

> ⚠️ 不可传 RealBench 仓库下的路径（含 golden `.v`），守卫会拒绝。

### `docker-entrypoint.sh` — 容器 entrypoint（一般不直接调用）

被 `docker run` 自动调用，做三件事：
1. 建 `/tmp/bin/claude` / `claude-trace` 软链指向 bind-mount 进来的 cli.js
2. 若 `NETWORK_ALLOWLIST=1`：用 `iptables` 把 OUTPUT 默认 DROP，只放行 API host IP（80/443/`$API_PORT`）与 DNS
3. 若 `RUN_AS_USER` 非空且当前是 root：`exec gosu "$RUN_AS_USER" env "HOME=${HOME:-/tmp}" "$@"` 降权到 host UID:GID（数字 UID 不在 /etc/passwd 时 gosu 会把 HOME 重置成 /，用 `env` 显式注入 HOME=/tmp 绕过）

脚本被 bind-mount 覆盖镜像内的版本（`-v $ENTRYPOINT_FILE:/docker-entrypoint.sh:ro`），改完宿主机文件即可生效，**必须 `chmod +x`**。

## 常见调试流程

### 1. 先确认镜像与 API 通

```bash
bash start_container.sh -i ./workdir/aes_sbox
# 容器内：
claude --version
claude-trace --version
# 测网络（应返回 4xx 表示路径错但网络通；000 才是网络不通）
curl -s -o /dev/null -w "%{http_code}\n" \
     -H "Authorization: Bearer $ANTHROPIC_AUTH_TOKEN" \
     "${ANTHROPIC_BASE_URL}"
```

### 2. 单 task 跑一次完整 claude-trace

```bash
bash start_container.sh ./workdir/aes_sbox --save
# 看 trace 是否正常
wc -l ./workdir/aes_sbox/.claude-trace/trace.jsonl
# 看错误
cat ./workdir/aes_sbox/run.traj.stderr
```

### 3. 全量跑

```bash
bash run.sh                 # 全流程
bash run.sh 1               # 只 stage1（已有 workdir 时复用）
bash run_models.sh          # 多模型对比
```

### 4. 删容器内 root 属主文件

容器以 host UID 写文件本应正常，但偶尔 root 残留文件 host 删不掉：

```bash
docker run --rm -v "$(pwd)/workdir:/host" alpine rm -rf /host/<module>
```

## 排错速查

| 现象 | 原因 | 处理 |
|------|------|------|
| `trace.jsonl` 空 / 秒退无输出 | gosu 把 HOME 重置成 /，claude 写不了 `/.claude.json` | entrypoint 用 `env HOME=/tmp`；确认 bind-mount 的是修复版且 `+x` |
| 鉴权 403 / 401 | 端点要求的 header 或 key 缺失 | 确认 `ANTHROPIC_AUTH_TOKEN` / `ANTHROPIC_BASE_URL`；若端点需自定义 header，设 `ANTHROPIC_CUSTOM_HEADERS` |
| `cannot be used with root/sudo` | claude code 拒绝 root 下 `--dangerously-skip-permissions` | 用 `RUN_AS_USER=$(id -u):$(id -g)` 而非 root |
| 子 agent 报 model not found | 端点不认官方 sonnet/haiku 名 | 设 `ANTHROPIC_DEFAULT_{HAIKU,SONNET,OPUS}_MODEL` 映射到端点支持的模型 |
| docker mount 源路径空 | `xargs \| bash -c` 单引号子 shell 看不到未 export 的变量 | `run.sh` 已对 CLAUDE_CODE_PKG/CLAUDE_TRACE_PKG/SETTINGS_FILE/ENTRYPOINT_FILE 加 `export` |
| `permission denied: /docker-entrypoint.sh` | bind-mount 的宿主文件没有 +x | `chmod +x docker-entrypoint.sh` |
| 进容器看到 `.v` 参考答案 | 误把 RealBench 仓库路径当 task_dir | 守卫已拒绝；改用 `workdir/<module>/` |

## 关键约束（一句话总结）

- **隔离**：只挂 workdir 下的 task dir，绝不挂 RealBench 仓库（含 golden `.v`）。
- **降权**：`RUN_AS_USER=$(id -u):$(id -g)` + `HOME=/tmp`，非 root 才能用 `--dangerously-skip-permissions`。
- **API**：标准 Anthropic API 开箱即用；自定义端点按需设 `ANTHROPIC_CUSTOM_HEADERS` 与 `ANTHROPIC_DEFAULT_*_MODEL`。
- **claude-code 版本**：用 `@2.1.77`（JS 版 cli.js），原生 ELF binary 不被 claude-trace 支持。
