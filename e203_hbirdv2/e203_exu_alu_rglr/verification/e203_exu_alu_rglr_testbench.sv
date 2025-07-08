`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_alu_i_ready;
		int errortime_alu_i_ready;
		int errors_alu_o_valid;
		int errortime_alu_o_valid;
		int errors_alu_o_wbck_wdat;
		int errortime_alu_o_wbck_wdat;
		int errors_alu_o_wbck_err;
		int errortime_alu_o_wbck_err;
		int errors_alu_o_cmt_ecall;
		int errortime_alu_o_cmt_ecall;
		int errors_alu_o_cmt_ebreak;
		int errortime_alu_o_cmt_ebreak;
		int errors_alu_o_cmt_wfi;
		int errortime_alu_o_cmt_wfi;
		int errors_alu_req_alu_add;
		int errortime_alu_req_alu_add;
		int errors_alu_req_alu_sub;
		int errortime_alu_req_alu_sub;
		int errors_alu_req_alu_xor;
		int errortime_alu_req_alu_xor;
		int errors_alu_req_alu_sll;
		int errortime_alu_req_alu_sll;
		int errors_alu_req_alu_srl;
		int errortime_alu_req_alu_srl;
		int errors_alu_req_alu_sra;
		int errortime_alu_req_alu_sra;
		int errors_alu_req_alu_or;
		int errortime_alu_req_alu_or;
		int errors_alu_req_alu_and;
		int errortime_alu_req_alu_and;
		int errors_alu_req_alu_slt;
		int errortime_alu_req_alu_slt;
		int errors_alu_req_alu_sltu;
		int errortime_alu_req_alu_sltu;
		int errors_alu_req_alu_lui;
		int errortime_alu_req_alu_lui;
		int errors_alu_req_alu_op1;
		int errortime_alu_req_alu_op1;
		int errors_alu_req_alu_op2;
		int errortime_alu_req_alu_op2;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic alu_i_valid;
	logic alu_i_ready_ref;
	logic alu_i_ready_dut;
	logic [32-1:0] alu_i_rs1;
	logic [32-1:0] alu_i_rs2;
	logic [32-1:0] alu_i_imm;
	logic [32-1:0] alu_i_pc;
	logic [21-1:0] alu_i_info;
	logic alu_o_valid_ref;
	logic alu_o_valid_dut;
	logic alu_o_ready;
	logic [32-1:0] alu_o_wbck_wdat_ref;
	logic [32-1:0] alu_o_wbck_wdat_dut;
	logic alu_o_wbck_err_ref;
	logic alu_o_wbck_err_dut;
	logic alu_o_cmt_ecall_ref;
	logic alu_o_cmt_ecall_dut;
	logic alu_o_cmt_ebreak_ref;
	logic alu_o_cmt_ebreak_dut;
	logic alu_o_cmt_wfi_ref;
	logic alu_o_cmt_wfi_dut;
	logic alu_req_alu_add_ref;
	logic alu_req_alu_add_dut;
	logic alu_req_alu_sub_ref;
	logic alu_req_alu_sub_dut;
	logic alu_req_alu_xor_ref;
	logic alu_req_alu_xor_dut;
	logic alu_req_alu_sll_ref;
	logic alu_req_alu_sll_dut;
	logic alu_req_alu_srl_ref;
	logic alu_req_alu_srl_dut;
	logic alu_req_alu_sra_ref;
	logic alu_req_alu_sra_dut;
	logic alu_req_alu_or_ref;
	logic alu_req_alu_or_dut;
	logic alu_req_alu_and_ref;
	logic alu_req_alu_and_dut;
	logic alu_req_alu_slt_ref;
	logic alu_req_alu_slt_dut;
	logic alu_req_alu_sltu_ref;
	logic alu_req_alu_sltu_dut;
	logic alu_req_alu_lui_ref;
	logic alu_req_alu_lui_dut;
	logic [32-1:0] alu_req_alu_op1_ref;
	logic [32-1:0] alu_req_alu_op1_dut;
	logic [32-1:0] alu_req_alu_op2_ref;
	logic [32-1:0] alu_req_alu_op2_dut;
	logic [32-1:0] alu_req_alu_res;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.alu_i_valid(alu_i_valid),
		.alu_i_rs1(alu_i_rs1),
		.alu_i_rs2(alu_i_rs2),
		.alu_i_imm(alu_i_imm),
		.alu_i_pc(alu_i_pc),
		.alu_i_info(alu_i_info),
		.alu_o_ready(alu_o_ready),
		.alu_req_alu_res(alu_req_alu_res),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_rglr good1 (
		.alu_i_valid(alu_i_valid),
		.alu_i_ready(alu_i_ready_ref),
		.alu_i_rs1(alu_i_rs1),
		.alu_i_rs2(alu_i_rs2),
		.alu_i_imm(alu_i_imm),
		.alu_i_pc(alu_i_pc),
		.alu_i_info(alu_i_info),
		.alu_o_valid(alu_o_valid_ref),
		.alu_o_ready(alu_o_ready),
		.alu_o_wbck_wdat(alu_o_wbck_wdat_ref),
		.alu_o_wbck_err(alu_o_wbck_err_ref),
		.alu_o_cmt_ecall(alu_o_cmt_ecall_ref),
		.alu_o_cmt_ebreak(alu_o_cmt_ebreak_ref),
		.alu_o_cmt_wfi(alu_o_cmt_wfi_ref),
		.alu_req_alu_add(alu_req_alu_add_ref),
		.alu_req_alu_sub(alu_req_alu_sub_ref),
		.alu_req_alu_xor(alu_req_alu_xor_ref),
		.alu_req_alu_sll(alu_req_alu_sll_ref),
		.alu_req_alu_srl(alu_req_alu_srl_ref),
		.alu_req_alu_sra(alu_req_alu_sra_ref),
		.alu_req_alu_or(alu_req_alu_or_ref),
		.alu_req_alu_and(alu_req_alu_and_ref),
		.alu_req_alu_slt(alu_req_alu_slt_ref),
		.alu_req_alu_sltu(alu_req_alu_sltu_ref),
		.alu_req_alu_lui(alu_req_alu_lui_ref),
		.alu_req_alu_op1(alu_req_alu_op1_ref),
		.alu_req_alu_op2(alu_req_alu_op2_ref),
		.alu_req_alu_res(alu_req_alu_res),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_rglr top_module1 (
		.alu_i_valid(alu_i_valid),
		.alu_i_ready(alu_i_ready_dut),
		.alu_i_rs1(alu_i_rs1),
		.alu_i_rs2(alu_i_rs2),
		.alu_i_imm(alu_i_imm),
		.alu_i_pc(alu_i_pc),
		.alu_i_info(alu_i_info),
		.alu_o_valid(alu_o_valid_dut),
		.alu_o_ready(alu_o_ready),
		.alu_o_wbck_wdat(alu_o_wbck_wdat_dut),
		.alu_o_wbck_err(alu_o_wbck_err_dut),
		.alu_o_cmt_ecall(alu_o_cmt_ecall_dut),
		.alu_o_cmt_ebreak(alu_o_cmt_ebreak_dut),
		.alu_o_cmt_wfi(alu_o_cmt_wfi_dut),
		.alu_req_alu_add(alu_req_alu_add_dut),
		.alu_req_alu_sub(alu_req_alu_sub_dut),
		.alu_req_alu_xor(alu_req_alu_xor_dut),
		.alu_req_alu_sll(alu_req_alu_sll_dut),
		.alu_req_alu_srl(alu_req_alu_srl_dut),
		.alu_req_alu_sra(alu_req_alu_sra_dut),
		.alu_req_alu_or(alu_req_alu_or_dut),
		.alu_req_alu_and(alu_req_alu_and_dut),
		.alu_req_alu_slt(alu_req_alu_slt_dut),
		.alu_req_alu_sltu(alu_req_alu_sltu_dut),
		.alu_req_alu_lui(alu_req_alu_lui_dut),
		.alu_req_alu_op1(alu_req_alu_op1_dut),
		.alu_req_alu_op2(alu_req_alu_op2_dut),
		.alu_req_alu_res(alu_req_alu_res),
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
		if (stats1.errors_alu_i_ready)
			$display("Hint: Output 'alu_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_i_ready, stats1.errortime_alu_i_ready);
		else
			$display("Hint: Output 'alu_i_ready' has no mismatches.");
		if (stats1.errors_alu_o_valid)
			$display("Hint: Output 'alu_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_valid, stats1.errortime_alu_o_valid);
		else
			$display("Hint: Output 'alu_o_valid' has no mismatches.");
		if (stats1.errors_alu_o_wbck_wdat)
			$display("Hint: Output 'alu_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_wbck_wdat, stats1.errortime_alu_o_wbck_wdat);
		else
			$display("Hint: Output 'alu_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_alu_o_wbck_err)
			$display("Hint: Output 'alu_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_wbck_err, stats1.errortime_alu_o_wbck_err);
		else
			$display("Hint: Output 'alu_o_wbck_err' has no mismatches.");
		if (stats1.errors_alu_o_cmt_ecall)
			$display("Hint: Output 'alu_o_cmt_ecall' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_cmt_ecall, stats1.errortime_alu_o_cmt_ecall);
		else
			$display("Hint: Output 'alu_o_cmt_ecall' has no mismatches.");
		if (stats1.errors_alu_o_cmt_ebreak)
			$display("Hint: Output 'alu_o_cmt_ebreak' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_cmt_ebreak, stats1.errortime_alu_o_cmt_ebreak);
		else
			$display("Hint: Output 'alu_o_cmt_ebreak' has no mismatches.");
		if (stats1.errors_alu_o_cmt_wfi)
			$display("Hint: Output 'alu_o_cmt_wfi' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_o_cmt_wfi, stats1.errortime_alu_o_cmt_wfi);
		else
			$display("Hint: Output 'alu_o_cmt_wfi' has no mismatches.");
		if (stats1.errors_alu_req_alu_add)
			$display("Hint: Output 'alu_req_alu_add' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_add, stats1.errortime_alu_req_alu_add);
		else
			$display("Hint: Output 'alu_req_alu_add' has no mismatches.");
		if (stats1.errors_alu_req_alu_sub)
			$display("Hint: Output 'alu_req_alu_sub' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_sub, stats1.errortime_alu_req_alu_sub);
		else
			$display("Hint: Output 'alu_req_alu_sub' has no mismatches.");
		if (stats1.errors_alu_req_alu_xor)
			$display("Hint: Output 'alu_req_alu_xor' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_xor, stats1.errortime_alu_req_alu_xor);
		else
			$display("Hint: Output 'alu_req_alu_xor' has no mismatches.");
		if (stats1.errors_alu_req_alu_sll)
			$display("Hint: Output 'alu_req_alu_sll' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_sll, stats1.errortime_alu_req_alu_sll);
		else
			$display("Hint: Output 'alu_req_alu_sll' has no mismatches.");
		if (stats1.errors_alu_req_alu_srl)
			$display("Hint: Output 'alu_req_alu_srl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_srl, stats1.errortime_alu_req_alu_srl);
		else
			$display("Hint: Output 'alu_req_alu_srl' has no mismatches.");
		if (stats1.errors_alu_req_alu_sra)
			$display("Hint: Output 'alu_req_alu_sra' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_sra, stats1.errortime_alu_req_alu_sra);
		else
			$display("Hint: Output 'alu_req_alu_sra' has no mismatches.");
		if (stats1.errors_alu_req_alu_or)
			$display("Hint: Output 'alu_req_alu_or' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_or, stats1.errortime_alu_req_alu_or);
		else
			$display("Hint: Output 'alu_req_alu_or' has no mismatches.");
		if (stats1.errors_alu_req_alu_and)
			$display("Hint: Output 'alu_req_alu_and' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_and, stats1.errortime_alu_req_alu_and);
		else
			$display("Hint: Output 'alu_req_alu_and' has no mismatches.");
		if (stats1.errors_alu_req_alu_slt)
			$display("Hint: Output 'alu_req_alu_slt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_slt, stats1.errortime_alu_req_alu_slt);
		else
			$display("Hint: Output 'alu_req_alu_slt' has no mismatches.");
		if (stats1.errors_alu_req_alu_sltu)
			$display("Hint: Output 'alu_req_alu_sltu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_sltu, stats1.errortime_alu_req_alu_sltu);
		else
			$display("Hint: Output 'alu_req_alu_sltu' has no mismatches.");
		if (stats1.errors_alu_req_alu_lui)
			$display("Hint: Output 'alu_req_alu_lui' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_lui, stats1.errortime_alu_req_alu_lui);
		else
			$display("Hint: Output 'alu_req_alu_lui' has no mismatches.");
		if (stats1.errors_alu_req_alu_op1)
			$display("Hint: Output 'alu_req_alu_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_op1, stats1.errortime_alu_req_alu_op1);
		else
			$display("Hint: Output 'alu_req_alu_op1' has no mismatches.");
		if (stats1.errors_alu_req_alu_op2)
			$display("Hint: Output 'alu_req_alu_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_req_alu_op2, stats1.errortime_alu_req_alu_op2);
		else
			$display("Hint: Output 'alu_req_alu_op2' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ alu_i_ready_ref,alu_o_valid_ref,alu_o_wbck_wdat_ref,alu_o_wbck_err_ref,alu_o_cmt_ecall_ref,alu_o_cmt_ebreak_ref,alu_o_cmt_wfi_ref,alu_req_alu_add_ref,alu_req_alu_sub_ref,alu_req_alu_xor_ref,alu_req_alu_sll_ref,alu_req_alu_srl_ref,alu_req_alu_sra_ref,alu_req_alu_or_ref,alu_req_alu_and_ref,alu_req_alu_slt_ref,alu_req_alu_sltu_ref,alu_req_alu_lui_ref,alu_req_alu_op1_ref,alu_req_alu_op2_ref} ===
			( { alu_i_ready_ref,alu_o_valid_ref,alu_o_wbck_wdat_ref,alu_o_wbck_err_ref,alu_o_cmt_ecall_ref,alu_o_cmt_ebreak_ref,alu_o_cmt_wfi_ref,alu_req_alu_add_ref,alu_req_alu_sub_ref,alu_req_alu_xor_ref,alu_req_alu_sll_ref,alu_req_alu_srl_ref,alu_req_alu_sra_ref,alu_req_alu_or_ref,alu_req_alu_and_ref,alu_req_alu_slt_ref,alu_req_alu_sltu_ref,alu_req_alu_lui_ref,alu_req_alu_op1_ref,alu_req_alu_op2_ref} ^
			  { alu_i_ready_dut,alu_o_valid_dut,alu_o_wbck_wdat_dut,alu_o_wbck_err_dut,alu_o_cmt_ecall_dut,alu_o_cmt_ebreak_dut,alu_o_cmt_wfi_dut,alu_req_alu_add_dut,alu_req_alu_sub_dut,alu_req_alu_xor_dut,alu_req_alu_sll_dut,alu_req_alu_srl_dut,alu_req_alu_sra_dut,alu_req_alu_or_dut,alu_req_alu_and_dut,alu_req_alu_slt_dut,alu_req_alu_sltu_dut,alu_req_alu_lui_dut,alu_req_alu_op1_dut,alu_req_alu_op2_dut} ^
			  { alu_i_ready_ref,alu_o_valid_ref,alu_o_wbck_wdat_ref,alu_o_wbck_err_ref,alu_o_cmt_ecall_ref,alu_o_cmt_ebreak_ref,alu_o_cmt_wfi_ref,alu_req_alu_add_ref,alu_req_alu_sub_ref,alu_req_alu_xor_ref,alu_req_alu_sll_ref,alu_req_alu_srl_ref,alu_req_alu_sra_ref,alu_req_alu_or_ref,alu_req_alu_and_ref,alu_req_alu_slt_ref,alu_req_alu_sltu_ref,alu_req_alu_lui_ref,alu_req_alu_op1_ref,alu_req_alu_op2_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (alu_i_ready_ref !== (alu_i_ready_ref ^ alu_i_ready_dut ^ alu_i_ready_ref)) begin
			if (stats1.errors_alu_i_ready == 0) stats1.errortime_alu_i_ready = $time;
			stats1.errors_alu_i_ready++;
		end
		if (alu_o_valid_ref !== (alu_o_valid_ref ^ alu_o_valid_dut ^ alu_o_valid_ref)) begin
			if (stats1.errors_alu_o_valid == 0) stats1.errortime_alu_o_valid = $time;
			stats1.errors_alu_o_valid++;
		end
		if (alu_o_wbck_wdat_ref !== (alu_o_wbck_wdat_ref ^ alu_o_wbck_wdat_dut ^ alu_o_wbck_wdat_ref)) begin
			if (stats1.errors_alu_o_wbck_wdat == 0) stats1.errortime_alu_o_wbck_wdat = $time;
			stats1.errors_alu_o_wbck_wdat++;
		end
		if (alu_o_wbck_err_ref !== (alu_o_wbck_err_ref ^ alu_o_wbck_err_dut ^ alu_o_wbck_err_ref)) begin
			if (stats1.errors_alu_o_wbck_err == 0) stats1.errortime_alu_o_wbck_err = $time;
			stats1.errors_alu_o_wbck_err++;
		end
		if (alu_o_cmt_ecall_ref !== (alu_o_cmt_ecall_ref ^ alu_o_cmt_ecall_dut ^ alu_o_cmt_ecall_ref)) begin
			if (stats1.errors_alu_o_cmt_ecall == 0) stats1.errortime_alu_o_cmt_ecall = $time;
			stats1.errors_alu_o_cmt_ecall++;
		end
		if (alu_o_cmt_ebreak_ref !== (alu_o_cmt_ebreak_ref ^ alu_o_cmt_ebreak_dut ^ alu_o_cmt_ebreak_ref)) begin
			if (stats1.errors_alu_o_cmt_ebreak == 0) stats1.errortime_alu_o_cmt_ebreak = $time;
			stats1.errors_alu_o_cmt_ebreak++;
		end
		if (alu_o_cmt_wfi_ref !== (alu_o_cmt_wfi_ref ^ alu_o_cmt_wfi_dut ^ alu_o_cmt_wfi_ref)) begin
			if (stats1.errors_alu_o_cmt_wfi == 0) stats1.errortime_alu_o_cmt_wfi = $time;
			stats1.errors_alu_o_cmt_wfi++;
		end
		if (alu_req_alu_add_ref !== (alu_req_alu_add_ref ^ alu_req_alu_add_dut ^ alu_req_alu_add_ref)) begin
			if (stats1.errors_alu_req_alu_add == 0) stats1.errortime_alu_req_alu_add = $time;
			stats1.errors_alu_req_alu_add++;
		end
		if (alu_req_alu_sub_ref !== (alu_req_alu_sub_ref ^ alu_req_alu_sub_dut ^ alu_req_alu_sub_ref)) begin
			if (stats1.errors_alu_req_alu_sub == 0) stats1.errortime_alu_req_alu_sub = $time;
			stats1.errors_alu_req_alu_sub++;
		end
		if (alu_req_alu_xor_ref !== (alu_req_alu_xor_ref ^ alu_req_alu_xor_dut ^ alu_req_alu_xor_ref)) begin
			if (stats1.errors_alu_req_alu_xor == 0) stats1.errortime_alu_req_alu_xor = $time;
			stats1.errors_alu_req_alu_xor++;
		end
		if (alu_req_alu_sll_ref !== (alu_req_alu_sll_ref ^ alu_req_alu_sll_dut ^ alu_req_alu_sll_ref)) begin
			if (stats1.errors_alu_req_alu_sll == 0) stats1.errortime_alu_req_alu_sll = $time;
			stats1.errors_alu_req_alu_sll++;
		end
		if (alu_req_alu_srl_ref !== (alu_req_alu_srl_ref ^ alu_req_alu_srl_dut ^ alu_req_alu_srl_ref)) begin
			if (stats1.errors_alu_req_alu_srl == 0) stats1.errortime_alu_req_alu_srl = $time;
			stats1.errors_alu_req_alu_srl++;
		end
		if (alu_req_alu_sra_ref !== (alu_req_alu_sra_ref ^ alu_req_alu_sra_dut ^ alu_req_alu_sra_ref)) begin
			if (stats1.errors_alu_req_alu_sra == 0) stats1.errortime_alu_req_alu_sra = $time;
			stats1.errors_alu_req_alu_sra++;
		end
		if (alu_req_alu_or_ref !== (alu_req_alu_or_ref ^ alu_req_alu_or_dut ^ alu_req_alu_or_ref)) begin
			if (stats1.errors_alu_req_alu_or == 0) stats1.errortime_alu_req_alu_or = $time;
			stats1.errors_alu_req_alu_or++;
		end
		if (alu_req_alu_and_ref !== (alu_req_alu_and_ref ^ alu_req_alu_and_dut ^ alu_req_alu_and_ref)) begin
			if (stats1.errors_alu_req_alu_and == 0) stats1.errortime_alu_req_alu_and = $time;
			stats1.errors_alu_req_alu_and++;
		end
		if (alu_req_alu_slt_ref !== (alu_req_alu_slt_ref ^ alu_req_alu_slt_dut ^ alu_req_alu_slt_ref)) begin
			if (stats1.errors_alu_req_alu_slt == 0) stats1.errortime_alu_req_alu_slt = $time;
			stats1.errors_alu_req_alu_slt++;
		end
		if (alu_req_alu_sltu_ref !== (alu_req_alu_sltu_ref ^ alu_req_alu_sltu_dut ^ alu_req_alu_sltu_ref)) begin
			if (stats1.errors_alu_req_alu_sltu == 0) stats1.errortime_alu_req_alu_sltu = $time;
			stats1.errors_alu_req_alu_sltu++;
		end
		if (alu_req_alu_lui_ref !== (alu_req_alu_lui_ref ^ alu_req_alu_lui_dut ^ alu_req_alu_lui_ref)) begin
			if (stats1.errors_alu_req_alu_lui == 0) stats1.errortime_alu_req_alu_lui = $time;
			stats1.errors_alu_req_alu_lui++;
		end
		if (alu_req_alu_op1_ref !== (alu_req_alu_op1_ref ^ alu_req_alu_op1_dut ^ alu_req_alu_op1_ref)) begin
			if (stats1.errors_alu_req_alu_op1 == 0) stats1.errortime_alu_req_alu_op1 = $time;
			stats1.errors_alu_req_alu_op1++;
		end
		if (alu_req_alu_op2_ref !== (alu_req_alu_op2_ref ^ alu_req_alu_op2_dut ^ alu_req_alu_op2_ref)) begin
			if (stats1.errors_alu_req_alu_op2 == 0) stats1.errortime_alu_req_alu_op2 = $time;
			stats1.errors_alu_req_alu_op2++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
