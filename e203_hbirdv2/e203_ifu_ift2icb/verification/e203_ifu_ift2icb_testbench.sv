`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_ifu_req_ready;
		int errortime_ifu_req_ready;
		int errors_ifu_rsp_valid;
		int errortime_ifu_rsp_valid;
		int errors_ifu_rsp_err;
		int errortime_ifu_rsp_err;
		int errors_ifu_rsp_instr;
		int errortime_ifu_rsp_instr;
		int errors_ifu2itcm_icb_cmd_valid;
		int errortime_ifu2itcm_icb_cmd_valid;
		int errors_ifu2itcm_icb_cmd_addr;
		int errortime_ifu2itcm_icb_cmd_addr;
		int errors_ifu2itcm_icb_rsp_ready;
		int errortime_ifu2itcm_icb_rsp_ready;
		int errors_ifu2biu_icb_cmd_valid;
		int errortime_ifu2biu_icb_cmd_valid;
		int errors_ifu2biu_icb_cmd_addr;
		int errortime_ifu2biu_icb_cmd_addr;
		int errors_ifu2biu_icb_rsp_ready;
		int errortime_ifu2biu_icb_rsp_ready;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic itcm_nohold;
	logic ifu_req_valid;
	logic ifu_req_ready_ref;
	logic ifu_req_ready_dut;
	logic [32-1:0] ifu_req_pc;
	logic ifu_req_seq;
	logic ifu_req_seq_rv32;
	logic [32-1:0] ifu_req_last_pc;
	logic ifu_rsp_valid_ref;
	logic ifu_rsp_valid_dut;
	logic ifu_rsp_ready;
	logic ifu_rsp_err_ref;
	logic ifu_rsp_err_dut;
	logic [32-1:0] ifu_rsp_instr_ref;
	logic [32-1:0] ifu_rsp_instr_dut;
	logic [32-1:0] itcm_region_indic;
	logic ifu2itcm_icb_cmd_valid_ref;
	logic ifu2itcm_icb_cmd_valid_dut;
	logic ifu2itcm_icb_cmd_ready;
	logic [16-1:0] ifu2itcm_icb_cmd_addr_ref;
	logic [16-1:0] ifu2itcm_icb_cmd_addr_dut;
	logic ifu2itcm_icb_rsp_valid;
	logic ifu2itcm_icb_rsp_ready_ref;
	logic ifu2itcm_icb_rsp_ready_dut;
	logic ifu2itcm_icb_rsp_err;
	logic [64-1:0] ifu2itcm_icb_rsp_rdata;
	logic ifu2biu_icb_cmd_valid_ref;
	logic ifu2biu_icb_cmd_valid_dut;
	logic ifu2biu_icb_cmd_ready;
	logic [32-1:0] ifu2biu_icb_cmd_addr_ref;
	logic [32-1:0] ifu2biu_icb_cmd_addr_dut;
	logic ifu2biu_icb_rsp_valid;
	logic ifu2biu_icb_rsp_ready_ref;
	logic ifu2biu_icb_rsp_ready_dut;
	logic ifu2biu_icb_rsp_err;
	logic [32-1:0] ifu2biu_icb_rsp_rdata;
	logic ifu2itcm_holdup;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.itcm_nohold(itcm_nohold),
		.ifu_req_valid(ifu_req_valid),
		.ifu_req_pc(ifu_req_pc),
		.ifu_req_seq(ifu_req_seq),
		.ifu_req_seq_rv32(ifu_req_seq_rv32),
		.ifu_req_last_pc(ifu_req_last_pc),
		.ifu_rsp_ready(ifu_rsp_ready),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_ifu_ift2icb good1 (
		.itcm_nohold(itcm_nohold),
		.ifu_req_valid(ifu_req_valid),
		.ifu_req_ready(ifu_req_ready_ref),
		.ifu_req_pc(ifu_req_pc),
		.ifu_req_seq(ifu_req_seq),
		.ifu_req_seq_rv32(ifu_req_seq_rv32),
		.ifu_req_last_pc(ifu_req_last_pc),
		.ifu_rsp_valid(ifu_rsp_valid_ref),
		.ifu_rsp_ready(ifu_rsp_ready),
		.ifu_rsp_err(ifu_rsp_err_ref),
		.ifu_rsp_instr(ifu_rsp_instr_ref),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid_ref),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr_ref),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready_ref),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid_ref),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready),
		.ifu2biu_icb_cmd_addr(ifu2biu_icb_cmd_addr_ref),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid),
		.ifu2biu_icb_rsp_ready(ifu2biu_icb_rsp_ready_ref),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_ifu_ift2icb top_module1 (
		.itcm_nohold(itcm_nohold),
		.ifu_req_valid(ifu_req_valid),
		.ifu_req_ready(ifu_req_ready_dut),
		.ifu_req_pc(ifu_req_pc),
		.ifu_req_seq(ifu_req_seq),
		.ifu_req_seq_rv32(ifu_req_seq_rv32),
		.ifu_req_last_pc(ifu_req_last_pc),
		.ifu_rsp_valid(ifu_rsp_valid_dut),
		.ifu_rsp_ready(ifu_rsp_ready),
		.ifu_rsp_err(ifu_rsp_err_dut),
		.ifu_rsp_instr(ifu_rsp_instr_dut),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid_dut),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr_dut),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready_dut),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid_dut),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready),
		.ifu2biu_icb_cmd_addr(ifu2biu_icb_cmd_addr_dut),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid),
		.ifu2biu_icb_rsp_ready(ifu2biu_icb_rsp_ready_dut),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata),
		.ifu2itcm_holdup(ifu2itcm_holdup),
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
		if (stats1.errors_ifu_req_ready)
			$display("Hint: Output 'ifu_req_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_req_ready, stats1.errortime_ifu_req_ready);
		else
			$display("Hint: Output 'ifu_req_ready' has no mismatches.");
		if (stats1.errors_ifu_rsp_valid)
			$display("Hint: Output 'ifu_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_rsp_valid, stats1.errortime_ifu_rsp_valid);
		else
			$display("Hint: Output 'ifu_rsp_valid' has no mismatches.");
		if (stats1.errors_ifu_rsp_err)
			$display("Hint: Output 'ifu_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_rsp_err, stats1.errortime_ifu_rsp_err);
		else
			$display("Hint: Output 'ifu_rsp_err' has no mismatches.");
		if (stats1.errors_ifu_rsp_instr)
			$display("Hint: Output 'ifu_rsp_instr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_rsp_instr, stats1.errortime_ifu_rsp_instr);
		else
			$display("Hint: Output 'ifu_rsp_instr' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_cmd_valid)
			$display("Hint: Output 'ifu2itcm_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_cmd_valid, stats1.errortime_ifu2itcm_icb_cmd_valid);
		else
			$display("Hint: Output 'ifu2itcm_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_cmd_addr)
			$display("Hint: Output 'ifu2itcm_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_cmd_addr, stats1.errortime_ifu2itcm_icb_cmd_addr);
		else
			$display("Hint: Output 'ifu2itcm_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_rsp_ready)
			$display("Hint: Output 'ifu2itcm_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_rsp_ready, stats1.errortime_ifu2itcm_icb_rsp_ready);
		else
			$display("Hint: Output 'ifu2itcm_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_cmd_valid)
			$display("Hint: Output 'ifu2biu_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_cmd_valid, stats1.errortime_ifu2biu_icb_cmd_valid);
		else
			$display("Hint: Output 'ifu2biu_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_cmd_addr)
			$display("Hint: Output 'ifu2biu_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_cmd_addr, stats1.errortime_ifu2biu_icb_cmd_addr);
		else
			$display("Hint: Output 'ifu2biu_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_rsp_ready)
			$display("Hint: Output 'ifu2biu_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_rsp_ready, stats1.errortime_ifu2biu_icb_rsp_ready);
		else
			$display("Hint: Output 'ifu2biu_icb_rsp_ready' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ ifu_req_ready_ref,ifu_rsp_valid_ref,ifu_rsp_err_ref,ifu_rsp_instr_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref} ===
			( { ifu_req_ready_ref,ifu_rsp_valid_ref,ifu_rsp_err_ref,ifu_rsp_instr_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref} ^
			  { ifu_req_ready_dut,ifu_rsp_valid_dut,ifu_rsp_err_dut,ifu_rsp_instr_dut,ifu2itcm_icb_cmd_valid_dut,ifu2itcm_icb_cmd_addr_dut,ifu2itcm_icb_rsp_ready_dut,ifu2biu_icb_cmd_valid_dut,ifu2biu_icb_cmd_addr_dut,ifu2biu_icb_rsp_ready_dut} ^
			  { ifu_req_ready_ref,ifu_rsp_valid_ref,ifu_rsp_err_ref,ifu_rsp_instr_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (ifu_req_ready_ref !== (ifu_req_ready_ref ^ ifu_req_ready_dut ^ ifu_req_ready_ref)) begin
			if (stats1.errors_ifu_req_ready == 0) stats1.errortime_ifu_req_ready = $time;
			stats1.errors_ifu_req_ready++;
		end
		if (ifu_rsp_valid_ref !== (ifu_rsp_valid_ref ^ ifu_rsp_valid_dut ^ ifu_rsp_valid_ref)) begin
			if (stats1.errors_ifu_rsp_valid == 0) stats1.errortime_ifu_rsp_valid = $time;
			stats1.errors_ifu_rsp_valid++;
		end
		if (ifu_rsp_err_ref !== (ifu_rsp_err_ref ^ ifu_rsp_err_dut ^ ifu_rsp_err_ref)) begin
			if (stats1.errors_ifu_rsp_err == 0) stats1.errortime_ifu_rsp_err = $time;
			stats1.errors_ifu_rsp_err++;
		end
		if (ifu_rsp_instr_ref !== (ifu_rsp_instr_ref ^ ifu_rsp_instr_dut ^ ifu_rsp_instr_ref)) begin
			if (stats1.errors_ifu_rsp_instr == 0) stats1.errortime_ifu_rsp_instr = $time;
			stats1.errors_ifu_rsp_instr++;
		end
		if (ifu2itcm_icb_cmd_valid_ref !== (ifu2itcm_icb_cmd_valid_ref ^ ifu2itcm_icb_cmd_valid_dut ^ ifu2itcm_icb_cmd_valid_ref)) begin
			if (stats1.errors_ifu2itcm_icb_cmd_valid == 0) stats1.errortime_ifu2itcm_icb_cmd_valid = $time;
			stats1.errors_ifu2itcm_icb_cmd_valid++;
		end
		if (ifu2itcm_icb_cmd_addr_ref !== (ifu2itcm_icb_cmd_addr_ref ^ ifu2itcm_icb_cmd_addr_dut ^ ifu2itcm_icb_cmd_addr_ref)) begin
			if (stats1.errors_ifu2itcm_icb_cmd_addr == 0) stats1.errortime_ifu2itcm_icb_cmd_addr = $time;
			stats1.errors_ifu2itcm_icb_cmd_addr++;
		end
		if (ifu2itcm_icb_rsp_ready_ref !== (ifu2itcm_icb_rsp_ready_ref ^ ifu2itcm_icb_rsp_ready_dut ^ ifu2itcm_icb_rsp_ready_ref)) begin
			if (stats1.errors_ifu2itcm_icb_rsp_ready == 0) stats1.errortime_ifu2itcm_icb_rsp_ready = $time;
			stats1.errors_ifu2itcm_icb_rsp_ready++;
		end
		if (ifu2biu_icb_cmd_valid_ref !== (ifu2biu_icb_cmd_valid_ref ^ ifu2biu_icb_cmd_valid_dut ^ ifu2biu_icb_cmd_valid_ref)) begin
			if (stats1.errors_ifu2biu_icb_cmd_valid == 0) stats1.errortime_ifu2biu_icb_cmd_valid = $time;
			stats1.errors_ifu2biu_icb_cmd_valid++;
		end
		if (ifu2biu_icb_cmd_addr_ref !== (ifu2biu_icb_cmd_addr_ref ^ ifu2biu_icb_cmd_addr_dut ^ ifu2biu_icb_cmd_addr_ref)) begin
			if (stats1.errors_ifu2biu_icb_cmd_addr == 0) stats1.errortime_ifu2biu_icb_cmd_addr = $time;
			stats1.errors_ifu2biu_icb_cmd_addr++;
		end
		if (ifu2biu_icb_rsp_ready_ref !== (ifu2biu_icb_rsp_ready_ref ^ ifu2biu_icb_rsp_ready_dut ^ ifu2biu_icb_rsp_ready_ref)) begin
			if (stats1.errors_ifu2biu_icb_rsp_ready == 0) stats1.errortime_ifu2biu_icb_rsp_ready = $time;
			stats1.errors_ifu2biu_icb_rsp_ready++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
