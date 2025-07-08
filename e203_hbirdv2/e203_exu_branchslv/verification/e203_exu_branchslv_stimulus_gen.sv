module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic cmt_i_valid,
output logic cmt_i_rv32,
output logic cmt_i_dret,
output logic cmt_i_mret,
output logic cmt_i_fencei,
output logic cmt_i_bjp,
output logic cmt_i_bjp_prdt,
output logic cmt_i_bjp_rslv,
output logic [31:0] cmt_i_pc,
output logic [31:0] cmt_i_imm,
output logic [31:0] csr_epc_r,
output logic [31:0] csr_dpc_r,
output logic nonalu_excpirq_flush_req_raw,
output logic brchmis_flush_ack,
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
	// Add Task1 here
		cmt_i_valid = 0;
		cmt_i_rv32 = 0;
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		cmt_i_fencei = 0;
		cmt_i_bjp = 0;
		cmt_i_bjp_prdt = 0;
		cmt_i_bjp_rslv = 0;
		cmt_i_pc = 0;
		cmt_i_imm = 0;
		csr_epc_r = 0;
		csr_dpc_r = 0;
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 0;
	endtask

	task base_all_high();
	// Add Task2 here
		cmt_i_valid = ~0;
		cmt_i_rv32 = ~0;
		cmt_i_dret = ~0;
		cmt_i_mret = ~0;
		cmt_i_fencei = ~0;
		cmt_i_bjp = ~0;
		cmt_i_bjp_prdt = ~0;
		cmt_i_bjp_rslv = ~0;
		cmt_i_pc = ~0;
		cmt_i_imm = ~0;
		csr_epc_r = ~0;
		csr_dpc_r = ~0;
		nonalu_excpirq_flush_req_raw = ~0;
		brchmis_flush_ack = ~0;
	endtask

	task base_all_random();
		cmt_i_valid = $urandom;
		cmt_i_rv32 = $urandom;
		cmt_i_dret = $urandom;
		cmt_i_mret = $urandom;
		cmt_i_fencei = $urandom;
		cmt_i_bjp = $urandom;
		cmt_i_bjp_prdt = $urandom;
		cmt_i_bjp_rslv = $urandom;
		cmt_i_pc = $urandom;
		cmt_i_imm = $urandom;
		csr_epc_r = $urandom;
		csr_dpc_r = $urandom;
		nonalu_excpirq_flush_req_raw = $urandom;
		brchmis_flush_ack = $urandom;
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

	task part_brchmis_need_flush(input r);
		if(r == 1)begin
			case ($random & 2'b11)
				2'b00:cmt_i_fencei = 1;
				2'b01:cmt_i_mret = 1;
				2'b10:cmt_i_dret = 1; 
				default: begin
					cmt_i_bjp = 1;
					cmt_i_bjp_prdt = 1;
					cmt_i_bjp_rslv = 0;
				end
			endcase
		end
		else begin
			case ($random & 1'b1)
				1'b0:cmt_i_bjp = 0; 
				default: begin
					cmt_i_bjp = 1;
					cmt_i_bjp_prdt = 1;
					cmt_i_bjp_rslv = 1;
				end
			endcase
			cmt_i_fencei = 0;
			cmt_i_mret = 0;
			cmt_i_dret = 0;
		end
	endtask

	task test_cmt_i_ready();
		// true
		@(negedge clk);		// cmt_i_is_branch = 0
		base_all_low();

		@(negedge clk);		// no need to flush
		base_all_low();
		cmt_i_bjp = 1;
		part_brchmis_need_flush(0);
		nonalu_excpirq_flush_req_raw = 0;

		@(negedge clk);		// need to flush
		base_all_low();
		cmt_i_bjp = 1;
		part_brchmis_need_flush(1);
		brchmis_flush_ack = 1;
		nonalu_excpirq_flush_req_raw = 0;

		// false
		@(negedge clk);		// need flush no ack
		base_all_low();
		cmt_i_bjp = 1;
		part_brchmis_need_flush(1);
		brchmis_flush_ack = 0;
		nonalu_excpirq_flush_req_raw = 0;

		@(negedge clk);		// need flush ack , non alu flush
		base_all_low();
		cmt_i_bjp = 1;
		part_brchmis_need_flush(1);
		brchmis_flush_ack = 1;
		nonalu_excpirq_flush_req_raw = 1;
	endtask

	task test_brchmis_flush_req();
		// true
		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;

		//false
		@(negedge clk);
		base_all_low();
		cmt_i_valid = 0;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(0);
		nonalu_excpirq_flush_req_raw = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 1;
	endtask
	
	task test_brchmis_flush_add_op1();
		@(negedge clk);
		base_all_low();
		cmt_i_dret = 1;
		cmt_i_mret = 0;
		csr_dpc_r = $random;
		csr_epc_r = $random;
		cmt_i_pc = $random;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 1;
		csr_dpc_r = $random;
		csr_epc_r = $random;
		cmt_i_pc = $random;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		csr_dpc_r = $random;
		csr_epc_r = $random;
		cmt_i_pc = $random;
	endtask

	task test_brchmis_flush_add_op2();
		@(negedge clk);
		base_all_low();
		cmt_i_dret = 1;
		cmt_i_mret = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		cmt_i_fencei = 1;
		cmt_i_rv32 = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		cmt_i_bjp_prdt = 1;
		cmt_i_rv32 = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		cmt_i_fencei = 1;
		cmt_i_rv32 = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_dret = 0;
		cmt_i_mret = 0;
		cmt_i_bjp_prdt = 1;
		cmt_i_rv32 = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_imm = $random;

		@(negedge clk);
		base_all_low();
		cmt_i_imm = $random;

	endtask

	`ifdef E203_TIMING_BOOST
	task test_brchmis_flush_pc();
		@(negedge clk);
		base_all_low();
		cmt_i_fencei = 1;
		cmt_i_pc = $random;
		cmt_i_rv32 = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_fencei = 1;
		cmt_i_pc = $random;
		cmt_i_rv32 = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_bjp = 1;
		cmt_i_bjp_prdt = 1;
		cmt_i_pc = $random;
		cmt_i_rv32 = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_bjp = 1;
		cmt_i_bjp_prdt = 1;
		cmt_i_pc = $random;
		cmt_i_rv32 = 0;

		@(negedge clk);
		base_all_low();
		cmt_i_bjp = 1;
		cmt_i_pc = $random;
		cmt_i_imm = $random;

		@(negedge clk);
		base_all_low();
		cmt_i_bjp = 0;
		cmt_i_dret = 1;
		csr_dpc_r = $random;

		@(negedge clk);
		base_all_low();
		csr_epc_r = $random;
	endtask
	`endif

	task test_ena();
		@(negedge clk);						// true
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_dret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_fencei = 1;

		@(negedge clk);						// false
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 0;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 0;
		cmt_i_dret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 0;
		cmt_i_fencei = 1;

		@(negedge clk);						// false
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 1;
		brchmis_flush_ack = 1;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 1;
		brchmis_flush_ack = 1;
		cmt_i_dret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 1;
		brchmis_flush_ack = 1;
		cmt_i_fencei = 1;

		@(negedge clk);						// false
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(0);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(0);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_dret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 1;
		part_brchmis_need_flush(0);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_fencei = 1;

		@(negedge clk);						// false
		base_all_low();
		cmt_i_valid = 0;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_mret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 0;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_dret = 1;

		@(negedge clk);
		base_all_low();
		cmt_i_valid = 0;
		part_brchmis_need_flush(1);
		nonalu_excpirq_flush_req_raw = 0;
		brchmis_flush_ack = 1;
		cmt_i_fencei = 1;
	endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(0);  // 异步复位测试
        @(negedge clk);
        
        // 测试任务1
        wavedrom_start("Task1");
		test_cmt_i_ready();
		test_brchmis_flush_req();
		test_brchmis_flush_add_op1();
		test_brchmis_flush_add_op2();
		`ifdef E203_TIMING_BOOST
		test_brchmis_flush_pc();
		`endif
		test_ena();
        repeat(2) @(negedge clk);
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule