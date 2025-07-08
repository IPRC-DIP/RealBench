module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
	output logic wfi_halt_ifu_ack,
	output logic wfi_halt_exu_ack,
	output logic amo_wait,
	output logic alu_excp_i_valid,
	output logic alu_excp_i_ld,
	output logic alu_excp_i_stamo,
	output logic alu_excp_i_misalgn,
	output logic alu_excp_i_buserr,
	output logic alu_excp_i_ecall,
	output logic alu_excp_i_ebreak,
	output logic alu_excp_i_wfi,
	output logic alu_excp_i_ifu_misalgn,
	output logic alu_excp_i_ifu_buserr,
	output logic alu_excp_i_ifu_ilegl,
	output logic [31:0] alu_excp_i_badaddr,
	output logic [31:0] alu_excp_i_pc,
	output logic [31:0] alu_excp_i_instr,
	output logic alu_excp_i_pc_vld,
	output logic longp_excp_i_valid,
	output logic longp_excp_i_ld,
	output logic longp_excp_i_st,
	output logic longp_excp_i_buserr,
	output logic longp_excp_i_insterr,
	output logic [31:0] longp_excp_i_badaddr,
	output logic [31:0] longp_excp_i_pc,
	output logic excpirq_flush_ack,
	output logic [31:0] csr_mtvec_r,
	output logic cmt_dret_ena,
	output logic cmt_ena,
	output logic dbg_irq_r,
	output logic lcl_irq_r,
	output logic ext_irq_r,
	output logic sft_irq_r,
	output logic tmr_irq_r,
	output logic status_mie_r,
	output logic mtie_r,
	output logic msie_r,
	output logic meie_r,
	output logic dbg_mode,
	output logic dbg_halt_r,
	output logic dbg_step_r,
	output logic dbg_ebreakm_r,
	output logic oitf_empty,
	output logic u_mode,
	output logic s_mode,
	output logic h_mode,
	output logic m_mode,
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
		wfi_halt_ifu_ack = 0;
		wfi_halt_exu_ack = 0;
		amo_wait = 0;
		alu_excp_i_valid = 0;
		alu_excp_i_ld = 0;
		alu_excp_i_stamo = 0;
		alu_excp_i_misalgn = 0;
		alu_excp_i_buserr = 0;
		alu_excp_i_ecall = 0;
		alu_excp_i_ebreak = 0;
		alu_excp_i_wfi = 0;
		alu_excp_i_ifu_misalgn = 0;
		alu_excp_i_ifu_buserr = 0;
		alu_excp_i_ifu_ilegl = 0;
		alu_excp_i_badaddr = 0;
		alu_excp_i_pc = 0;
		alu_excp_i_instr = 0;
		alu_excp_i_pc_vld = 0;
		longp_excp_i_valid = 0;
		longp_excp_i_ld = 0;
		longp_excp_i_st = 0;
		longp_excp_i_buserr = 0;
		longp_excp_i_insterr = 0;
		longp_excp_i_badaddr = 0;
		longp_excp_i_pc = 0;
		excpirq_flush_ack = 0;
		csr_mtvec_r = 0;
		cmt_dret_ena = 0;
		cmt_ena = 0;
		dbg_irq_r = 0;
		lcl_irq_r = 0;
		ext_irq_r = 0;
		sft_irq_r = 0;
		tmr_irq_r = 0;
		status_mie_r = 0;
		mtie_r = 0;
		msie_r = 0;
		meie_r = 0;
		dbg_mode = 0;
		dbg_halt_r = 0;
		dbg_step_r = 0;
		dbg_ebreakm_r = 0;
		oitf_empty = 0;
		u_mode = 0;
		s_mode = 0;
		h_mode = 0;
		m_mode = 0;
	endtask

	task part_all_high();
	// Add Task2 here
		wfi_halt_ifu_ack = ~0;
		wfi_halt_exu_ack = ~0;
		amo_wait = ~0;
		alu_excp_i_valid = ~0;
		alu_excp_i_ld = ~0;
		alu_excp_i_stamo = ~0;
		alu_excp_i_misalgn = ~0;
		alu_excp_i_buserr = ~0;
		alu_excp_i_ecall = ~0;
		alu_excp_i_ebreak = ~0;
		alu_excp_i_wfi = ~0;
		alu_excp_i_ifu_misalgn = ~0;
		alu_excp_i_ifu_buserr = ~0;
		alu_excp_i_ifu_ilegl = ~0;
		alu_excp_i_badaddr = ~0;
		alu_excp_i_pc = ~0;
		alu_excp_i_instr = ~0;
		alu_excp_i_pc_vld = ~0;
		longp_excp_i_valid = ~0;
		longp_excp_i_ld = ~0;
		longp_excp_i_st = ~0;
		longp_excp_i_buserr = ~0;
		longp_excp_i_insterr = ~0;
		longp_excp_i_badaddr = ~0;
		longp_excp_i_pc = ~0;
		excpirq_flush_ack = ~0;
		csr_mtvec_r = ~0;
		cmt_dret_ena = ~0;
		cmt_ena = ~0;
		dbg_irq_r = ~0;
		lcl_irq_r = ~0;
		ext_irq_r = ~0;
		sft_irq_r = ~0;
		tmr_irq_r = ~0;
		status_mie_r = ~0;
		mtie_r = ~0;
		msie_r = ~0;
		meie_r = ~0;
		dbg_mode = ~0;
		dbg_halt_r = ~0;
		dbg_step_r = ~0;
		dbg_ebreakm_r = ~0;
		oitf_empty = ~0;
		u_mode = ~0;
		s_mode = ~0;
		h_mode = ~0;
		m_mode = ~0;
	endtask

	task part_all_random();
		wfi_halt_ifu_ack = $urandom;
		wfi_halt_exu_ack = $urandom;
		amo_wait = $urandom;
		alu_excp_i_valid = $urandom;
		alu_excp_i_ld = $urandom;
		alu_excp_i_stamo = $urandom;
		alu_excp_i_misalgn = $urandom;
		alu_excp_i_buserr = $urandom;
		alu_excp_i_ecall = $urandom;
		alu_excp_i_ebreak = $urandom;
		alu_excp_i_wfi = $urandom;
		alu_excp_i_ifu_misalgn = $urandom;
		alu_excp_i_ifu_buserr = $urandom;
		alu_excp_i_ifu_ilegl = $urandom;
		alu_excp_i_badaddr = $urandom;
		alu_excp_i_pc = $urandom;
		alu_excp_i_instr = $urandom;
		alu_excp_i_pc_vld = $urandom;
		longp_excp_i_valid = $urandom;
		longp_excp_i_ld = $urandom;
		longp_excp_i_st = $urandom;
		longp_excp_i_buserr = $urandom;
		longp_excp_i_insterr = $urandom;
		longp_excp_i_badaddr = $urandom;
		longp_excp_i_pc = $urandom;
		excpirq_flush_ack = $urandom;
		csr_mtvec_r = $urandom;
		cmt_dret_ena = $urandom;
		cmt_ena = $urandom;
		dbg_irq_r = $urandom;
		lcl_irq_r = $urandom;
		ext_irq_r = $urandom;
		sft_irq_r = $urandom;
		tmr_irq_r = $urandom;
		status_mie_r = $urandom;
		mtie_r = $urandom;
		msie_r = $urandom;
		meie_r = $urandom;
		dbg_mode = $urandom;
		dbg_halt_r = $urandom;
		dbg_step_r = $urandom;
		dbg_ebreakm_r = $urandom;
		oitf_empty = $urandom;
		u_mode = $urandom;
		s_mode = $urandom;
		h_mode = $urandom;
		m_mode = $urandom;
	endtask

	task part_longp_need_flush(input r);
		part_all_low();
		longp_excp_i_valid = r;
	endtask

	task longp_excp_flush_req(input r);
		part_longp_need_flush(r);
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

	task test_wfi_halt_req();
		@(negedge clk);
		part_all_low();		//  set wfi_halt_req_r = 1;
		cmt_ena = 1;
		alu_excp_i_wfi = 1;
		dbg_mode = 0;

		@(negedge clk);
		part_all_low();		// clear
		dbg_mode = 0;
		dbg_step_r = 0;
		ext_irq_r = 1;
		meie_r = 1;
	endtask

	task test_wfi_flag_ena();
		@(negedge clk);
		part_all_low();		//  set wfi_halt_req_r = 1;
		cmt_ena = 1;
		alu_excp_i_wfi = 1;
		dbg_mode = 0;

		@(negedge clk);		// set wfi_flag_r = 1;
		part_all_low();
		wfi_halt_ifu_ack = 1;
		wfi_halt_exu_ack = 1;
	endtask

	task test_step_req();
		@(negedge clk);
		part_all_low();
		dbg_mode = 0;
		dbg_step_r = 1;
		cmt_ena = 1;
		// dbg_entry_taken_ena = 0;
		excpirq_flush_ack = 0;
	endtask


    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
		@(negedge clk);
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(0);  // 异步复位测试
		@(negedge clk);
        
        // register check
		test_step_req();
		test_wfi_halt_req();
		test_wfi_flag_ena();

        // combinational logic random check 
        for(int i = 0; i < 10000; i++)begin
			@(negedge clk);
			part_all_random();
        end

        // 结束
        $finish;
    end
endmodule