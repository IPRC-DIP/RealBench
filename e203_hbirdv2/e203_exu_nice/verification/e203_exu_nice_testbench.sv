`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_nice_i_ready;
		int errortime_nice_i_ready;
		int errors_nice_o_longpipe;
		int errortime_nice_o_longpipe;
		int errors_nice_o_valid;
		int errortime_nice_o_valid;
		int errors_nice_o_itag_valid;
		int errortime_nice_o_itag_valid;
		int errors_nice_o_itag;
		int errortime_nice_o_itag;
		int errors_nice_rsp_multicyc_ready;
		int errortime_nice_rsp_multicyc_ready;
		int errors_nice_req_valid;
		int errortime_nice_req_valid;
		int errors_nice_req_instr;
		int errortime_nice_req_instr;
		int errors_nice_req_rs1;
		int errortime_nice_req_rs1;
		int errors_nice_req_rs2;
		int errortime_nice_req_rs2;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic nice_i_xs_off;
	logic nice_i_valid;
	logic nice_i_ready_ref;
	logic nice_i_ready_dut;
	logic [32-1:0] nice_i_instr;
	logic [32-1:0] nice_i_rs1;
	logic [32-1:0] nice_i_rs2;
	logic nice_i_itag;
	logic nice_o_longpipe_ref;
	logic nice_o_longpipe_dut;
	logic nice_o_valid_ref;
	logic nice_o_valid_dut;
	logic nice_o_ready;
	logic nice_o_itag_valid_ref;
	logic nice_o_itag_valid_dut;
	logic nice_o_itag_ready;
	logic nice_o_itag_ref;
	logic nice_o_itag_dut;
	logic nice_rsp_multicyc_valid;
	logic nice_rsp_multicyc_ready_ref;
	logic nice_rsp_multicyc_ready_dut;
	logic nice_req_valid_ref;
	logic nice_req_valid_dut;
	logic nice_req_ready;
	logic [32-1:0] nice_req_instr_ref;
	logic [32-1:0] nice_req_instr_dut;
	logic [32-1:0] nice_req_rs1_ref;
	logic [32-1:0] nice_req_rs1_dut;
	logic [32-1:0] nice_req_rs2_ref;
	logic [32-1:0] nice_req_rs2_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.nice_i_xs_off(nice_i_xs_off),
		.nice_i_valid(nice_i_valid),
		.nice_i_instr(nice_i_instr),
		.nice_i_rs1(nice_i_rs1),
		.nice_i_rs2(nice_i_rs2),
		.nice_i_itag(nice_i_itag),
		.nice_o_ready(nice_o_ready),
		.nice_o_itag_ready(nice_o_itag_ready),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_req_ready(nice_req_ready),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_nice good1 (
		.nice_i_xs_off(nice_i_xs_off),
		.nice_i_valid(nice_i_valid),
		.nice_i_ready(nice_i_ready_ref),
		.nice_i_instr(nice_i_instr),
		.nice_i_rs1(nice_i_rs1),
		.nice_i_rs2(nice_i_rs2),
		.nice_i_itag(nice_i_itag),
		.nice_o_longpipe(nice_o_longpipe_ref),
		.nice_o_valid(nice_o_valid_ref),
		.nice_o_ready(nice_o_ready),
		.nice_o_itag_valid(nice_o_itag_valid_ref),
		.nice_o_itag_ready(nice_o_itag_ready),
		.nice_o_itag(nice_o_itag_ref),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_ref),
		.nice_req_valid(nice_req_valid_ref),
		.nice_req_ready(nice_req_ready),
		.nice_req_instr(nice_req_instr_ref),
		.nice_req_rs1(nice_req_rs1_ref),
		.nice_req_rs2(nice_req_rs2_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_nice top_module1 (
		.nice_i_xs_off(nice_i_xs_off),
		.nice_i_valid(nice_i_valid),
		.nice_i_ready(nice_i_ready_dut),
		.nice_i_instr(nice_i_instr),
		.nice_i_rs1(nice_i_rs1),
		.nice_i_rs2(nice_i_rs2),
		.nice_i_itag(nice_i_itag),
		.nice_o_longpipe(nice_o_longpipe_dut),
		.nice_o_valid(nice_o_valid_dut),
		.nice_o_ready(nice_o_ready),
		.nice_o_itag_valid(nice_o_itag_valid_dut),
		.nice_o_itag_ready(nice_o_itag_ready),
		.nice_o_itag(nice_o_itag_dut),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_dut),
		.nice_req_valid(nice_req_valid_dut),
		.nice_req_ready(nice_req_ready),
		.nice_req_instr(nice_req_instr_dut),
		.nice_req_rs1(nice_req_rs1_dut),
		.nice_req_rs2(nice_req_rs2_dut),
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
		if (stats1.errors_nice_i_ready)
			$display("Hint: Output 'nice_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_i_ready, stats1.errortime_nice_i_ready);
		else
			$display("Hint: Output 'nice_i_ready' has no mismatches.");
		if (stats1.errors_nice_o_longpipe)
			$display("Hint: Output 'nice_o_longpipe' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_o_longpipe, stats1.errortime_nice_o_longpipe);
		else
			$display("Hint: Output 'nice_o_longpipe' has no mismatches.");
		if (stats1.errors_nice_o_valid)
			$display("Hint: Output 'nice_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_o_valid, stats1.errortime_nice_o_valid);
		else
			$display("Hint: Output 'nice_o_valid' has no mismatches.");
		if (stats1.errors_nice_o_itag_valid)
			$display("Hint: Output 'nice_o_itag_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_o_itag_valid, stats1.errortime_nice_o_itag_valid);
		else
			$display("Hint: Output 'nice_o_itag_valid' has no mismatches.");
		if (stats1.errors_nice_o_itag)
			$display("Hint: Output 'nice_o_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_o_itag, stats1.errortime_nice_o_itag);
		else
			$display("Hint: Output 'nice_o_itag' has no mismatches.");
		if (stats1.errors_nice_rsp_multicyc_ready)
			$display("Hint: Output 'nice_rsp_multicyc_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_rsp_multicyc_ready, stats1.errortime_nice_rsp_multicyc_ready);
		else
			$display("Hint: Output 'nice_rsp_multicyc_ready' has no mismatches.");
		if (stats1.errors_nice_req_valid)
			$display("Hint: Output 'nice_req_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_valid, stats1.errortime_nice_req_valid);
		else
			$display("Hint: Output 'nice_req_valid' has no mismatches.");
		if (stats1.errors_nice_req_instr)
			$display("Hint: Output 'nice_req_instr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_instr, stats1.errortime_nice_req_instr);
		else
			$display("Hint: Output 'nice_req_instr' has no mismatches.");
		if (stats1.errors_nice_req_rs1)
			$display("Hint: Output 'nice_req_rs1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_rs1, stats1.errortime_nice_req_rs1);
		else
			$display("Hint: Output 'nice_req_rs1' has no mismatches.");
		if (stats1.errors_nice_req_rs2)
			$display("Hint: Output 'nice_req_rs2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_rs2, stats1.errortime_nice_req_rs2);
		else
			$display("Hint: Output 'nice_req_rs2' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ nice_i_ready_ref,nice_o_longpipe_ref,nice_o_valid_ref,nice_o_itag_valid_ref,nice_o_itag_ref,nice_rsp_multicyc_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref} ===
			( { nice_i_ready_ref,nice_o_longpipe_ref,nice_o_valid_ref,nice_o_itag_valid_ref,nice_o_itag_ref,nice_rsp_multicyc_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref} ^
			  { nice_i_ready_dut,nice_o_longpipe_dut,nice_o_valid_dut,nice_o_itag_valid_dut,nice_o_itag_dut,nice_rsp_multicyc_ready_dut,nice_req_valid_dut,nice_req_instr_dut,nice_req_rs1_dut,nice_req_rs2_dut} ^
			  { nice_i_ready_ref,nice_o_longpipe_ref,nice_o_valid_ref,nice_o_itag_valid_ref,nice_o_itag_ref,nice_rsp_multicyc_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (nice_i_ready_ref !== (nice_i_ready_ref ^ nice_i_ready_dut ^ nice_i_ready_ref)) begin
			if (stats1.errors_nice_i_ready == 0) stats1.errortime_nice_i_ready = $time;
			stats1.errors_nice_i_ready++;
		end
		if (nice_o_longpipe_ref !== (nice_o_longpipe_ref ^ nice_o_longpipe_dut ^ nice_o_longpipe_ref)) begin
			if (stats1.errors_nice_o_longpipe == 0) stats1.errortime_nice_o_longpipe = $time;
			stats1.errors_nice_o_longpipe++;
		end
		if (nice_o_valid_ref !== (nice_o_valid_ref ^ nice_o_valid_dut ^ nice_o_valid_ref)) begin
			if (stats1.errors_nice_o_valid == 0) stats1.errortime_nice_o_valid = $time;
			stats1.errors_nice_o_valid++;
		end
		if (nice_o_itag_valid_ref !== (nice_o_itag_valid_ref ^ nice_o_itag_valid_dut ^ nice_o_itag_valid_ref)) begin
			if (stats1.errors_nice_o_itag_valid == 0) stats1.errortime_nice_o_itag_valid = $time;
			stats1.errors_nice_o_itag_valid++;
		end
		if (nice_o_itag_ref !== (nice_o_itag_ref ^ nice_o_itag_dut ^ nice_o_itag_ref)) begin
			if (stats1.errors_nice_o_itag == 0) stats1.errortime_nice_o_itag = $time;
			stats1.errors_nice_o_itag++;
		end
		if (nice_rsp_multicyc_ready_ref !== (nice_rsp_multicyc_ready_ref ^ nice_rsp_multicyc_ready_dut ^ nice_rsp_multicyc_ready_ref)) begin
			if (stats1.errors_nice_rsp_multicyc_ready == 0) stats1.errortime_nice_rsp_multicyc_ready = $time;
			stats1.errors_nice_rsp_multicyc_ready++;
		end
		if (nice_req_valid_ref !== (nice_req_valid_ref ^ nice_req_valid_dut ^ nice_req_valid_ref)) begin
			if (stats1.errors_nice_req_valid == 0) stats1.errortime_nice_req_valid = $time;
			stats1.errors_nice_req_valid++;
		end
		if (nice_req_instr_ref !== (nice_req_instr_ref ^ nice_req_instr_dut ^ nice_req_instr_ref)) begin
			if (stats1.errors_nice_req_instr == 0) stats1.errortime_nice_req_instr = $time;
			stats1.errors_nice_req_instr++;
		end
		if (nice_req_rs1_ref !== (nice_req_rs1_ref ^ nice_req_rs1_dut ^ nice_req_rs1_ref)) begin
			if (stats1.errors_nice_req_rs1 == 0) stats1.errortime_nice_req_rs1 = $time;
			stats1.errors_nice_req_rs1++;
		end
		if (nice_req_rs2_ref !== (nice_req_rs2_ref ^ nice_req_rs2_dut ^ nice_req_rs2_ref)) begin
			if (stats1.errors_nice_req_rs2 == 0) stats1.errortime_nice_req_rs2 = $time;
			stats1.errors_nice_req_rs2++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
