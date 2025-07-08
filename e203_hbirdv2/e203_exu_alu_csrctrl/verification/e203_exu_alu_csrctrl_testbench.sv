`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_csr_i_ready;
		int errortime_csr_i_ready;
		int errors_csr_ena;
		int errortime_csr_ena;
		int errors_csr_wr_en;
		int errortime_csr_wr_en;
		int errors_csr_rd_en;
		int errortime_csr_rd_en;
		int errors_csr_idx;
		int errortime_csr_idx;
		int errors_wbck_csr_dat;
		int errortime_wbck_csr_dat;
		int errors_csr_o_valid;
		int errortime_csr_o_valid;
		int errors_csr_o_wbck_wdat;
		int errortime_csr_o_wbck_wdat;
		int errors_csr_o_wbck_err;
		int errortime_csr_o_wbck_err;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic csr_i_valid;
	logic csr_i_ready_ref;
	logic csr_i_ready_dut;
	logic [32-1:0] csr_i_rs1;
	logic [26-1:0] csr_i_info;
	logic csr_i_rdwen;
	logic csr_ena_ref;
	logic csr_ena_dut;
	logic csr_wr_en_ref;
	logic csr_wr_en_dut;
	logic csr_rd_en_ref;
	logic csr_rd_en_dut;
	logic [12-1:0] csr_idx_ref;
	logic [12-1:0] csr_idx_dut;
	logic csr_access_ilgl;
	logic [32-1:0] read_csr_dat;
	logic [32-1:0] wbck_csr_dat_ref;
	logic [32-1:0] wbck_csr_dat_dut;
	logic csr_o_valid_ref;
	logic csr_o_valid_dut;
	logic csr_o_ready;
	logic [32-1:0] csr_o_wbck_wdat_ref;
	logic [32-1:0] csr_o_wbck_wdat_dut;
	logic csr_o_wbck_err_ref;
	logic csr_o_wbck_err_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.csr_i_valid(csr_i_valid),
		.csr_i_rs1(csr_i_rs1),
		.csr_i_info(csr_i_info),
		.csr_i_rdwen(csr_i_rdwen),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.csr_o_ready(csr_o_ready),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_csrctrl good1 (
		.csr_i_valid(csr_i_valid),
		.csr_i_ready(csr_i_ready_ref),
		.csr_i_rs1(csr_i_rs1),
		.csr_i_info(csr_i_info),
		.csr_i_rdwen(csr_i_rdwen),
		.csr_ena(csr_ena_ref),
		.csr_wr_en(csr_wr_en_ref),
		.csr_rd_en(csr_rd_en_ref),
		.csr_idx(csr_idx_ref),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.wbck_csr_dat(wbck_csr_dat_ref),
		.csr_o_valid(csr_o_valid_ref),
		.csr_o_ready(csr_o_ready),
		.csr_o_wbck_wdat(csr_o_wbck_wdat_ref),
		.csr_o_wbck_err(csr_o_wbck_err_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_csrctrl top_module1 (
		.csr_i_valid(csr_i_valid),
		.csr_i_ready(csr_i_ready_dut),
		.csr_i_rs1(csr_i_rs1),
		.csr_i_info(csr_i_info),
		.csr_i_rdwen(csr_i_rdwen),
		.csr_ena(csr_ena_dut),
		.csr_wr_en(csr_wr_en_dut),
		.csr_rd_en(csr_rd_en_dut),
		.csr_idx(csr_idx_dut),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.wbck_csr_dat(wbck_csr_dat_dut),
		.csr_o_valid(csr_o_valid_dut),
		.csr_o_ready(csr_o_ready),
		.csr_o_wbck_wdat(csr_o_wbck_wdat_dut),
		.csr_o_wbck_err(csr_o_wbck_err_dut),
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
		if (stats1.errors_csr_i_ready)
			$display("Hint: Output 'csr_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_i_ready, stats1.errortime_csr_i_ready);
		else
			$display("Hint: Output 'csr_i_ready' has no mismatches.");
		if (stats1.errors_csr_ena)
			$display("Hint: Output 'csr_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_ena, stats1.errortime_csr_ena);
		else
			$display("Hint: Output 'csr_ena' has no mismatches.");
		if (stats1.errors_csr_wr_en)
			$display("Hint: Output 'csr_wr_en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_wr_en, stats1.errortime_csr_wr_en);
		else
			$display("Hint: Output 'csr_wr_en' has no mismatches.");
		if (stats1.errors_csr_rd_en)
			$display("Hint: Output 'csr_rd_en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_rd_en, stats1.errortime_csr_rd_en);
		else
			$display("Hint: Output 'csr_rd_en' has no mismatches.");
		if (stats1.errors_csr_idx)
			$display("Hint: Output 'csr_idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_idx, stats1.errortime_csr_idx);
		else
			$display("Hint: Output 'csr_idx' has no mismatches.");
		if (stats1.errors_wbck_csr_dat)
			$display("Hint: Output 'wbck_csr_dat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wbck_csr_dat, stats1.errortime_wbck_csr_dat);
		else
			$display("Hint: Output 'wbck_csr_dat' has no mismatches.");
		if (stats1.errors_csr_o_valid)
			$display("Hint: Output 'csr_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_o_valid, stats1.errortime_csr_o_valid);
		else
			$display("Hint: Output 'csr_o_valid' has no mismatches.");
		if (stats1.errors_csr_o_wbck_wdat)
			$display("Hint: Output 'csr_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_o_wbck_wdat, stats1.errortime_csr_o_wbck_wdat);
		else
			$display("Hint: Output 'csr_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_csr_o_wbck_err)
			$display("Hint: Output 'csr_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_o_wbck_err, stats1.errortime_csr_o_wbck_err);
		else
			$display("Hint: Output 'csr_o_wbck_err' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ csr_i_ready_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,csr_o_valid_ref,csr_o_wbck_wdat_ref,csr_o_wbck_err_ref} ===
			( { csr_i_ready_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,csr_o_valid_ref,csr_o_wbck_wdat_ref,csr_o_wbck_err_ref} ^
			  { csr_i_ready_dut,csr_ena_dut,csr_wr_en_dut,csr_rd_en_dut,csr_idx_dut,wbck_csr_dat_dut,csr_o_valid_dut,csr_o_wbck_wdat_dut,csr_o_wbck_err_dut} ^
			  { csr_i_ready_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,csr_o_valid_ref,csr_o_wbck_wdat_ref,csr_o_wbck_err_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (csr_i_ready_ref !== (csr_i_ready_ref ^ csr_i_ready_dut ^ csr_i_ready_ref)) begin
			if (stats1.errors_csr_i_ready == 0) stats1.errortime_csr_i_ready = $time;
			stats1.errors_csr_i_ready++;
		end
		if (csr_ena_ref !== (csr_ena_ref ^ csr_ena_dut ^ csr_ena_ref)) begin
			if (stats1.errors_csr_ena == 0) stats1.errortime_csr_ena = $time;
			stats1.errors_csr_ena++;
		end
		if (csr_wr_en_ref !== (csr_wr_en_ref ^ csr_wr_en_dut ^ csr_wr_en_ref)) begin
			if (stats1.errors_csr_wr_en == 0) stats1.errortime_csr_wr_en = $time;
			stats1.errors_csr_wr_en++;
		end
		if (csr_rd_en_ref !== (csr_rd_en_ref ^ csr_rd_en_dut ^ csr_rd_en_ref)) begin
			if (stats1.errors_csr_rd_en == 0) stats1.errortime_csr_rd_en = $time;
			stats1.errors_csr_rd_en++;
		end
		if (csr_idx_ref !== (csr_idx_ref ^ csr_idx_dut ^ csr_idx_ref)) begin
			if (stats1.errors_csr_idx == 0) stats1.errortime_csr_idx = $time;
			stats1.errors_csr_idx++;
		end
		if (wbck_csr_dat_ref !== (wbck_csr_dat_ref ^ wbck_csr_dat_dut ^ wbck_csr_dat_ref)) begin
			if (stats1.errors_wbck_csr_dat == 0) stats1.errortime_wbck_csr_dat = $time;
			stats1.errors_wbck_csr_dat++;
		end
		if (csr_o_valid_ref !== (csr_o_valid_ref ^ csr_o_valid_dut ^ csr_o_valid_ref)) begin
			if (stats1.errors_csr_o_valid == 0) stats1.errortime_csr_o_valid = $time;
			stats1.errors_csr_o_valid++;
		end
		if (csr_o_wbck_wdat_ref !== (csr_o_wbck_wdat_ref ^ csr_o_wbck_wdat_dut ^ csr_o_wbck_wdat_ref)) begin
			if (stats1.errors_csr_o_wbck_wdat == 0) stats1.errortime_csr_o_wbck_wdat = $time;
			stats1.errors_csr_o_wbck_wdat++;
		end
		if (csr_o_wbck_err_ref !== (csr_o_wbck_err_ref ^ csr_o_wbck_err_dut ^ csr_o_wbck_err_ref)) begin
			if (stats1.errors_csr_o_wbck_err == 0) stats1.errortime_csr_o_wbck_err = $time;
			stats1.errors_csr_o_wbck_err++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
