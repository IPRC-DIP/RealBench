# Use this python file to generate problems.jsonl
import argparse
import os
import json
from benchmark_info import benchmark_info,system_info
current_file_path = os.path.abspath(__file__)
current_folder_path = os.path.dirname(current_file_path)

def get_dir_from_system(system:str):
    dir_list= ['sdc','aes','e203_hbirdv2']
    for dir in dir_list:
        if dir[:4] in system:
            return dir
    assert False,'can not find correct dir'

def read_md_file(md_file_path):
    if not os.path.exists(md_file):
        assert False,f'{md_file} does not exist'
    with open(md_file_path, 'r', encoding='utf-8') as f:
        return f.read() 

def write_jsonl(content, jsonl_file_path):
    with open(jsonl_file_path, 'w', encoding='utf-8') as f:
        json_obj = {"text": content}
        f.write(json.dumps(json_obj, ensure_ascii=False) + '\n')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--benchmark_path",type=str,help="project root path",default=current_folder_path)
    parser.add_argument("--task_level",type=str,help="benchmark task level",default='module')
    args = parser.parse_args()
    benchmark_path,task_level = args.benchmark_path,args.task_level
    
    if task_level == 'module':
        problems_folder = os.path.join(benchmark_path,'problems')
        os.makedirs(problems_folder,exist_ok=True)
        for system, components in benchmark_info.items():
            system_folder = os.path.join(problems_folder, system)
            os.makedirs(system_folder, exist_ok=True)
            output_file = os.path.join(system_folder, "problems.jsonl")
            with open(output_file, "w", encoding="utf-8") as f:
                for module, dependencies in components.items():
                    path0 = os.path.join(benchmark_path,system,module)
                    if not os.path.isdir(path0):
                        assert False,'module in benchmark_info is not in project file'
                    md_file = f"{path0}/{module}.md"
                    if not os.path.exists(md_file):
                        assert False,'module markdown file does not exist'
                    content = read_md_file(md_file)
                    json_obj = {
                        "task": module,  
                        "problem": content.strip()
                    }
                    f.write(json.dumps(json_obj, ensure_ascii=False) + '\n')
    elif task_level == 'system':
        problems_folder = os.path.join(benchmark_path,'problems')
        os.makedirs(problems_folder,exist_ok=True)
        system_folder = os.path.join(problems_folder,'system')
        os.makedirs(system_folder, exist_ok=True)
        output_file = os.path.join(system_folder, "problems.jsonl")
        with open(output_file, "w", encoding="utf-8") as f:
            for system, components in system_info.items():
                path0 = f"{benchmark_path}/{get_dir_from_system(system)}"
                md_file = f"{os.path.join(path0,system)}/{system}.md"
                content_list = []
                content = read_md_file(md_file)
                content_list.append(content)
                for submodule in components:
                    path1 = os.path.join(path0,submodule)
                    md_file = f"{os.path.join(path1)}/{submodule}.md"
                    content = read_md_file(md_file)
                    content_list.append(content)
                json_obj = {
                    "task": system,  # 文件名
                    "problem": "\n\n".join(content_list).strip()  # 文件内容
                }
                f.write(json.dumps(json_obj, ensure_ascii=False) + '\n')
    else:
        assert False,"--task_level must be one of module, system"
    
