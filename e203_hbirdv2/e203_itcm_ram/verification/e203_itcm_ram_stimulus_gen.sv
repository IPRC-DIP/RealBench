module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic sd,
output logic ds,
output logic ls,
output logic cs,
output logic we,
output logic [12:0] addr,
output logic [7:0] wem,
output logic [63:0] din,
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
		sd = 0;
		ds = 0;
		ls = 0;
		cs = 0;
		we = 0;
		addr = 0;
		wem = 0;
		din = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		sd = ~0;
		ds = ~0;
		ls = ~0;
		cs = ~0;
		we = ~0;
		addr = ~0;
		wem = ~0;
		din = ~0;
	end
	endtask

	task Random_Test();
	begin
		sd = $urandom;
		ds = $urandom;
		ls = $urandom;
		cs = $urandom;
		we = $urandom;
		addr = $urandom;
		wem = $urandom;
		din = $urandom;
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