`include "e203_defines.v"
module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
	output logic alu_req_alu,
	output logic alu_req_alu_add,
	output logic alu_req_alu_sub,
	output logic alu_req_alu_xor,
	output logic alu_req_alu_sll,
	output logic alu_req_alu_srl,
	output logic alu_req_alu_sra,
	output logic alu_req_alu_or,
	output logic alu_req_alu_and,
	output logic alu_req_alu_slt,
	output logic alu_req_alu_sltu,
	output logic alu_req_alu_lui,
	output logic [31:0] alu_req_alu_op1,
	output logic [31:0] alu_req_alu_op2,
	output logic bjp_req_alu,
	output logic [31:0] bjp_req_alu_op1,
	output logic [31:0] bjp_req_alu_op2,
	output logic bjp_req_alu_cmp_eq,
	output logic bjp_req_alu_cmp_ne,
	output logic bjp_req_alu_cmp_lt,
	output logic bjp_req_alu_cmp_gt,
	output logic bjp_req_alu_cmp_ltu,
	output logic bjp_req_alu_cmp_gtu,
	output logic bjp_req_alu_add,
	output logic agu_req_alu,
	output logic [31:0] agu_req_alu_op1,
	output logic [31:0] agu_req_alu_op2,
	output logic agu_req_alu_swap,
	output logic agu_req_alu_add,
	output logic agu_req_alu_and,
	output logic agu_req_alu_or,
	output logic agu_req_alu_xor,
	output logic agu_req_alu_max,
	output logic agu_req_alu_min,
	output logic agu_req_alu_maxu,
	output logic agu_req_alu_minu,
	output logic agu_sbf_0_ena,
	output logic [31:0] agu_sbf_0_nxt,
	output logic agu_sbf_1_ena,
	output logic [31:0] agu_sbf_1_nxt,
	output logic muldiv_req_alu,
	output logic [34:0] muldiv_req_alu_op1,
	output logic [34:0] muldiv_req_alu_op2,
	output logic muldiv_req_alu_add,
	output logic muldiv_req_alu_sub,
	output logic muldiv_sbf_0_ena,
	output logic [32:0] muldiv_sbf_0_nxt,
	output logic muldiv_sbf_1_ena,
	output logic [32:0] muldiv_sbf_1_nxt,
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
		alu_req_alu = 0;
		alu_req_alu_add = 0;
		alu_req_alu_sub = 0;
		alu_req_alu_xor = 0;
		alu_req_alu_sll = 0;
		alu_req_alu_srl = 0;
		alu_req_alu_sra = 0;
		alu_req_alu_or = 0;
		alu_req_alu_and = 0;
		alu_req_alu_slt = 0;
		alu_req_alu_sltu = 0;
		alu_req_alu_lui = 0;
		alu_req_alu_op1 = 0;
		alu_req_alu_op2 = 0;
		bjp_req_alu = 0;
		bjp_req_alu_op1 = 0;
		bjp_req_alu_op2 = 0;
		bjp_req_alu_cmp_eq = 0;
		bjp_req_alu_cmp_ne = 0;
		bjp_req_alu_cmp_lt = 0;
		bjp_req_alu_cmp_gt = 0;
		bjp_req_alu_cmp_ltu = 0;
		bjp_req_alu_cmp_gtu = 0;
		bjp_req_alu_add = 0;
		agu_req_alu = 0;
		agu_req_alu_op1 = 0;
		agu_req_alu_op2 = 0;
		agu_req_alu_swap = 0;
		agu_req_alu_add = 0;
		agu_req_alu_and = 0;
		agu_req_alu_or = 0;
		agu_req_alu_xor = 0;
		agu_req_alu_max = 0;
		agu_req_alu_min = 0;
		agu_req_alu_maxu = 0;
		agu_req_alu_minu = 0;
		agu_sbf_0_ena = 0;
		agu_sbf_0_nxt = 0;
		agu_sbf_1_ena = 0;
		agu_sbf_1_nxt = 0;
		muldiv_req_alu = 0;
		muldiv_req_alu_op1 = 0;
		muldiv_req_alu_op2 = 0;
		muldiv_req_alu_add = 0;
		muldiv_req_alu_sub = 0;
		muldiv_sbf_0_ena = 0;
		muldiv_sbf_0_nxt = 0;
		muldiv_sbf_1_ena = 0;
		muldiv_sbf_1_nxt = 0;
	endtask

	task base_all_high();
		alu_req_alu = ~0;
		alu_req_alu_add = ~0;
		alu_req_alu_sub = ~0;
		alu_req_alu_xor = ~0;
		alu_req_alu_sll = ~0;
		alu_req_alu_srl = ~0;
		alu_req_alu_sra = ~0;
		alu_req_alu_or = ~0;
		alu_req_alu_and = ~0;
		alu_req_alu_slt = ~0;
		alu_req_alu_sltu = ~0;
		alu_req_alu_lui = ~0;
		alu_req_alu_op1 = ~0;
		alu_req_alu_op2 = ~0;
		bjp_req_alu = ~0;
		bjp_req_alu_op1 = ~0;
		bjp_req_alu_op2 = ~0;
		bjp_req_alu_cmp_eq = ~0;
		bjp_req_alu_cmp_ne = ~0;
		bjp_req_alu_cmp_lt = ~0;
		bjp_req_alu_cmp_gt = ~0;
		bjp_req_alu_cmp_ltu = ~0;
		bjp_req_alu_cmp_gtu = ~0;
		bjp_req_alu_add = ~0;
		agu_req_alu = ~0;
		agu_req_alu_op1 = ~0;
		agu_req_alu_op2 = ~0;
		agu_req_alu_swap = ~0;
		agu_req_alu_add = ~0;
		agu_req_alu_and = ~0;
		agu_req_alu_or = ~0;
		agu_req_alu_xor = ~0;
		agu_req_alu_max = ~0;
		agu_req_alu_min = ~0;
		agu_req_alu_maxu = ~0;
		agu_req_alu_minu = ~0;
		agu_sbf_0_ena = ~0;
		agu_sbf_0_nxt = ~0;
		agu_sbf_1_ena = ~0;
		agu_sbf_1_nxt = ~0;
		muldiv_req_alu = ~0;
		muldiv_req_alu_op1 = ~0;
		muldiv_req_alu_op2 = ~0;
		muldiv_req_alu_add = ~0;
		muldiv_req_alu_sub = ~0;
		muldiv_sbf_0_ena = ~0;
		muldiv_sbf_0_nxt = ~0;
		muldiv_sbf_1_ena = ~0;
		muldiv_sbf_1_nxt = ~0;
	endtask

	task base_all_random();
		alu_req_alu = $urandom;
		alu_req_alu_add = $urandom;
		alu_req_alu_sub = $urandom;
		alu_req_alu_xor = $urandom;
		alu_req_alu_sll = $urandom;
		alu_req_alu_srl = $urandom;
		alu_req_alu_sra = $urandom;
		alu_req_alu_or = $urandom;
		alu_req_alu_and = $urandom;
		alu_req_alu_slt = $urandom;
		alu_req_alu_sltu = $urandom;
		alu_req_alu_lui = $urandom;
		alu_req_alu_op1 = $urandom;
		alu_req_alu_op2 = $urandom;
		bjp_req_alu = $urandom;
		bjp_req_alu_op1 = $urandom;
		bjp_req_alu_op2 = $urandom;
		bjp_req_alu_cmp_eq = $urandom;
		bjp_req_alu_cmp_ne = $urandom;
		bjp_req_alu_cmp_lt = $urandom;
		bjp_req_alu_cmp_gt = $urandom;
		bjp_req_alu_cmp_ltu = $urandom;
		bjp_req_alu_cmp_gtu = $urandom;
		bjp_req_alu_add = $urandom;
		agu_req_alu = $urandom;
		agu_req_alu_op1 = $urandom;
		agu_req_alu_op2 = $urandom;
		agu_req_alu_swap = $urandom;
		agu_req_alu_add = $urandom;
		agu_req_alu_and = $urandom;
		agu_req_alu_or = $urandom;
		agu_req_alu_xor = $urandom;
		agu_req_alu_max = $urandom;
		agu_req_alu_min = $urandom;
		agu_req_alu_maxu = $urandom;
		agu_req_alu_minu = $urandom;
		agu_sbf_0_ena = $urandom;
		agu_sbf_0_nxt = $urandom;
		agu_sbf_1_ena = $urandom;
		agu_sbf_1_nxt = $urandom;
		muldiv_req_alu = $urandom;
		muldiv_req_alu_op1 = $urandom;
		muldiv_req_alu_op2 = $urandom;
		muldiv_req_alu_add = $urandom;
		muldiv_req_alu_sub = $urandom;
		muldiv_sbf_0_ena = $urandom;
		muldiv_sbf_0_nxt = $urandom;
		muldiv_sbf_1_ena = $urandom;
		muldiv_sbf_1_nxt = $urandom;
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

	task test_alu();
		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_add = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_sub = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_xor = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_sll = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random & 5'b11111;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_srl = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random & 5'b11111;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_sra = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random & 5'b11111;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_or = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_and = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_slt = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_sltu = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		alu_req_alu = 1;
		alu_req_alu_lui = 1;
		alu_req_alu_op1 = $random;
		alu_req_alu_op2 = $random;
	endtask

	task test_bjp();
		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_eq = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = ~bjp_req_alu_op1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_eq = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_ne = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = ~bjp_req_alu_op1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_ne = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1;
		
		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_lt = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1-1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_lt = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1+1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_gt = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1-1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_gt = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1+1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_ltu = 1;
		bjp_req_alu_op1 = $urandom;
		bjp_req_alu_op2 = bjp_req_alu_op1-1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_ltu = 1;
		bjp_req_alu_op1 = $urandom;
		bjp_req_alu_op2 = bjp_req_alu_op1+1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_gtu = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1-1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_cmp_gtu = 1;
		bjp_req_alu_op1 = $random;
		bjp_req_alu_op2 = bjp_req_alu_op1+1;

		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_add = 1;
		bjp_req_alu_op1 = $random >> 1;
		bjp_req_alu_op2 = $random >> 1;


		@(negedge clk);
		base_all_low();
		bjp_req_alu = 1;
		bjp_req_alu_add = 1;
		bjp_req_alu_op1 = $random >> 1;
		bjp_req_alu_op2 = $random >> 1;
	endtask

	task test_agu();
		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_swap = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_add = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_and = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_or = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_xor = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_max = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;
		
		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_min = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_maxu = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;

		@(negedge clk);
		agu_req_alu = 1;
		agu_req_alu_minu = 1;
		agu_req_alu_op1 = $random;
		agu_req_alu_op2 = $random;
		
	endtask

	task test_shared_buffer();
		@(negedge clk);
		base_all_low();
		agu_sbf_0_ena = 1;
		agu_sbf_0_nxt = $random;

		@(negedge clk);
		base_all_low();
		agu_sbf_1_ena = 1;
		agu_sbf_1_nxt = $random;
	endtask

	task test_muldiv();
		@(negedge clk);
		base_all_low();
		muldiv_req_alu = 1;
		muldiv_req_alu_add = 1;
		muldiv_req_alu_op1 = $random;
		muldiv_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		muldiv_req_alu = 1;
		muldiv_req_alu_sub = 1;
		muldiv_req_alu_op1 = $random;
		muldiv_req_alu_op2 = $random;

		@(negedge clk);
		base_all_low();
		muldiv_req_alu = 1;
		muldiv_sbf_0_ena = 1;
		muldiv_sbf_0_nxt = $random;

		@(negedge clk);
		base_all_low();
		muldiv_req_alu = 1;
		muldiv_sbf_1_ena = 1;
		muldiv_sbf_1_nxt = $random;
	endtask

    initial begin
        // 初始化
		base_all_low();
        rst_n = 0;
		wavedrom_enable = '0;
        wavedrom_title = "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(1);  // 异步复位测试
        @(negedge clk);

        test_alu();
		test_bjp();
		test_agu();
		test_shared_buffer();

	`ifdef E203_SUPPORT_SHARE_MULDIV
		test_muldiv();		// ifdef E203_SUPPORT_SHARE_MULDIV
	`endif
		@(negedge clk);
        // 结束
        $finish;
    end
endmodule