`include "e203_defines.v"
module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
	output logic wfi_halt_exu_req,
	output logic oitf_empty,
	output logic amo_wait,
	output logic disp_i_valid,
	output logic disp_i_rs1x0,
	output logic disp_i_rs2x0,
	output logic disp_i_rs1en,
	output logic disp_i_rs2en,
	output logic [4:0] disp_i_rs1idx,
	output logic [4:0] disp_i_rs2idx,
	output logic [31:0] disp_i_rs1,
	output logic [31:0] disp_i_rs2,
	output logic disp_i_rdwen,
	output logic [4:0] disp_i_rdidx,
	output logic [31:0] disp_i_info,
	output logic [31:0] disp_i_imm,
	output logic [31:0] disp_i_pc,
	output logic disp_i_misalgn,
	output logic disp_i_buserr,
	output logic disp_i_ilegl,
	output logic disp_o_alu_ready,
	output logic disp_o_alu_longpipe,
	output logic oitfrd_match_disprs1,
	output logic oitfrd_match_disprs2,
	output logic oitfrd_match_disprs3,
	output logic oitfrd_match_disprd,
	output logic disp_oitf_ptr,
	output logic disp_oitf_ready,
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
	task part_all_low();
	// Add Task1 here
		wfi_halt_exu_req = 0;
		oitf_empty = 0;
		amo_wait = 0;
		disp_i_valid = 0;
		disp_i_rs1x0 = 0;
		disp_i_rs2x0 = 0;
		disp_i_rs1en = 0;
		disp_i_rs2en = 0;
		disp_i_rs1idx = 0;
		disp_i_rs2idx = 0;
		disp_i_rs1 = 0;
		disp_i_rs2 = 0;
		disp_i_rdwen = 0;
		disp_i_rdidx = 0;
		disp_i_info = 0;
		disp_i_imm = 0;
		disp_i_pc = 0;
		disp_i_misalgn = 0;
		disp_i_buserr = 0;
		disp_i_ilegl = 0;
		disp_o_alu_ready = 0;
		disp_o_alu_longpipe = 0;
		oitfrd_match_disprs1 = 0;
		oitfrd_match_disprs2 = 0;
		oitfrd_match_disprs3 = 0;
		oitfrd_match_disprd = 0;
		disp_oitf_ptr = 0;
		disp_oitf_ready = 0;
	endtask

	task part_all_high();
	// Add Task2 here
		wfi_halt_exu_req = ~0;
		oitf_empty = ~0;
		amo_wait = ~0;
		disp_i_valid = ~0;
		disp_i_rs1x0 = ~0;
		disp_i_rs2x0 = ~0;
		disp_i_rs1en = ~0;
		disp_i_rs2en = ~0;
		disp_i_rs1idx = ~0;
		disp_i_rs2idx = ~0;
		disp_i_rs1 = ~0;
		disp_i_rs2 = ~0;
		disp_i_rdwen = ~0;
		disp_i_rdidx = ~0;
		disp_i_info = ~0;
		disp_i_imm = ~0;
		disp_i_pc = ~0;
		disp_i_misalgn = ~0;
		disp_i_buserr = ~0;
		disp_i_ilegl = ~0;
		disp_o_alu_ready = ~0;
		disp_o_alu_longpipe = ~0;
		oitfrd_match_disprs1 = ~0;
		oitfrd_match_disprs2 = ~0;
		oitfrd_match_disprs3 = ~0;
		oitfrd_match_disprd = ~0;
		disp_oitf_ptr = ~0;
		disp_oitf_ready = ~0;
	endtask

	task part_random_test();
		wfi_halt_exu_req = $urandom;
		oitf_empty = $urandom;
		amo_wait = $urandom;
		disp_i_valid = $urandom;
		disp_i_rs1x0 = $urandom;
		disp_i_rs2x0 = $urandom;
		disp_i_rs1en = $urandom;
		disp_i_rs2en = $urandom;
		disp_i_rs1idx = $urandom;
		disp_i_rs2idx = $urandom;
		disp_i_rs1 = $urandom;
		disp_i_rs2 = $urandom;
		disp_i_rdwen = $urandom;
		disp_i_rdidx = $urandom;
		disp_i_info = $urandom;
		disp_i_imm = $urandom;
		disp_i_pc = $urandom;
		disp_i_misalgn = $urandom;
		disp_i_buserr = $urandom;
		disp_i_ilegl = $urandom;
		disp_o_alu_ready = $urandom;
		disp_o_alu_longpipe = $urandom;
		oitfrd_match_disprs1 = $urandom;
		oitfrd_match_disprs2 = $urandom;
		oitfrd_match_disprs3 = $urandom;
		oitfrd_match_disprd = $urandom;
		disp_oitf_ptr = $urandom;
		disp_oitf_ready = $urandom;
	endtask

	task part_disp_condition_true();
		part_all_low();
		disp_i_info[`E203_DECINFO_GRP] = 0; // 0是alu的group， disp_csr = 0 
		oitf_empty = 1;
		disp_i_info[`E203_DECINFO_GRP] = 0; // disp_fence_fencei = 0
        disp_i_info [`E203_DECINFO_BJP_FENCE] = 0;
		disp_i_info [`E203_DECINFO_BJP_FENCEI] = 0;
		wfi_halt_exu_req = 0;
		oitfrd_match_disprs1 = 0;	// dep = 0
		oitfrd_match_disprs2 = 0;
		oitfrd_match_disprs3 = 0;
		oitfrd_match_disprd = 0;
		disp_i_info[`E203_DECINFO_GRP] = 0; // disp_alu_longp_prdt = 0
		disp_oitf_ready = 1;
	endtask

	task part_disp_condition_false();
		part_all_low();
		disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_CSR; // disp_csr = 1 // overided
		oitf_empty = 0;
		disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_BJP; // disp_fence_fencei = 1 // overided
        disp_i_info [`E203_DECINFO_BJP_FENCE] = 1;
		disp_i_info [`E203_DECINFO_BJP_FENCEI] = 0;
		wfi_halt_exu_req = 1;
		oitfrd_match_disprs1 = 1;	// dep = 0
		oitfrd_match_disprs2 = 1;
		oitfrd_match_disprs3 = 1;
		oitfrd_match_disprd = 1;
		disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_AGU; // disp_alu_longp_prdt = 1
		disp_oitf_ready = 0;
	endtask

	task test_wfi_halt_exu_ack();
		@(negedge clk);		// true
		part_all_low();
		oitf_empty = 1;
		amo_wait = 0;
		@(negedge clk);		// false
		part_all_low();
		oitf_empty = 0;
		amo_wait = 0;
		@(negedge clk);
		part_all_low();	// false
		oitf_empty = 1;
		amo_wait = 1;
		@(negedge clk);
		part_all_low();	// false
		oitf_empty = 0;
		amo_wait = 1;
	endtask

	task test_disp_i_ready();
		@(negedge clk);		//	true		
		part_disp_condition_true();
		disp_o_alu_ready = 1;
		@(negedge clk);		// false
		part_disp_condition_false();
		disp_o_alu_ready = 1;
		@(negedge clk);		// false
		part_disp_condition_true();
		disp_o_alu_ready = 0;
		@(negedge clk);		// false
		part_disp_condition_false();
		disp_o_alu_ready = 0;
	endtask

	task part_disp_o_alu_valid_true();
		part_disp_condition_true();
		disp_i_valid = 1;
	endtask

	task part_disp_o_alu_valid_false();
		part_disp_condition_false();
		disp_i_valid = 0;
	endtask

	task test_disp_o_alu_valid();
		@(negedge clk);		//	true		
		part_disp_condition_true();
		disp_i_valid = 1;
		@(negedge clk);		// false
		part_disp_condition_false();
		disp_i_valid = 1;
		@(negedge clk);		// false
		part_disp_condition_true();
		disp_i_valid = 0;
		@(negedge clk);		// false
		part_disp_condition_false();
		disp_i_valid = 0;
	endtask

	task test_disp_o_alu_rs1();
		@(negedge clk);		// use x0
		part_all_low();
		disp_i_rs1x0 = 1;
		disp_i_rs1 = $urandom;
		@(negedge clk);		// use x1
		part_all_low();
		disp_i_rs1x0 = 0;
		disp_i_rs1 = $urandom;
	endtask

	task test_disp_o_alu_rs2();
		@(negedge clk);		// use x0
		part_all_low();
		disp_i_rs2x0 = 1;
		disp_i_rs2 = $urandom;
		@(negedge clk);		// use x1
		part_all_low();
		disp_i_rs2x0 = 0;
		disp_i_rs2 = $urandom;
	endtask

	task test_disp_o_alu_rdwen();
		@(negedge clk);		// 1
		part_all_low();
		disp_i_rdwen = 1;
		@(negedge clk);		// 0
		part_all_low();
		disp_i_rdwen = 0;
	endtask

	task test_disp_o_alu_rdidx();
		@(negedge clk);		// 1
		part_all_low();
		disp_i_rdidx = $urandom;
		@(negedge clk);		// 2
		part_all_low();
		disp_i_rdidx = $urandom;
	endtask

	task test_disp_o_alu_info();
		@(negedge clk);		// all 1
		part_all_low();
		disp_i_info = ~0;
		@(negedge clk);		// all 0
		part_all_low();
		disp_i_info = '0;
		@(negedge clk);		// random
		part_all_low();
		disp_i_info = $urandom;
	endtask

	task test_disp_o_alu_imm();
		@(negedge clk);		// all 1
		part_all_low();
		disp_i_imm = ~0;
		@(negedge clk);		// all 0
		part_all_low();
		disp_i_imm = '0;
		@(negedge clk);		// random
		part_all_low();
		disp_i_imm = $urandom;
	endtask

	task test_disp_o_alu_pc();
		@(negedge clk);		// random
		part_all_low();
		disp_i_pc = $urandom;
	endtask

	task test_disp_o_alu_itag();
		@(negedge clk);
		part_all_low();
		disp_oitf_ptr = $urandom;
	endtask

	task test_disp_o_alu_mislgn();
		@(negedge clk);
		part_all_low();
		disp_i_misalgn = 1;
		@(negedge clk);
		part_all_low();
		disp_i_misalgn = 0;
	endtask

	task test_disp_o_alu_buserr();
		@(negedge clk);
		part_all_low();
		disp_i_buserr = 1;
		@(negedge clk);
		part_all_low();
		disp_i_buserr = 0;
	endtask

	task test_disp_o_alu_ilegl();
		@(negedge clk);
		part_all_low();
		disp_i_ilegl = 1;
		@(negedge clk);
		part_all_low();
		disp_i_ilegl = 0;
	endtask

	task test_disp_oitf_ena();
		@(negedge clk);		// true
		part_disp_o_alu_valid_true();
		disp_o_alu_ready = 1;
		disp_o_alu_longpipe = 1;
		@(negedge clk);
		part_disp_o_alu_valid_false();	// false
		disp_o_alu_ready = 1;
		disp_o_alu_longpipe = 1;
		@(negedge clk);
		part_disp_o_alu_valid_false();	// false
		disp_o_alu_ready = 1;
		disp_o_alu_longpipe = 0;
		@(negedge clk);
		part_disp_o_alu_valid_false();	// false
		disp_o_alu_ready = 0;
		disp_o_alu_longpipe = 1;
		@(negedge clk);
		part_disp_o_alu_valid_false();	// false
		disp_o_alu_ready = 0;
		disp_o_alu_longpipe = 0;
		@(negedge clk);
		part_disp_o_alu_valid_true();	// false
		disp_o_alu_ready = 0;
		disp_o_alu_longpipe = 1;
		@(negedge clk);
		part_disp_o_alu_valid_true();	// false
		disp_o_alu_ready = 1;
		disp_o_alu_longpipe = 0;
	endtask

	task test_disp_oitf_rs1fpu();	// fpu系列无需验证，ref未实现
	endtask
	task test_disp_oitf_rs2fpu();
	endtask
	task test_disp_oitf_rs3fpu();
	endtask
	task test_disp_oitf_rdfpu();
	endtask

	task test_disp_oitf_rs1en();
		@(negedge clk);
		part_all_low();
		disp_i_rs1en = $urandom;
	endtask
	task test_disp_oitf_rs2en();
		@(negedge clk);
		part_all_low();
		disp_i_rs2en = $urandom;
	endtask
	task test_disp_oitf_rs3en();	// 不涉及fpu时无用
	endtask
	task test_disp_oitf_rdwen();
		@(negedge clk);
		part_all_low();
		disp_i_rdwen = $urandom;
	endtask

	task test_disp_oitf_rs1idx();
		@(negedge clk);
		part_all_low();
		disp_i_rs1idx = $urandom;
	endtask
	task test_disp_oitf_rs2idx();
		@(negedge clk);
		part_all_low();
		disp_i_rs2idx = $urandom;
	endtask
	task test_disp_oitf_rs3idx();	// 不涉及fpu无用
	endtask
	task test_disp_oitf_rdidx();
		@(negedge clk);
		part_all_low();
		disp_i_rdidx = $urandom;
	endtask
	task test_disp_oitf_pc();
		@(negedge clk);
		part_all_low();
		disp_i_pc = $urandom;
	endtask

	task test_disp_condition();	// 测试disp_condition的逻辑是否正确，体现在disp_o_alu_valid上
		@(negedge clk);		// true
		begin
			part_disp_condition_true();
			disp_i_valid = 1;
		end
		@(negedge clk);		// 以下均为false，诱因为disp_csr
		begin
			part_disp_condition_true();
			disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_CSR; // disp_csr = 0
			oitf_empty = 0;
			disp_i_valid = 1;
		end
		@(negedge clk);		// disp_fence_fencei
		begin
			part_disp_condition_true();
			disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_BJP; // disp_fence_fencei = 1
			disp_i_info [`E203_DECINFO_BJP_FENCE] = 1;
			disp_i_info [`E203_DECINFO_BJP_FENCEI] = 0;
			oitf_empty = 0;
			disp_i_valid = 1;
		end
		@(negedge clk);		// wfi_halt_exu_req
		begin
			part_disp_condition_true();
			wfi_halt_exu_req = 1;
			disp_i_valid = 1;
		end
		@(negedge clk);		// dep = wawdep | rawdep
		begin
			part_disp_condition_true();
			oitfrd_match_disprs1 = 1;
			disp_i_valid = 1;
		end
		@(negedge clk);
		begin
			part_disp_condition_true();
			oitfrd_match_disprs2 = 1;
			disp_i_valid = 1;
		end
		@(negedge clk);
		begin
			part_disp_condition_true();
			oitfrd_match_disprs3 = 1;
			disp_i_valid = 1;
		end
		@(negedge clk);
		begin
			part_disp_condition_true();
			oitfrd_match_disprd = 1;
			disp_i_valid = 1;
		end
		@(negedge clk);		// disp_alu_longp_prdt
		begin
			part_disp_condition_true();
			disp_i_info[`E203_DECINFO_GRP] = `E203_DECINFO_GRP_AGU; // disp_alu_longp_prdt = 0
			disp_oitf_ready = 0;
			disp_i_valid = 1;
		end
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
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(1);  // 异步复位测试
        @(negedge clk);
        
        // 测试输出逻辑
        wavedrom_start("Output Logic");
		test_wfi_halt_exu_ack();
		test_disp_i_ready();
		test_disp_o_alu_valid();
		test_disp_o_alu_rs1();
		test_disp_o_alu_rs2();
		test_disp_o_alu_rdwen();
		test_disp_o_alu_rdidx();
		test_disp_o_alu_info();
		test_disp_o_alu_imm();
		test_disp_o_alu_pc();
		test_disp_o_alu_itag();
		test_disp_o_alu_mislgn();
		test_disp_o_alu_buserr();
		test_disp_o_alu_ilegl();
		test_disp_oitf_ena();
		test_disp_oitf_rs1en();
		test_disp_oitf_rs2en();
		test_disp_oitf_rs3en();
		test_disp_oitf_rdwen();
		test_disp_oitf_rs1idx();
		test_disp_oitf_rs2idx();
		test_disp_oitf_rs3idx();
		test_disp_oitf_rdidx();
		test_disp_oitf_pc();
        wavedrom_stop();

        // 测试核心中间变量的逻辑
        wavedrom_start("Core Internal Logic");
		test_disp_condition();
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule