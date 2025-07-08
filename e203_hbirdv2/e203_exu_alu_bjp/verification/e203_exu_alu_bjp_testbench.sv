`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_bjp_i_ready;
		int errortime_bjp_i_ready;
		int errors_bjp_o_valid;
		int errortime_bjp_o_valid;
		int errors_bjp_o_wbck_wdat;
		int errortime_bjp_o_wbck_wdat;
		int errors_bjp_o_wbck_err;
		int errortime_bjp_o_wbck_err;
		int errors_bjp_o_cmt_bjp;
		int errortime_bjp_o_cmt_bjp;
		int errors_bjp_o_cmt_mret;
		int errortime_bjp_o_cmt_mret;
		int errors_bjp_o_cmt_dret;
		int errortime_bjp_o_cmt_dret;
		int errors_bjp_o_cmt_fencei;
		int errortime_bjp_o_cmt_fencei;
		int errors_bjp_o_cmt_prdt;
		int errortime_bjp_o_cmt_prdt;
		int errors_bjp_o_cmt_rslv;
		int errortime_bjp_o_cmt_rslv;
		int errors_bjp_req_alu_op1;
		int errortime_bjp_req_alu_op1;
		int errors_bjp_req_alu_op2;
		int errortime_bjp_req_alu_op2;
		int errors_bjp_req_alu_cmp_eq;
		int errortime_bjp_req_alu_cmp_eq;
		int errors_bjp_req_alu_cmp_ne;
		int errortime_bjp_req_alu_cmp_ne;
		int errors_bjp_req_alu_cmp_lt;
		int errortime_bjp_req_alu_cmp_lt;
		int errors_bjp_req_alu_cmp_gt;
		int errortime_bjp_req_alu_cmp_gt;
		int errors_bjp_req_alu_cmp_ltu;
		int errortime_bjp_req_alu_cmp_ltu;
		int errors_bjp_req_alu_cmp_gtu;
		int errortime_bjp_req_alu_cmp_gtu;
		int errors_bjp_req_alu_add;
		int errortime_bjp_req_alu_add;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic bjp_i_valid;
	logic bjp_i_ready_ref;
	logic bjp_i_ready_dut;
	logic [32-1:0] bjp_i_rs1;
	logic [32-1:0] bjp_i_rs2;
	logic [32-1:0] bjp_i_imm;
	logic [32-1:0] bjp_i_pc;
	logic [17-1:0] bjp_i_info;
	logic bjp_o_valid_ref;
	logic bjp_o_valid_dut;
	logic bjp_o_ready;
	logic [32-1:0] bjp_o_wbck_wdat_ref;
	logic [32-1:0] bjp_o_wbck_wdat_dut;
	logic bjp_o_wbck_err_ref;
	logic bjp_o_wbck_err_dut;
	logic bjp_o_cmt_bjp_ref;
	logic bjp_o_cmt_bjp_dut;
	logic bjp_o_cmt_mret_ref;
	logic bjp_o_cmt_mret_dut;
	logic bjp_o_cmt_dret_ref;
	logic bjp_o_cmt_dret_dut;
	logic bjp_o_cmt_fencei_ref;
	logic bjp_o_cmt_fencei_dut;
	logic bjp_o_cmt_prdt_ref;
	logic bjp_o_cmt_prdt_dut;
	logic bjp_o_cmt_rslv_ref;
	logic bjp_o_cmt_rslv_dut;
	logic [32-1:0] bjp_req_alu_op1_ref;
	logic [32-1:0] bjp_req_alu_op1_dut;
	logic [32-1:0] bjp_req_alu_op2_ref;
	logic [32-1:0] bjp_req_alu_op2_dut;
	logic bjp_req_alu_cmp_eq_ref;
	logic bjp_req_alu_cmp_eq_dut;
	logic bjp_req_alu_cmp_ne_ref;
	logic bjp_req_alu_cmp_ne_dut;
	logic bjp_req_alu_cmp_lt_ref;
	logic bjp_req_alu_cmp_lt_dut;
	logic bjp_req_alu_cmp_gt_ref;
	logic bjp_req_alu_cmp_gt_dut;
	logic bjp_req_alu_cmp_ltu_ref;
	logic bjp_req_alu_cmp_ltu_dut;
	logic bjp_req_alu_cmp_gtu_ref;
	logic bjp_req_alu_cmp_gtu_dut;
	logic bjp_req_alu_add_ref;
	logic bjp_req_alu_add_dut;
	logic bjp_req_alu_cmp_res;
	logic [32-1:0] bjp_req_alu_add_res;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.bjp_i_valid(bjp_i_valid),
		.bjp_i_rs1(bjp_i_rs1),
		.bjp_i_rs2(bjp_i_rs2),
		.bjp_i_imm(bjp_i_imm),
		.bjp_i_pc(bjp_i_pc),
		.bjp_i_info(bjp_i_info),
		.bjp_o_ready(bjp_o_ready),
		.bjp_req_alu_cmp_res(bjp_req_alu_cmp_res),
		.bjp_req_alu_add_res(bjp_req_alu_add_res),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_bjp good1 (
		.bjp_i_valid(bjp_i_valid),
		.bjp_i_ready(bjp_i_ready_ref),
		.bjp_i_rs1(bjp_i_rs1),
		.bjp_i_rs2(bjp_i_rs2),
		.bjp_i_imm(bjp_i_imm),
		.bjp_i_pc(bjp_i_pc),
		.bjp_i_info(bjp_i_info),
		.bjp_o_valid(bjp_o_valid_ref),
		.bjp_o_ready(bjp_o_ready),
		.bjp_o_wbck_wdat(bjp_o_wbck_wdat_ref),
		.bjp_o_wbck_err(bjp_o_wbck_err_ref),
		.bjp_o_cmt_bjp(bjp_o_cmt_bjp_ref),
		.bjp_o_cmt_mret(bjp_o_cmt_mret_ref),
		.bjp_o_cmt_dret(bjp_o_cmt_dret_ref),
		.bjp_o_cmt_fencei(bjp_o_cmt_fencei_ref),
		.bjp_o_cmt_prdt(bjp_o_cmt_prdt_ref),
		.bjp_o_cmt_rslv(bjp_o_cmt_rslv_ref),
		.bjp_req_alu_op1(bjp_req_alu_op1_ref),
		.bjp_req_alu_op2(bjp_req_alu_op2_ref),
		.bjp_req_alu_cmp_eq(bjp_req_alu_cmp_eq_ref),
		.bjp_req_alu_cmp_ne(bjp_req_alu_cmp_ne_ref),
		.bjp_req_alu_cmp_lt(bjp_req_alu_cmp_lt_ref),
		.bjp_req_alu_cmp_gt(bjp_req_alu_cmp_gt_ref),
		.bjp_req_alu_cmp_ltu(bjp_req_alu_cmp_ltu_ref),
		.bjp_req_alu_cmp_gtu(bjp_req_alu_cmp_gtu_ref),
		.bjp_req_alu_add(bjp_req_alu_add_ref),
		.bjp_req_alu_cmp_res(bjp_req_alu_cmp_res),
		.bjp_req_alu_add_res(bjp_req_alu_add_res),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_bjp top_module1 (
		.bjp_i_valid(bjp_i_valid),
		.bjp_i_ready(bjp_i_ready_dut),
		.bjp_i_rs1(bjp_i_rs1),
		.bjp_i_rs2(bjp_i_rs2),
		.bjp_i_imm(bjp_i_imm),
		.bjp_i_pc(bjp_i_pc),
		.bjp_i_info(bjp_i_info),
		.bjp_o_valid(bjp_o_valid_dut),
		.bjp_o_ready(bjp_o_ready),
		.bjp_o_wbck_wdat(bjp_o_wbck_wdat_dut),
		.bjp_o_wbck_err(bjp_o_wbck_err_dut),
		.bjp_o_cmt_bjp(bjp_o_cmt_bjp_dut),
		.bjp_o_cmt_mret(bjp_o_cmt_mret_dut),
		.bjp_o_cmt_dret(bjp_o_cmt_dret_dut),
		.bjp_o_cmt_fencei(bjp_o_cmt_fencei_dut),
		.bjp_o_cmt_prdt(bjp_o_cmt_prdt_dut),
		.bjp_o_cmt_rslv(bjp_o_cmt_rslv_dut),
		.bjp_req_alu_op1(bjp_req_alu_op1_dut),
		.bjp_req_alu_op2(bjp_req_alu_op2_dut),
		.bjp_req_alu_cmp_eq(bjp_req_alu_cmp_eq_dut),
		.bjp_req_alu_cmp_ne(bjp_req_alu_cmp_ne_dut),
		.bjp_req_alu_cmp_lt(bjp_req_alu_cmp_lt_dut),
		.bjp_req_alu_cmp_gt(bjp_req_alu_cmp_gt_dut),
		.bjp_req_alu_cmp_ltu(bjp_req_alu_cmp_ltu_dut),
		.bjp_req_alu_cmp_gtu(bjp_req_alu_cmp_gtu_dut),
		.bjp_req_alu_add(bjp_req_alu_add_dut),
		.bjp_req_alu_cmp_res(bjp_req_alu_cmp_res),
		.bjp_req_alu_add_res(bjp_req_alu_add_res),
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
		if (stats1.errors_bjp_i_ready)
			$display("Hint: Output 'bjp_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_i_ready, stats1.errortime_bjp_i_ready);
		else
			$display("Hint: Output 'bjp_i_ready' has no mismatches.");
		if (stats1.errors_bjp_o_valid)
			$display("Hint: Output 'bjp_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_valid, stats1.errortime_bjp_o_valid);
		else
			$display("Hint: Output 'bjp_o_valid' has no mismatches.");
		if (stats1.errors_bjp_o_wbck_wdat)
			$display("Hint: Output 'bjp_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_wbck_wdat, stats1.errortime_bjp_o_wbck_wdat);
		else
			$display("Hint: Output 'bjp_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_bjp_o_wbck_err)
			$display("Hint: Output 'bjp_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_wbck_err, stats1.errortime_bjp_o_wbck_err);
		else
			$display("Hint: Output 'bjp_o_wbck_err' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_bjp)
			$display("Hint: Output 'bjp_o_cmt_bjp' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_bjp, stats1.errortime_bjp_o_cmt_bjp);
		else
			$display("Hint: Output 'bjp_o_cmt_bjp' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_mret)
			$display("Hint: Output 'bjp_o_cmt_mret' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_mret, stats1.errortime_bjp_o_cmt_mret);
		else
			$display("Hint: Output 'bjp_o_cmt_mret' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_dret)
			$display("Hint: Output 'bjp_o_cmt_dret' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_dret, stats1.errortime_bjp_o_cmt_dret);
		else
			$display("Hint: Output 'bjp_o_cmt_dret' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_fencei)
			$display("Hint: Output 'bjp_o_cmt_fencei' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_fencei, stats1.errortime_bjp_o_cmt_fencei);
		else
			$display("Hint: Output 'bjp_o_cmt_fencei' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_prdt)
			$display("Hint: Output 'bjp_o_cmt_prdt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_prdt, stats1.errortime_bjp_o_cmt_prdt);
		else
			$display("Hint: Output 'bjp_o_cmt_prdt' has no mismatches.");
		if (stats1.errors_bjp_o_cmt_rslv)
			$display("Hint: Output 'bjp_o_cmt_rslv' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_o_cmt_rslv, stats1.errortime_bjp_o_cmt_rslv);
		else
			$display("Hint: Output 'bjp_o_cmt_rslv' has no mismatches.");
		if (stats1.errors_bjp_req_alu_op1)
			$display("Hint: Output 'bjp_req_alu_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_op1, stats1.errortime_bjp_req_alu_op1);
		else
			$display("Hint: Output 'bjp_req_alu_op1' has no mismatches.");
		if (stats1.errors_bjp_req_alu_op2)
			$display("Hint: Output 'bjp_req_alu_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_op2, stats1.errortime_bjp_req_alu_op2);
		else
			$display("Hint: Output 'bjp_req_alu_op2' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_eq)
			$display("Hint: Output 'bjp_req_alu_cmp_eq' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_eq, stats1.errortime_bjp_req_alu_cmp_eq);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_eq' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_ne)
			$display("Hint: Output 'bjp_req_alu_cmp_ne' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_ne, stats1.errortime_bjp_req_alu_cmp_ne);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_ne' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_lt)
			$display("Hint: Output 'bjp_req_alu_cmp_lt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_lt, stats1.errortime_bjp_req_alu_cmp_lt);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_lt' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_gt)
			$display("Hint: Output 'bjp_req_alu_cmp_gt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_gt, stats1.errortime_bjp_req_alu_cmp_gt);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_gt' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_ltu)
			$display("Hint: Output 'bjp_req_alu_cmp_ltu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_ltu, stats1.errortime_bjp_req_alu_cmp_ltu);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_ltu' has no mismatches.");
		if (stats1.errors_bjp_req_alu_cmp_gtu)
			$display("Hint: Output 'bjp_req_alu_cmp_gtu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_cmp_gtu, stats1.errortime_bjp_req_alu_cmp_gtu);
		else
			$display("Hint: Output 'bjp_req_alu_cmp_gtu' has no mismatches.");
		if (stats1.errors_bjp_req_alu_add)
			$display("Hint: Output 'bjp_req_alu_add' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bjp_req_alu_add, stats1.errortime_bjp_req_alu_add);
		else
			$display("Hint: Output 'bjp_req_alu_add' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ bjp_i_ready_ref,bjp_o_valid_ref,bjp_o_wbck_wdat_ref,bjp_o_wbck_err_ref,bjp_o_cmt_bjp_ref,bjp_o_cmt_mret_ref,bjp_o_cmt_dret_ref,bjp_o_cmt_fencei_ref,bjp_o_cmt_prdt_ref,bjp_o_cmt_rslv_ref,bjp_req_alu_op1_ref,bjp_req_alu_op2_ref,bjp_req_alu_cmp_eq_ref,bjp_req_alu_cmp_ne_ref,bjp_req_alu_cmp_lt_ref,bjp_req_alu_cmp_gt_ref,bjp_req_alu_cmp_ltu_ref,bjp_req_alu_cmp_gtu_ref,bjp_req_alu_add_ref} ===
			( { bjp_i_ready_ref,bjp_o_valid_ref,bjp_o_wbck_wdat_ref,bjp_o_wbck_err_ref,bjp_o_cmt_bjp_ref,bjp_o_cmt_mret_ref,bjp_o_cmt_dret_ref,bjp_o_cmt_fencei_ref,bjp_o_cmt_prdt_ref,bjp_o_cmt_rslv_ref,bjp_req_alu_op1_ref,bjp_req_alu_op2_ref,bjp_req_alu_cmp_eq_ref,bjp_req_alu_cmp_ne_ref,bjp_req_alu_cmp_lt_ref,bjp_req_alu_cmp_gt_ref,bjp_req_alu_cmp_ltu_ref,bjp_req_alu_cmp_gtu_ref,bjp_req_alu_add_ref} ^
			  { bjp_i_ready_dut,bjp_o_valid_dut,bjp_o_wbck_wdat_dut,bjp_o_wbck_err_dut,bjp_o_cmt_bjp_dut,bjp_o_cmt_mret_dut,bjp_o_cmt_dret_dut,bjp_o_cmt_fencei_dut,bjp_o_cmt_prdt_dut,bjp_o_cmt_rslv_dut,bjp_req_alu_op1_dut,bjp_req_alu_op2_dut,bjp_req_alu_cmp_eq_dut,bjp_req_alu_cmp_ne_dut,bjp_req_alu_cmp_lt_dut,bjp_req_alu_cmp_gt_dut,bjp_req_alu_cmp_ltu_dut,bjp_req_alu_cmp_gtu_dut,bjp_req_alu_add_dut} ^
			  { bjp_i_ready_ref,bjp_o_valid_ref,bjp_o_wbck_wdat_ref,bjp_o_wbck_err_ref,bjp_o_cmt_bjp_ref,bjp_o_cmt_mret_ref,bjp_o_cmt_dret_ref,bjp_o_cmt_fencei_ref,bjp_o_cmt_prdt_ref,bjp_o_cmt_rslv_ref,bjp_req_alu_op1_ref,bjp_req_alu_op2_ref,bjp_req_alu_cmp_eq_ref,bjp_req_alu_cmp_ne_ref,bjp_req_alu_cmp_lt_ref,bjp_req_alu_cmp_gt_ref,bjp_req_alu_cmp_ltu_ref,bjp_req_alu_cmp_gtu_ref,bjp_req_alu_add_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (bjp_i_ready_ref !== (bjp_i_ready_ref ^ bjp_i_ready_dut ^ bjp_i_ready_ref)) begin
			if (stats1.errors_bjp_i_ready == 0) stats1.errortime_bjp_i_ready = $time;
			stats1.errors_bjp_i_ready++;
		end
		if (bjp_o_valid_ref !== (bjp_o_valid_ref ^ bjp_o_valid_dut ^ bjp_o_valid_ref)) begin
			if (stats1.errors_bjp_o_valid == 0) stats1.errortime_bjp_o_valid = $time;
			stats1.errors_bjp_o_valid++;
		end
		if (bjp_o_wbck_wdat_ref !== (bjp_o_wbck_wdat_ref ^ bjp_o_wbck_wdat_dut ^ bjp_o_wbck_wdat_ref)) begin
			if (stats1.errors_bjp_o_wbck_wdat == 0) stats1.errortime_bjp_o_wbck_wdat = $time;
			stats1.errors_bjp_o_wbck_wdat++;
		end
		if (bjp_o_wbck_err_ref !== (bjp_o_wbck_err_ref ^ bjp_o_wbck_err_dut ^ bjp_o_wbck_err_ref)) begin
			if (stats1.errors_bjp_o_wbck_err == 0) stats1.errortime_bjp_o_wbck_err = $time;
			stats1.errors_bjp_o_wbck_err++;
		end
		if (bjp_o_cmt_bjp_ref !== (bjp_o_cmt_bjp_ref ^ bjp_o_cmt_bjp_dut ^ bjp_o_cmt_bjp_ref)) begin
			if (stats1.errors_bjp_o_cmt_bjp == 0) stats1.errortime_bjp_o_cmt_bjp = $time;
			stats1.errors_bjp_o_cmt_bjp++;
		end
		if (bjp_o_cmt_mret_ref !== (bjp_o_cmt_mret_ref ^ bjp_o_cmt_mret_dut ^ bjp_o_cmt_mret_ref)) begin
			if (stats1.errors_bjp_o_cmt_mret == 0) stats1.errortime_bjp_o_cmt_mret = $time;
			stats1.errors_bjp_o_cmt_mret++;
		end
		if (bjp_o_cmt_dret_ref !== (bjp_o_cmt_dret_ref ^ bjp_o_cmt_dret_dut ^ bjp_o_cmt_dret_ref)) begin
			if (stats1.errors_bjp_o_cmt_dret == 0) stats1.errortime_bjp_o_cmt_dret = $time;
			stats1.errors_bjp_o_cmt_dret++;
		end
		if (bjp_o_cmt_fencei_ref !== (bjp_o_cmt_fencei_ref ^ bjp_o_cmt_fencei_dut ^ bjp_o_cmt_fencei_ref)) begin
			if (stats1.errors_bjp_o_cmt_fencei == 0) stats1.errortime_bjp_o_cmt_fencei = $time;
			stats1.errors_bjp_o_cmt_fencei++;
		end
		if (bjp_o_cmt_prdt_ref !== (bjp_o_cmt_prdt_ref ^ bjp_o_cmt_prdt_dut ^ bjp_o_cmt_prdt_ref)) begin
			if (stats1.errors_bjp_o_cmt_prdt == 0) stats1.errortime_bjp_o_cmt_prdt = $time;
			stats1.errors_bjp_o_cmt_prdt++;
		end
		if (bjp_o_cmt_rslv_ref !== (bjp_o_cmt_rslv_ref ^ bjp_o_cmt_rslv_dut ^ bjp_o_cmt_rslv_ref)) begin
			if (stats1.errors_bjp_o_cmt_rslv == 0) stats1.errortime_bjp_o_cmt_rslv = $time;
			stats1.errors_bjp_o_cmt_rslv++;
		end
		if (bjp_req_alu_op1_ref !== (bjp_req_alu_op1_ref ^ bjp_req_alu_op1_dut ^ bjp_req_alu_op1_ref)) begin
			if (stats1.errors_bjp_req_alu_op1 == 0) stats1.errortime_bjp_req_alu_op1 = $time;
			stats1.errors_bjp_req_alu_op1++;
		end
		if (bjp_req_alu_op2_ref !== (bjp_req_alu_op2_ref ^ bjp_req_alu_op2_dut ^ bjp_req_alu_op2_ref)) begin
			if (stats1.errors_bjp_req_alu_op2 == 0) stats1.errortime_bjp_req_alu_op2 = $time;
			stats1.errors_bjp_req_alu_op2++;
		end
		if (bjp_req_alu_cmp_eq_ref !== (bjp_req_alu_cmp_eq_ref ^ bjp_req_alu_cmp_eq_dut ^ bjp_req_alu_cmp_eq_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_eq == 0) stats1.errortime_bjp_req_alu_cmp_eq = $time;
			stats1.errors_bjp_req_alu_cmp_eq++;
		end
		if (bjp_req_alu_cmp_ne_ref !== (bjp_req_alu_cmp_ne_ref ^ bjp_req_alu_cmp_ne_dut ^ bjp_req_alu_cmp_ne_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_ne == 0) stats1.errortime_bjp_req_alu_cmp_ne = $time;
			stats1.errors_bjp_req_alu_cmp_ne++;
		end
		if (bjp_req_alu_cmp_lt_ref !== (bjp_req_alu_cmp_lt_ref ^ bjp_req_alu_cmp_lt_dut ^ bjp_req_alu_cmp_lt_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_lt == 0) stats1.errortime_bjp_req_alu_cmp_lt = $time;
			stats1.errors_bjp_req_alu_cmp_lt++;
		end
		if (bjp_req_alu_cmp_gt_ref !== (bjp_req_alu_cmp_gt_ref ^ bjp_req_alu_cmp_gt_dut ^ bjp_req_alu_cmp_gt_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_gt == 0) stats1.errortime_bjp_req_alu_cmp_gt = $time;
			stats1.errors_bjp_req_alu_cmp_gt++;
		end
		if (bjp_req_alu_cmp_ltu_ref !== (bjp_req_alu_cmp_ltu_ref ^ bjp_req_alu_cmp_ltu_dut ^ bjp_req_alu_cmp_ltu_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_ltu == 0) stats1.errortime_bjp_req_alu_cmp_ltu = $time;
			stats1.errors_bjp_req_alu_cmp_ltu++;
		end
		if (bjp_req_alu_cmp_gtu_ref !== (bjp_req_alu_cmp_gtu_ref ^ bjp_req_alu_cmp_gtu_dut ^ bjp_req_alu_cmp_gtu_ref)) begin
			if (stats1.errors_bjp_req_alu_cmp_gtu == 0) stats1.errortime_bjp_req_alu_cmp_gtu = $time;
			stats1.errors_bjp_req_alu_cmp_gtu++;
		end
		if (bjp_req_alu_add_ref !== (bjp_req_alu_add_ref ^ bjp_req_alu_add_dut ^ bjp_req_alu_add_ref)) begin
			if (stats1.errors_bjp_req_alu_add == 0) stats1.errortime_bjp_req_alu_add = $time;
			stats1.errors_bjp_req_alu_add++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
