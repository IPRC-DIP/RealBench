module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic bjp_i_valid,
    output logic [31:0] bjp_i_rs1,
    output logic [31:0] bjp_i_rs2,
    output logic [31:0] bjp_i_imm,
    output logic [31:0] bjp_i_pc,
    output logic [16:0] bjp_i_info,
    output logic bjp_o_ready,
    output logic bjp_req_alu_cmp_res,
    output logic [31:0] bjp_req_alu_add_res,
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

	task base_all_low();
		bjp_i_valid = 0;
		bjp_i_rs1 = 0;
		bjp_i_rs2 = 0;
		bjp_i_imm = 0;
		bjp_i_pc = 0;
		bjp_i_info = 0;
		bjp_o_ready = 0;
		bjp_req_alu_cmp_res = 0;
		bjp_req_alu_add_res = 0;
	endtask

	task base_all_high();
		bjp_i_valid = ~0;
		bjp_i_rs1 = ~0;
		bjp_i_rs2 = ~0;
		bjp_i_imm = ~0;
		bjp_i_pc = ~0;
		bjp_i_info = ~0;
		bjp_o_ready = ~0;
		bjp_req_alu_cmp_res = ~0;
		bjp_req_alu_add_res = ~0;
	endtask

	task base_all_random();
		bjp_i_valid = $urandom;
		bjp_i_rs1 = $urandom;
		bjp_i_rs2 = $urandom;
		bjp_i_imm = $urandom;
		bjp_i_pc = $urandom;
		bjp_i_info = $urandom;
		bjp_o_ready = $urandom;
		bjp_req_alu_cmp_res = $urandom;
		bjp_req_alu_add_res = $urandom;
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

    task set_validready(input i_valid,input o_ready);
        bjp_i_valid = i_valid;
        bjp_o_ready = o_ready;
    endtask

    task set_random_input();
        bjp_i_rs1 = $urandom;
		bjp_i_rs2 = $urandom;
		bjp_i_imm = $urandom;
		bjp_i_pc = $urandom;
    endtask

    task Task1();
        @(negedge clk);         // mret
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_MRET] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;  // 顺便测试结果返回逻辑

        @(negedge clk);         // dret
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_DRET] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // fencei
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_FENCEI] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // beq
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BEQ] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // bne
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BNE] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;


        @(negedge clk);         // blt
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BLT] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // bgt
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BGT] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // bltu
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BLTU] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // bgtu
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BXX] = 1;
        bjp_i_info[`E203_DECINFO_BJP_BGTU] = 1;
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // jump rv32
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 1;
        bjp_i_info[`E203_DECINFO_BJP_JUMP] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

        @(negedge clk);         // jump not rv32
        base_all_low();
        set_validready(1,1);
        set_random_input();
        bjp_i_info[`E203_DECINFO_RV32] = 0;
        bjp_i_info[`E203_DECINFO_BJP_JUMP] = 1;
        bjp_req_alu_add_res = $random;
        bjp_req_alu_cmp_res = $random;

    endtask

    initial begin
        // 初始化
        base_all_low();
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);
        @(negedge clk);
        reset_test(1);
        @(negedge clk);

        // 
        Task1();

        // 结束
        @(negedge clk);
        $finish;
    end
endmodule