`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_nice_csr_ready;
		int errortime_nice_csr_ready;
		int errors_nice_csr_rdata;
		int errortime_nice_csr_rdata;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic nice_csr_valid;
	logic nice_csr_ready_ref;
	logic nice_csr_ready_dut;
	logic [32-1:0] nice_csr_addr;
	logic nice_csr_wr;
	logic [32-1:0] nice_csr_wdata;
	logic [32-1:0] nice_csr_rdata_ref;
	logic [32-1:0] nice_csr_rdata_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.nice_csr_valid(nice_csr_valid),
		.nice_csr_addr(nice_csr_addr),
		.nice_csr_wr(nice_csr_wr),
		.nice_csr_wdata(nice_csr_wdata),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_extend_csr good1 (
		.nice_csr_valid(nice_csr_valid),
		.nice_csr_ready(nice_csr_ready_ref),
		.nice_csr_addr(nice_csr_addr),
		.nice_csr_wr(nice_csr_wr),
		.nice_csr_wdata(nice_csr_wdata),
		.nice_csr_rdata(nice_csr_rdata_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_extend_csr top_module1 (
		.nice_csr_valid(nice_csr_valid),
		.nice_csr_ready(nice_csr_ready_dut),
		.nice_csr_addr(nice_csr_addr),
		.nice_csr_wr(nice_csr_wr),
		.nice_csr_wdata(nice_csr_wdata),
		.nice_csr_rdata(nice_csr_rdata_dut),
		.clk(clk),
		.rst_n(rst_n)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_nice_csr_ready)
			$display("Hint: Output 'nice_csr_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_csr_ready, stats1.errortime_nice_csr_ready);
		else
			$display("Hint: Output 'nice_csr_ready' has no mismatches.");
		if (stats1.errors_nice_csr_rdata)
			$display("Hint: Output 'nice_csr_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_csr_rdata, stats1.errortime_nice_csr_rdata);
		else
			$display("Hint: Output 'nice_csr_rdata' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ nice_csr_ready_ref,nice_csr_rdata_ref} ===
			( { nice_csr_ready_ref,nice_csr_rdata_ref} ^
			  { nice_csr_ready_dut,nice_csr_rdata_dut} ^
			  { nice_csr_ready_ref,nice_csr_rdata_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (nice_csr_ready_ref !== (nice_csr_ready_ref ^ nice_csr_ready_dut ^ nice_csr_ready_ref)) begin
			if (stats1.errors_nice_csr_ready == 0) stats1.errortime_nice_csr_ready = $time;
			stats1.errors_nice_csr_ready++;
		end
		if (nice_csr_rdata_ref !== (nice_csr_rdata_ref ^ nice_csr_rdata_dut ^ nice_csr_rdata_ref)) begin
			if (stats1.errors_nice_csr_rdata == 0) stats1.errortime_nice_csr_rdata = $time;
			stats1.errors_nice_csr_rdata++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
