import json
from tqdm import tqdm
from joblib import Parallel, delayed
import subprocess
import tempfile
import os
import numpy as np
import itertools
import argparse
from benchmark_info import benchmark_info,system_info

module_names = ["sd_bd", "sd_clock_divider", "sd_crc_16", "sd_crc_7", "sd_controller_wb", "sd_data_master",
    "sd_cmd_master", "sd_rx_fifo", "sd_tx_fifo", "sd_fifo_rx_filler", "sd_fifo_tx_filler", "sd_data_serial_host",
    "sd_cmd_serial_host", "sdc_controller", "aes_sbox", "aes_rcon", "aes_inv_sbox", "aes_key_expand_128", "aes_cipher_top",
    "aes_inv_cipher_top", "e203_biu", "e203_clk_ctrl", "e203_clkgate", "e203_core", "e203_cpu", "e203_cpu_top", "e203_dtcm_ctrl",
    "e203_dtcm_ram", "e203_extend_csr", "e203_exu", "e203_exu_alu", "e203_exu_alu_bjp", "e203_exu_alu_csrctrl", "e203_exu_alu_dpath",
    "e203_exu_alu_lsuagu", "e203_exu_alu_muldiv", "e203_exu_alu_rglr", "e203_exu_branchslv", "e203_exu_commit", "e203_exu_csr", "e203_exu_decode",
    "e203_exu_disp", "e203_exu_excp", "e203_exu_longpwbck", "e203_exu_nice", "e203_exu_oitf", "e203_exu_regfile", "e203_exu_wbck", "e203_ifu",
    "e203_ifu_ifetch", "e203_ifu_ift2icb", "e203_ifu_litebpu", "e203_ifu_minidec", "e203_irq_sync", "e203_itcm_ctrl", "e203_itcm_ram", "e203_lsu",
    "e203_lsu_ctrl", "e203_reset_ctrl", "e203_srams"]
system_names = ["sdc_controller", "aes_cipher_top", "aes_inv_cipher_top", "e203_cpu_top"]


def testbench_verification(code, system_name, module_name):
    template_dir = os.path.join(system_name, module_name, "verification")
    with tempfile.TemporaryDirectory(dir=f"/run/user/{os.getuid()}") as temp_dir:
        # prepare tempdir
        os.system(f"cp {template_dir}/* {temp_dir}/")
        top_filepath = os.path.join(temp_dir, f"{module_name}_top.sv")
        assert os.path.exists(top_filepath)
        os.system(f"rm {top_filepath}")
        with open(top_filepath, "w") as f:
            f.write(code)

        # verilator
        syntax = -2
        semantic = -2
        syntax_err_msg = ""
        semantic_err_msg = ""
        ys_ret = subprocess.run(
            f"cd {temp_dir} && make all",
            shell=True,
            timeout=5 * 60,
            stderr=subprocess.PIPE,
            stdout=subprocess.PIPE,
        )
        if ys_ret.stderr:
            err_msg = ys_ret.stderr.decode()
            for line in err_msg.split('\n'):
                if line.startswith(f"%Error") or line.startswith(f"%Warning"):
                    syntax_err_msg += line
                    syntax_err_msg += "\n"
            syntax = 0
            semantic = 0
            return syntax, semantic, syntax_err_msg, semantic_err_msg

        tb_msg = ys_ret.stdout.decode()
        for line in tb_msg.split('\n'):
            if "Hint: Output" in line and "no mismatches" in line:
                continue
            elif "Hint: Output" in line and "mismatches" in line:
                semantic_err_msg += line[6:]
                semantic_err_msg += '\n'
        syntax = 1
        semantic = 1 if semantic_err_msg == "" else 0
        return syntax, semantic, syntax_err_msg, semantic_err_msg


def testbench_verification_system(code, system_name):
    template_dir = os.path.join("system", system_name)
    with tempfile.TemporaryDirectory(dir=f"/run/user/{os.getuid()}") as temp_dir:
        # prepare tempdir
        os.system(f"cp {template_dir}/* {temp_dir}/")
        top_filepath = os.path.join(temp_dir, f"{system_name}_top.sv")
        assert os.path.exists(top_filepath)
        os.system(f"rm {top_filepath}")
        with open(top_filepath, "w") as f:
            f.write(code)

        # verilator
        syntax = -2
        semantic = -2
        syntax_err_msg = ""
        semantic_err_msg = ""
        ys_ret = subprocess.run(
            f"cd {temp_dir} && make all",
            shell=True,
            timeout=5 * 60,
            stderr=subprocess.PIPE,
            stdout=subprocess.PIPE,
        )
        if ys_ret.stderr:
            err_msg = ys_ret.stderr.decode()
            for line in err_msg.split('\n'):
                if line.startswith(f"%Error") or line.startswith(f"%Warning"):
                    syntax_err_msg += line
                    syntax_err_msg += "\n"
            syntax = 0
            semantic = 0
            return syntax, semantic, syntax_err_msg, semantic_err_msg

        tb_msg = ys_ret.stdout.decode()
        for line in tb_msg.split('\n'):
            if "Hint: Output" in line and "no mismatches" in line:
                continue
            elif "Hint: Output" in line and "mismatches" in line:
                semantic_err_msg += line[6:]
                semantic_err_msg += '\n'
        syntax = 1
        semantic = 1 if semantic_err_msg == "" else 0
        return syntax, semantic, syntax_err_msg, semantic_err_msg


def formal_verification(code, system_name, module_name):
    template_dir = os.path.join(system_name, module_name, "verification")
    # template_dir = 'formal-template'
    with tempfile.TemporaryDirectory(dir=f"/run/user/{os.getuid()}") as temp_dir:
        # prepare tempdir
        os.system(f"mkdir {temp_dir}/ref")
        os.system(f"mkdir {temp_dir}/top")
        os.system(f"cp {template_dir}/* {temp_dir}/ref/")
        os.system(f"cp {template_dir}/* {temp_dir}/top/")
        os.system(f"rm {temp_dir}/ref/{module_name}_stimulus_gen.sv")
        os.system(f"rm {temp_dir}/ref/{module_name}_testbench.sv")
        os.system(f"rm {temp_dir}/ref/{module_name}_top.sv")

        os.system(f"rm {temp_dir}/top/{module_name}_stimulus_gen.sv")
        os.system(f"rm {temp_dir}/top/{module_name}_testbench.sv")
        os.system(f"rm {temp_dir}/top/{module_name}_ref.sv")
        os.system(f"rm {temp_dir}/top/{module_name}_top.sv")
        with open(f"{temp_dir}/top/{module_name}_top.sv", "w") as f:
            f.write(code)

        # jaspergold
        os.system(f"yosys -p 'read_verilog -sv {temp_dir}/ref/*v; synth; write_verilog {temp_dir}/a.v' > /dev/null")
        os.system(f"yosys -p 'read_verilog -sv {temp_dir}/top/*v; synth; write_verilog {temp_dir}/b.v' > /dev/null")
        os.system(f"cp formal-template/top.f {temp_dir}")
        os.system(f"cp formal-template/ref.f {temp_dir}")
        with open(f'formal-template/test.tcl', 'r') as f:
            temp_content = f.read()
        temp_content = temp_content.replace('###TOPMODULE###', module_name)
        with open(f"{temp_dir}/test.tcl", 'w') as f:
            f.write(temp_content)
        if not os.path.exists(temp_dir + '/a.v'):
            return -5
        if not os.path.exists(temp_dir + '/b.v'):
            return -4
        os.system(f"cd {temp_dir} && jaspergold -no_gui -sec test.tcl > /dev/null")
        if not os.path.exists(f"{temp_dir}/jgproject/jg.log"):
            formal = -3
        else:
            with open(f"{temp_dir}/jgproject/jg.log", 'r') as f:
                log = f.read()
            if 'ERROR' in log:
                formal = -2
            lines = log.split('\n')
            for line in lines:
                if 'JPW: ' in line and 'puts "JPW: $' not in line:
                    result = line.split('JPW: ')[1]
                    if result == 'proven':
                        formal = 1
                    elif result == 'determined':
                        formal = 2
                    elif result == 'determined_or_skipped':
                        formal = 3
                    elif result in ['cex', 'cex_threshold_reached']:
                        formal = 0
                    else:
                        formal = 4
                    break
            else:
                formal = 4

        return formal

def formal_verification_system(code, system_name):
    template_dir = os.path.join("system", system_name)
    # template_dir = 'formal-template'
    with tempfile.TemporaryDirectory(dir=f"/run/user/{os.getuid()}") as temp_dir:
        # prepare tempdir
        os.system(f"mkdir {temp_dir}/ref")
        os.system(f"mkdir {temp_dir}/top")
        os.system(f"cp {template_dir}/* {temp_dir}/ref/")
        os.system(f"cp {template_dir}/* {temp_dir}/top/")
        os.system(f"rm {temp_dir}/ref/{system_name}_stimulus_gen.sv")
        os.system(f"rm {temp_dir}/ref/{system_name}_testbench.sv")
        os.system(f"rm {temp_dir}/ref/{system_name}_top.sv")

        os.system(f"rm {temp_dir}/top/{system_name}_stimulus_gen.sv")
        os.system(f"rm {temp_dir}/top/{system_name}_testbench.sv")
        os.system(f"rm {temp_dir}/top/{system_name}_ref.sv")
        os.system(f"rm {temp_dir}/top/{system_name}_top.sv")
        with open(f"{temp_dir}/top/{system_name}_top.sv", "w") as f:
            f.write(code)

        # jaspergold
        os.system(f"yosys -p 'read_verilog -sv {temp_dir}/ref/*v; synth; write_verilog {temp_dir}/a.v' > /dev/null")
        os.system(f"yosys -p 'read_verilog -sv {temp_dir}/top/*v; synth; write_verilog {temp_dir}/b.v' > /dev/null")
        os.system(f"cp formal-template/top.f {temp_dir}")
        os.system(f"cp formal-template/ref.f {temp_dir}")
        with open(f'formal-template/test.tcl', 'r') as f:
            temp_content = f.read()
        temp_content = temp_content.replace('###TOPMODULE###', system_name)
        with open(f"{temp_dir}/test.tcl", 'w') as f:
            f.write(temp_content)
        if not os.path.exists(temp_dir + '/a.v'):
            return -5
        if not os.path.exists(temp_dir + '/b.v'):
            return -4
        os.system(f"cd {temp_dir} && jaspergold -no_gui -sec test.tcl > /dev/null")
        if not os.path.exists(f"{temp_dir}/jgproject/jg.log"):
            formal = -3
        else:
            with open(f"{temp_dir}/jgproject/jg.log", 'r') as f:
                log = f.read()
            if 'ERROR' in log:
                formal = -2
            lines = log.split('\n')
            for line in lines:
                if 'JPW: ' in line and 'puts "JPW: $' not in line:
                    result = line.split('JPW: ')[1]
                    if result == 'proven':
                        formal = 1
                    elif result == 'determined':
                        formal = 2
                    elif result == 'determined_or_skipped':
                        formal = 3
                    elif result in ['cex', 'cex_threshold_reached']:
                        formal = 0
                    else:
                        formal = 4
                    break
            else:
                formal = 4

        return formal

def run_tbverify(filepath, system_name):
    data = []
    with open(filepath, 'r') as file:
        for line in file:
            record = json.loads(line)
            data.append(record)
    results = Parallel(n_jobs=40)(
        delayed(testbench_verification)(record["code"], system_name, record["task"]) for record in data
    )

    for index, record in enumerate(data):
        record["syntax"] = results[index][0]
        record["function"] = results[index][1]
        record["syntax_info"] = results[index][2]
        record["function_info"] = results[index][3]

    new_filepath = filepath.replace("samples", "samples_after_verilator")
    new_dir = os.path.dirname(new_filepath)  
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)  
    with open(new_filepath, 'w') as f:
        for record in data:
            f.write(json.dumps(record) + '\n')


def run_tbverify_system(filepath):
    data = []
    with open(filepath, 'r') as file:
        for line in file:
            record = json.loads(line)
            data.append(record)
    results = Parallel(n_jobs=40)(
        delayed(testbench_verification_system)(record["code"], record["task"]) for record in data
    )

    for index, record in enumerate(data):
        record["syntax"] = results[index][0]
        record["function"] = results[index][1]
        record["syntax_info"] = results[index][2]
        record["function_info"] = results[index][3]

    new_filepath = filepath.replace("samples", "samples_after_verilator")
    new_dir = os.path.dirname(new_filepath)  
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)  
    with open(new_filepath, 'w') as f:
        for record in data:
            f.write(json.dumps(record) + '\n')


def run_fmverify(filepath, system_name):
    data = []
    with open(filepath, 'r') as file:
        for line in file:
            record = json.loads(line)
            data.append(record)
    for record in tqdm(data):
        if record["function"] == 1:
            record["formal"] = formal_verification(record["code"], system_name, record["task"])
        else:
            record["formal"] = 0
            
    new_filepath = filepath.replace("samples_after_verilator", "samples_after_formal")
    new_dir = os.path.dirname(new_filepath)  
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)  
    with open(new_filepath, 'w') as f:
        for record in data:
            f.write(json.dumps(record) + '\n')


def run_fmverify_system(filepath):
    data = []
    with open(filepath, 'r') as file:
        for line in file:
            record = json.loads(line)
            data.append(record)
    for record in tqdm(data):
        if record["function"] == 1:
            record["formal"] = formal_verification_system(record['code'],record['task'])
        else:
            record["formal"] = 0

    new_filepath = filepath.replace("samples_after_verilator", "samples_after_formal")
    new_dir = os.path.dirname(new_filepath)  
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)  
    with open(new_filepath, 'w') as f:
        for record in data:
            f.write(json.dumps(record) + '\n')


def estimate_pass_at_k(num_samples, num_correct, k):
    """
    Estimates pass@k of each problem and returns them in an array.
    """

    def estimator(n: int, c: int, k: int) -> float:
        """
        Calculates 1 - comb(n - c, k) / comb(n, k).
        """
        if n - c < k:
            return 1.0
        return 1.0 - np.prod(1.0 - k / np.arange(n - c + 1, n + 1))

    if isinstance(num_samples, int):
        num_samples_it = itertools.repeat(num_samples, len(num_correct))
    else:
        assert len(num_samples) == len(num_correct)
        num_samples_it = iter(num_samples)

    return np.array([estimator(int(n), int(c), k) for n, c in zip(num_samples_it, num_correct)])

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--solution_name",
        type=str,
        default="codev-qwen-7b",
        help="sample solution name",
    )
    parser.add_argument("--formal",action="store_true",help='use formal verification')
    parser.add_argument("--task_level",type=str,default='module',help='task level (module or system)')
    parser.add_argument("--num_samples",type=int,default=1,help='sample num')
    args = parser.parse_args()
    solution_dir = "samples"
    num_samples = args.num_samples
    solution_name, task_level = args.solution_name, args.task_level
    # verify

    # function
    if task_level == 'module':      
        for system, _ in benchmark_info.items():
            run_tbverify(f"{solution_dir}/{solution_name}/{system}.jsonl", system)
    elif task_level == 'system':
        run_tbverify_system(f"{solution_dir}/{solution_name}/system.jsonl")
    else:
        assert False,'undefined task level'
    # formal
    if args.formal:
        if task_level == 'module':      
            for system, _ in benchmark_info.items():
                run_fmverify(
                    f"samples_after_verilator/{solution_name}/{system}.jsonl", system
                )
        elif task_level == 'system':
            run_fmverify_system(f"samples_after_verilator/{solution_name}/system.jsonl")
        else:
            assert False,'undefined task level'

    # result analyze
    if not args.formal:
        if task_level == 'module':
            infos = {module:[0, 0, 0] for module in module_names}
            for system,_ in benchmark_info.items():
                result_file = os.path.join(
                    "samples_after_verilator",
                    solution_name,
                    f"{system}.jsonl",
                )

                with open(result_file, 'r') as file:
                    for line in file:
                        record = json.loads(line)
                        module = record["task"]
                        infos[module][0] += int(record["syntax"]==1)
                        infos[module][1] += int(record["function"]==1)
                        infos[module][2] += 0#int(record["formal"]==1)
            num_correct_syntax = [infos[module][0] for module in infos]
            num_correct_function = [infos[module][1] for module in infos]
            num_correct_formal = [infos[module][2] for module in infos]
        elif task_level == 'system':
            infos = {system:[0, 0, 0] for system in system_names}
            result_file = os.path.join(
                "samples_after_verilator", solution_name, "system.jsonl"
            )
            with open(result_file, 'r') as file:
                for line in file:
                    record = json.loads(line)
                    system = record["task"]
                    infos[system][0] += int(record["syntax"]==1)
                    infos[system][1] += int(record["function"]==1)
                    infos[system][2] += 0#int(record["formal"]==1)
            num_correct_syntax = [infos[system][0] for system in infos]
            num_correct_function = [infos[system][1] for system in infos]
            num_correct_formal = [infos[system][2] for system in infos]
        else:
            assert False,'undefined task level'
        syntax_1 = estimate_pass_at_k(num_samples, num_correct_syntax, 1).mean()
        syntax_5 = estimate_pass_at_k(num_samples, num_correct_syntax, 5).mean()
        function_1 = estimate_pass_at_k(num_samples, num_correct_function, 1).mean()
        function_5 = estimate_pass_at_k(num_samples, num_correct_function, 5).mean()
        formal_1 = estimate_pass_at_k(num_samples, num_correct_formal, 1).mean()
        formal_5 = estimate_pass_at_k(num_samples, num_correct_formal, 5).mean()
        print(f'task_level:{task_level}',syntax_1, syntax_5, function_1, function_5, formal_1, formal_5)
    else:
        if task_level == 'module':
            infos = {module:[0, 0, 0] for module in module_names}
            for system in benchmark_info:
                result_file = os.path.join(
                    "samples_after_formal", solution_name, f"{system}.jsonl"
                )

                with open(result_file, 'r') as file:
                    for line in file:
                        record = json.loads(line)
                        module = record["task"]
                        infos[module][0] += int(record["syntax"]==1)
                        infos[module][1] += int(record["function"]==1)
                        infos[module][2] += int(record["formal"]==1)
            num_correct_syntax = [infos[module][0] for module in infos]
            num_correct_function = [infos[module][1] for module in infos]
            num_correct_formal = [infos[module][2] for module in infos]
        elif task_level == 'system':
            system_names = ["sdc_controller", "aes_cipher_top", "aes_inv_cipher_top", "e203_cpu_top"]
            infos = {system:[0, 0, 0] for system in system_names}
            result_file = os.path.join(
                "samples_after_formal",
                solution_name,
                "system.jsonl",
            )
            with open(result_file, 'r') as file:
                for line in file:
                    record = json.loads(line)
                    system = record["task"]
                    infos[system][0] += int(record["syntax"]==1)
                    infos[system][1] += int(record["function"]==1)
                    infos[system][2] += int(record["formal"]==1)
            num_correct_syntax = [infos[system][0] for system in infos]
            num_correct_function = [infos[system][1] for system in infos]
            num_correct_formal = [infos[system][2] for system in infos]
        else:
            assert False,'undefined task level'
        syntax_1 = estimate_pass_at_k(num_samples, num_correct_syntax, 1).mean()
        syntax_5 = estimate_pass_at_k(num_samples, num_correct_syntax, 5).mean()
        function_1 = estimate_pass_at_k(num_samples, num_correct_function, 1).mean()
        function_5 = estimate_pass_at_k(num_samples, num_correct_function, 5).mean()
        formal_1 = estimate_pass_at_k(num_samples, num_correct_formal, 1).mean()
        formal_5 = estimate_pass_at_k(num_samples, num_correct_formal, 5).mean()
        print(f'task_level:{task_level}',syntax_1, syntax_5, function_1, function_5, formal_1, formal_5)
