`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_dout;
		int errortime_dout;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic sd;
	logic ds;
	logic ls;
	logic cs;
	logic we;
	logic [14-1:0] addr;
	logic [4-1:0] wem;
	logic [32-1:0] din;
	logic [32-1:0] dout_ref;
	logic [32-1:0] dout_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.sd(sd),
		.ds(ds),
		.ls(ls),
		.cs(cs),
		.we(we),
		.addr(addr),
		.wem(wem),
		.din(din),
		.rst_n(rst_n),
		.clk(clk),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_dtcm_ram good1 (
		.sd(sd),
		.ds(ds),
		.ls(ls),
		.cs(cs),
		.we(we),
		.addr(addr),
		.wem(wem),
		.din(din),
		.dout(dout_ref),
		.rst_n(rst_n),
		.clk(clk)
	);
       
    // 实例化待测模块
	e203_dtcm_ram top_module1 (
		.sd(sd),
		.ds(ds),
		.ls(ls),
		.cs(cs),
		.we(we),
		.addr(addr),
		.wem(wem),
		.din(din),
		.dout(dout_dut),
		.rst_n(rst_n),
		.clk(clk)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_dout)
			$display("Hint: Output 'dout' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dout, stats1.errortime_dout);
		else
			$display("Hint: Output 'dout' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ dout_ref} ===
			( { dout_ref} ^
			  { dout_dut} ^
			  { dout_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (dout_ref !== (dout_ref ^ dout_dut ^ dout_ref)) begin
			if (stats1.errors_dout == 0) stats1.errortime_dout = $time;
			stats1.errors_dout++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
