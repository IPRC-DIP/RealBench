module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic [31:0] pc_rtvec,
output logic [31:0] dcsr_r,
output logic [31:0] dpc_r,
output logic [31:0] dscratch_r,
output logic dbg_mode,
output logic dbg_halt_r,
output logic dbg_step_r,
output logic dbg_ebreakm_r,
output logic dbg_stopcycle,
output logic dbg_irq_a,
output logic core_mhartid,
output logic ext_irq_a,
output logic sft_irq_a,
output logic tmr_irq_a,
output logic tcm_sd,
output logic tcm_ds,
output logic ext2itcm_icb_cmd_valid,
output logic [15:0] ext2itcm_icb_cmd_addr,
output logic ext2itcm_icb_cmd_read,
output logic [31:0] ext2itcm_icb_cmd_wdata,
output logic [3:0] ext2itcm_icb_cmd_wmask,
output logic ext2itcm_icb_rsp_ready,
output logic ext2dtcm_icb_cmd_valid,
output logic [15:0] ext2dtcm_icb_cmd_addr,
output logic ext2dtcm_icb_cmd_read,
output logic [31:0] ext2dtcm_icb_cmd_wdata,
output logic [3:0] ext2dtcm_icb_cmd_wmask,
output logic ext2dtcm_icb_rsp_ready,
output logic ppi_icb_cmd_ready,
output logic ppi_icb_rsp_valid,
output logic ppi_icb_rsp_err,
output logic [31:0] ppi_icb_rsp_rdata,
output logic clint_icb_cmd_ready,
output logic clint_icb_rsp_valid,
output logic clint_icb_rsp_err,
output logic [31:0] clint_icb_rsp_rdata,
output logic plic_icb_cmd_ready,
output logic plic_icb_rsp_valid,
output logic plic_icb_rsp_err,
output logic [31:0] plic_icb_rsp_rdata,
output logic fio_icb_cmd_ready,
output logic fio_icb_rsp_valid,
output logic fio_icb_rsp_err,
output logic [31:0] fio_icb_rsp_rdata,
output logic mem_icb_cmd_ready,
output logic mem_icb_rsp_valid,
output logic mem_icb_rsp_err,
output logic [31:0] mem_icb_rsp_rdata,
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
		dcsr_r = 0;
		dpc_r = 0;
		dscratch_r = 0;
		dbg_mode = 0;
		dbg_halt_r = 0;
		dbg_step_r = 0;
		dbg_ebreakm_r = 0;
		dbg_stopcycle = 0;
		dbg_irq_a = 0;
		core_mhartid = 0;
		ext_irq_a = 0;
		sft_irq_a = 0;
		tmr_irq_a = 0;
		tcm_sd = 0;
		tcm_ds = 0;
		ext2itcm_icb_cmd_valid = 0;
		ext2itcm_icb_cmd_addr = 0;
		ext2itcm_icb_cmd_read = 0;
		ext2itcm_icb_cmd_wdata = 0;
		ext2itcm_icb_cmd_wmask = 0;
		ext2itcm_icb_rsp_ready = 0;
		ext2dtcm_icb_cmd_valid = 0;
		ext2dtcm_icb_cmd_addr = 0;
		ext2dtcm_icb_cmd_read = 0;
		ext2dtcm_icb_cmd_wdata = 0;
		ext2dtcm_icb_cmd_wmask = 0;
		ext2dtcm_icb_rsp_ready = 0;
		ppi_icb_cmd_ready = 0;
		ppi_icb_rsp_valid = 0;
		ppi_icb_rsp_err = 0;
		ppi_icb_rsp_rdata = 0;
		clint_icb_cmd_ready = 0;
		clint_icb_rsp_valid = 0;
		clint_icb_rsp_err = 0;
		clint_icb_rsp_rdata = 0;
		plic_icb_cmd_ready = 0;
		plic_icb_rsp_valid = 0;
		plic_icb_rsp_err = 0;
		plic_icb_rsp_rdata = 0;
		fio_icb_cmd_ready = 0;
		fio_icb_rsp_valid = 0;
		fio_icb_rsp_err = 0;
		fio_icb_rsp_rdata = 0;
		mem_icb_cmd_ready = 0;
		mem_icb_rsp_valid = 0;
		mem_icb_rsp_err = 0;
		mem_icb_rsp_rdata = 0;
		test_mode = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		pc_rtvec = ~0;
		dcsr_r = ~0;
		dpc_r = ~0;
		dscratch_r = ~0;
		dbg_mode = ~0;
		dbg_halt_r = ~0;
		dbg_step_r = ~0;
		dbg_ebreakm_r = ~0;
		dbg_stopcycle = ~0;
		dbg_irq_a = ~0;
		core_mhartid = ~0;
		ext_irq_a = ~0;
		sft_irq_a = ~0;
		tmr_irq_a = ~0;
		tcm_sd = ~0;
		tcm_ds = ~0;
		ext2itcm_icb_cmd_valid = ~0;
		ext2itcm_icb_cmd_addr = ~0;
		ext2itcm_icb_cmd_read = ~0;
		ext2itcm_icb_cmd_wdata = ~0;
		ext2itcm_icb_cmd_wmask = ~0;
		ext2itcm_icb_rsp_ready = ~0;
		ext2dtcm_icb_cmd_valid = ~0;
		ext2dtcm_icb_cmd_addr = ~0;
		ext2dtcm_icb_cmd_read = ~0;
		ext2dtcm_icb_cmd_wdata = ~0;
		ext2dtcm_icb_cmd_wmask = ~0;
		ext2dtcm_icb_rsp_ready = ~0;
		ppi_icb_cmd_ready = ~0;
		ppi_icb_rsp_valid = ~0;
		ppi_icb_rsp_err = ~0;
		ppi_icb_rsp_rdata = ~0;
		clint_icb_cmd_ready = ~0;
		clint_icb_rsp_valid = ~0;
		clint_icb_rsp_err = ~0;
		clint_icb_rsp_rdata = ~0;
		plic_icb_cmd_ready = ~0;
		plic_icb_rsp_valid = ~0;
		plic_icb_rsp_err = ~0;
		plic_icb_rsp_rdata = ~0;
		fio_icb_cmd_ready = ~0;
		fio_icb_rsp_valid = ~0;
		fio_icb_rsp_err = ~0;
		fio_icb_rsp_rdata = ~0;
		mem_icb_cmd_ready = ~0;
		mem_icb_rsp_valid = ~0;
		mem_icb_rsp_err = ~0;
		mem_icb_rsp_rdata = ~0;
		test_mode = ~0;
	end
	endtask

	task Random_Test();
	begin
		pc_rtvec = $urandom;
		dcsr_r = $urandom;
		dpc_r = $urandom;
		dscratch_r = $urandom;
		dbg_mode = $urandom;
		dbg_halt_r = $urandom;
		dbg_step_r = $urandom;
		dbg_ebreakm_r = $urandom;
		dbg_stopcycle = $urandom;
		dbg_irq_a = $urandom;
		core_mhartid = $urandom;
		ext_irq_a = $urandom;
		sft_irq_a = $urandom;
		tmr_irq_a = $urandom;
		tcm_sd = $urandom;
		tcm_ds = $urandom;
		ext2itcm_icb_cmd_valid = $urandom;
		ext2itcm_icb_cmd_addr = $urandom;
		ext2itcm_icb_cmd_read = $urandom;
		ext2itcm_icb_cmd_wdata = $urandom;
		ext2itcm_icb_cmd_wmask = $urandom;
		ext2itcm_icb_rsp_ready = $urandom;
		ext2dtcm_icb_cmd_valid = $urandom;
		ext2dtcm_icb_cmd_addr = $urandom;
		ext2dtcm_icb_cmd_read = $urandom;
		ext2dtcm_icb_cmd_wdata = $urandom;
		ext2dtcm_icb_cmd_wmask = $urandom;
		ext2dtcm_icb_rsp_ready = $urandom;
		ppi_icb_cmd_ready = $urandom;
		ppi_icb_rsp_valid = $urandom;
		ppi_icb_rsp_err = $urandom;
		ppi_icb_rsp_rdata = $urandom;
		clint_icb_cmd_ready = $urandom;
		clint_icb_rsp_valid = $urandom;
		clint_icb_rsp_err = $urandom;
		clint_icb_rsp_rdata = $urandom;
		plic_icb_cmd_ready = $urandom;
		plic_icb_rsp_valid = $urandom;
		plic_icb_rsp_err = $urandom;
		plic_icb_rsp_rdata = $urandom;
		fio_icb_cmd_ready = $urandom;
		fio_icb_rsp_valid = $urandom;
		fio_icb_rsp_err = $urandom;
		fio_icb_rsp_rdata = $urandom;
		mem_icb_cmd_ready = $urandom;
		mem_icb_rsp_valid = $urandom;
		mem_icb_rsp_err = $urandom;
		mem_icb_rsp_rdata = $urandom;
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