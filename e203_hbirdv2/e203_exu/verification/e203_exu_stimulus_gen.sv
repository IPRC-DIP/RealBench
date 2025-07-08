module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic core_mhartid,
output logic dbg_irq_r,
output logic lcl_irq_r,
output logic evt_r,
output logic ext_irq_r,
output logic sft_irq_r,
output logic tmr_irq_r,
output logic [31:0] dcsr_r,
output logic [31:0] dpc_r,
output logic [31:0] dscratch_r,
output logic dbg_mode,
output logic dbg_halt_r,
output logic dbg_step_r,
output logic dbg_ebreakm_r,
output logic dbg_stopcycle,
output logic i_valid,
output logic [31:0] i_ir,
output logic [31:0] i_pc,
output logic i_pc_vld,
output logic i_misalgn,
output logic i_buserr,
output logic i_prdt_taken,
output logic i_muldiv_b2b,
output logic [4:0] i_rs1idx,
output logic [4:0] i_rs2idx,
output logic pipe_flush_ack,
output logic lsu_o_valid,
output logic [31:0] lsu_o_wbck_wdat,
output logic lsu_o_wbck_itag,
output logic lsu_o_wbck_err,
output logic lsu_o_cmt_ld,
output logic lsu_o_cmt_st,
output logic [31:0] lsu_o_cmt_badaddr,
output logic lsu_o_cmt_buserr,
output logic wfi_halt_ifu_ack,
output logic agu_icb_cmd_ready,
output logic agu_icb_rsp_valid,
output logic agu_icb_rsp_err,
output logic agu_icb_rsp_excl_ok,
output logic [31:0] agu_icb_rsp_rdata,
output logic nice_req_ready,
output logic nice_rsp_multicyc_valid,
output logic [31:0] nice_rsp_multicyc_dat,
output logic nice_rsp_multicyc_err,
output logic test_mode,
output logic clk_aon,
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

	task Task1();
	begin
	// Add Task1 here
		core_mhartid = 0;
		dbg_irq_r = 0;
		lcl_irq_r = 0;
		evt_r = 0;
		ext_irq_r = 0;
		sft_irq_r = 0;
		tmr_irq_r = 0;
		dcsr_r = 0;
		dpc_r = 0;
		dscratch_r = 0;
		dbg_mode = 0;
		dbg_halt_r = 0;
		dbg_step_r = 0;
		dbg_ebreakm_r = 0;
		dbg_stopcycle = 0;
		i_valid = 0;
		i_ir = 0;
		i_pc = 0;
		i_pc_vld = 0;
		i_misalgn = 0;
		i_buserr = 0;
		i_prdt_taken = 0;
		i_muldiv_b2b = 0;
		i_rs1idx = 0;
		i_rs2idx = 0;
		pipe_flush_ack = 0;
		lsu_o_valid = 0;
		lsu_o_wbck_wdat = 0;
		lsu_o_wbck_itag = 0;
		lsu_o_wbck_err = 0;
		lsu_o_cmt_ld = 0;
		lsu_o_cmt_st = 0;
		lsu_o_cmt_badaddr = 0;
		lsu_o_cmt_buserr = 0;
		wfi_halt_ifu_ack = 0;
		agu_icb_cmd_ready = 0;
		agu_icb_rsp_valid = 0;
		agu_icb_rsp_err = 0;
		agu_icb_rsp_excl_ok = 0;
		agu_icb_rsp_rdata = 0;
		nice_req_ready = 0;
		nice_rsp_multicyc_valid = 0;
		nice_rsp_multicyc_dat = 0;
		nice_rsp_multicyc_err = 0;
		test_mode = 0;
		clk_aon = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		core_mhartid = ~0;
		dbg_irq_r = ~0;
		lcl_irq_r = ~0;
		evt_r = ~0;
		ext_irq_r = ~0;
		sft_irq_r = ~0;
		tmr_irq_r = ~0;
		dcsr_r = ~0;
		dpc_r = ~0;
		dscratch_r = ~0;
		dbg_mode = ~0;
		dbg_halt_r = ~0;
		dbg_step_r = ~0;
		dbg_ebreakm_r = ~0;
		dbg_stopcycle = ~0;
		i_valid = ~0;
		i_ir = ~0;
		i_pc = ~0;
		i_pc_vld = ~0;
		i_misalgn = ~0;
		i_buserr = ~0;
		i_prdt_taken = ~0;
		i_muldiv_b2b = ~0;
		i_rs1idx = ~0;
		i_rs2idx = ~0;
		pipe_flush_ack = ~0;
		lsu_o_valid = ~0;
		lsu_o_wbck_wdat = ~0;
		lsu_o_wbck_itag = ~0;
		lsu_o_wbck_err = ~0;
		lsu_o_cmt_ld = ~0;
		lsu_o_cmt_st = ~0;
		lsu_o_cmt_badaddr = ~0;
		lsu_o_cmt_buserr = ~0;
		wfi_halt_ifu_ack = ~0;
		agu_icb_cmd_ready = ~0;
		agu_icb_rsp_valid = ~0;
		agu_icb_rsp_err = ~0;
		agu_icb_rsp_excl_ok = ~0;
		agu_icb_rsp_rdata = ~0;
		nice_req_ready = ~0;
		nice_rsp_multicyc_valid = ~0;
		nice_rsp_multicyc_dat = ~0;
		nice_rsp_multicyc_err = ~0;
		test_mode = ~0;
		clk_aon = ~0;
	end
	endtask

	task Random_Test();
	begin
		core_mhartid = $urandom;
		dbg_irq_r = $urandom;
		lcl_irq_r = $urandom;
		evt_r = $urandom;
		ext_irq_r = $urandom;
		sft_irq_r = $urandom;
		tmr_irq_r = $urandom;
		dcsr_r = $urandom;
		dpc_r = $urandom;
		dscratch_r = $urandom;
		dbg_mode = $urandom;
		dbg_halt_r = $urandom;
		dbg_step_r = $urandom;
		dbg_ebreakm_r = $urandom;
		dbg_stopcycle = $urandom;
		i_valid = $urandom;
		i_ir = $urandom;
		i_pc = $urandom;
		i_pc_vld = $urandom;
		i_misalgn = $urandom;
		i_buserr = $urandom;
		i_prdt_taken = $urandom;
		i_muldiv_b2b = $urandom;
		i_rs1idx = $urandom;
		i_rs2idx = $urandom;
		pipe_flush_ack = $urandom;
		lsu_o_valid = $urandom;
		lsu_o_wbck_wdat = $urandom;
		lsu_o_wbck_itag = $urandom;
		lsu_o_wbck_err = $urandom;
		lsu_o_cmt_ld = $urandom;
		lsu_o_cmt_st = $urandom;
		lsu_o_cmt_badaddr = $urandom;
		lsu_o_cmt_buserr = $urandom;
		wfi_halt_ifu_ack = $urandom;
		agu_icb_cmd_ready = $urandom;
		agu_icb_rsp_valid = $urandom;
		agu_icb_rsp_err = $urandom;
		agu_icb_rsp_excl_ok = $urandom;
		agu_icb_rsp_rdata = $urandom;
		nice_req_ready = $urandom;
		nice_rsp_multicyc_valid = $urandom;
		nice_rsp_multicyc_dat = $urandom;
		nice_rsp_multicyc_err = $urandom;
		test_mode = $urandom;
		clk_aon = $urandom;
	end
	endtask

    task reset_test(input async=0);
        bit arfail, srfail, datafail;
   
        @(posedge clk);
        @(posedge clk) rst_n <= 1;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst_n <= 0; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst_n <= 1;
        end
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 测试任务1
        wavedrom_start("Task1");
		Task1();
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 测试任务2
        wavedrom_start("Task2");
		Task2();
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 随机测试
        for(int i = 0; i < 100; i++)begin
            wavedrom_start("Random Test");
		Random_Test();
            repeat(2) @(posedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule