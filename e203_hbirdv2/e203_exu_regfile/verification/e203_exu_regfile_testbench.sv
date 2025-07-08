`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_read_src1_dat;
		int errortime_read_src1_dat;
		int errors_read_src2_dat;
		int errortime_read_src2_dat;
		int errors_x1_r;
		int errortime_x1_r;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [5-1:0] read_src1_idx;
	logic [5-1:0] read_src2_idx;
	logic [32-1:0] read_src1_dat_ref;
	logic [32-1:0] read_src1_dat_dut;
	logic [32-1:0] read_src2_dat_ref;
	logic [32-1:0] read_src2_dat_dut;
	logic wbck_dest_wen;
	logic [5-1:0] wbck_dest_idx;
	logic [32-1:0] wbck_dest_dat;
	logic [32-1:0] x1_r_ref;
	logic [32-1:0] x1_r_dut;
	logic test_mode;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.read_src1_idx(read_src1_idx),
		.read_src2_idx(read_src2_idx),
		.wbck_dest_wen(wbck_dest_wen),
		.wbck_dest_idx(wbck_dest_idx),
		.wbck_dest_dat(wbck_dest_dat),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_regfile good1 (
		.read_src1_idx(read_src1_idx),
		.read_src2_idx(read_src2_idx),
		.read_src1_dat(read_src1_dat_ref),
		.read_src2_dat(read_src2_dat_ref),
		.wbck_dest_wen(wbck_dest_wen),
		.wbck_dest_idx(wbck_dest_idx),
		.wbck_dest_dat(wbck_dest_dat),
		.x1_r(x1_r_ref),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_regfile top_module1 (
		.read_src1_idx(read_src1_idx),
		.read_src2_idx(read_src2_idx),
		.read_src1_dat(read_src1_dat_dut),
		.read_src2_dat(read_src2_dat_dut),
		.wbck_dest_wen(wbck_dest_wen),
		.wbck_dest_idx(wbck_dest_idx),
		.wbck_dest_dat(wbck_dest_dat),
		.x1_r(x1_r_dut),
		.test_mode(test_mode),
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
		if (stats1.errors_read_src1_dat)
			$display("Hint: Output 'read_src1_dat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_read_src1_dat, stats1.errortime_read_src1_dat);
		else
			$display("Hint: Output 'read_src1_dat' has no mismatches.");
		if (stats1.errors_read_src2_dat)
			$display("Hint: Output 'read_src2_dat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_read_src2_dat, stats1.errortime_read_src2_dat);
		else
			$display("Hint: Output 'read_src2_dat' has no mismatches.");
		if (stats1.errors_x1_r)
			$display("Hint: Output 'x1_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_x1_r, stats1.errortime_x1_r);
		else
			$display("Hint: Output 'x1_r' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ read_src1_dat_ref,read_src2_dat_ref,x1_r_ref} ===
			( { read_src1_dat_ref,read_src2_dat_ref,x1_r_ref} ^
			  { read_src1_dat_dut,read_src2_dat_dut,x1_r_dut} ^
			  { read_src1_dat_ref,read_src2_dat_ref,x1_r_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (read_src1_dat_ref !== (read_src1_dat_ref ^ read_src1_dat_dut ^ read_src1_dat_ref)) begin
			if (stats1.errors_read_src1_dat == 0) stats1.errortime_read_src1_dat = $time;
			stats1.errors_read_src1_dat++;
		end
		if (read_src2_dat_ref !== (read_src2_dat_ref ^ read_src2_dat_dut ^ read_src2_dat_ref)) begin
			if (stats1.errors_read_src2_dat == 0) stats1.errortime_read_src2_dat = $time;
			stats1.errors_read_src2_dat++;
		end
		if (x1_r_ref !== (x1_r_ref ^ x1_r_dut ^ x1_r_ref)) begin
			if (stats1.errors_x1_r == 0) stats1.errortime_x1_r = $time;
			stats1.errors_x1_r++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
