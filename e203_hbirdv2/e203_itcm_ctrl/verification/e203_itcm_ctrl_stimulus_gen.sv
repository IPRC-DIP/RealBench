module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic tcm_cgstop,
output logic ifu2itcm_icb_cmd_valid,
output logic [15:0] ifu2itcm_icb_cmd_addr,
output logic ifu2itcm_icb_cmd_read,
output logic [63:0] ifu2itcm_icb_cmd_wdata,
output logic [7:0] ifu2itcm_icb_cmd_wmask,
output logic ifu2itcm_icb_rsp_ready,
output logic lsu2itcm_icb_cmd_valid,
output logic [15:0] lsu2itcm_icb_cmd_addr,
output logic lsu2itcm_icb_cmd_read,
output logic [31:0] lsu2itcm_icb_cmd_wdata,
output logic [3:0] lsu2itcm_icb_cmd_wmask,
output logic lsu2itcm_icb_rsp_ready,
output logic ext2itcm_icb_cmd_valid,
output logic [15:0] ext2itcm_icb_cmd_addr,
output logic ext2itcm_icb_cmd_read,
output logic [31:0] ext2itcm_icb_cmd_wdata,
output logic [3:0] ext2itcm_icb_cmd_wmask,
output logic ext2itcm_icb_rsp_ready,
output logic [63:0] itcm_ram_dout,
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
		tcm_cgstop = 0;
		ifu2itcm_icb_cmd_valid = 0;
		ifu2itcm_icb_cmd_addr = 0;
		ifu2itcm_icb_cmd_read = 0;
		ifu2itcm_icb_cmd_wdata = 0;
		ifu2itcm_icb_cmd_wmask = 0;
		ifu2itcm_icb_rsp_ready = 0;
		lsu2itcm_icb_cmd_valid = 0;
		lsu2itcm_icb_cmd_addr = 0;
		lsu2itcm_icb_cmd_read = 0;
		lsu2itcm_icb_cmd_wdata = 0;
		lsu2itcm_icb_cmd_wmask = 0;
		lsu2itcm_icb_rsp_ready = 0;
		ext2itcm_icb_cmd_valid = 0;
		ext2itcm_icb_cmd_addr = 0;
		ext2itcm_icb_cmd_read = 0;
		ext2itcm_icb_cmd_wdata = 0;
		ext2itcm_icb_cmd_wmask = 0;
		ext2itcm_icb_rsp_ready = 0;
		itcm_ram_dout = 0;
		test_mode = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		tcm_cgstop = ~0;
		ifu2itcm_icb_cmd_valid = ~0;
		ifu2itcm_icb_cmd_addr = ~0;
		ifu2itcm_icb_cmd_read = ~0;
		ifu2itcm_icb_cmd_wdata = ~0;
		ifu2itcm_icb_cmd_wmask = ~0;
		ifu2itcm_icb_rsp_ready = ~0;
		lsu2itcm_icb_cmd_valid = ~0;
		lsu2itcm_icb_cmd_addr = ~0;
		lsu2itcm_icb_cmd_read = ~0;
		lsu2itcm_icb_cmd_wdata = ~0;
		lsu2itcm_icb_cmd_wmask = ~0;
		lsu2itcm_icb_rsp_ready = ~0;
		ext2itcm_icb_cmd_valid = ~0;
		ext2itcm_icb_cmd_addr = ~0;
		ext2itcm_icb_cmd_read = ~0;
		ext2itcm_icb_cmd_wdata = ~0;
		ext2itcm_icb_cmd_wmask = ~0;
		ext2itcm_icb_rsp_ready = ~0;
		itcm_ram_dout = ~0;
		test_mode = ~0;
	end
	endtask

	task Random_Test();
	begin
		tcm_cgstop = $urandom;
		ifu2itcm_icb_cmd_valid = $urandom;
		ifu2itcm_icb_cmd_addr = $urandom;
		ifu2itcm_icb_cmd_read = $urandom;
		ifu2itcm_icb_cmd_wdata = $urandom;
		ifu2itcm_icb_cmd_wmask = $urandom;
		ifu2itcm_icb_rsp_ready = $urandom;
		lsu2itcm_icb_cmd_valid = $urandom;
		lsu2itcm_icb_cmd_addr = $urandom;
		lsu2itcm_icb_cmd_read = $urandom;
		lsu2itcm_icb_cmd_wdata = $urandom;
		lsu2itcm_icb_cmd_wmask = $urandom;
		lsu2itcm_icb_rsp_ready = $urandom;
		ext2itcm_icb_cmd_valid = $urandom;
		ext2itcm_icb_cmd_addr = $urandom;
		ext2itcm_icb_cmd_read = $urandom;
		ext2itcm_icb_cmd_wdata = $urandom;
		ext2itcm_icb_cmd_wmask = $urandom;
		ext2itcm_icb_rsp_ready = $urandom;
		itcm_ram_dout = $urandom;
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