`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_ext_irq_r;
		int errortime_ext_irq_r;
		int errors_sft_irq_r;
		int errortime_sft_irq_r;
		int errors_tmr_irq_r;
		int errortime_tmr_irq_r;
		int errors_dbg_irq_r;
		int errortime_dbg_irq_r;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic rst_n;
	logic ext_irq_a;
	logic sft_irq_a;
	logic tmr_irq_a;
	logic dbg_irq_a;
	logic ext_irq_r_ref;
	logic ext_irq_r_dut;
	logic sft_irq_r_ref;
	logic sft_irq_r_dut;
	logic tmr_irq_r_ref;
	logic tmr_irq_r_dut;
	logic dbg_irq_r_ref;
	logic dbg_irq_r_dut;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.clk(clk),
		.rst_n(rst_n),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.dbg_irq_a(dbg_irq_a),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_irq_sync good1 (
		.clk(clk),
		.rst_n(rst_n),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.dbg_irq_a(dbg_irq_a),
		.ext_irq_r(ext_irq_r_ref),
		.sft_irq_r(sft_irq_r_ref),
		.tmr_irq_r(tmr_irq_r_ref),
		.dbg_irq_r(dbg_irq_r_ref)
	);
       
    // 实例化待测模块
	e203_irq_sync top_module1 (
		.clk(clk),
		.rst_n(rst_n),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.dbg_irq_a(dbg_irq_a),
		.ext_irq_r(ext_irq_r_dut),
		.sft_irq_r(sft_irq_r_dut),
		.tmr_irq_r(tmr_irq_r_dut),
		.dbg_irq_r(dbg_irq_r_dut)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_ext_irq_r)
			$display("Hint: Output 'ext_irq_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext_irq_r, stats1.errortime_ext_irq_r);
		else
			$display("Hint: Output 'ext_irq_r' has no mismatches.");
		if (stats1.errors_sft_irq_r)
			$display("Hint: Output 'sft_irq_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_sft_irq_r, stats1.errortime_sft_irq_r);
		else
			$display("Hint: Output 'sft_irq_r' has no mismatches.");
		if (stats1.errors_tmr_irq_r)
			$display("Hint: Output 'tmr_irq_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_tmr_irq_r, stats1.errortime_tmr_irq_r);
		else
			$display("Hint: Output 'tmr_irq_r' has no mismatches.");
		if (stats1.errors_dbg_irq_r)
			$display("Hint: Output 'dbg_irq_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dbg_irq_r, stats1.errortime_dbg_irq_r);
		else
			$display("Hint: Output 'dbg_irq_r' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ ext_irq_r_ref,sft_irq_r_ref,tmr_irq_r_ref,dbg_irq_r_ref} ===
			( { ext_irq_r_ref,sft_irq_r_ref,tmr_irq_r_ref,dbg_irq_r_ref} ^
			  { ext_irq_r_dut,sft_irq_r_dut,tmr_irq_r_dut,dbg_irq_r_dut} ^
			  { ext_irq_r_ref,sft_irq_r_ref,tmr_irq_r_ref,dbg_irq_r_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (ext_irq_r_ref !== (ext_irq_r_ref ^ ext_irq_r_dut ^ ext_irq_r_ref)) begin
			if (stats1.errors_ext_irq_r == 0) stats1.errortime_ext_irq_r = $time;
			stats1.errors_ext_irq_r++;
		end
		if (sft_irq_r_ref !== (sft_irq_r_ref ^ sft_irq_r_dut ^ sft_irq_r_ref)) begin
			if (stats1.errors_sft_irq_r == 0) stats1.errortime_sft_irq_r = $time;
			stats1.errors_sft_irq_r++;
		end
		if (tmr_irq_r_ref !== (tmr_irq_r_ref ^ tmr_irq_r_dut ^ tmr_irq_r_ref)) begin
			if (stats1.errors_tmr_irq_r == 0) stats1.errortime_tmr_irq_r = $time;
			stats1.errors_tmr_irq_r++;
		end
		if (dbg_irq_r_ref !== (dbg_irq_r_ref ^ dbg_irq_r_dut ^ dbg_irq_r_ref)) begin
			if (stats1.errors_dbg_irq_r == 0) stats1.errortime_dbg_irq_r = $time;
			stats1.errors_dbg_irq_r++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
