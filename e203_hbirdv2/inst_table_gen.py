# it is a small script used to generate a markdown table describing port connections.
import os

os.chdir(os.path.dirname(__file__))

param_header = " | Parameter Name | Value |\n | -------------- | ----- |\n"
port_header = " | Port Name | Direction | Description |\n | --------- | --------- | ----------- |\n"
port_description = "Connect with"

with open("inst.in", "r") as fin, open("inst.out", "w") as fout:
    lines = fin.readlines()
    lines = [line.strip() for line in lines if line.strip()]
    params = list()# name | setvalue
    ports = list()# name | direction | connection
    inst_count = 0
    for line in lines:
        line = line.split("|")
        if len(line) == 5: # param
            params.append([line[1].replace(" ", ""), ""])
        elif len(line) == 6: # port
            ports.append([line[1].replace(" ", ""), line[2].replace(" ", ""), ""])
        else:
            line = line[0]
            param = line[line.find("#("): line.find(")") + 1].replace("#", "").replace("(", "").replace(")", "").split(",")
            if len(param) < len(params):
                print(f"Warning: {line.split(" ")[0]} params not fully defined, need to check manually")
            for j, val in enumerate(param):
                val = val.replace(" ", "")
                params[j][1] = val
            i = line.find(")")
            port = line[i+1+line[i+1:].find("("):i+1+line[i+1:].find(")")+1].replace("(", "").replace(")", "").split(",")
            if len(port) < len(ports):
                print(f"Warning: {line.split(" ")[0]} ports not fully initiated, need to check manually") 
            for j, val in enumerate(port):
                val = val.replace(" ", "")
                ports[j][2] = val
            # starting
            fout.write(f"{inst_count+1}. \n")
            inst_count += 1
            # write params
            fout.write(param_header)
            for name, value in params:
                fout.write(f" | {name} | {value} |\n")
            # write ports
            fout.write(port_header)
            for name, direction, connection in ports:
                fout.write(f" | {name} | {direction} | {port_description} {connection} |\n")
            # ending
            fout.write("\n")
                    
                    
            
            