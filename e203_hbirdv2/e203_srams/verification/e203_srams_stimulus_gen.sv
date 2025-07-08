module stimulus_gen (
    input clk,
output logic itcm_ram_sd,
output logic itcm_ram_ds,
output logic itcm_ram_ls,
output logic itcm_ram_cs,
output logic itcm_ram_we,
output logic [12:0] itcm_ram_addr,
output logic [7:0] itcm_ram_wem,
output logic [63:0] itcm_ram_din,
output logic clk_itcm_ram,
output logic rst_itcm,
output logic dtcm_ram_sd,
output logic dtcm_ram_ds,
output logic dtcm_ram_ls,
output logic dtcm_ram_cs,
output logic dtcm_ram_we,
output logic [13:0] dtcm_ram_addr,
output logic [3:0] dtcm_ram_wem,
output logic [31:0] dtcm_ram_din,
output logic clk_dtcm_ram,
output logic rst_dtcm,
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

	task Task2();
	begin
	// Add Task2 here
		itcm_ram_sd = 0;
		itcm_ram_ds = 0;
		itcm_ram_ls = 0;
		itcm_ram_cs = 0;
		itcm_ram_we = 0;
		itcm_ram_addr = 0;
		itcm_ram_wem = 0;
		itcm_ram_din = 0;
		clk_itcm_ram = 0;
		rst_itcm = 0;
		dtcm_ram_sd = 0;
		dtcm_ram_ds = 0;
		dtcm_ram_ls = 0;
		dtcm_ram_cs = 0;
		dtcm_ram_we = 0;
		dtcm_ram_addr = 0;
		dtcm_ram_wem = 0;
		dtcm_ram_din = 0;
		clk_dtcm_ram = 0;
		rst_dtcm = 0;
		test_mode = 0;
	end
	endtask

	task Task1();
	begin
	// Add Task1 here
		itcm_ram_sd = ~0;
		itcm_ram_ds = ~0;
		itcm_ram_ls = ~0;
		itcm_ram_cs = ~0;
		itcm_ram_we = ~0;
		itcm_ram_addr = ~0;
		itcm_ram_wem = ~0;
		itcm_ram_din = ~0;
		clk_itcm_ram = ~0;
		rst_itcm = ~0;
		dtcm_ram_sd = ~0;
		dtcm_ram_ds = ~0;
		dtcm_ram_ls = ~0;
		dtcm_ram_cs = ~0;
		dtcm_ram_we = ~0;
		dtcm_ram_addr = ~0;
		dtcm_ram_wem = ~0;
		dtcm_ram_din = ~0;
		clk_dtcm_ram = ~0;
		rst_dtcm = ~0;
		test_mode = ~0;
	end
	endtask

	task Random_Test();
	begin
		itcm_ram_sd = $urandom;
		itcm_ram_ds = $urandom;
		itcm_ram_ls = $urandom;
		itcm_ram_cs = $urandom;
		itcm_ram_we = $urandom;
		itcm_ram_addr = $urandom;
		itcm_ram_wem = $urandom;
		itcm_ram_din = $urandom;
		clk_itcm_ram = $urandom;
		rst_itcm = 0;
		dtcm_ram_sd = $urandom;
		dtcm_ram_ds = $urandom;
		dtcm_ram_ls = $urandom;
		dtcm_ram_cs = $urandom;
		dtcm_ram_we = $urandom;
		dtcm_ram_addr = $urandom;
		dtcm_ram_wem = $urandom;
		dtcm_ram_din = $urandom;
		clk_dtcm_ram = $urandom;
		rst_dtcm = 0;
		test_mode = $urandom;
	end
	endtask

    initial begin
        
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