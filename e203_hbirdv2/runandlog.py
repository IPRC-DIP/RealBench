# 一键make all所有veerification并将结果放到output.txt中
import os
import subprocess
from datetime import datetime

def run_make_in_verification_folders():
    current_dir = os.getcwd()
    output_file = os.path.join(current_dir, "output.txt")
    
    with open(output_file, 'w') as f:
        f.write(f"Make command output - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
    
    print(f"All output will be saved to: {output_file}")
    
    for root, dirs, files in os.walk(current_dir):
        if os.path.basename(root) == "verification":
            print(f"\nProcessing directory: {root}")
            
            # 记录当前目录信息
            with open(output_file, 'a') as f:
                f.write(f"\n=== Directory: {root} ===\n")
            
            try:
                process = subprocess.Popen(
                    ['make', 'all'],
                    cwd=root,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True
                )
                
                with open(output_file, 'a') as f:
                    for line in process.stdout:
                        print(line, end='')  
                        f.write(line)
                
                return_code = process.wait()
                
                # 记录返回码
                with open(output_file, 'a') as f:
                    f.write(f"\nReturn code: {return_code}\n")
                
                if return_code == 0:
                    print(f"Successfully executed 'make all' in {root}")
                else:
                    print(f"'make all' failed in {root} with return code {return_code}")
            
            except Exception as e:
                error_msg = f"Error executing 'make all' in {root}: {str(e)}\n"
                print(error_msg)
                with open(output_file, 'a') as f:
                    f.write(error_msg)

if __name__ == "__main__":
    print("Starting 'make all' in all verification folders...")
    run_make_in_verification_folders()
    print("\nAll operations completed. Check output.txt for details.")