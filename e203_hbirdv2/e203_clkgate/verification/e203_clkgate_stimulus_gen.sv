module stimulus_gen (
    input clk,
output logic clk_in,
output logic test_mode,
output logic clock_en,
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
		clk_in = 0;
		test_mode = 0;
		clock_en = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		clk_in = ~0;
		test_mode = ~0;
		clock_en = ~0;
	end
	endtask

	task Random_Test();
	begin
		clk_in = $urandom;
		test_mode = $urandom;
		clock_en = 1'b1;
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