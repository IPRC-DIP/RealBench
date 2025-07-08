import os
import argparse
"""
A script to check if the document table hasall the signals included.

Run:
use --mode to specify if you use module signal definition or module
instantiation code. 1 for former and 2 for latter. The default is 1.

Input:

1. Module instantiation code. It only support signal name explicitly 
written. Or module signal definition code.

2. Module signal document table. |name|direction|width|description|

Output:
Error if any signal in the table is wrong.

Limitation:
1. Cannot check if the signal is marked with macro. A warning
will be printed and you should check it manually.
2. Mode 2 cannot check the direction of the signal. A warning
will be printed and you should check it manually.
3. Cannot check if the bit width is correct. No warning will 
be printed.
"""
os.chdir(os.path.dirname(__file__))
parser = argparse.ArgumentParser()
parser.add_argument("--mode", type=int, default=1, help="Specify the mode: 1 for module signal definition, 2 for module instantiation.")
args = parser.parse_args()
mode = args.mode

with open("inst.in", "r") as fin, open("inst.out", "w") as fout:
    lines = fin.readlines()
    lines = [line.strip() for line in lines if line.strip()]
    macro = False
    signals = dict()
    for line in lines:
        if line.startswith("//"):
            continue
        # module instance or module signal definition
        # the followings has to occupy whole line
        #     modulename instname ( or module modulename (
        #     );
        line = line.split("|")
        if len(line) == 1:
            line = line[0]
            if line.endswith("(") or line.startswith(");"):
                continue
            if line.startswith("`if") or line.startswith("`endif"):
                macro = True
                continue
            line = line.split(",")
            for sig in line:
                sig = sig.strip()
                if len(sig) == 0 or sig.startswith("//"):
                    continue
                if mode == 2:
                    i = sig.find("(")
                    name = sig[1:i].strip()
                    signals[name] = [False, None]
                elif mode == 1:
                    dir = 0
                    if sig.startswith("input"):
                        dir = 1
                    elif sig.startswith("output"):
                        dir = 2
                    name = sig.split(" ")[-1].strip()
                    signals[name] = [False, dir]      
                    # dict generated:
                    # signals = {"signal_name" : [is_appeared_in_table, direction]}
        elif len(line) == 5 or len(line) == 6:
            # document table
            # |name|[direction]|width|description|
            name = line[1].strip()
            dir = 1 if line[2].strip() == "input" or line[2].strip() == "Input" else 2
            if name in signals:
                if signals[name][0]:
                    print(f"Warning: {name} is duplicated in the document table")
                signals[name][0] = True
                if signals[name][1] is not None:
                    if signals[name][1] != dir:
                        print(f"Error: {name} direction is different in the document table")
            else:
                print(f"Error: {name} is not in the instance list")
    for name, val in signals.items():
        used = val[0]
        dir = val[1]
        if not used:
            print(f"Error: {name} is not appeared in the document table")
    if mode == 2:
        print("Warning: You are using mode 2. Please check the diretion manually.")
    if macro:
        print("Warning: Optional signals are used. Please check the document table manually.")
                
            