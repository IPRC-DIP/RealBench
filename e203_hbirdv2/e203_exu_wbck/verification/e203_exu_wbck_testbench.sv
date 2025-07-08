`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_alu_wbck_i_ready;
		int errortime_alu_wbck_i_ready;
		int errors_longp_wbck_i_ready;
		int errortime_longp_wbck_i_ready;
		int errors_rf_wbck_o_ena;
		int errortime_rf_wbck_o_ena;
		int errors_rf_wbck_o_wdat;
		int errortime_rf_wbck_o_wdat;
		int errors_rf_wbck_o_rdidx;
		int errortime_rf_wbck_o_rdidx;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic alu_wbck_i_valid;
	logic alu_wbck_i_ready_ref;
	logic alu_wbck_i_ready_dut;
	logic [32-1:0] alu_wbck_i_wdat;
	logic [5-1:0] alu_wbck_i_rdidx;
	logic longp_wbck_i_valid;
	logic longp_wbck_i_ready_ref;
	logic longp_wbck_i_ready_dut;
	logic [32-1:0] longp_wbck_i_wdat;
	logic [5-1:0] longp_wbck_i_flags;
	logic [5-1:0] longp_wbck_i_rdidx;
	logic longp_wbck_i_rdfpu;
	logic rf_wbck_o_ena_ref;
	logic rf_wbck_o_ena_dut;
	logic [32-1:0] rf_wbck_o_wdat_ref;
	logic [32-1:0] rf_wbck_o_wdat_dut;
	logic [5-1:0] rf_wbck_o_rdidx_ref;
	logic [5-1:0] rf_wbck_o_rdidx_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.alu_wbck_i_valid(alu_wbck_i_valid),
		.alu_wbck_i_wdat(alu_wbck_i_wdat),
		.alu_wbck_i_rdidx(alu_wbck_i_rdidx),
		.longp_wbck_i_valid(longp_wbck_i_valid),
		.longp_wbck_i_wdat(longp_wbck_i_wdat),
		.longp_wbck_i_flags(longp_wbck_i_flags),
		.longp_wbck_i_rdidx(longp_wbck_i_rdidx),
		.longp_wbck_i_rdfpu(longp_wbck_i_rdfpu),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_wbck good1 (
		.alu_wbck_i_valid(alu_wbck_i_valid),
		.alu_wbck_i_ready(alu_wbck_i_ready_ref),
		.alu_wbck_i_wdat(alu_wbck_i_wdat),
		.alu_wbck_i_rdidx(alu_wbck_i_rdidx),
		.longp_wbck_i_valid(longp_wbck_i_valid),
		.longp_wbck_i_ready(longp_wbck_i_ready_ref),
		.longp_wbck_i_wdat(longp_wbck_i_wdat),
		.longp_wbck_i_flags(longp_wbck_i_flags),
		.longp_wbck_i_rdidx(longp_wbck_i_rdidx),
		.longp_wbck_i_rdfpu(longp_wbck_i_rdfpu),
		.rf_wbck_o_ena(rf_wbck_o_ena_ref),
		.rf_wbck_o_wdat(rf_wbck_o_wdat_ref),
		.rf_wbck_o_rdidx(rf_wbck_o_rdidx_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_wbck top_module1 (
		.alu_wbck_i_valid(alu_wbck_i_valid),
		.alu_wbck_i_ready(alu_wbck_i_ready_dut),
		.alu_wbck_i_wdat(alu_wbck_i_wdat),
		.alu_wbck_i_rdidx(alu_wbck_i_rdidx),
		.longp_wbck_i_valid(longp_wbck_i_valid),
		.longp_wbck_i_ready(longp_wbck_i_ready_dut),
		.longp_wbck_i_wdat(longp_wbck_i_wdat),
		.longp_wbck_i_flags(longp_wbck_i_flags),
		.longp_wbck_i_rdidx(longp_wbck_i_rdidx),
		.longp_wbck_i_rdfpu(longp_wbck_i_rdfpu),
		.rf_wbck_o_ena(rf_wbck_o_ena_dut),
		.rf_wbck_o_wdat(rf_wbck_o_wdat_dut),
		.rf_wbck_o_rdidx(rf_wbck_o_rdidx_dut),
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
		if (stats1.errors_alu_wbck_i_ready)
			$display("Hint: Output 'alu_wbck_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_wbck_i_ready, stats1.errortime_alu_wbck_i_ready);
		else
			$display("Hint: Output 'alu_wbck_i_ready' has no mismatches.");
		if (stats1.errors_longp_wbck_i_ready)
			$display("Hint: Output 'longp_wbck_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_i_ready, stats1.errortime_longp_wbck_i_ready);
		else
			$display("Hint: Output 'longp_wbck_i_ready' has no mismatches.");
		if (stats1.errors_rf_wbck_o_ena)
			$display("Hint: Output 'rf_wbck_o_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rf_wbck_o_ena, stats1.errortime_rf_wbck_o_ena);
		else
			$display("Hint: Output 'rf_wbck_o_ena' has no mismatches.");
		if (stats1.errors_rf_wbck_o_wdat)
			$display("Hint: Output 'rf_wbck_o_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rf_wbck_o_wdat, stats1.errortime_rf_wbck_o_wdat);
		else
			$display("Hint: Output 'rf_wbck_o_wdat' has no mismatches.");
		if (stats1.errors_rf_wbck_o_rdidx)
			$display("Hint: Output 'rf_wbck_o_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rf_wbck_o_rdidx, stats1.errortime_rf_wbck_o_rdidx);
		else
			$display("Hint: Output 'rf_wbck_o_rdidx' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ alu_wbck_i_ready_ref,longp_wbck_i_ready_ref,rf_wbck_o_ena_ref,rf_wbck_o_wdat_ref,rf_wbck_o_rdidx_ref} ===
			( { alu_wbck_i_ready_ref,longp_wbck_i_ready_ref,rf_wbck_o_ena_ref,rf_wbck_o_wdat_ref,rf_wbck_o_rdidx_ref} ^
			  { alu_wbck_i_ready_dut,longp_wbck_i_ready_dut,rf_wbck_o_ena_dut,rf_wbck_o_wdat_dut,rf_wbck_o_rdidx_dut} ^
			  { alu_wbck_i_ready_ref,longp_wbck_i_ready_ref,rf_wbck_o_ena_ref,rf_wbck_o_wdat_ref,rf_wbck_o_rdidx_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (alu_wbck_i_ready_ref !== (alu_wbck_i_ready_ref ^ alu_wbck_i_ready_dut ^ alu_wbck_i_ready_ref)) begin
			if (stats1.errors_alu_wbck_i_ready == 0) stats1.errortime_alu_wbck_i_ready = $time;
			stats1.errors_alu_wbck_i_ready++;
		end
		if (longp_wbck_i_ready_ref !== (longp_wbck_i_ready_ref ^ longp_wbck_i_ready_dut ^ longp_wbck_i_ready_ref)) begin
			if (stats1.errors_longp_wbck_i_ready == 0) stats1.errortime_longp_wbck_i_ready = $time;
			stats1.errors_longp_wbck_i_ready++;
		end
		if (rf_wbck_o_ena_ref !== (rf_wbck_o_ena_ref ^ rf_wbck_o_ena_dut ^ rf_wbck_o_ena_ref)) begin
			if (stats1.errors_rf_wbck_o_ena == 0) stats1.errortime_rf_wbck_o_ena = $time;
			stats1.errors_rf_wbck_o_ena++;
		end
		if (rf_wbck_o_wdat_ref !== (rf_wbck_o_wdat_ref ^ rf_wbck_o_wdat_dut ^ rf_wbck_o_wdat_ref)) begin
			if (stats1.errors_rf_wbck_o_wdat == 0) stats1.errortime_rf_wbck_o_wdat = $time;
			stats1.errors_rf_wbck_o_wdat++;
		end
		if (rf_wbck_o_rdidx_ref !== (rf_wbck_o_rdidx_ref ^ rf_wbck_o_rdidx_dut ^ rf_wbck_o_rdidx_ref)) begin
			if (stats1.errors_rf_wbck_o_rdidx == 0) stats1.errortime_rf_wbck_o_rdidx = $time;
			stats1.errors_rf_wbck_o_rdidx++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
