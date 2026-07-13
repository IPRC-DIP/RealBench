#!/usr/bin/env python3
"""
RTL Evaluation Pipeline
=======================

Benchmark creation, RTL collection, verilator verification, and reporting.

Dependencies: numpy, joblib, verilator

Quick start (with run.sh)
-------------------------

    # 1. Create benchmark tasks
    python evaluation.py mk_bench \\
        --projects-dir /path/to/RealBench \\
        --target /path/to/benchmark_output

    # 2. Run Claude Code on all modules (use run.sh — see below)
    bash run.sh 1

    # 3. Evaluate: collect + verify + report
    python evaluation.py all \\
        --source /path/to/benchmark_output \\
        --output-dir /path/to/eval_output \\
        --solution-name my_experiment \\
        --bench-repo /path/to/RealBench

Subcommands
-----------

    mk_bench   Create task directories from raw RealBench project folders.
               Copies Makefiles, golden RTL, docs; generates task.md.

    collect    Scan module dirs for generated .v files, group by system
               (aes, sdc, e203), write JSONL to samples/<name>/.

    evaluate   Run verilator testbench verification on each module,
               compute pass@1 metrics, save results JSON with per-module detail.

    report     Render results as markdown: overall pass@1, per-module
               PASS/FAIL table, failure details with error messages.

    all        Shorthand for collect + evaluate + report.

Note: Running Claude Code is handled by run.sh (bash), which uses
find | xargs -P for robust parallel execution.

Directory layout
----------------

    benchmark_output/         # created by mk_bench
      aes_sbox/
        task.md               # task description
        Makefile              # from RealBench verification/
        aes_sbox.v            # golden RTL (overwritten by Claude)
        run.traj.json         # Claude run metadata

    eval_output/              # created by collect/evaluate/report
      samples/<name>/
        aes.jsonl sdc.jsonl e203_hbirdv2.jsonl
      results/<name>_module_results.json
      report/<name>_evaluation.md
"""

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

import numpy as np
from joblib import Parallel, delayed

# ==============================================================================
# Constants
# ==============================================================================
MODULE_NAMES = [
    "sd_bd", "sd_clock_divider", "sd_crc_16", "sd_crc_7", "sd_controller_wb",
    "sd_data_master", "sd_cmd_master", "sd_rx_fifo", "sd_tx_fifo",
    "sd_fifo_rx_filler", "sd_fifo_tx_filler", "sd_data_serial_host",
    "sd_cmd_serial_host", "sdc_controller", "aes_sbox", "aes_rcon",
    "aes_inv_sbox", "aes_key_expand_128", "aes_cipher_top", "aes_inv_cipher_top",
    "e203_biu", "e203_clk_ctrl", "e203_clkgate", "e203_core", "e203_cpu",
    "e203_cpu_top", "e203_dtcm_ctrl", "e203_dtcm_ram", "e203_extend_csr",
    "e203_exu", "e203_exu_alu", "e203_exu_alu_bjp", "e203_exu_alu_csrctrl",
    "e203_exu_alu_dpath", "e203_exu_alu_lsuagu", "e203_exu_alu_muldiv",
    "e203_exu_alu_rglr", "e203_exu_branchslv", "e203_exu_commit", "e203_exu_csr",
    "e203_exu_decode", "e203_exu_disp", "e203_exu_excp", "e203_exu_longpwbck",
    "e203_exu_nice", "e203_exu_oitf", "e203_exu_regfile", "e203_exu_wbck",
    "e203_ifu", "e203_ifu_ifetch", "e203_ifu_ift2icb", "e203_ifu_litebpu",
    "e203_ifu_minidec", "e203_irq_sync", "e203_itcm_ctrl", "e203_itcm_ram",
    "e203_lsu", "e203_lsu_ctrl", "e203_reset_ctrl", "e203_srams",
]

SYSTEM_NAMES = ["sdc_controller", "aes_cipher_top", "aes_inv_cipher_top", "e203_cpu_top"]

BENCHMARK_INFO = {
    "sdc": {
        "sd_bd": [],
        "sd_clock_divider": [],
        "sd_crc_16": [],
        "sd_crc_7": [],
        "sd_controller_wb": [],
        "sd_data_master": [],
        "sd_cmd_master": [],
        "sd_rx_fifo": [],
        "sd_tx_fifo": [],
        "sd_fifo_rx_filler": ["sd_rx_fifo"],
        "sd_fifo_tx_filler": ["sd_tx_fifo"],
        "sd_data_serial_host": ["sd_crc_16"],
        "sd_cmd_serial_host": ["sd_crc_7"],
        "sdc_controller": [
            "sd_bd", "sd_clock_divider", "sd_controller_wb", "sd_data_master",
            "sd_cmd_master", "sd_fifo_rx_filler", "sd_fifo_tx_filler",
            "sd_data_serial_host", "sd_cmd_serial_host",
        ],
    },
    "aes": {
        "aes_sbox": [],
        "aes_rcon": [],
        "aes_inv_sbox": [],
        "aes_key_expand_128": ["aes_sbox", "aes_rcon"],
        "aes_cipher_top": ["aes_key_expand_128", "aes_sbox"],
        "aes_inv_cipher_top": ["aes_key_expand_128", "aes_inv_sbox"],
    },
    "e203_hbirdv2": {
        "e203_biu": ["sirv_gnrl_icb_arbt", "sirv_gnrl_icb_splt", "sirv_gnrl_icb_buffer"],
        "e203_clk_ctrl": ["e203_clkgate", "sirv_gnrl_dffr"],
        "e203_clkgate": [],
        "e203_core": ["e203_ifu", "e203_exu", "e203_lsu", "e203_biu"],
        "e203_cpu": [
            "e203_reset_ctrl", "e203_clk_ctrl", "e203_irq_sync", "e203_extend_csr",
            "e203_subsys_nice_core", "e203_core", "e203_itcm_ctrl", "e203_dtcm_ctrl",
        ],
        "e203_cpu_top": ["e203_cpu", "e203_srams"],
        "e203_dtcm_ctrl": ["sirv_gnrl_icb_arbt", "sirv_sram_icb_ctrl"],
        "e203_dtcm_ram": ["sirv_gnrl_ram"],
        "e203_extend_csr": [],
        "e203_exu": [
            "e203_exu_regfile", "e203_exu_decode", "e203_exu_disp", "e203_exu_oitf",
            "e203_exu_alu", "e203_exu_longpwbck", "e203_exu_wbck", "e203_exu_commit",
            "e203_exu_csr",
        ],
        "e203_exu_alu": [
            "e203_exu_nice", "e203_exu_alu_csrctrl", "e203_exu_alu_bjp",
            "e203_exu_alu_lsuagu", "e203_exu_alu_rglr", "e203_exu_alu_muldiv",
            "e203_exu_alu_dpath",
        ],
        "e203_exu_alu_bjp": [],
        "e203_exu_alu_csrctrl": [],
        "e203_exu_alu_dpath": ["sirv_gnrl_dffl"],
        "e203_exu_alu_lsuagu": ["sirv_gnrl_dfflr"],
        "e203_exu_alu_muldiv": ["sirv_gnrl_dfflr"],
        "e203_exu_alu_rglr": [],
        "e203_exu_branchslv": [],
        "e203_exu_commit": ["e203_exu_branchslv", "e203_exu_excp"],
        "e203_exu_csr": ["sirv_gnrl_dfflr", "sirv_gnrl_dffr"],
        "e203_exu_decode": [],
        "e203_exu_disp": [],
        "e203_exu_excp": ["sirv_gnrl_dfflr"],
        "e203_exu_longpwbck": [],
        "e203_exu_nice": ["sirv_gnrl_fifo"],
        "e203_exu_oitf": ["sirv_gnrl_dfflr", "sirv_gnrl_dffl"],
        "e203_exu_regfile": ["sirv_gnrl_dffl", "sirv_gnrl_ltch"],
        "e203_exu_wbck": [],
        "e203_ifu": ["e203_ifu_ifetch", "e203_ifu_ift2icb"],
        "e203_ifu_ifetch": [
            "sirv_gnrl_dffrs", "sirv_gnrl_dfflr", "e203_ifu_minidec", "e203_ifu_litebpu",
        ],
        "e203_ifu_ift2icb": ["sirv_gnrl_bypbuf", "sirv_gnrl_dfflr", "sirv_gnrl_dffl"],
        "e203_ifu_litebpu": ["sirv_gnrl_dfflr"],
        "e203_ifu_minidec": ["e203_exu_decode"],
        "e203_irq_sync": ["sirv_gnrl_sync"],
        "e203_itcm_ctrl": [
            "sirv_gnrl_icb_n2w", "sirv_gnrl_icb_arbt", "sirv_sram_icb_ctrl",
            "sirv_gnrl_dfflr",
        ],
        "e203_itcm_ram": ["sirv_gnrl_ram"],
        "e203_lsu": ["e203_lsu_ctrl"],
        "e203_lsu_ctrl": [
            "sirv_gnrl_icb_arbt", "sirv_gnrl_dfflr", "sirv_gnrl_pipe_stage",
            "sirv_gnrl_fifo",
        ],
        "e203_reset_ctrl": [],
        "e203_srams": ["e203_itcm_ram", "e203_dtcm_ram"],
    },
}

SYSTEM_PREFIX_MAP = {
    "aes": "aes",
    "sd": "sdc",
    "e203": "e203_hbirdv2",
}

TASK_TEMPLATE = """Task: Implement the Verilog module {module_name} and a SystemVerilog testbench.

Requirements:
- Specifications: Follow `doc/{module_name}.md`.
- RTL: Module name must be `{module_name}`. Save as `{module_name}.v`.
- Testbench: Module name must be `tb`. Save as `{module_name}_tb.sv`.
- Compiler: Verilator. Code must be synthesizable.

Workflow:
1. Read repository files and Makefile.
2. Write the RTL and testbench code following `doc/{module_name}.md`.
3. Run "make all" to compile and simulate.
4. If errors occur, fix the code and repeat step 3 until successful."""


# ==============================================================================
# Subcommand: mk_bench
# ==============================================================================
def cmd_mk_bench(args):
    """Generate benchmark task directories from raw RealBench project folders."""
    projects = ["aes", "e203_hbirdv2", "sdc"]
    repo_base = Path(args.target)
    projects_dir = Path(args.projects_dir)

    repo_base.mkdir(parents=True, exist_ok=True)
    created = 0

    for project_name in projects:
        project_path = projects_dir / project_name
        if not project_path.is_dir():
            print(f"Skipping {project_name}: Directory not found at {project_path}")
            continue

        print(f"Processing project: {project_name}")

        for module_path in sorted(project_path.iterdir()):
            if not module_path.is_dir():
                continue
            module_name = module_path.name
            if module_name not in MODULE_NAMES and module_name not in SYSTEM_NAMES:
                continue

            module_dest = repo_base / module_name
            module_dest.mkdir(parents=True, exist_ok=True)
            project_dir = module_path.parent
            copied_v_files = []

            # Copy verification files (Makefile, .v stimulus, etc.) — skip .sv golden files
            verification_src = module_path / "verification"
            if verification_src.is_dir():
                for f in verification_src.iterdir():
                    if f.is_file() and not f.name.endswith(".sv"):
                        shutil.copy2(str(f), str(module_dest / f.name))
                        if f.suffix == ".v":
                            copied_v_files.append(f.stem)

            if not args.pure_code:
                doc_dest = module_dest / "doc"
                doc_file = module_path / f"{module_name}.md"
                if doc_file.exists():
                    doc_dest.mkdir(exist_ok=True)
                    shutil.copy2(str(doc_file), str(doc_dest / f"{module_name}.md"))

            # Generate task.md
            task_md = module_dest / "task.md"
            task_md.write_text(TASK_TEMPLATE.format(module_name=module_name))

            print(f"  Created: {module_name}")
            created += 1

    print(f"\n[Success] {created} benchmark tasks generated in {repo_base.resolve()}")


# ==============================================================================
# Subcommand: collect
# ==============================================================================
def cmd_collect(args):
    """Collect generated .v files from module dirs into grouped JSONL files."""
    source = Path(args.source)
    target = Path(args.output_dir) / "samples" / args.solution_name

    groups = {
        "aes": "aes.jsonl",
        "sdc": "sdc.jsonl",
        "e203_hbirdv2": "e203_hbirdv2.jsonl",
    }
    results = {filename: [] for filename in groups.values()}
    processed = 0
    skipped = 0

    for module_dir in sorted(source.iterdir()):
        if not module_dir.is_dir():
            continue
        module_name = module_dir.name

        # Skip non-module directories
        if module_name not in MODULE_NAMES and module_name not in SYSTEM_NAMES:
            continue

        rtl_file = module_dir / f"{module_name}.v"
        if not rtl_file.exists():
            print(f"Warning: No {rtl_file.name} in {module_dir}")
            skipped += 1
            continue

        code = rtl_file.read_text(encoding="utf-8")
        if not code.strip():
            print(f"Warning: Empty RTL in {module_dir}")
            skipped += 1
            continue

        code = re.sub(r'^\s*`timescale.*$', '', code, flags=re.IGNORECASE | re.MULTILINE)

        system_prefix = None
        for prefix, system in SYSTEM_PREFIX_MAP.items():
            if module_name.startswith(prefix):
                system_prefix = system
                break

        if system_prefix is None:
            print(f"Warning: Unrecognized module prefix for '{module_name}'")
            skipped += 1
            continue

        target_file = groups[system_prefix]
        results[target_file].append({
            "task": module_name,
            "codeid": 1,
            "code": code,
        })
        processed += 1

    target.mkdir(parents=True, exist_ok=True)

    for filename, entries in results.items():
        if entries:
            out_path = target / filename
            with open(out_path, "w", encoding="utf-8") as f:
                for entry in entries:
                    f.write(json.dumps(entry) + "\n")
            print(f"Saved {len(entries)} records to {out_path}")

    print(f"\nCollect done: {processed} processed, {skipped} skipped")
    if processed == 0:
        sys.exit(1)


# ==============================================================================
# Subcommand: evaluate
# ==============================================================================
def testbench_verification(code, system_name, module_name, bench_repo):
    """Run verilator testbench verification for a single module."""
    template_dir = Path(bench_repo) / system_name / module_name / "verification"

    with tempfile.TemporaryDirectory() as temp_dir:
        temp_path = Path(temp_dir)

        if not template_dir.is_dir():
            return -2, -2, f"Template dir not found: {template_dir}", ""

        for item in template_dir.iterdir():
            if item.is_file():
                shutil.copy(str(item), str(temp_path / item.name))

        top_file = temp_path / f"{module_name}_top.sv"
        if not top_file.exists():
            return -2, -2, f"Top file not found: {top_file}", ""
        top_file.unlink()
        top_file.write_text(code, encoding="utf-8")

        try:
            result = subprocess.run(
                ["make", "all"],
                cwd=str(temp_path),
                timeout=5 * 60,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
            )
        except subprocess.TimeoutExpired:
            return 0, 0, "Verilator timed out (5 min)", ""

        syntax_err_msg = ""
        semantic_err_msg = ""

        if result.stderr:
            err_msg = result.stderr.decode(errors="replace")
            for line in err_msg.split('\n'):
                if line.startswith("%Error") or line.startswith("%Warning"):
                    syntax_err_msg += line + "\n"
            syntax = 0
            semantic = 0
            return syntax, semantic, syntax_err_msg, semantic_err_msg

        tb_msg = result.stdout.decode(errors="replace")
        for line in tb_msg.split('\n'):
            if "Hint: Output" in line and "no mismatches" in line:
                continue
            elif "Hint: Output" in line and "mismatches" in line:
                semantic_err_msg += line[6:] + '\n'

        syntax = 1
        semantic = 1 if semantic_err_msg == "" else 0
        return syntax, semantic, syntax_err_msg, semantic_err_msg


def estimate_pass_at_k(num_samples, num_correct, k):
    """Estimates pass@k: 1 - comb(n - c, k) / comb(n, k)."""
    def estimator(n, c, k_val):
        if n - c < k_val:
            return 1.0
        return 1.0 - np.prod(1.0 - k_val / np.arange(n - c + 1, n + 1))

    if isinstance(num_samples, int):
        return np.array([estimator(num_samples, int(c), k) for c in num_correct])
    else:
        assert len(num_samples) == len(num_correct)
        return np.array([estimator(int(n), int(c), k) for n, c in zip(num_samples, num_correct)])


def cmd_evaluate(args):
    """Run verilator testbench verification and compute pass@k metrics."""
    samples_dir = Path(args.output_dir) / "samples" / args.solution_name
    results_dir = Path(args.output_dir) / "results"
    results_dir.mkdir(parents=True, exist_ok=True)

    all_infos = {module: [0, 0, 0] for module in MODULE_NAMES}
    # Per-module detail for reporting: {module: {"syntax": pass/fail, "function": pass/fail, "syntax_info": ..., "function_info": ...}}
    per_module_detail = {}

    for system_name in BENCHMARK_INFO:
        jsonl_file = samples_dir / f"{system_name}.jsonl"
        if not jsonl_file.exists():
            print(f"Warning: JSONL not found, skipping: {jsonl_file}")
            continue

        data = []
        with open(jsonl_file, 'r', encoding='utf-8') as f:
            for line in f:
                data.append(json.loads(line))

        print(f"Verifying {len(data)} modules in {jsonl_file.name} ({args.workers} workers)...")
        results = Parallel(n_jobs=args.workers)(
            delayed(testbench_verification)(
                r["code"], system_name, r["task"], args.bench_repo
            )
            for r in data
        )

        for idx, record in enumerate(data):
            record["syntax"] = results[idx][0]
            record["function"] = results[idx][1]
            record["syntax_info"] = results[idx][2]
            record["function_info"] = results[idx][3]

        verified_dir = (
            Path(args.output_dir) / "samples_after_verilator" / args.solution_name
        )
        verified_dir.mkdir(parents=True, exist_ok=True)
        out_path = verified_dir / jsonl_file.name
        with open(out_path, 'w', encoding='utf-8') as f:
            for record in data:
                f.write(json.dumps(record) + '\n')

        for record in data:
            module = record["task"]
            syn_ok = int(record["syntax"] == 1)
            fun_ok = int(record["function"] == 1)
            if module in all_infos:
                all_infos[module][0] += syn_ok
                all_infos[module][1] += fun_ok
            per_module_detail[module] = {
                "syntax": "PASS" if syn_ok else "FAIL",
                "function": "PASS" if fun_ok else "FAIL",
                "syntax_info": record.get("syntax_info", "")[:200] if syn_ok == 0 else "",
                "function_info": record.get("function_info", "")[:200] if fun_ok == 0 else "",
            }

    num_correct_syntax = [all_infos[k][0] for k in all_infos]
    num_correct_function = [all_infos[k][1] for k in all_infos]

    overall_stats = {
        "syntax_1": float(estimate_pass_at_k(args.num_samples, num_correct_syntax, 1).mean()),
        "function_1": float(estimate_pass_at_k(args.num_samples, num_correct_function, 1).mean()),
        "total_modules": len(per_module_detail),
        "syntax_pass": sum(1 for v in per_module_detail.values() if v["syntax"] == "PASS"),
        "function_pass": sum(1 for v in per_module_detail.values() if v["function"] == "PASS"),
    }

    results_data = {
        "solution_name": args.solution_name,
        "task_level": "module",
        "num_samples": args.num_samples,
        "is_formal": False,
        "overall_stats": overall_stats,
        "per_module": all_infos,
        "per_module_detail": per_module_detail,
    }

    json_path = results_dir / f"{args.solution_name}_module_results.json"
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(results_data, f, indent=2)

    print(f"\nResults saved to {json_path}")


# ==============================================================================
# Subcommand: report
# ==============================================================================
def cmd_report(args):
    """Pretty-print evaluation results as markdown."""
    json_path = Path(args.output_dir) / "results" / f"{args.solution_name}_module_results.json"
    if not json_path.exists():
        print(f"Error: Results file not found: {json_path}")
        sys.exit(1)

    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    solution_name = data.get("solution_name", "?")
    overall_stats = data.get("overall_stats", {})
    per_module_detail = data.get("per_module_detail", {})

    # Build markdown report
    lines = []
    lines.append("# RTL Verification Results")
    lines.append("")
    lines.append(f"**Solution**: `{solution_name}`  ")
    lines.append(f"**Task Level**: module  ")

    lines.append("")
    lines.append("## Overall (Pass@1)")
    lines.append("")
    lines.append(f"| Metric    | Pass@1 |")
    lines.append(f"|-----------|--------|")
    lines.append(f"| Syntax    | {overall_stats.get('syntax_1', 0):.2%} |")
    lines.append(f"| Function  | {overall_stats.get('function_1', 0):.2%} |")
    lines.append("")
    lines.append(f"{overall_stats.get('syntax_pass', 0)}/{overall_stats.get('total_modules', 0)} syntax correct, "
                  f"{overall_stats.get('function_pass', 0)}/{overall_stats.get('total_modules', 0)} function correct")

    # Failure summary
    syntax_failures = {m: d for m, d in per_module_detail.items() if d["syntax"] == "FAIL"}
    function_failures = {m: d for m, d in per_module_detail.items() if d["function"] == "FAIL"}

    if syntax_failures:
        lines.append("")
        lines.append("## Syntax Failures")
        lines.append("")
        lines.append(f"| # | Module | Error |")
        lines.append(f"|---|--------|-------|")
        for i, (module, detail) in enumerate(sorted(syntax_failures.items()), 1):
            err = detail.get("syntax_info", "").replace("\n", " ").replace("|", "\\|")[:120]
            lines.append(f"| {i} | `{module}` | {err} |")

    if function_failures:
        lines.append("")
        lines.append("## Function Failures")
        lines.append("")
        lines.append(f"| # | Module | Error |")
        lines.append(f"|---|--------|-------|")
        for i, (module, detail) in enumerate(sorted(function_failures.items()), 1):
            err = detail.get("function_info", "").replace("\n", " ").replace("|", "\\|")[:120]
            lines.append(f"| {i} | `{module}` | {err} |")

    lines.append("")
    lines.append("## Per-Module Detail")
    lines.append("")
    lines.append(f"| Module | Syntax | Function |")
    lines.append(f"|--------|--------|----------|")
    for module in sorted(per_module_detail.keys()):
        detail = per_module_detail[module]
        syn = "PASS" if detail["syntax"] == "PASS" else "FAIL"
        fun = "PASS" if detail["function"] == "PASS" else "FAIL"
        lines.append(f"| `{module}` | {syn} | {fun} |")

    md = "\n".join(lines)

    # Write to file
    report_dir = Path(args.output_dir) / "report"
    report_dir.mkdir(parents=True, exist_ok=True)
    report_path = report_dir / f"{solution_name}_evaluation.md"
    report_path.write_text(md)
    print(f"Report saved to {report_path}")

    # Also print to stdout
    print(md)


# ==============================================================================
# Subcommand: all (run full pipeline)
# ==============================================================================
def cmd_all(args):
    """Run the full pipeline: collect + evaluate + report."""
    cmd_collect(args)
    cmd_evaluate(args)
    cmd_report(args)


# ==============================================================================
# CLI
# ==============================================================================
def main():
    parser = argparse.ArgumentParser(
        description="Self-contained RTL evaluation pipeline."
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    # --- mk_bench ---
    p = subparsers.add_parser("mk_bench", help="Generate benchmark task directories from RealBench")
    p.add_argument("--projects-dir", required=True,
                   help="Directory containing aes/, e203_hbirdv2/, sdc/ subdirs (RealBench repo)")
    p.add_argument("--target", required=True,
                   help="Target directory for generated benchmark tasks")
    p.add_argument("--pure-code", action="store_true",
                   help="Skip doc/ file copying")
    p.set_defaults(func=cmd_mk_bench)

    # --- collect ---
    p = subparsers.add_parser("collect", help="Collect generated .v files into JSONL")
    p.add_argument("--source", required=True,
                   help="Directory containing module subdirectories")
    p.add_argument("--output-dir", required=True,
                   help="Output directory for samples/")
    p.add_argument("--solution-name", default="results",
                   help="Solution name (default: results)")
    p.set_defaults(func=cmd_collect)

    # --- evaluate ---
    p = subparsers.add_parser("evaluate", help="Run verilator verification and compute pass@k")
    p.add_argument("--output-dir", required=True,
                   help="Directory containing samples/ and for results/")
    p.add_argument("--solution-name", required=True,
                   help="Solution name")
    p.add_argument("--bench-repo", required=True,
                   help="Path to RealBench repo (for verification templates)")
    p.add_argument("--workers", type=int, default=40,
                   help="Parallel workers for verilator (default: 40)")
    p.add_argument("--num-samples", type=int, default=1,
                   help="Number of samples for pass@k (default: 1)")
    p.set_defaults(func=cmd_evaluate)

    # --- report ---
    p = subparsers.add_parser("report", help="Pretty-print evaluation results")
    p.add_argument("--output-dir", required=True,
                   help="Directory containing results/")
    p.add_argument("--solution-name", required=True,
                   help="Solution name")
    p.set_defaults(func=cmd_report)

    # --- all ---
    p = subparsers.add_parser("all", help="Run collect + evaluate + report")
    p.add_argument("--source", required=True,
                   help="Directory containing module subdirectories")
    p.add_argument("--output-dir", required=True,
                   help="Output directory for samples/ and results/")
    p.add_argument("--solution-name", required=True,
                   help="Solution name")
    p.add_argument("--bench-repo", required=True,
                   help="Path to RealBench repo")
    p.add_argument("--workers", type=int, default=40,
                   help="Parallel workers for verilator (default: 40)")
    p.add_argument("--num-samples", type=int, default=1,
                   help="Number of samples for pass@k (default: 1)")
    p.set_defaults(func=cmd_all)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
