import os
import re

# 获取 Verilog 文件中的所有输入输出端口的名称、方向和位宽
def extract_ports(verilog_file):
    ports = []
    # 正则表达式匹配 input 或 output 端口，包括带有宏定义的位宽
    input_pattern = re.compile(r"\s*(input|output)\s+(wire|reg)?\s*(\[\s*([^]]+)\s*\])?\s*(\w+)")
    
    with open(verilog_file, 'r', encoding='utf-8') as file:
        for line in file:
            match = input_pattern.match(line.strip())
            if match:
                direction = match.group(1)  # input 或 output
                width_expr = match.group(4) if match.group(4) else '1'  # 如果没有宏定义，默认宽度是 1
                name = match.group(5)  # 端口名称

                # 如果位宽是一个宏定义，提取宏定义名
                if '`' in width_expr:
                    # 例如 `E203_XLEN，提取 E203_XLEN
                    width = width_expr.split('`')[1]
                else:
                    width = width_expr

                if '-' in width:
                        width = width.split('-')[0]
                ports.append((direction, name, width, ""))  # description 留空
    return ports

# 生成 Markdown 表格内容
def generate_markdown_table(ports):
    table_header = "| Direction | Port Name | Width | Description |\n|-----------|-----------|-------|-------------|\n"
    table_rows = ""
    for port in ports:
        table_rows += f"| {port[0]} | {port[1]} | {port[2]} | {port[3]} |\n"
    return table_header + table_rows

# 插入到 Markdown 文件中
def insert_ports_into_markdown(markdown_file, ports):
    with open(markdown_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # 查找 "## Interface" 位置
    interface_index = None
    for i, line in enumerate(lines):
        if line.strip() == "## Interface":
            interface_index = i
            break

    # 如果没有找到，抛出异常
    if interface_index is None:
        print("未找到 '## Interface' 标题，无法插入端口信息")
        return

    # 在 "## Interface" 下插入端口信息
    table = generate_markdown_table(ports)
    lines.insert(interface_index + 1, table)

    # 写回到文件
    with open(markdown_file, 'w', encoding='utf-8') as file:
        file.writelines(lines)

# 主函数
def main(verilog_folder, module_name,markdown_file):
    # 获取文件夹中的所有 Verilog 文件
    verilog_files = [f for f in os.listdir(verilog_folder) if f.endswith('.v')]
    
    # 获取所有输入输出端口
    all_ports = []
    for verilog_file in verilog_files:
        if verilog_file == "e203_exu_"+module_name+".v":
            verilog_path = os.path.join(verilog_folder, verilog_file)
            ports = extract_ports(verilog_path)
            all_ports.extend(ports)

    # 将端口信息插入到 Markdown 文件
    insert_ports_into_markdown(markdown_file, all_ports)
    print("端口信息已成功插入到 Markdown 文件中")

if __name__ == "__main__":
    # 输入文件夹路径和 Markdown 文件路径
    module_name = 'alu'
    verilog_folder = "e203_exu_"+module_name  # 请根据需要修改路径
    markdown_file = verilog_folder+"/e203_exu_"+module_name+".md"  # 请根据需要修改路径

    main(verilog_folder,module_name, markdown_file)
