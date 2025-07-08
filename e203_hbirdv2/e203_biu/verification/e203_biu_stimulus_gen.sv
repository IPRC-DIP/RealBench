module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic lsu2biu_icb_cmd_valid,
output logic [31:0] lsu2biu_icb_cmd_addr,
output logic lsu2biu_icb_cmd_read,
output logic [31:0] lsu2biu_icb_cmd_wdata,
output logic [3:0] lsu2biu_icb_cmd_wmask,
output logic [1:0] lsu2biu_icb_cmd_burst,
output logic [1:0] lsu2biu_icb_cmd_beat,
output logic lsu2biu_icb_cmd_lock,
output logic lsu2biu_icb_cmd_excl,
output logic [1:0] lsu2biu_icb_cmd_size,
output logic lsu2biu_icb_rsp_ready,
output logic ifu2biu_icb_cmd_valid,
output logic [31:0] ifu2biu_icb_cmd_addr,
output logic ifu2biu_icb_cmd_read,
output logic [31:0] ifu2biu_icb_cmd_wdata,
output logic [3:0] ifu2biu_icb_cmd_wmask,
output logic [1:0] ifu2biu_icb_cmd_burst,
output logic [1:0] ifu2biu_icb_cmd_beat,
output logic ifu2biu_icb_cmd_lock,
output logic ifu2biu_icb_cmd_excl,
output logic [1:0] ifu2biu_icb_cmd_size,
output logic ifu2biu_icb_rsp_ready,
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
		lsu2biu_icb_cmd_valid = 0;
		lsu2biu_icb_cmd_addr = 0;
		lsu2biu_icb_cmd_read = 0;
		lsu2biu_icb_cmd_wdata = 0;
		lsu2biu_icb_cmd_wmask = 0;
		lsu2biu_icb_cmd_burst = 0;
		lsu2biu_icb_cmd_beat = 0;
		lsu2biu_icb_cmd_lock = 0;
		lsu2biu_icb_cmd_excl = 0;
		lsu2biu_icb_cmd_size = 0;
		lsu2biu_icb_rsp_ready = 0;
		ifu2biu_icb_cmd_valid = 0;
		ifu2biu_icb_cmd_addr = 0;
		ifu2biu_icb_cmd_read = 0;
		ifu2biu_icb_cmd_wdata = 0;
		ifu2biu_icb_cmd_wmask = 0;
		ifu2biu_icb_cmd_burst = 0;
		ifu2biu_icb_cmd_beat = 0;
		ifu2biu_icb_cmd_lock = 0;
		ifu2biu_icb_cmd_excl = 0;
		ifu2biu_icb_cmd_size = 0;
		ifu2biu_icb_rsp_ready = 0;
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
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		lsu2biu_icb_cmd_valid = ~0;
		lsu2biu_icb_cmd_addr = ~0;
		lsu2biu_icb_cmd_read = ~0;
		lsu2biu_icb_cmd_wdata = ~0;
		lsu2biu_icb_cmd_wmask = ~0;
		lsu2biu_icb_cmd_burst = ~0;
		lsu2biu_icb_cmd_beat = ~0;
		lsu2biu_icb_cmd_lock = ~0;
		lsu2biu_icb_cmd_excl = ~0;
		lsu2biu_icb_cmd_size = ~0;
		lsu2biu_icb_rsp_ready = ~0;
		ifu2biu_icb_cmd_valid = ~0;
		ifu2biu_icb_cmd_addr = ~0;
		ifu2biu_icb_cmd_read = ~0;
		ifu2biu_icb_cmd_wdata = ~0;
		ifu2biu_icb_cmd_wmask = ~0;
		ifu2biu_icb_cmd_burst = ~0;
		ifu2biu_icb_cmd_beat = ~0;
		ifu2biu_icb_cmd_lock = ~0;
		ifu2biu_icb_cmd_excl = ~0;
		ifu2biu_icb_cmd_size = ~0;
		ifu2biu_icb_rsp_ready = ~0;
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
	end
	endtask

	task Random_Test();
	begin
		lsu2biu_icb_cmd_valid = $urandom;
		lsu2biu_icb_cmd_addr = $urandom;
		lsu2biu_icb_cmd_read = $urandom;
		lsu2biu_icb_cmd_wdata = $urandom;
		lsu2biu_icb_cmd_wmask = $urandom;
		lsu2biu_icb_cmd_burst = $urandom;
		lsu2biu_icb_cmd_beat = $urandom;
		lsu2biu_icb_cmd_lock = $urandom;
		lsu2biu_icb_cmd_excl = $urandom;
		lsu2biu_icb_cmd_size = $urandom;
		lsu2biu_icb_rsp_ready = $urandom;
		ifu2biu_icb_cmd_valid = $urandom;
		ifu2biu_icb_cmd_addr = $urandom;
		ifu2biu_icb_cmd_read = $urandom;
		ifu2biu_icb_cmd_wdata = $urandom;
		ifu2biu_icb_cmd_wmask = $urandom;
		ifu2biu_icb_cmd_burst = $urandom;
		ifu2biu_icb_cmd_beat = $urandom;
		ifu2biu_icb_cmd_lock = $urandom;
		ifu2biu_icb_cmd_excl = $urandom;
		ifu2biu_icb_cmd_size = $urandom;
		ifu2biu_icb_rsp_ready = $urandom;
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