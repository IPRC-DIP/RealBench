# RealBench
<p align="left">
    <a href="https://arxiv.org/abs/2507.16200"><img src="https://img.shields.io/badge/arXiv-2507.16200-b31b1b.svg?style=for-the-badge">
    <a href="https://huggingface.co/datasets/Pengwei-Jin/RealBench"><img src="https://img.shields.io/badge/🤗%20Hugging%20Face-RealBench-%23ff8811.svg?style=for-the-badge">
    <a href="https://opensource.org/license/mit/"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge">
</p>
       
## Overview

RealBench is a benchmark for complex IP design tasks in real scenarios. It has the following features
- More complex tasks
- System-level and module-level tasks
- Multi-modal data
- Syntax, function, and formal correctness verification

## Setup Linux Environment

Use `conda` to set up this environment

1. configure `conda` environment

   ```bash
   conda env create -f conda_env.yml
   ```

2. Check tool version

   ```bash
   conda activate realbench
   python --version
   # Python 3.10.18
   gcc -v
   # ...
   # gcc version 14.3.0 (conda-forge gcc 14.3.0-3)
   verilator
   # Usage:
   #         verilator --help
   #         verilator --version
   #         verilator --binary -j 0 [options] [source_files.v]... [opt_c_files.cpp/c/cc/a/o/so]
   #         verilator --cc [options] [source_files.v]... [opt_c_files.cpp/c/cc/a/o/so]
   #         verilator --sc [options] [source_files.v]... [opt_c_files.cpp/c/cc/a/o/so]
   #         verilator --lint-only -Wall [source_files.v]...
   yosys -V
   # Yosys 0.55 ...
   ```

To use formal verification, you need also install `jaspergold` in your environment.

## Usage 

### Decryption

The documents are encrypted with GPG to prevent crawlers from scraping test data for direct training. Decryption is required prior to use.

```bash
make decrypt
make clean_encrypt
```

### Problem Generation

Use `generate_problem.py` to extract problem description from project files.

```bash
python generate_problem.py --task_level module
```

There are two options for `task_level`. `module` represents the task description of module level, and `system` represents the task description of system level.

### Verification

Use `run_verify.py` to verify the correctness of the model generation results. 

```bash
python run_verify.py --solution_name codev-qwen-7b --formal --task_level module --num_samples 20
```

`--solution_name` indicates the method/model name that generates the RTL code to be verified.

`--formal` can be used to add formal verification (you need to install `jaspergold` in the environment first)

`--task_level` indicates the type of task

`--num_samples` indicates the number of samples for a single task, used to calculate `pass@k`

**Notice**: If `num_sample` is less than 5, the result of `metric@5` is unreliable. (`metric` represent `syntax`, `function`  and `formal`)

### Solution Organization

Each solution must follow the standardized format described below.

**Directory Structure**

Solutions should be organized as follows:

```
samples/
├── solution_name/
│   ├── aes.jsonl
│   ├── e203_hbirdv2.jsonl
│   └── ...
└── codev-qwen-7b/  (reference example)
```


**Contents**

The solution folder should contain JSONL files with design results

Each JSONL (JSON Lines) file must contain entries with the following required fields:

```json
{
  "task": "The module name corresponding to the code",
  "code": "The code that needs to be verified"
}
```

For details, please refer to the `samples/codev-qwen-7b` folder in the repository.

## LLM + Claude Code Evaluation
We provide a Docker-based workflow for evaluating LLM agents on RealBench. The runner invokes Claude Code on each
  generated task, records trajectories with `claude-trace`, and evaluates the generated Verilog with the RealBench flow.

### Build Docker Image
```bash
  cd llm/realbench_release
  docker build -t claude-runner:latest .
```
### Run Evaluation
Set the RealBench repository path and API credentials first:
```
  export REALBENCH_REPO=/path/to/RealBench
  export ANTHROPIC_BASE_URL=<your_api_endpoint>
  export ANTHROPIC_AUTH_TOKEN=<your_api_key>
  export ANTHROPIC_MODEL=<your_model_name>
```
Run the full pipeline:
```
  bash run.sh
```
  The pipeline has four stages:
```
  bash run.sh 0      # create task directories from RealBench
  bash run.sh 1      # run Claude Code in Docker
  bash run.sh 2      # collect generated Verilog
  bash run.sh 3      # evaluate and generate report
```

### Docker Isolation Against Prompt Injection and Host-Side Attacks
The runner limits this risk by mounting only `workdir/<task>/` as `/workspace`, never mounting the RealBench
repository with golden `.v` files, running as a non-root host UID/GID, disabling unnecessary tools such as
  `WebSearch`, `WebFetch`, `curl`, and `wget`, and restricting outbound traffic to the configured API host when
  `NETWORK_ALLOWLIST=1`.

## Paper and BibTeX

Please cite the paper if you use RealBench.

Paper: https://arxiv.org/abs/2507.16200
```
@article{jin2025realbench,
  title={RealBench: Benchmarking Verilog Generation Models with Real-World IP Designs},
  author={Jin, Pengwei and Huang, Di and Li, Chongxiao and Cheng, Shuyao and Zhao, Yang and Zheng, Xinyao and Zhu, Jiaguo and Xing, Shuyi and Dou, Bohan and Zhang, Rui and others},
  journal={arXiv preprint arXiv:2507.16200},
  year={2025}
}
```
