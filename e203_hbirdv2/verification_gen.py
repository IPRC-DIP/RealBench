# 此代码用于自动化生成verification文件夹和其中不需要人工智慧的部分

# 具体效果：
# 生成verification文件夹
# 生成xxx_ref.sv（模块参考代码）,xxx_top.sv（模型生成模块代码）
# 生成xxx_stimulus_gen.sv（激励生成模块）,xxx_testbench.sv（测试平台）
# 理论上，运行此代码后，只需要修改激励生成模块即可

import os
import shutil
from pyverilog.vparser.parser import parse
from pyverilog.vparser.ast import Input,IntConst,InstanceList

def getwidth(port):
    if(port.first.width == None):
        return 1
    def get_xsb_number(msb):
        msb_name = type(msb).__name__
        if(msb_name == 'Minus'):
            return get_xsb_number(msb.left) - get_xsb_number(msb.right)
        elif(msb_name == 'Divide'):
            return get_xsb_number(msb.left) // get_xsb_number(msb.right)
        elif(msb_name == 'IntConst'):
            return int(msb.value)
        elif(msb_name == 'Plus'):
            return get_xsb_number(msb.left) + get_xsb_number(msb.right)
        else:
            raise RuntimeError(f"msb type not included in get_xsb_number cases! msb_name:{msb_name}")
    lsb = port.first.width.lsb
    msb = port.first.width.msb
    lsb_v = get_xsb_number(lsb)
    msb_v = get_xsb_number(msb)
    return msb_v - lsb_v + 1
        
def get_io(ast):
    result = []
    for port in ast.description.definitions[0].portlist.ports:
        item = {'name':port.first.name,'signed':port.first.signed,'value':port.first.value,'width':getwidth(port), 'direction':'input' if type(port.first) is Input else 'output'}
        result.append(item)
    return result

def main():
    # 创建验证文件夹
    module_dir = "e203_exu_alu_muldiv"
    os.chdir(module_dir)

    verification_dir = "verification"
    os.makedirs(verification_dir, exist_ok=True)

    # 查找唯一的markdown文件
    md_files = [f for f in os.listdir('.') 
                if f.endswith('.md') and os.path.isfile(f)]
    
    if len(md_files) != 1:
        raise ValueError("当前目录中必须且只能包含一个markdown文件")
    
    base_name = os.path.splitext(md_files[0])[0]

    # 验证对应的.v文件是否存在
    v_file = f"{base_name}.v"
    if not os.path.exists(v_file):
        raise FileNotFoundError(f"找不到对应的Verilog文件: {v_file}")

    # 复制文件到验证目录
    dest_ref = os.path.join(verification_dir, f"{base_name}_ref.sv")
    dest_top = os.path.join(verification_dir, f"{base_name}_top.sv")
    dest_testbench = os.path.join(verification_dir,f"{base_name}_testbench.sv")
    dest_stimulus_gen = os.path.join(verification_dir,f"{base_name}_stimulus_gen.sv")
    dest_makefile = os.path.join(verification_dir,f"Makefile")
    shutil.copy(v_file, dest_ref)
    shutil.copy(v_file, dest_top)
    shutil.copy('../testbench_template.sv',dest_testbench)
    shutil.copy('../stimulus_gen_template.sv',dest_stimulus_gen)
    shutil.copy('../Makefile',dest_makefile)


    # 修改_ref.sv文件内容
    modified = False
    with open(dest_ref, 'r+', encoding='utf-8') as f:
        lines = f.readlines()
        f.seek(0)
        f.truncate()

        for line in lines:
            # 查找第一个未修改的模块声明
            if not modified and line.strip().startswith(f"module {base_name}"):
                new_line = line.replace(
                    f"module {base_name}",
                    f"module ref_{base_name}", 
                    1  # 仅替换第一个出现的位置
                )
                f.write(new_line)
                modified = True
            else:
                f.write(line)

    if not modified:
        raise RuntimeError(f"未找到模块声明: module {base_name}")
    
    # 解析verilog文件
    ast, directives = parse([v_file],
            preprocess_include=['../config','../e203_defines'],
            preprocess_define=[])         
    ios = get_io(ast)

    def get_instances(ast):
        instances = []
        unique = set()
        
        # Traverse the AST
        def traverse(node):
            if isinstance(node, InstanceList):  # If the node is an InstanceList
                for instance in node.instances:
                    instances.append((instance.module, instance.name))  # (module_name, instance_name)
                    unique.add(instance.module)
            
            # Recursively visit child nodes
            for c in node.children():
                traverse(c)
        
        traverse(ast)
        return instances, unique

    instances, unique = get_instances(ast)

    print("Instantiated modules: ")
    for module in unique:
        print(f'\t{module}')
    
    # 检查模块使用的是rst还是rst_n, 寻找所有的input模块
    rst_n = False
    inputs = list()
    for io in ios:
        if io['name'] == "rst_n":
            rst_n = True
        elif io['name'] == "clk" or io['name'] == "rst":
            pass
        elif io['direction'] == "input":
            inputs.append((io['name'], io['width']))
        
    
    # 修改stimulus_gen.sv文件的内容
    with open(dest_stimulus_gen,'r+',encoding='utf-8')as f:
        lines = f.readlines()
        f.seek(0)
        f.truncate()
        i = 0
        tasknames = ["Task1", "Task2", "Random_Test"]
        random_default = 100 # number of random test
        val_default = 0 # default test case is all 0 and all 1
        import re      
        def swap(match):
            return f"rst_n <= {1 - int(match.group(1))}"
        for line in lines:
            # 修改rst 到 rst_n 如果用的后者的话
            if rst_n:
                line = re.sub(r'rst\s*<=\s*(0|1)', swap, line)
            if line.strip().startswith("// 输出待测模块的输入"):
                for input in inputs:
                    f.write("output logic " + (f"[{input[1]-1}:0] " if input[1] != 1 else "") + input[0] + ",\n")
            # add place for tasks
            elif line.strip().startswith("task reset_test"):
                val = ''
                for j, str in enumerate(tasknames):
                    f.write(f"\ttask {str}();\n\tbegin\n")
                    if j != 2:
                        f.write(f"\t// Add {str} here\n")
                        val = ('~' if j == 1 else '') + '0'
                    else: # add random task
                        # f.write(f"\tfor (int i = 0; i < {random_default}; i++) begin\n")
                        val = '$urandom'
                    for input in inputs:
                        f.write(f"\t\t{input[0]} = {val};\n")
                    f.write("\tend\n\tendtask\n\n")
                f.write(line)
            elif line.strip().startswith("wavedrom_start("):
                f.write(line)
                f.write(f"\t\t{tasknames[i]}();\n")
                i = i + 1
            else:
                f.write(line)
            
    
    # 修改testbench.sv文件的内容
    with open(dest_testbench,'r',encoding='utf-8')as file:
        lines = file.readlines()

    # 标记插入状态
    typedef_inserted = False
    signal_inserted = False
    stimulus_gen_inserted = False
    ref_inserted = False
    dut_inserted = False
    finalerror_inserted = False
    match_inserted = False
    always_inserted = False
    # 遍历每一行，查找需要匹配的内容
    i = 0
    while i < len(lines):
        line = lines[i]
        # 查找 "typedef struct packed" 并插入
        if "typedef struct packed" in line and (not typedef_inserted):
            for io in ios:
                if io['direction'] == 'output':
                    new_line = f"\t\tint errors_{io['name']};"
                    lines.insert(i + 3, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\tint errortime_{io['name']};"
                    lines.insert(i + 3, new_line + '\n')  # 在该行后插入新内容
                    i += 1
            print("typedef ok")
            typedef_inserted = True  # 确保只插入一次
        # 查找 "// 接口信号" 并插入
        elif "接口信号" in line and not signal_inserted:
            for io in ios:
                if io['name'] != 'clk':
                    if io['direction'] == 'input':
                        if io['width'] == 1:
                            new_line = f"\tlogic {io['name']};"
                            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                            i += 1
                        else: 
                            new_line = f"\tlogic [{io['width']}-1:0] {io['name']};"
                            lines.insert(i + 1, new_line + '\n')
                            i += 1
                    else:
                        if io['width'] == 1:
                            new_line = f"\tlogic {io['name']}_ref;"
                            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                            i += 1
                            new_line = f"\tlogic {io['name']}_dut;"
                            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                            i += 1
                        else: 
                            new_line = f"\tlogic [{io['width']}-1:0] {io['name']}_ref;"
                            lines.insert(i + 1, new_line + '\n')
                            i += 1
                            new_line = f"\tlogic [{io['width']}-1:0] {io['name']}_dut;"
                            lines.insert(i + 1, new_line + '\n')
                            i += 1
            print("io ok")
            signal_inserted = True  # 确保只插入一次
            
        elif "实例化激励模块" in line and not stimulus_gen_inserted:
            for io in ios:
                if io['direction'] == 'input':
                    new_line = f"\t\t.{io['name']}({io['name']}),"
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
            print("stimulus ok")
            stimulus_gen_inserted = True

        elif "实例化参考模块" in line and not ref_inserted:
            new_line = f"\tref_{base_name} good1 ("
            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            for index,io in enumerate(ios):
                if io['direction'] == 'input':
                    if index == len(ios)-1:
                        new_line = f"\t\t.{io['name']}({io['name']})"
                    else:
                        new_line = f"\t\t.{io['name']}({io['name']}),"
                else:
                    if index == len(ios)-1:
                        new_line = f"\t\t.{io['name']}({io['name']}_ref)"
                    else:
                        new_line = f"\t\t.{io['name']}({io['name']}_ref),"
                lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                i += 1
            new_line = f"\t);"
            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            print("ref ok")
            ref_inserted = True

        elif "实例化待测模块" in line and not dut_inserted:
            new_line = f"\t{base_name} top_module1 ("
            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            for index,io in enumerate(ios):
                if io['direction'] == 'input':
                    if index == len(ios)-1:
                        new_line = f"\t\t.{io['name']}({io['name']})"
                    else:
                        new_line = f"\t\t.{io['name']}({io['name']}),"
                else:
                    if index == len(ios)-1:
                        new_line = f"\t\t.{io['name']}({io['name']}_dut)"
                    else:
                        new_line = f"\t\t.{io['name']}({io['name']}_dut),"
                lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                i += 1
            new_line = f"\t);"
            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            print("dut ok")
            dut_inserted = True

        elif "公式化生成错误信息" in line and not finalerror_inserted:
            for io in ios:
                if io['direction'] == 'output':
                    new_line = f"\t\tif (stats1.errors_{io['name']})"
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\t\t$display(\"Hint: Output '{io['name']}' has %0d mismatches. First mismatch occurred at time %0d.\", "
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\t\t\t\tstats1.errors_{io['name']}, stats1.errortime_{io['name']});"
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\telse"
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\t\t$display(\"Hint: Output '{io['name']}' has no mismatches.\");"
                    lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
            print("finalerror ok")
            finalerror_inserted = True
        
        elif "公式化信号对比" in line and not match_inserted:
            mid_line_ref = ''
            mid_line_dut = ''
            first = True
            for match in ios:
                if match['direction'] == 'output':
                    if first:
                        first = False
                    else:
                        mid_line_ref += ','
                    mid_line_ref += f"{match['name']}_ref"
            first = True
            for match in ios:
                if match['direction'] == 'output':
                    if first:
                        first = False
                    else:
                        mid_line_dut += ','
                    mid_line_dut += f"{match['name']}_ref"

            new_line = '\t\t{ '+mid_line_ref+'} ==='
            lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            new_line = '\t\t\t( { '+ mid_line_ref +'} ^'
            lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            new_line = '\t\t\t  { '+ mid_line_dut +'} ^'
            lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            new_line = '\t\t\t  { '+ mid_line_ref +'} );'
            lines.insert(i + 2, new_line + '\n')  # 在该行后插入新内容 
            i += 1
            print("match ok")
            match_inserted = True

        elif "公式化错误统计" in line and not always_inserted:
            for io in ios:
                if io['direction'] == 'output':
                    new_line = f"\t\tif ({io['name']}_ref !== ({io['name']}_ref ^ {io['name']}_dut ^ {io['name']}_ref)) begin"
                    lines.insert(i + 8, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\t\tif (stats1.errors_{io['name']} == 0) stats1.errortime_{io['name']} = $time;"
                    lines.insert(i + 8, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\t\tstats1.errors_{io['name']}++;"
                    lines.insert(i + 8, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
                    new_line = f"\t\tend"
                    lines.insert(i + 8, new_line + '\n')  # 在该行后插入新内容 
                    i += 1
            print("always ok")
            always_inserted = True
        else:
            i+=1
    # 重新写回文件
    with open(dest_testbench, 'w', encoding='utf-8') as file:
        file.writelines(lines)
    
    # 暂时不使用此段代码的功能
    # 修改stimulus_gen.sv文件的内容
    with open(dest_stimulus_gen,'r',encoding='utf-8')as file:
        lines = file.readlines()
    # 标记插入状态
    output_inserted = False
    # 遍历，查找需要匹配的内容
    i = 0
    while i < len(lines):
        line = lines[i]
        if "输出待测模块的输入" in line and not output_inserted:
            for io in ios:
                if io['direction'] == 'input':
                    if io['name'] == 'clk' or io['name']=='rst_n' :
                        continue
                    else:
                        if io['width'] == 1:
                            new_line = f"\toutput logic {io['name']},"
                            lines.insert(i + 1, new_line + '\n')  # 在该行后插入新内容 
                            i += 1
                        else: 
                            new_line = f"\toutput logic [{io['width']}-1:0] {io['name']},"
                            lines.insert(i + 1, new_line + '\n')
                            i += 1
            output_inserted = True
        else:
            i+=1
    # 重新写回文件
    with open(dest_stimulus_gen, 'w', encoding='utf-8') as file:
        file.writelines(lines)

    print("操作成功完成！")

    # 删除中间文件
    file_path = "parser.out"
    if os.path.exists(file_path):
        os.remove(file_path)
        print(f"文件 {file_path} 已成功删除")
    else:
        print(f"文件 {file_path} 不存在")
    file_path = "parsetab.py"
    if os.path.exists(file_path):
        os.remove(file_path)
        print(f"文件 {file_path} 已成功删除")
    else:
        print(f"文件 {file_path} 不存在")
if __name__ == "__main__":
    main()
