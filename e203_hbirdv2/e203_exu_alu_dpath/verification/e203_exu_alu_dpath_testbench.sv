`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_alu_req_alu_res;
		int errortime_alu_req_alu_res;
		int errors_bjp_req_alu_cmp_res;
		int errortime_bjp_req_alu_cmp_res;
		int errors_bjp_req_alu_add_res;
		int errortime_bjp_req_alu_add_res;
		int errors_agu_req_alu_res;
		int errortime_agu_req_alu_res;
		int errors_agu_sbf_0_r;
		int errortime_agu_sbf_0_r;
		int errors_agu_sbf_1_r;
		int errortime_agu_sbf_1_r;
		int errors_muldiv_req_alu_res;
		int errortime_muldiv_req_alu_res;
		int errors_muldiv_sbf_0_r;
		int errortime_muldiv_sbf_0_r;
		int errors_muldiv_sbf_1_r;
		int errortime_muldiv_sbf_1_r;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic alu_req_alu;
	logic alu_req_alu_add;
	logic alu_req_alu_sub;
	logic alu_req_alu_xor;
	logic alu_req_alu_sll;
	logic alu_req_alu_srl;
	logic alu_req_alu_sra;
	logic alu_req_alu_or;
	logic alu_req_alu_and;
	logic alu_req_alu_slt;
	logic alu_req_alu_sltu;
	logic alu_req_alu_lui;
	logic [32-1:0] alu_req_alu_op1;
	logic [32-1:0] alu_req_alu_op2;
	logic [32-1:0] alu_req_alu_res_ref;
	logic [32-1:0] alu_req_alu_res_dut;
	logic bjp_req_alu;
	logic [32-1:0] bjp_req_alu_op1;
	logic [32-1:0] bjp_req_alu_op2;
	logic bjp_req_alu_cmp_eq;
	logic bjp_req_alu_cmp_ne;
	logic bjp_req_alu_cmp_lt;
	logic bjp_req_alu_cmp_gt;
	logic bjp_req_alu_cmp_ltu;
	logic bjp_req_alu_cmp_gtu;
	logic bjp_req_alu_add;
	logic bjp_req_alu_cmp_res_ref;
	logic bjp_req_alu_cmp_res_dut;
	logic [32-1:0] bjp_req_alu_add_res_ref;
	logic [32-1:0] bjp_req_alu_add_res_dut;
	logic agu_req_alu;
	logic [32-1:0] agu_req_alu_op1;
	logic [32-1:0] agu_req_alu_op2;
	logic agu_req_alu_swap;
	logic agu_req_alu_add;
	logic agu_req_alu_and;
	logic agu_req_alu_or;
	logic agu_req_alu_xor;
	logic agu_req_alu_max;
	logic agu_req_alu_min;
	logic agu_req_alu_maxu;
	logic agu_req_alu_minu;
	logic [32-1:0] agu_req_alu_res_ref;
	logic [32-1:0] agu_req_alu_res_dut;
	logic agu_sbf_0_ena;
	logic [32-1:0] agu_sbf_0_nxt;
	logic [32-1:0] agu_sbf_0_r_ref;
	logic [32-1:0] agu_sbf_0_r_dut;
	logic agu_sbf_1_ena;
	logic [32-1:0] agu_sbf_1_nxt;
	logic [32-1:0] agu_sbf_1_r_ref;
	logic [32-1:0] agu_sbf_1_r_dut;
	logic muldiv_req_alu;
	logic [35-1:0] muldiv_req_alu_op1;
	logic [35-1:0] muldiv_req_alu_op2;
	logic muldiv_req_alu_add;
	logic muldiv_req_alu_sub;
	logic [35-1:0] muldiv_req_alu_res_ref;
	logic [35-1:0] muldiv_req_alu_res_dut;
	logic muldiv_sbf_0_ena;
	logic [33-1:0] muldiv_sbf_0_nxt;
	logic [33-1:0] muldiv_sbf_0_r_ref;
	logic [33-1:0] muldiv_sbf_0_r_dut;
	logic muldiv_sbf_1_ena;
	logic [33-1:0] muldiv_sbf_1_nxt;
	logic [33-1:0] muldiv_sbf_1_r_ref;
	logic [33-1:0] muldiv_sbf_1_r_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.alu_req_alu(alu_req_alu),
		.alu_req_alu_add(alu_req_alu_add),
		.alu_req_alu_sub(alu_req_alu_sub),
		.alu_req_alu_xor(alu_req_alu_xor),
		.alu_req_alu_sll(alu_req_alu_sll),
		.alu_req_alu_srl(alu_req_alu_srl),
		.alu_req_alu_sra(alu_req_alu_sra),
		.alu_req_alu_or(alu_req_alu_or),
		.alu_req_alu_and(alu_req_alu_and),
		.alu_req_alu_slt(alu_req_alu_slt),
		.alu_req_alu_sltu(alu_req_alu_sltu),
		.alu_req_alu_lui(alu_req_alu_lui),
		.alu_req_alu_op1(alu_req_alu_op1),
		.alu_req_alu_op2(alu_req_alu_op2),
		.bjp_req_alu(bjp_req_alu),
		.bjp_req_alu_op1(bjp_req_alu_op1),
		.bjp_req_alu_op2(bjp_req_alu_op2),
		.bjp_req_alu_cmp_eq(bjp_req_alu_cmp_eq),
		.bjp_req_alu_cmp_ne(bjp_req_alu_cmp_ne),
		.bjp_req_alu_cmp_lt(bjp_req_alu_cmp_lt),
		.bjp_req_alu_cmp_gt(bjp_req_alu_cmp_gt),
		.bjp_req_alu_cmp_ltu(bjp_req_alu_cmp_ltu),
		.bjp_req_alu_cmp_gtu(bjp_req_alu_cmp_gtu),
		.bjp_req_alu_add(bjp_req_alu_add),
		.agu_req_alu(agu_req_alu),
		.agu_req_alu_op1(agu_req_alu_op1),
		.agu_req_alu_op2(agu_req_alu_op2),
		.agu_req_alu_swap(agu_req_alu_swap),
		.agu_req_alu_add(agu_req_alu_add),
		.agu_req_alu_and(agu_req_alu_and),
		.agu_req_alu_or(agu_req_alu_or),
		.agu_req_alu_xor(agu_req_alu_xor),
		.agu_req_alu_max(agu_req_alu_max),
		.agu_req_alu_min(agu_req_alu_min),
		.agu_req_alu_maxu(agu_req_alu_maxu),
		.agu_req_alu_minu(agu_req_alu_minu),
		.agu_sbf_0_ena(agu_sbf_0_ena),
		.agu_sbf_0_nxt(agu_sbf_0_nxt),
		.agu_sbf_1_ena(agu_sbf_1_ena),
		.agu_sbf_1_nxt(agu_sbf_1_nxt),
		.muldiv_req_alu(muldiv_req_alu),
		.muldiv_req_alu_op1(muldiv_req_alu_op1),
		.muldiv_req_alu_op2(muldiv_req_alu_op2),
		.muldiv_req_alu_add(muldiv_req_alu_add),
		.muldiv_req_alu_sub(muldiv_req_alu_sub),
		.muldiv_sbf_0_ena(muldiv_sbf_0_ena),
		.muldiv_sbf_0_nxt(muldiv_sbf_0_nxt),
		.muldiv_sbf_1_ena(muldiv_sbf_1_ena),
		.muldiv_sbf_1_nxt(muldiv_sbf_1_nxt),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_dpath good1 (
		.alu_req_alu(alu_req_alu),
		.alu_req_alu_add(alu_req_alu_add),
		.alu_req_alu_sub(alu_req_alu_sub),
		.alu_req_alu_xor(alu_req_alu_xor),
		.alu_req_alu_sll(alu_req_alu_sll),
		.alu_req_alu_srl(alu_req_alu_srl),
		.alu_req_alu_sra(alu_req_alu_sra),
		.alu_req_alu_or(alu_req_alu_or),
		.alu_req_alu_and(alu_req_alu_and),
		.alu_req_alu_slt(alu_req_alu_slt),
		.alu_req_alu_sltu(alu_req_alu_sltu),
		.alu_req_alu_lui(alu_req_alu_lui),
		.alu_req_alu_op1(alu_req_alu_op1),
		.alu_req_alu_op2(alu_req_alu_op2),
		.alu_req_alu_res(alu_req_alu_res_ref),
		.bjp_req_alu(bjp_req_alu),
		.bjp_req_alu_op1(bjp_req_alu_op1),
		.bjp_req_alu_op2(bjp_req_alu_op2),
		.bjp_req_alu_cmp_eq(bjp_req_alu_cmp_eq),
		.bjp_req_alu_cmp_ne(bjp_req_alu_cmp_ne),
		.bjp_req_alu_cmp_lt(bjp_req_alu_cmp_lt),
		.bjp_req_alu_cmp_gt(bjp_req_alu_cmp_gt),
		.bjp_req_alu_cmp_ltu(bjp_req_alu_cmp_ltu),
		.bjp_req_alu_cmp_gtu(bjp_req_alu_cmp_gtu),
		.bjp_req_alu_add(bjp_req_alu_add),
		.bjp_req_alu_cmp_res(bjp_req_alu_cmp_res_ref),
		.bjp_req_alu_add_res(bjp_req_alu_add_res_ref),
		.agu_req_alu(agu_req_alu),
		.agu_req_alu_op1(agu_req_alu_op1),
		.agu_req_alu_op2(agu_req_alu_op2),
		.agu_req_alu_swap(agu_req_alu_swap),
		.agu_req_alu_add(agu_req_alu_add),
		.agu_req_alu_and(agu_req_alu_and),
		.agu_req_alu_or(agu_req_alu_or),
		.agu_req_alu_xor(agu_req_alu_xor),
		.agu_req_alu_max(agu_req_alu_max),
		.agu_req_alu_min(agu_req_alu_min),
		.agu_req_alu_maxu(agu_req_alu_maxu),
		.agu_req_alu_minu(agu_req_alu_minu),
		.agu_req_alu_res(agu_req_alu_res_ref),
		.agu_sbf_0_ena(agu_sbf_0_ena),
		.agu_sbf_0_nxt(agu_sbf_0_nxt),
		.agu_sbf_0_r(agu_sbf_0_r_ref),
		.agu_sbf_1_ena(agu_sbf_1_ena),
		.agu_sbf_1_nxt(agu_sbf_1_nxt),
		.agu_sbf_1_r(agu_sbf_1_r_ref),
		.muldiv_req_alu(muldiv_req_alu),
		.muldiv_req_alu_op1(muldiv_req_alu_op1),
		.muldiv_req_alu_op2(muldiv_req_alu_op2),
		.muldiv_req_alu_add(muldiv_req_alu_add),
		.muldiv_req_alu_sub(muldiv_req_alu_sub),
		.muldiv_req_alu_res(muldiv_req_alu_res_ref),
		.muldiv_sbf_0_ena(muldiv_sbf_0_ena),
		.muldiv_sbf_0_nxt(muldiv_sbf_0_nxt),
		.muldiv_sbf_0_r(muldiv_sbf_0_r_ref),
		.muldiv_sbf_1_ena(muldiv_sbf_1_ena),
		.muldiv_sbf_1_nxt(muldiv_sbf_1_nxt),
		.muldiv_sbf_1_r(muldiv_sbf_1_r_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_dpath top_module1 (
		.alu_req_alu(alu_req_alu),
		.alu_req_alu_add(alu_req_alu_add),
		.alu_req_alu_sub(alu_req_alu_sub),
		.alu_req_alu_xor(alu_req_alu_xor),
		.alu_req_alu_sll(alu_req_alu_sll),
		.alu_req_alu_srl(alu_req_alu_srl),
		.alu_req_alu_sra(alu_req_alu_sra),
		.alu_req_alu_or(alu_req_alu_or),
		.alu_req_alu_and(alu_req_alu_and),
		.alu_req_alu_slt(alu_req_alu_slt),
		.alu_req_alu_sltu(alu_req_alu_sltu),
		.alu_req_alu_lui(alu_req_alu_lui),
		.alu_req_alu_op1(alu_req_alu_op1),
		.alu_req_alu_op2(alu_req_alu_op2),
		.alu_req_alu_res(alu_req_alu_res_dut),
		.bjp_req_alu(bjp_req_alu),
		.bjp_req_alu_op1(bjp_req_alu_op1),
		.bjp_req_alu_op2(bjp_req_alu_op2),
		.bjp_req_alu_cmp_eq(bjp_req_alu_cmp_eq),
		.bjp_req_alu_cmp_ne(bjp_req_alu_cmp_ne),
		.bjp_req_alu_cmp_lt(bjp_req_alu_cmp_lt),
		.bjp_req_alu_cmp_gt(bjp_req_alu_cmp_gt),
		.bjp_req_alu_cmp_ltu(bjp_req_alu_cmp_ltu),
		.bjp_req_alu_cmp_gtu(bjp_req_alu_cmp_gtu),
		.bjp_req_alu_add(bjp_req_alu_add),
		.bjp_req_alu_cmp_res(bjp_req_alu_cmp_res_dut),
		.bjp_req_alu_add_res(bjp_req_alu_add_res_dut),
		.agu_req_alu(agu_req_alu),
		.agu_req_alu_op1(agu_req_alu_op1),
		.agu_req_alu_op2(agu_req_alu_op2),
		.agu_req_alu_swap(agu_req_alu_swap),
		.agu_req_alu_add(agu_req_alu_add),
		.agu_req_alu_and(agu_req_alu_and),
		.agu_req_alu_or(agu_req_alu_or),
		.agu_req_alu_xor(agu_req_alu_xor),
		.agu_req_alu_max(agu_req_alu_max),
		.agu_req_alu_min(agu_req_alu_min),
		.agu_req_alu_maxu(agu_req_alu_maxu),
		.agu_req_alu_minu(agu_req_alu_minu),
		.agu_req_alu_res(agu_req_alu_res_dut),
		.agu_sbf_0_ena(agu_sbf_0_ena),
		.agu_sbf_0_nxt(agu_sbf_0_nxt),
		.agu_sbf_0_r(agu_sbf_0_r_dut),
		.agu_sbf_1_ena(agu_sbf_1_ena),
		.agu_sbf_1_nxt(agu_sbf_1_nxt),
		.agu_sbf_1_r(agu_sbf_1_r_dut),
		.muldiv_req_alu(muldiv_req_alu),
		.muldiv_req_alu_op1(muldiv_req_alu_op1),
		.muldiv_req_alu_op2(muldiv_req_alu_op2),
		.muldiv_req_alu_add(muldiv_req_alu_add),
		.muldiv_req_alu_sub(muldiv_req_alu_sub),
		.muldiv_req_alu_res(muldiv_req_alu_res_dut),
		.muldiv_sbf_0_ena(muldiv_sbf_0_ena),
		.muldiv_sbf_0_nxt(muldiv_sbf_0_nxt),
		.muldiv_sbf_0_r(muldiv_sbf_0_r_dut),
		.muldiv_sbf_1_ena(muldiv_sbf_1_ena),
		.muldiv_sbf_1_nxt(muldiv_sbf_1_nxt),
		.muldiv_sbf_1_r(muldiv_sbf_1_r_dut),
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
		if (stats1.errors_alu_req_alu_res)
			$display("Hint: Output 'alu_req_alu_res' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_res, stats1.errortime_alu_req_alu_res);
		else
			$display("Hint: Output 'alu_req_alu_res' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_res)
			$display("Hint: Output 'bjp_req_alu_cmp_res' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_res, stats1.errortime_bjp_req_alu_cmp_res);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_res' has no mismatches.");
		if (stats1.errors_bjp_req_alu_add_res)
			$display("Hint: Output 'bjp_req_alu_add_res' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_add_res, stats1.errortime_bjp_req_alu_add_res);
		else
			$display("Hint: Output 'bjp_req_alu_add_res' has no mismatches.");
		if (stats1.errors_agu_req_alu_res)
			$display("Hint: Output 'agu_req_alu_res' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_res, stats1.errortime_agu_req_alu_res);
		else
			$display("Hint: Output 'agu_req_alu_res' has no mismatches.");
		if (stats1.errors_agu_sbf_0_r)
			$display("Hint: Output 'agu_sbf_0_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_0_r, stats1.errortime_agu_sbf_0_r);
		else
			$display("Hint: Output 'agu_sbf_0_r' has no mismatches.");
		if (stats1.errors_agu_sbf_1_r)
			$display("Hint: Output 'agu_sbf_1_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_1_r, stats1.errortime_agu_sbf_1_r);
		else
			$display("Hint: Output 'agu_sbf_1_r' has no mismatches.");
		if (stats1.errors_muldiv_req_alu_res)
			$display("Hint: Output 'muldiv_req_alu_res' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_req_alu_res, stats1.errortime_muldiv_req_alu_res);
		else
			$display("Hint: Output 'muldiv_req_alu_res' has no mismatches.");
		if (stats1.errors_muldiv_sbf_0_r)
			$display("Hint: Output 'muldiv_sbf_0_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_0_r, stats1.errortime_muldiv_sbf_0_r);
		else
			$display("Hint: Output 'muldiv_sbf_0_r' has no mismatches.");
		if (stats1.errors_muldiv_sbf_1_r)
			$display("Hint: Output 'muldiv_sbf_1_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_muldiv_sbf_1_r, stats1.errortime_muldiv_sbf_1_r);
		else
			$display("Hint: Output 'muldiv_sbf_1_r' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ alu_req_alu_res_ref,bjp_req_alu_cmp_res_ref,bjp_req_alu_add_res_ref,agu_req_alu_res_ref,agu_sbf_0_r_ref,agu_sbf_1_r_ref,muldiv_req_alu_res_ref,muldiv_sbf_0_r_ref,muldiv_sbf_1_r_ref} ===
			( { alu_req_alu_res_ref,bjp_req_alu_cmp_res_ref,bjp_req_alu_add_res_ref,agu_req_alu_res_ref,agu_sbf_0_r_ref,agu_sbf_1_r_ref,muldiv_req_alu_res_ref,muldiv_sbf_0_r_ref,muldiv_sbf_1_r_ref} ^
			  { alu_req_alu_res_dut,bjp_req_alu_cmp_res_dut,bjp_req_alu_add_res_dut,agu_req_alu_res_dut,agu_sbf_0_r_dut,agu_sbf_1_r_dut,muldiv_req_alu_res_dut,muldiv_sbf_0_r_dut,muldiv_sbf_1_r_dut} ^
			  { alu_req_alu_res_ref,bjp_req_alu_cmp_res_ref,bjp_req_alu_add_res_ref,agu_req_alu_res_ref,agu_sbf_0_r_ref,agu_sbf_1_r_ref,muldiv_req_alu_res_ref,muldiv_sbf_0_r_ref,muldiv_sbf_1_r_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (alu_req_alu_res_ref !== (alu_req_alu_res_ref ^ alu_req_alu_res_dut ^ alu_req_alu_res_ref)) begin
			if (stats1.errors_alu_req_alu_res == 0) stats1.errortime_alu_req_alu_res = $time;
			stats1.errors_alu_req_alu_res++;
		end
		if (bjp_req_alu_cmp_res_ref !== (bjp_req_alu_cmp_res_ref ^ bjp_req_alu_cmp_res_dut ^ bjp_req_alu_cmp_res_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_res == 0) stats1.errortime_bjp_req_alu_cmp_res = $time;
			stats1.errors_bjp_req_alu_cmp_res++;
		end
		if (bjp_req_alu_add_res_ref !== (bjp_req_alu_add_res_ref ^ bjp_req_alu_add_res_dut ^ bjp_req_alu_add_res_ref)) begin
			if (stats1.errors_bjp_req_alu_add_res == 0) stats1.errortime_bjp_req_alu_add_res = $time;
			stats1.errors_bjp_req_alu_add_res++;
		end
		if (agu_req_alu_res_ref !== (agu_req_alu_res_ref ^ agu_req_alu_res_dut ^ agu_req_alu_res_ref)) begin
			if (stats1.errors_agu_req_alu_res == 0) stats1.errortime_agu_req_alu_res = $time;
			stats1.errors_agu_req_alu_res++;
		end
		if (agu_sbf_0_r_ref !== (agu_sbf_0_r_ref ^ agu_sbf_0_r_dut ^ agu_sbf_0_r_ref)) begin
			if (stats1.errors_agu_sbf_0_r == 0) stats1.errortime_agu_sbf_0_r = $time;
			stats1.errors_agu_sbf_0_r++;
		end
		if (agu_sbf_1_r_ref !== (agu_sbf_1_r_ref ^ agu_sbf_1_r_dut ^ agu_sbf_1_r_ref)) begin
			if (stats1.errors_agu_sbf_1_r == 0) stats1.errortime_agu_sbf_1_r = $time;
			stats1.errors_agu_sbf_1_r++;
		end
		if (muldiv_req_alu_res_ref !== (muldiv_req_alu_res_ref ^ muldiv_req_alu_res_dut ^ muldiv_req_alu_res_ref)) begin
			if (stats1.errors_muldiv_req_alu_res == 0) stats1.errortime_muldiv_req_alu_res = $time;
			stats1.errors_muldiv_req_alu_res++;
		end
		if (muldiv_sbf_0_r_ref !== (muldiv_sbf_0_r_ref ^ muldiv_sbf_0_r_dut ^ muldiv_sbf_0_r_ref)) begin
			if (stats1.errors_muldiv_sbf_0_r == 0) stats1.errortime_muldiv_sbf_0_r = $time;
			stats1.errors_muldiv_sbf_0_r++;
		end
		if (muldiv_sbf_1_r_ref !== (muldiv_sbf_1_r_ref ^ muldiv_sbf_1_r_dut ^ muldiv_sbf_1_r_ref)) begin
			if (stats1.errors_muldiv_sbf_1_r == 0) stats1.errortime_muldiv_sbf_1_r = $time;
			stats1.errors_muldiv_sbf_1_r++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
