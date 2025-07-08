`include "e203_defines.v"
module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic alu_i_valid,
    output logic [31:0] alu_i_rs1,
    output logic [31:0] alu_i_rs2,
    output logic [31:0] alu_i_imm,
    output logic [31:0] alu_i_pc,
    output logic [20:0] alu_i_info,
    output logic alu_o_ready,
    output logic [31:0] alu_req_alu_res,
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title <= title;
        wavedrom_enable <= 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable <= 0;
    endtask

    task set_validready(input i_valid,input o_ready);
        alu_i_valid = i_valid;
        alu_o_ready = o_ready;
    endtask

    task set_random_input();
        alu_i_rs1 = $urandom;
		alu_i_rs2 = $urandom;
		alu_i_imm = $urandom;
		alu_i_pc = $urandom;
    endtask

	task Task1();
	// Add Task1 here 测试各种alu请求是否正确
        @(negedge clk);     // valid ready
        base_all_low();
		set_validready(0,0);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_ADD] = ~'0;

        @(negedge clk);     // add,同时测试操作数选取,同时测试返回结果传递逻辑
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_ADD] = 1;
        alu_i_info[`E203_DECINFO_ALU_OP2IMM] = 1;
        alu_i_info[`E203_DECINFO_ALU_OP1PC] = 1;
        alu_req_alu_res = $urandom;
        
        @(negedge clk);     // sub
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SUB] = 1;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // xor
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_XOR] = ~'0;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // sll
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SLL] = ~'0;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // srl
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SRL] = ~'0;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // sra
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SRA] = ~'0;
        alu_req_alu_res = $urandom;
        
        @(negedge clk);     // or
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_OR] = ~'0;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // and
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_AND] = ~'0;
        alu_req_alu_res = $urandom;

        @(negedge clk);     // slt
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SLT] = ~'0;
        

        @(negedge clk);     // sltu
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_SLTU] = ~'0;

        @(negedge clk);     // lui
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_LUI] = ~'0;

        @(negedge clk);     // nop
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_NOP] = ~'0;
        alu_i_info[`E203_DECINFO_ALU_ADD] = ~'0;

        @(negedge clk);     // ecall
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_ECAL] = ~'0;

        @(negedge clk);     // ebreak
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_EBRK] = ~'0;

        @(negedge clk);     // wfi
        base_all_low();
		set_validready(1,1);
        set_random_input();
        alu_i_info[`E203_DECINFO_ALU_WFI] = ~'0;


	endtask

    task base_all_low();
        alu_i_valid = '0;
		alu_i_rs1 = '0;
		alu_i_rs2 = '0;
		alu_i_imm = '0;
		alu_i_pc = '0;
		alu_i_info = '0;
		alu_o_ready = '0;
		alu_req_alu_res = '0;
    endtask

	task base_all_random();
		alu_i_valid = $urandom;
		alu_i_rs1 = $urandom;
		alu_i_rs2 = $urandom;
		alu_i_imm = $urandom;
		alu_i_pc = $urandom;
		alu_i_info = $urandom;
		alu_o_ready = $urandom;
		alu_req_alu_res = $urandom;
	endtask

    task reset_test(input async=0);
        bit arfail, srfail;

        // 复位信号拉高
        rst_n = 1;
        if (async == 1)begin
            // 异步复位测试
            @(negedge clk);
            rst_n = 0;
            #1;
            arfail = !tb_match;
            rst_n = 1;
            if (arfail)
                $display("Error: Asynchronous reset failed. Ensure your design resets immediately when rst_n is asserted.");
            else
                $display("Info: Asynchronous reset succeed.");
        end
        else begin
            // 同步复位测试
            @(negedge clk); rst_n = 0;
            @(negedge clk); srfail = !tb_match;
            @(negedge clk); rst_n = 1;
            if (srfail)
                $display("Error: Synchronous reset failed. Check if your design resets on the clock edge.");
            else 
                $display("Info: Synchronous reset succeed.");
        end
    endtask

    initial begin
        // 初始化
        {
            alu_i_valid,
            alu_i_rs1,
            alu_i_rs2,
            alu_i_imm,
            alu_i_pc,
            alu_i_info,
            alu_o_ready,
            alu_req_alu_res
        } = '0;
        {rst_n,wavedrom_enable} = '0;
        wavedrom_title = "";
        
        // 测试任务1
        wavedrom_start("Task1");
		Task1();
        @(negedge clk);
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule