#!/bin/bash
# 一键对多个模型分别跑 RealBench 全流程
# 用法:
#   bash run_models.sh                 # 默认对下面列表里的模型跑 0,1,2,3 全流程
#   bash run_models.sh 1               # 只跑 stage 1（模型已 mk_bench 过时复用）
#   bash run_models.sh 0,1,2,3 "your-model-name"   # 指定单个模型
#
# 每个模型用独立 workdir（./workdir/<sanitized_model>），避免不同模型的 .v 互相覆盖；
# eval 结果也各自独立。
cd "$(dirname "$0")"

# 从 ~/.bashrc 同步 ANTHROPIC_* 环境变量（容器内已由 start_container.sh 注入，文件不存在则跳过）
# shellcheck disable=SC1090
[ -f ~/.bashrc ] && source ~/.bashrc || true

STAGES="${1:-0,1,2,3}"
# 默认对比的模型列表，按需修改为你自己的端点支持的模型名
DEFAULT_MODELS=("claude-sonnet-4-6" "claude-haiku-4-5-20251001")

# 第二个参数可指定单个模型；否则用默认列表
if [ -n "$2" ]; then
    MODELS=("$2")
else
    MODELS=("${DEFAULT_MODELS[@]}")
fi

WORKDIR_BASE="${WORKDIR_BASE:-$(pwd)/workdir}"
mkdir -p "$WORKDIR_BASE"

overall_rc=0
for model in "${MODELS[@]}"; do
    # 模型名里的 / 换成 _，做目录名/solution 名
    safe="${model//\//_}"

    export CLAUDE_MODEL="$model"
    export PROJECT_DIR="${WORKDIR_BASE}/${safe}"
    export SOLUTION_NAME="${safe}_cc_result"

    echo ""
    echo "############################################################"
    echo "# MODEL       : $model"
    echo "# WORKDIR     : $PROJECT_DIR"
    echo "# SOLUTION    : $SOLUTION_NAME"
    echo "# STAGES      : $STAGES"
    echo "############################################################"

    if bash run.sh "$STAGES"; then
        echo "[done] model=$model  ->  $PROJECT_DIR/eval_output"
    else
        rc=$?
        echo "[fail] model=$model  rc=$rc  (继续下一个模型)"
        overall_rc=$rc
    fi
done

echo ""
echo "==== 全部模型跑完 ===="
echo "结果目录："
for model in "${MODELS[@]}"; do
    safe="${model//\//_}"
    echo "  $model -> $WORKDIR_BASE/$safe/eval_output"
done
exit $overall_rc
