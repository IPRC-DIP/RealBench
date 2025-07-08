`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_clk_out;
		int errortime_clk_out;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic clk_in;
	logic test_mode;
	logic clock_en;
	logic clk_out_ref;
	logic clk_out_dut;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
        .clk(clk),
		.clk_in(clk_in),
		.test_mode(test_mode),
		.clock_en(clock_en),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_clkgate good1 (
		.clk_in(clk_in),
		.test_mode(test_mode),
		.clock_en(clock_en),
		.clk_out(clk_out_ref)
	);
       
    // 实例化待测模块
	e203_clkgate top_module1 (
		.clk_in(clk_in),
		.test_mode(test_mode),
		.clock_en(clock_en),
		.clk_out(clk_out_dut)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_clk_out)
			$display("Hint: Output 'clk_out' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_out, stats1.errortime_clk_out);
		else
			$display("Hint: Output 'clk_out' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ clk_out_ref} ===
			( { clk_out_ref} ^
			  { clk_out_dut} ^
			  { clk_out_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (clk_out_ref !== (clk_out_ref ^ clk_out_dut ^ clk_out_ref)) begin
			if (stats1.errors_clk_out == 0) stats1.errortime_clk_out = $time;
			stats1.errors_clk_out++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
