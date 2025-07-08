`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_rst_core;
		int errortime_rst_core;
		int errors_rst_itcm;
		int errortime_rst_itcm;
		int errors_rst_dtcm;
		int errortime_rst_dtcm;
		int errors_rst_aon;
		int errortime_rst_aon;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic rst_n;
	logic test_mode;
	logic rst_core_ref;
	logic rst_core_dut;
	logic rst_itcm_ref;
	logic rst_itcm_dut;
	logic rst_dtcm_ref;
	logic rst_dtcm_dut;
	logic rst_aon_ref;
	logic rst_aon_dut;

	
	logic rst_core_ref_0;
	logic rst_core_dut_0;
	logic rst_itcm_ref_0;
	logic rst_itcm_dut_0;
	logic rst_dtcm_ref_0;
	logic rst_dtcm_dut_0;
	logic rst_aon_ref_0;
	logic rst_aon_dut_0;
    
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
		.test_mode(test_mode),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_reset_ctrl good1 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.rst_core(rst_core_ref),
		.rst_itcm(rst_itcm_ref),
		.rst_dtcm(rst_dtcm_ref),
		.rst_aon(rst_aon_ref)
	);
       
    // 实例化待测模块
	e203_reset_ctrl top_module1 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.rst_core(rst_core_dut),
		.rst_itcm(rst_itcm_dut),
		.rst_dtcm(rst_dtcm_dut),
		.rst_aon(rst_aon_dut)
	);

	// 实例化参考模块0
	ref_e203_reset_ctrl #(0) good0 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.rst_core(rst_core_ref_0),
		.rst_itcm(rst_itcm_ref_0),
		.rst_dtcm(rst_dtcm_ref_0),
		.rst_aon(rst_aon_ref_0)
	);
       
    // 实例化待测模块0
	e203_reset_ctrl #(0) top_module0 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.rst_core(rst_core_dut_0),
		.rst_itcm(rst_itcm_dut_0),
		.rst_dtcm(rst_dtcm_dut_0),
		.rst_aon(rst_aon_dut_0)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_rst_core)
			$display("Hint: Output 'rst_core' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rst_core, stats1.errortime_rst_core);
		else
			$display("Hint: Output 'rst_core' has no mismatches.");
		if (stats1.errors_rst_itcm)
			$display("Hint: Output 'rst_itcm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rst_itcm, stats1.errortime_rst_itcm);
		else
			$display("Hint: Output 'rst_itcm' has no mismatches.");
		if (stats1.errors_rst_dtcm)
			$display("Hint: Output 'rst_dtcm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rst_dtcm, stats1.errortime_rst_dtcm);
		else
			$display("Hint: Output 'rst_dtcm' has no mismatches.");
		if (stats1.errors_rst_aon)
			$display("Hint: Output 'rst_aon' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rst_aon, stats1.errortime_rst_aon);
		else
			$display("Hint: Output 'rst_aon' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ rst_core_ref,rst_itcm_ref,rst_dtcm_ref,rst_aon_ref,rst_core_ref_0,rst_itcm_ref_0,rst_dtcm_ref_0,rst_aon_ref_0} ===
			( { rst_core_ref,rst_itcm_ref,rst_dtcm_ref,rst_aon_ref,rst_core_ref_0,rst_itcm_ref_0,rst_dtcm_ref_0,rst_aon_ref_0} ^
			  { rst_core_dut,rst_itcm_dut,rst_dtcm_dut,rst_aon_dut,rst_core_dut_0,rst_itcm_dut_0,rst_dtcm_dut_0,rst_aon_dut_0} ^
			  { rst_core_ref,rst_itcm_ref,rst_dtcm_ref,rst_aon_ref,rst_core_ref_0,rst_itcm_ref_0,rst_dtcm_ref_0,rst_aon_ref_0} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (rst_core_ref !== (rst_core_ref ^ rst_core_dut ^ rst_core_ref)) begin
			if (stats1.errors_rst_core == 0) stats1.errortime_rst_core = $time;
			stats1.errors_rst_core++;
		end
		if (rst_core_ref_0 !== (rst_core_ref_0 ^ rst_core_dut_0 ^ rst_core_ref_0)) begin
			if (stats1.errors_rst_core == 0) stats1.errortime_rst_core = $time;
			stats1.errors_rst_core++;
		end
		if (rst_itcm_ref !== (rst_itcm_ref ^ rst_itcm_dut ^ rst_itcm_ref)) begin
			if (stats1.errors_rst_itcm == 0) stats1.errortime_rst_itcm = $time;
			stats1.errors_rst_itcm++;
		end
		if (rst_itcm_ref_0 !== (rst_itcm_ref_0 ^ rst_itcm_dut_0 ^ rst_itcm_ref_0)) begin
			if (stats1.errors_rst_itcm == 0) stats1.errortime_rst_itcm = $time;
			stats1.errors_rst_itcm++;
		end
		if (rst_dtcm_ref !== (rst_dtcm_ref ^ rst_dtcm_dut ^ rst_dtcm_ref)) begin
			if (stats1.errors_rst_dtcm == 0) stats1.errortime_rst_dtcm = $time;
			stats1.errors_rst_dtcm++;
		end
		if (rst_dtcm_ref_0 !== (rst_dtcm_ref_0 ^ rst_dtcm_dut_0 ^ rst_dtcm_ref_0)) begin
			if (stats1.errors_rst_dtcm == 0) stats1.errortime_rst_dtcm = $time;
			stats1.errors_rst_dtcm++;
		end
		if (rst_aon_ref !== (rst_aon_ref ^ rst_aon_dut ^ rst_aon_ref)) begin
			if (stats1.errors_rst_aon == 0) stats1.errortime_rst_aon = $time;
			stats1.errors_rst_aon++;
		end
		if (rst_aon_ref_0 !== (rst_aon_ref_0 ^ rst_aon_dut_0 ^ rst_aon_ref_0)) begin
			if (stats1.errors_rst_aon == 0) stats1.errortime_rst_aon = $time;
			stats1.errors_rst_aon++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
