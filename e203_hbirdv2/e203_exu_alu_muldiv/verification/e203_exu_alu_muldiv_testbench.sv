`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_muldiv_i_ready;
		int errortime_muldiv_i_ready;
		int errors_muldiv_i_longpipe;
		int errortime_muldiv_i_longpipe;
		int errors_muldiv_o_valid;
		int errortime_muldiv_o_valid;
		int errors_muldiv_o_wbck_wdat;
		int errortime_muldiv_o_wbck_wdat;
		int errors_muldiv_o_wbck_err;
		int errortime_muldiv_o_wbck_err;
		int errors_muldiv_req_alu_op1;
		int errortime_muldiv_req_alu_op1;
		int errors_muldiv_req_alu_op2;
		int errortime_muldiv_req_alu_op2;
		int errors_muldiv_req_alu_add;
		int errortime_muldiv_req_alu_add;
		int errors_muldiv_req_alu_sub;
		int errortime_muldiv_req_alu_sub;
		int errors_muldiv_sbf_0_ena;
		int errortime_muldiv_sbf_0_ena;
		int errors_muldiv_sbf_0_nxt;
		int errortime_muldiv_sbf_0_nxt;
		int errors_muldiv_sbf_1_ena;
		int errortime_muldiv_sbf_1_ena;
		int errors_muldiv_sbf_1_nxt;
		int errortime_muldiv_sbf_1_nxt;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic mdv_nob2b;
	logic muldiv_i_valid;
	logic muldiv_i_ready_ref;
	logic muldiv_i_ready_dut;
	logic [32-1:0] muldiv_i_rs1;
	logic [32-1:0] muldiv_i_rs2;
	logic [32-1:0] muldiv_i_imm;
	logic [13-1:0] muldiv_i_info;
	logic muldiv_i_itag;
	logic muldiv_i_longpipe_ref;
	logic muldiv_i_longpipe_dut;
	logic flush_pulse;
	logic muldiv_o_valid_ref;
	logic muldiv_o_valid_dut;
	logic muldiv_o_ready;
	logic [32-1:0] muldiv_o_wbck_wdat_ref;
	logic [32-1:0] muldiv_o_wbck_wdat_dut;
	logic muldiv_o_wbck_err_ref;
	logic muldiv_o_wbck_err_dut;
	logic [35-1:0] muldiv_req_alu_op1_ref;
	logic [35-1:0] muldiv_req_alu_op1_dut;
	logic [35-1:0] muldiv_req_alu_op2_ref;
	logic [35-1:0] muldiv_req_alu_op2_dut;
	logic muldiv_req_alu_add_ref;
	logic muldiv_req_alu_add_dut;
	logic muldiv_req_alu_sub_ref;
	logic muldiv_req_alu_sub_dut;
	logic [35-1:0] muldiv_req_alu_res;
	logic muldiv_sbf_0_ena_ref;
	logic muldiv_sbf_0_ena_dut;
	logic [33-1:0] muldiv_sbf_0_nxt_ref;
	logic [33-1:0] muldiv_sbf_0_nxt_dut;
	logic [33-1:0] muldiv_sbf_0_r;
	logic muldiv_sbf_1_ena_ref;
	logic muldiv_sbf_1_ena_dut;
	logic [33-1:0] muldiv_sbf_1_nxt_ref;
	logic [33-1:0] muldiv_sbf_1_nxt_dut;
	logic [33-1:0] muldiv_sbf_1_r;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.mdv_nob2b(mdv_nob2b),
		.muldiv_i_valid(muldiv_i_valid),
		.muldiv_i_rs1(muldiv_i_rs1),
		.muldiv_i_rs2(muldiv_i_rs2),
		.muldiv_i_imm(muldiv_i_imm),
		.muldiv_i_info(muldiv_i_info),
		.muldiv_i_itag(muldiv_i_itag),
		.flush_pulse(flush_pulse),
		.muldiv_o_ready(muldiv_o_ready),
		.muldiv_req_alu_res(muldiv_req_alu_res),
		.muldiv_sbf_0_r(muldiv_sbf_0_r),
		.muldiv_sbf_1_r(muldiv_sbf_1_r),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_muldiv good1 (
		.mdv_nob2b(mdv_nob2b),
		.muldiv_i_valid(muldiv_i_valid),
		.muldiv_i_ready(muldiv_i_ready_ref),
		.muldiv_i_rs1(muldiv_i_rs1),
		.muldiv_i_rs2(muldiv_i_rs2),
		.muldiv_i_imm(muldiv_i_imm),
		.muldiv_i_info(muldiv_i_info),
		.muldiv_i_itag(muldiv_i_itag),
		.muldiv_i_longpipe(muldiv_i_longpipe_ref),
		.flush_pulse(flush_pulse),
		.muldiv_o_valid(muldiv_o_valid_ref),
		.muldiv_o_ready(muldiv_o_ready),
		.muldiv_o_wbck_wdat(muldiv_o_wbck_wdat_ref),
		.muldiv_o_wbck_err(muldiv_o_wbck_err_ref),
		.muldiv_req_alu_op1(muldiv_req_alu_op1_ref),
		.muldiv_req_alu_op2(muldiv_req_alu_op2_ref),
		.muldiv_req_alu_add(muldiv_req_alu_add_ref),
		.muldiv_req_alu_sub(muldiv_req_alu_sub_ref),
		.muldiv_req_alu_res(muldiv_req_alu_res),
		.muldiv_sbf_0_ena(muldiv_sbf_0_ena_ref),
		.muldiv_sbf_0_nxt(muldiv_sbf_0_nxt_ref),
		.muldiv_sbf_0_r(muldiv_sbf_0_r),
		.muldiv_sbf_1_ena(muldiv_sbf_1_ena_ref),
		.muldiv_sbf_1_nxt(muldiv_sbf_1_nxt_ref),
		.muldiv_sbf_1_r(muldiv_sbf_1_r),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_muldiv top_module1 (
		.mdv_nob2b(mdv_nob2b),
		.muldiv_i_valid(muldiv_i_valid),
		.muldiv_i_ready(muldiv_i_ready_dut),
		.muldiv_i_rs1(muldiv_i_rs1),
		.muldiv_i_rs2(muldiv_i_rs2),
		.muldiv_i_imm(muldiv_i_imm),
		.muldiv_i_info(muldiv_i_info),
		.muldiv_i_itag(muldiv_i_itag),
		.muldiv_i_longpipe(muldiv_i_longpipe_dut),
		.flush_pulse(flush_pulse),
		.muldiv_o_valid(muldiv_o_valid_dut),
		.muldiv_o_ready(muldiv_o_ready),
		.muldiv_o_wbck_wdat(muldiv_o_wbck_wdat_dut),
		.muldiv_o_wbck_err(muldiv_o_wbck_err_dut),
		.muldiv_req_alu_op1(muldiv_req_alu_op1_dut),
		.muldiv_req_alu_op2(muldiv_req_alu_op2_dut),
		.muldiv_req_alu_add(muldiv_req_alu_add_dut),
		.muldiv_req_alu_sub(muldiv_req_alu_sub_dut),
		.muldiv_req_alu_res(muldiv_req_alu_res),
		.muldiv_sbf_0_ena(muldiv_sbf_0_ena_dut),
		.muldiv_sbf_0_nxt(muldiv_sbf_0_nxt_dut),
		.muldiv_sbf_0_r(muldiv_sbf_0_r),
		.muldiv_sbf_1_ena(muldiv_sbf_1_ena_dut),
		.muldiv_sbf_1_nxt(muldiv_sbf_1_nxt_dut),
		.muldiv_sbf_1_r(muldiv_sbf_1_r),
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
		if (stats1.errors_muldiv_i_ready)
			$display("Hint: Output 'muldiv_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_i_ready, stats1.errortime_muldiv_i_ready);
		else
			$display("Hint: Output 'muldiv_i_ready' has no mismatches.");
		if (stats1.errors_muldiv_i_longpipe)
			$display("Hint: Output 'muldiv_i_longpipe' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_i_longpipe, stats1.errortime_muldiv_i_longpipe);
		else
			$display("Hint: Output 'muldiv_i_longpipe' has no mismatches.");
		if (stats1.errors_muldiv_o_valid)
			$display("Hint: Output 'muldiv_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_o_valid, stats1.errortime_muldiv_o_valid);
		else
			$display("Hint: Output 'muldiv_o_valid' has no mismatches.");
		if (stats1.errors_muldiv_o_wbck_wdat)
			$display("Hint: Output 'muldiv_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_o_wbck_wdat, stats1.errortime_muldiv_o_wbck_wdat);
		else
			$display("Hint: Output 'muldiv_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_muldiv_o_wbck_err)
			$display("Hint: Output 'muldiv_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_o_wbck_err, stats1.errortime_muldiv_o_wbck_err);
		else
			$display("Hint: Output 'muldiv_o_wbck_err' has no mismatches.");
		if (stats1.errors_muldiv_req_alu_op1)
			$display("Hint: Output 'muldiv_req_alu_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_req_alu_op1, stats1.errortime_muldiv_req_alu_op1);
		else
			$display("Hint: Output 'muldiv_req_alu_op1' has no mismatches.");
		if (stats1.errors_muldiv_req_alu_op2)
			$display("Hint: Output 'muldiv_req_alu_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_req_alu_op2, stats1.errortime_muldiv_req_alu_op2);
		else
			$display("Hint: Output 'muldiv_req_alu_op2' has no mismatches.");
		if (stats1.errors_muldiv_req_alu_add)
			$display("Hint: Output 'muldiv_req_alu_add' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_req_alu_add, stats1.errortime_muldiv_req_alu_add);
		else
			$display("Hint: Output 'muldiv_req_alu_add' has no mismatches.");
		if (stats1.errors_muldiv_req_alu_sub)
			$display("Hint: Output 'muldiv_req_alu_sub' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_req_alu_sub, stats1.errortime_muldiv_req_alu_sub);
		else
			$display("Hint: Output 'muldiv_req_alu_sub' has no mismatches.");
		if (stats1.errors_muldiv_sbf_0_ena)
			$display("Hint: Output 'muldiv_sbf_0_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_0_ena, stats1.errortime_muldiv_sbf_0_ena);
		else
			$display("Hint: Output 'muldiv_sbf_0_ena' has no mismatches.");
		if (stats1.errors_muldiv_sbf_0_nxt)
			$display("Hint: Output 'muldiv_sbf_0_nxt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_0_nxt, stats1.errortime_muldiv_sbf_0_nxt);
		else
			$display("Hint: Output 'muldiv_sbf_0_nxt' has no mismatches.");
		if (stats1.errors_muldiv_sbf_1_ena)
			$display("Hint: Output 'muldiv_sbf_1_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_1_ena, stats1.errortime_muldiv_sbf_1_ena);
		else
			$display("Hint: Output 'muldiv_sbf_1_ena' has no mismatches.");
		if (stats1.errors_muldiv_sbf_1_nxt)
			$display("Hint: Output 'muldiv_sbf_1_nxt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_1_nxt, stats1.errortime_muldiv_sbf_1_nxt);
		else
			$display("Hint: Output 'muldiv_sbf_1_nxt' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ muldiv_i_ready_ref,muldiv_i_longpipe_ref,muldiv_o_valid_ref,muldiv_o_wbck_wdat_ref,muldiv_o_wbck_err_ref,muldiv_req_alu_op1_ref,muldiv_req_alu_op2_ref,muldiv_req_alu_add_ref,muldiv_req_alu_sub_ref,muldiv_sbf_0_ena_ref,muldiv_sbf_0_nxt_ref,muldiv_sbf_1_ena_ref,muldiv_sbf_1_nxt_ref} ===
			( { muldiv_i_ready_ref,muldiv_i_longpipe_ref,muldiv_o_valid_ref,muldiv_o_wbck_wdat_ref,muldiv_o_wbck_err_ref,muldiv_req_alu_op1_ref,muldiv_req_alu_op2_ref,muldiv_req_alu_add_ref,muldiv_req_alu_sub_ref,muldiv_sbf_0_ena_ref,muldiv_sbf_0_nxt_ref,muldiv_sbf_1_ena_ref,muldiv_sbf_1_nxt_ref} ^
			  { muldiv_i_ready_dut,muldiv_i_longpipe_dut,muldiv_o_valid_dut,muldiv_o_wbck_wdat_dut,muldiv_o_wbck_err_dut,muldiv_req_alu_op1_dut,muldiv_req_alu_op2_dut,muldiv_req_alu_add_dut,muldiv_req_alu_sub_dut,muldiv_sbf_0_ena_dut,muldiv_sbf_0_nxt_dut,muldiv_sbf_1_ena_dut,muldiv_sbf_1_nxt_dut} ^
			  { muldiv_i_ready_ref,muldiv_i_longpipe_ref,muldiv_o_valid_ref,muldiv_o_wbck_wdat_ref,muldiv_o_wbck_err_ref,muldiv_req_alu_op1_ref,muldiv_req_alu_op2_ref,muldiv_req_alu_add_ref,muldiv_req_alu_sub_ref,muldiv_sbf_0_ena_ref,muldiv_sbf_0_nxt_ref,muldiv_sbf_1_ena_ref,muldiv_sbf_1_nxt_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (muldiv_i_ready_ref !== (muldiv_i_ready_ref ^ muldiv_i_ready_dut ^ muldiv_i_ready_ref)) begin
			if (stats1.errors_muldiv_i_ready == 0) stats1.errortime_muldiv_i_ready = $time;
			stats1.errors_muldiv_i_ready++;
		end
		if (muldiv_i_longpipe_ref !== (muldiv_i_longpipe_ref ^ muldiv_i_longpipe_dut ^ muldiv_i_longpipe_ref)) begin
			if (stats1.errors_muldiv_i_longpipe == 0) stats1.errortime_muldiv_i_longpipe = $time;
			stats1.errors_muldiv_i_longpipe++;
		end
		if (muldiv_o_valid_ref !== (muldiv_o_valid_ref ^ muldiv_o_valid_dut ^ muldiv_o_valid_ref)) begin
			if (stats1.errors_muldiv_o_valid == 0) stats1.errortime_muldiv_o_valid = $time;
			stats1.errors_muldiv_o_valid++;
		end
		if (muldiv_o_wbck_wdat_ref !== (muldiv_o_wbck_wdat_ref ^ muldiv_o_wbck_wdat_dut ^ muldiv_o_wbck_wdat_ref)) begin
			if (stats1.errors_muldiv_o_wbck_wdat == 0) stats1.errortime_muldiv_o_wbck_wdat = $time;
			stats1.errors_muldiv_o_wbck_wdat++;
		end
		if (muldiv_o_wbck_err_ref !== (muldiv_o_wbck_err_ref ^ muldiv_o_wbck_err_dut ^ muldiv_o_wbck_err_ref)) begin
			if (stats1.errors_muldiv_o_wbck_err == 0) stats1.errortime_muldiv_o_wbck_err = $time;
			stats1.errors_muldiv_o_wbck_err++;
		end
		if (muldiv_req_alu_op1_ref !== (muldiv_req_alu_op1_ref ^ muldiv_req_alu_op1_dut ^ muldiv_req_alu_op1_ref)) begin
			if (stats1.errors_muldiv_req_alu_op1 == 0) stats1.errortime_muldiv_req_alu_op1 = $time;
			stats1.errors_muldiv_req_alu_op1++;
		end
		if (muldiv_req_alu_op2_ref !== (muldiv_req_alu_op2_ref ^ muldiv_req_alu_op2_dut ^ muldiv_req_alu_op2_ref)) begin
			if (stats1.errors_muldiv_req_alu_op2 == 0) stats1.errortime_muldiv_req_alu_op2 = $time;
			stats1.errors_muldiv_req_alu_op2++;
		end
		if (muldiv_req_alu_add_ref !== (muldiv_req_alu_add_ref ^ muldiv_req_alu_add_dut ^ muldiv_req_alu_add_ref)) begin
			if (stats1.errors_muldiv_req_alu_add == 0) stats1.errortime_muldiv_req_alu_add = $time;
			stats1.errors_muldiv_req_alu_add++;
		end
		if (muldiv_req_alu_sub_ref !== (muldiv_req_alu_sub_ref ^ muldiv_req_alu_sub_dut ^ muldiv_req_alu_sub_ref)) begin
			if (stats1.errors_muldiv_req_alu_sub == 0) stats1.errortime_muldiv_req_alu_sub = $time;
			stats1.errors_muldiv_req_alu_sub++;
		end
		if (muldiv_sbf_0_ena_ref !== (muldiv_sbf_0_ena_ref ^ muldiv_sbf_0_ena_dut ^ muldiv_sbf_0_ena_ref)) begin
			if (stats1.errors_muldiv_sbf_0_ena == 0) stats1.errortime_muldiv_sbf_0_ena = $time;
			stats1.errors_muldiv_sbf_0_ena++;
		end
		if (muldiv_sbf_0_nxt_ref !== (muldiv_sbf_0_nxt_ref ^ muldiv_sbf_0_nxt_dut ^ muldiv_sbf_0_nxt_ref)) begin
			if (stats1.errors_muldiv_sbf_0_nxt == 0) stats1.errortime_muldiv_sbf_0_nxt = $time;
			stats1.errors_muldiv_sbf_0_nxt++;
		end
		if (muldiv_sbf_1_ena_ref !== (muldiv_sbf_1_ena_ref ^ muldiv_sbf_1_ena_dut ^ muldiv_sbf_1_ena_ref)) begin
			if (stats1.errors_muldiv_sbf_1_ena == 0) stats1.errortime_muldiv_sbf_1_ena = $time;
			stats1.errors_muldiv_sbf_1_ena++;
		end
		if (muldiv_sbf_1_nxt_ref !== (muldiv_sbf_1_nxt_ref ^ muldiv_sbf_1_nxt_dut ^ muldiv_sbf_1_nxt_ref)) begin
			if (stats1.errors_muldiv_sbf_1_nxt == 0) stats1.errortime_muldiv_sbf_1_nxt = $time;
			stats1.errors_muldiv_sbf_1_nxt++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
