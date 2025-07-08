#!/bin/bash

# 定义成功、失败和未验证模块的列表
success_list=()
failure_list=()
not_verified_list=()

# 遍历当前目录下的所有一级文件夹
for module in */; do
  # 检查是否存在 verification 文件夹
  if [ -d "${module}verification" ]; then
    # 进入 verification 文件夹
    cd "${module}verification" || continue

    # 执行 make all，将输出保存到临时文件中
    output=$(mktemp)
    make all > "$output" 2>&1

    # 获取输出的倒数第二行
    second_last_line=$(tail -n 2 "$output" | head -n 1)

    # 检查倒数第二行是否包含指定内容
    if [[ "$second_last_line" == *"See lines with '%00' in ./logs"* ]]; then
      # 如果成功，加入成功列表
      success_list+=("${module}")
    else
      # 如果失败，加入失败列表
      failure_list+=("${module}")
    fi

    # 清理临时文件
    rm -f "$output"

    # 执行 make clean 清理垃圾
    make clean > /dev/null 2>&1

    # 返回上一级目录
    cd - > /dev/null || exit
  else
    # 如果没有 verification 文件夹，加入未验证列表
    not_verified_list+=("${module}")
  fi
done

# 打印结果
echo "=== 检查结果 ==="
echo "成功的模块："
for module in "${success_list[@]}"; do
  echo "  - ${module}"
done

echo "不成功的模块："
for module in "${failure_list[@]}"; do
  echo "  - ${module}"
done

echo "没有验证的模块："
for module in "${not_verified_list[@]}"; do
  echo "  - ${module}"
done