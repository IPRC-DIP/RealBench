module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic i_valid,
output logic nice_xs_off,
output logic oitf_empty,
output logic i_itag,
output logic [31:0] i_rs1,
output logic [31:0] i_rs2,
output logic [31:0] i_imm,
output logic [31:0] i_info,
output logic [31:0] i_pc,
output logic [31:0] i_instr,
output logic i_pc_vld,
output logic [4:0] i_rdidx,
output logic i_rdwen,
output logic i_ilegl,
output logic i_buserr,
output logic i_misalgn,
output logic flush_req,
output logic flush_pulse,
output logic cmt_o_ready,
output logic wbck_o_ready,
output logic mdv_nob2b,
output logic nonflush_cmt_ena,
output logic csr_access_ilgl,
output logic [31:0] read_csr_dat,
output logic agu_icb_cmd_ready,
output logic agu_icb_rsp_valid,
output logic agu_icb_rsp_err,
output logic agu_icb_rsp_excl_ok,
output logic [31:0] agu_icb_rsp_rdata,
output logic nice_req_ready,
output logic nice_rsp_multicyc_valid,
output logic nice_longp_wbck_ready,
output logic i_nice_cmt_off_ilgl,
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
		i_valid = 0;
		nice_xs_off = 0;
		oitf_empty = 0;
		i_itag = 0;
		i_rs1 = 0;
		i_rs2 = 0;
		i_imm = 0;
		i_info = 0;
		i_pc = 0;
		i_instr = 0;
		i_pc_vld = 0;
		i_rdidx = 0;
		i_rdwen = 0;
		i_ilegl = 0;
		i_buserr = 0;
		i_misalgn = 0;
		flush_req = 0;
		flush_pulse = 0;
		cmt_o_ready = 0;
		wbck_o_ready = 0;
		mdv_nob2b = 0;
		nonflush_cmt_ena = 0;
		csr_access_ilgl = 0;
		read_csr_dat = 0;
		agu_icb_cmd_ready = 0;
		agu_icb_rsp_valid = 0;
		agu_icb_rsp_err = 0;
		agu_icb_rsp_excl_ok = 0;
		agu_icb_rsp_rdata = 0;
		nice_req_ready = 0;
		nice_rsp_multicyc_valid = 0;
		nice_longp_wbck_ready = 0;
		i_nice_cmt_off_ilgl = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		i_valid = ~0;
		nice_xs_off = ~0;
		oitf_empty = ~0;
		i_itag = ~0;
		i_rs1 = ~0;
		i_rs2 = ~0;
		i_imm = ~0;
		i_info = ~0;
		i_pc = ~0;
		i_instr = ~0;
		i_pc_vld = ~0;
		i_rdidx = ~0;
		i_rdwen = ~0;
		i_ilegl = ~0;
		i_buserr = ~0;
		i_misalgn = ~0;
		flush_req = ~0;
		flush_pulse = ~0;
		cmt_o_ready = ~0;
		wbck_o_ready = ~0;
		mdv_nob2b = ~0;
		nonflush_cmt_ena = ~0;
		csr_access_ilgl = ~0;
		read_csr_dat = ~0;
		agu_icb_cmd_ready = ~0;
		agu_icb_rsp_valid = ~0;
		agu_icb_rsp_err = ~0;
		agu_icb_rsp_excl_ok = ~0;
		agu_icb_rsp_rdata = ~0;
		nice_req_ready = ~0;
		nice_rsp_multicyc_valid = ~0;
		nice_longp_wbck_ready = ~0;
		i_nice_cmt_off_ilgl = ~0;
	end
	endtask

	task Random_Test();
	begin
		i_valid = $urandom;
		nice_xs_off = $urandom;
		oitf_empty = $urandom;
		i_itag = $urandom;
		i_rs1 = $urandom;
		i_rs2 = $urandom;
		i_imm = $urandom;
		i_info = $urandom;
		i_pc = $urandom;
		i_instr = $urandom;
		i_pc_vld = $urandom;
		i_rdidx = $urandom;
		i_rdwen = $urandom;
		i_ilegl = $urandom;
		i_buserr = $urandom;
		i_misalgn = $urandom;
		flush_req = $urandom;
		flush_pulse = $urandom;
		cmt_o_ready = $urandom;
		wbck_o_ready = $urandom;
		mdv_nob2b = $urandom;
		nonflush_cmt_ena = $urandom;
		csr_access_ilgl = $urandom;
		read_csr_dat = $urandom;
		agu_icb_cmd_ready = $urandom;
		agu_icb_rsp_valid = $urandom;
		agu_icb_rsp_err = $urandom;
		agu_icb_rsp_excl_ok = $urandom;
		agu_icb_rsp_rdata = $urandom;
		nice_req_ready = $urandom;
		nice_rsp_multicyc_valid = $urandom;
		nice_longp_wbck_ready = $urandom;
		i_nice_cmt_off_ilgl = $urandom;
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