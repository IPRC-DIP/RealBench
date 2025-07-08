module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic [31:0] pc_rtvec,
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
output logic [31:0] itcm_region_indic,
output logic ifu2itcm_holdup,
output logic ifu2itcm_icb_cmd_ready,
output logic ifu2itcm_icb_rsp_valid,
output logic ifu2itcm_icb_rsp_err,
output logic [63:0] ifu2itcm_icb_rsp_rdata,
output logic [31:0] ppi_region_indic,
output logic ppi_icb_enable,
output logic ppi_icb_cmd_ready,
output logic ppi_icb_rsp_valid,
output logic ppi_icb_rsp_err,
output logic ppi_icb_rsp_excl_ok,
output logic [31:0] ppi_icb_rsp_rdata,
output logic [31:0] clint_region_indic,
output logic clint_icb_enable,
output logic clint_icb_cmd_ready,
output logic clint_icb_rsp_valid,
output logic clint_icb_rsp_err,
output logic clint_icb_rsp_excl_ok,
output logic [31:0] clint_icb_rsp_rdata,
output logic [31:0] plic_region_indic,
output logic plic_icb_enable,
output logic plic_icb_cmd_ready,
output logic plic_icb_rsp_valid,
output logic plic_icb_rsp_err,
output logic plic_icb_rsp_excl_ok,
output logic [31:0] plic_icb_rsp_rdata,
output logic [31:0] fio_region_indic,
output logic fio_icb_enable,
output logic fio_icb_cmd_ready,
output logic fio_icb_rsp_valid,
output logic fio_icb_rsp_err,
output logic fio_icb_rsp_excl_ok,
output logic [31:0] fio_icb_rsp_rdata,
output logic mem_icb_enable,
output logic mem_icb_cmd_ready,
output logic mem_icb_rsp_valid,
output logic mem_icb_rsp_err,
output logic mem_icb_rsp_excl_ok,
output logic [31:0] mem_icb_rsp_rdata,
output logic lsu2itcm_icb_cmd_ready,
output logic lsu2itcm_icb_rsp_valid,
output logic lsu2itcm_icb_rsp_err,
output logic lsu2itcm_icb_rsp_excl_ok,
output logic [31:0] lsu2itcm_icb_rsp_rdata,
output logic [31:0] dtcm_region_indic,
output logic lsu2dtcm_icb_cmd_ready,
output logic lsu2dtcm_icb_rsp_valid,
output logic lsu2dtcm_icb_rsp_err,
output logic lsu2dtcm_icb_rsp_excl_ok,
output logic [31:0] lsu2dtcm_icb_rsp_rdata,
output logic nice_mem_holdup,
output logic nice_req_ready,
output logic nice_rsp_multicyc_valid,
output logic [31:0] nice_rsp_multicyc_dat,
output logic nice_rsp_multicyc_err,
output logic nice_icb_cmd_valid,
output logic [31:0] nice_icb_cmd_addr,
output logic nice_icb_cmd_read,
output logic [31:0] nice_icb_cmd_wdata,
output logic [1:0] nice_icb_cmd_size,
output logic nice_icb_rsp_ready,
output logic clk_core_ifu,
output logic clk_core_exu,
output logic clk_core_lsu,
output logic clk_core_biu,
output logic clk_aon,
output logic test_mode,
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
		pc_rtvec = 0;
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
		itcm_region_indic = 0;
		ifu2itcm_holdup = 0;
		ifu2itcm_icb_cmd_ready = 0;
		ifu2itcm_icb_rsp_valid = 0;
		ifu2itcm_icb_rsp_err = 0;
		ifu2itcm_icb_rsp_rdata = 0;
		ppi_region_indic = 0;
		ppi_icb_enable = 0;
		ppi_icb_cmd_ready = 0;
		ppi_icb_rsp_valid = 0;
		ppi_icb_rsp_err = 0;
		ppi_icb_rsp_excl_ok = 0;
		ppi_icb_rsp_rdata = 0;
		clint_region_indic = 0;
		clint_icb_enable = 0;
		clint_icb_cmd_ready = 0;
		clint_icb_rsp_valid = 0;
		clint_icb_rsp_err = 0;
		clint_icb_rsp_excl_ok = 0;
		clint_icb_rsp_rdata = 0;
		plic_region_indic = 0;
		plic_icb_enable = 0;
		plic_icb_cmd_ready = 0;
		plic_icb_rsp_valid = 0;
		plic_icb_rsp_err = 0;
		plic_icb_rsp_excl_ok = 0;
		plic_icb_rsp_rdata = 0;
		fio_region_indic = 0;
		fio_icb_enable = 0;
		fio_icb_cmd_ready = 0;
		fio_icb_rsp_valid = 0;
		fio_icb_rsp_err = 0;
		fio_icb_rsp_excl_ok = 0;
		fio_icb_rsp_rdata = 0;
		mem_icb_enable = 0;
		mem_icb_cmd_ready = 0;
		mem_icb_rsp_valid = 0;
		mem_icb_rsp_err = 0;
		mem_icb_rsp_excl_ok = 0;
		mem_icb_rsp_rdata = 0;
		lsu2itcm_icb_cmd_ready = 0;
		lsu2itcm_icb_rsp_valid = 0;
		lsu2itcm_icb_rsp_err = 0;
		lsu2itcm_icb_rsp_excl_ok = 0;
		lsu2itcm_icb_rsp_rdata = 0;
		dtcm_region_indic = 0;
		lsu2dtcm_icb_cmd_ready = 0;
		lsu2dtcm_icb_rsp_valid = 0;
		lsu2dtcm_icb_rsp_err = 0;
		lsu2dtcm_icb_rsp_excl_ok = 0;
		lsu2dtcm_icb_rsp_rdata = 0;
		nice_mem_holdup = 0;
		nice_req_ready = 0;
		nice_rsp_multicyc_valid = 0;
		nice_rsp_multicyc_dat = 0;
		nice_rsp_multicyc_err = 0;
		nice_icb_cmd_valid = 0;
		nice_icb_cmd_addr = 0;
		nice_icb_cmd_read = 0;
		nice_icb_cmd_wdata = 0;
		nice_icb_cmd_size = 0;
		nice_icb_rsp_ready = 0;
		clk_core_ifu = 0;
		clk_core_exu = 0;
		clk_core_lsu = 0;
		clk_core_biu = 0;
		clk_aon = 0;
		test_mode = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		pc_rtvec = ~0;
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
		itcm_region_indic = ~0;
		ifu2itcm_holdup = ~0;
		ifu2itcm_icb_cmd_ready = ~0;
		ifu2itcm_icb_rsp_valid = ~0;
		ifu2itcm_icb_rsp_err = ~0;
		ifu2itcm_icb_rsp_rdata = ~0;
		ppi_region_indic = ~0;
		ppi_icb_enable = ~0;
		ppi_icb_cmd_ready = ~0;
		ppi_icb_rsp_valid = ~0;
		ppi_icb_rsp_err = ~0;
		ppi_icb_rsp_excl_ok = ~0;
		ppi_icb_rsp_rdata = ~0;
		clint_region_indic = ~0;
		clint_icb_enable = ~0;
		clint_icb_cmd_ready = ~0;
		clint_icb_rsp_valid = ~0;
		clint_icb_rsp_err = ~0;
		clint_icb_rsp_excl_ok = ~0;
		clint_icb_rsp_rdata = ~0;
		plic_region_indic = ~0;
		plic_icb_enable = ~0;
		plic_icb_cmd_ready = ~0;
		plic_icb_rsp_valid = ~0;
		plic_icb_rsp_err = ~0;
		plic_icb_rsp_excl_ok = ~0;
		plic_icb_rsp_rdata = ~0;
		fio_region_indic = ~0;
		fio_icb_enable = ~0;
		fio_icb_cmd_ready = ~0;
		fio_icb_rsp_valid = ~0;
		fio_icb_rsp_err = ~0;
		fio_icb_rsp_excl_ok = ~0;
		fio_icb_rsp_rdata = ~0;
		mem_icb_enable = ~0;
		mem_icb_cmd_ready = ~0;
		mem_icb_rsp_valid = ~0;
		mem_icb_rsp_err = ~0;
		mem_icb_rsp_excl_ok = ~0;
		mem_icb_rsp_rdata = ~0;
		lsu2itcm_icb_cmd_ready = ~0;
		lsu2itcm_icb_rsp_valid = ~0;
		lsu2itcm_icb_rsp_err = ~0;
		lsu2itcm_icb_rsp_excl_ok = ~0;
		lsu2itcm_icb_rsp_rdata = ~0;
		dtcm_region_indic = ~0;
		lsu2dtcm_icb_cmd_ready = ~0;
		lsu2dtcm_icb_rsp_valid = ~0;
		lsu2dtcm_icb_rsp_err = ~0;
		lsu2dtcm_icb_rsp_excl_ok = ~0;
		lsu2dtcm_icb_rsp_rdata = ~0;
		nice_mem_holdup = ~0;
		nice_req_ready = ~0;
		nice_rsp_multicyc_valid = ~0;
		nice_rsp_multicyc_dat = ~0;
		nice_rsp_multicyc_err = ~0;
		nice_icb_cmd_valid = ~0;
		nice_icb_cmd_addr = ~0;
		nice_icb_cmd_read = ~0;
		nice_icb_cmd_wdata = ~0;
		nice_icb_cmd_size = ~0;
		nice_icb_rsp_ready = ~0;
		clk_core_ifu = ~0;
		clk_core_exu = ~0;
		clk_core_lsu = ~0;
		clk_core_biu = ~0;
		clk_aon = ~0;
		test_mode = ~0;
	end
	endtask

	task Random_Test();
	begin
		pc_rtvec = $urandom;
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
		itcm_region_indic = $urandom;
		ifu2itcm_holdup = $urandom;
		ifu2itcm_icb_cmd_ready = $urandom;
		ifu2itcm_icb_rsp_valid = $urandom;
		ifu2itcm_icb_rsp_err = $urandom;
		ifu2itcm_icb_rsp_rdata = $urandom;
		ppi_region_indic = $urandom;
		ppi_icb_enable = $urandom;
		ppi_icb_cmd_ready = $urandom;
		ppi_icb_rsp_valid = $urandom;
		ppi_icb_rsp_err = $urandom;
		ppi_icb_rsp_excl_ok = $urandom;
		ppi_icb_rsp_rdata = $urandom;
		clint_region_indic = $urandom;
		clint_icb_enable = $urandom;
		clint_icb_cmd_ready = $urandom;
		clint_icb_rsp_valid = $urandom;
		clint_icb_rsp_err = $urandom;
		clint_icb_rsp_excl_ok = $urandom;
		clint_icb_rsp_rdata = $urandom;
		plic_region_indic = $urandom;
		plic_icb_enable = $urandom;
		plic_icb_cmd_ready = $urandom;
		plic_icb_rsp_valid = $urandom;
		plic_icb_rsp_err = $urandom;
		plic_icb_rsp_excl_ok = $urandom;
		plic_icb_rsp_rdata = $urandom;
		fio_region_indic = $urandom;
		fio_icb_enable = $urandom;
		fio_icb_cmd_ready = $urandom;
		fio_icb_rsp_valid = $urandom;
		fio_icb_rsp_err = $urandom;
		fio_icb_rsp_excl_ok = $urandom;
		fio_icb_rsp_rdata = $urandom;
		mem_icb_enable = $urandom;
		mem_icb_cmd_ready = $urandom;
		mem_icb_rsp_valid = $urandom;
		mem_icb_rsp_err = $urandom;
		mem_icb_rsp_excl_ok = $urandom;
		mem_icb_rsp_rdata = $urandom;
		lsu2itcm_icb_cmd_ready = $urandom;
		lsu2itcm_icb_rsp_valid = $urandom;
		lsu2itcm_icb_rsp_err = $urandom;
		lsu2itcm_icb_rsp_excl_ok = $urandom;
		lsu2itcm_icb_rsp_rdata = $urandom;
		dtcm_region_indic = $urandom;
		lsu2dtcm_icb_cmd_ready = $urandom;
		lsu2dtcm_icb_rsp_valid = $urandom;
		lsu2dtcm_icb_rsp_err = $urandom;
		lsu2dtcm_icb_rsp_excl_ok = $urandom;
		lsu2dtcm_icb_rsp_rdata = $urandom;
		nice_mem_holdup = $urandom;
		nice_req_ready = $urandom;
		nice_rsp_multicyc_valid = $urandom;
		nice_rsp_multicyc_dat = $urandom;
		nice_rsp_multicyc_err = $urandom;
		nice_icb_cmd_valid = $urandom;
		nice_icb_cmd_addr = $urandom;
		nice_icb_cmd_read = $urandom;
		nice_icb_cmd_wdata = $urandom;
		nice_icb_cmd_size = $urandom;
		nice_icb_rsp_ready = $urandom;
		clk_core_ifu = $urandom;
		clk_core_exu = $urandom;
		clk_core_lsu = $urandom;
		clk_core_biu = $urandom;
		clk_aon = $urandom;
		test_mode = $urandom;
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
        for(int i = 0; i < 1000; i++)begin
            wavedrom_start("Random Test");
		Random_Test();
            repeat(2) @(posedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule