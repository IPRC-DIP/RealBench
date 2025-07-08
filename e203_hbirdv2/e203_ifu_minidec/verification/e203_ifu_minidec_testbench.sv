`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_dec_rs1en;
		int errortime_dec_rs1en;
		int errors_dec_rs2en;
		int errortime_dec_rs2en;
		int errors_dec_rs1idx;
		int errortime_dec_rs1idx;
		int errors_dec_rs2idx;
		int errortime_dec_rs2idx;
		int errors_dec_mulhsu;
		int errortime_dec_mulhsu;
		int errors_dec_mul;
		int errortime_dec_mul;
		int errors_dec_div;
		int errortime_dec_div;
		int errors_dec_rem;
		int errortime_dec_rem;
		int errors_dec_divu;
		int errortime_dec_divu;
		int errors_dec_remu;
		int errortime_dec_remu;
		int errors_dec_rv32;
		int errortime_dec_rv32;
		int errors_dec_bjp;
		int errortime_dec_bjp;
		int errors_dec_jal;
		int errortime_dec_jal;
		int errors_dec_jalr;
		int errortime_dec_jalr;
		int errors_dec_bxx;
		int errortime_dec_bxx;
		int errors_dec_jalr_rs1idx;
		int errortime_dec_jalr_rs1idx;
		int errors_dec_bjp_imm;
		int errortime_dec_bjp_imm;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [32-1:0] instr;
	logic dec_rs1en_ref;
	logic dec_rs1en_dut;
	logic dec_rs2en_ref;
	logic dec_rs2en_dut;
	logic [5-1:0] dec_rs1idx_ref;
	logic [5-1:0] dec_rs1idx_dut;
	logic [5-1:0] dec_rs2idx_ref;
	logic [5-1:0] dec_rs2idx_dut;
	logic dec_mulhsu_ref;
	logic dec_mulhsu_dut;
	logic dec_mul_ref;
	logic dec_mul_dut;
	logic dec_div_ref;
	logic dec_div_dut;
	logic dec_rem_ref;
	logic dec_rem_dut;
	logic dec_divu_ref;
	logic dec_divu_dut;
	logic dec_remu_ref;
	logic dec_remu_dut;
	logic dec_rv32_ref;
	logic dec_rv32_dut;
	logic dec_bjp_ref;
	logic dec_bjp_dut;
	logic dec_jal_ref;
	logic dec_jal_dut;
	logic dec_jalr_ref;
	logic dec_jalr_dut;
	logic dec_bxx_ref;
	logic dec_bxx_dut;
	logic [5-1:0] dec_jalr_rs1idx_ref;
	logic [5-1:0] dec_jalr_rs1idx_dut;
	logic [32-1:0] dec_bjp_imm_ref;
	logic [32-1:0] dec_bjp_imm_dut;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.instr(instr),
		.clk(clk),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_ifu_minidec good1 (
		.instr(instr),
		.dec_rs1en(dec_rs1en_ref),
		.dec_rs2en(dec_rs2en_ref),
		.dec_rs1idx(dec_rs1idx_ref),
		.dec_rs2idx(dec_rs2idx_ref),
		.dec_mulhsu(dec_mulhsu_ref),
		.dec_mul(dec_mul_ref),
		.dec_div(dec_div_ref),
		.dec_rem(dec_rem_ref),
		.dec_divu(dec_divu_ref),
		.dec_remu(dec_remu_ref),
		.dec_rv32(dec_rv32_ref),
		.dec_bjp(dec_bjp_ref),
		.dec_jal(dec_jal_ref),
		.dec_jalr(dec_jalr_ref),
		.dec_bxx(dec_bxx_ref),
		.dec_jalr_rs1idx(dec_jalr_rs1idx_ref),
		.dec_bjp_imm(dec_bjp_imm_ref)
	);
       
    // 实例化待测模块
	e203_ifu_minidec top_module1 (
		.instr(instr),
		.dec_rs1en(dec_rs1en_dut),
		.dec_rs2en(dec_rs2en_dut),
		.dec_rs1idx(dec_rs1idx_dut),
		.dec_rs2idx(dec_rs2idx_dut),
		.dec_mulhsu(dec_mulhsu_dut),
		.dec_mul(dec_mul_dut),
		.dec_div(dec_div_dut),
		.dec_rem(dec_rem_dut),
		.dec_divu(dec_divu_dut),
		.dec_remu(dec_remu_dut),
		.dec_rv32(dec_rv32_dut),
		.dec_bjp(dec_bjp_dut),
		.dec_jal(dec_jal_dut),
		.dec_jalr(dec_jalr_dut),
		.dec_bxx(dec_bxx_dut),
		.dec_jalr_rs1idx(dec_jalr_rs1idx_dut),
		.dec_bjp_imm(dec_bjp_imm_dut)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_dec_rs1en)
			$display("Hint: Output 'dec_rs1en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rs1en, stats1.errortime_dec_rs1en);
		else
			$display("Hint: Output 'dec_rs1en' has no mismatches.");
		if (stats1.errors_dec_rs2en)
			$display("Hint: Output 'dec_rs2en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rs2en, stats1.errortime_dec_rs2en);
		else
			$display("Hint: Output 'dec_rs2en' has no mismatches.");
		if (stats1.errors_dec_rs1idx)
			$display("Hint: Output 'dec_rs1idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rs1idx, stats1.errortime_dec_rs1idx);
		else
			$display("Hint: Output 'dec_rs1idx' has no mismatches.");
		if (stats1.errors_dec_rs2idx)
			$display("Hint: Output 'dec_rs2idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rs2idx, stats1.errortime_dec_rs2idx);
		else
			$display("Hint: Output 'dec_rs2idx' has no mismatches.");
		if (stats1.errors_dec_mulhsu)
			$display("Hint: Output 'dec_mulhsu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_mulhsu, stats1.errortime_dec_mulhsu);
		else
			$display("Hint: Output 'dec_mulhsu' has no mismatches.");
		if (stats1.errors_dec_mul)
			$display("Hint: Output 'dec_mul' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_mul, stats1.errortime_dec_mul);
		else
			$display("Hint: Output 'dec_mul' has no mismatches.");
		if (stats1.errors_dec_div)
			$display("Hint: Output 'dec_div' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_div, stats1.errortime_dec_div);
		else
			$display("Hint: Output 'dec_div' has no mismatches.");
		if (stats1.errors_dec_rem)
			$display("Hint: Output 'dec_rem' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rem, stats1.errortime_dec_rem);
		else
			$display("Hint: Output 'dec_rem' has no mismatches.");
		if (stats1.errors_dec_divu)
			$display("Hint: Output 'dec_divu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_divu, stats1.errortime_dec_divu);
		else
			$display("Hint: Output 'dec_divu' has no mismatches.");
		if (stats1.errors_dec_remu)
			$display("Hint: Output 'dec_remu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_remu, stats1.errortime_dec_remu);
		else
			$display("Hint: Output 'dec_remu' has no mismatches.");
		if (stats1.errors_dec_rv32)
			$display("Hint: Output 'dec_rv32' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_rv32, stats1.errortime_dec_rv32);
		else
			$display("Hint: Output 'dec_rv32' has no mismatches.");
		if (stats1.errors_dec_bjp)
			$display("Hint: Output 'dec_bjp' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_bjp, stats1.errortime_dec_bjp);
		else
			$display("Hint: Output 'dec_bjp' has no mismatches.");
		if (stats1.errors_dec_jal)
			$display("Hint: Output 'dec_jal' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_jal, stats1.errortime_dec_jal);
		else
			$display("Hint: Output 'dec_jal' has no mismatches.");
		if (stats1.errors_dec_jalr)
			$display("Hint: Output 'dec_jalr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_jalr, stats1.errortime_dec_jalr);
		else
			$display("Hint: Output 'dec_jalr' has no mismatches.");
		if (stats1.errors_dec_bxx)
			$display("Hint: Output 'dec_bxx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_bxx, stats1.errortime_dec_bxx);
		else
			$display("Hint: Output 'dec_bxx' has no mismatches.");
		if (stats1.errors_dec_jalr_rs1idx)
			$display("Hint: Output 'dec_jalr_rs1idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_jalr_rs1idx, stats1.errortime_dec_jalr_rs1idx);
		else
			$display("Hint: Output 'dec_jalr_rs1idx' has no mismatches.");
		if (stats1.errors_dec_bjp_imm)
			$display("Hint: Output 'dec_bjp_imm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec_bjp_imm, stats1.errortime_dec_bjp_imm);
		else
			$display("Hint: Output 'dec_bjp_imm' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ dec_rs1en_ref,dec_rs2en_ref,dec_rs1idx_ref,dec_rs2idx_ref,dec_mulhsu_ref,dec_mul_ref,dec_div_ref,dec_rem_ref,dec_divu_ref,dec_remu_ref,dec_rv32_ref,dec_bjp_ref,dec_jal_ref,dec_jalr_ref,dec_bxx_ref,dec_jalr_rs1idx_ref,dec_bjp_imm_ref} ===
			( { dec_rs1en_ref,dec_rs2en_ref,dec_rs1idx_ref,dec_rs2idx_ref,dec_mulhsu_ref,dec_mul_ref,dec_div_ref,dec_rem_ref,dec_divu_ref,dec_remu_ref,dec_rv32_ref,dec_bjp_ref,dec_jal_ref,dec_jalr_ref,dec_bxx_ref,dec_jalr_rs1idx_ref,dec_bjp_imm_ref} ^
			  { dec_rs1en_dut,dec_rs2en_dut,dec_rs1idx_dut,dec_rs2idx_dut,dec_mulhsu_dut,dec_mul_dut,dec_div_dut,dec_rem_dut,dec_divu_dut,dec_remu_dut,dec_rv32_dut,dec_bjp_dut,dec_jal_dut,dec_jalr_dut,dec_bxx_dut,dec_jalr_rs1idx_dut,dec_bjp_imm_dut} ^
			  { dec_rs1en_ref,dec_rs2en_ref,dec_rs1idx_ref,dec_rs2idx_ref,dec_mulhsu_ref,dec_mul_ref,dec_div_ref,dec_rem_ref,dec_divu_ref,dec_remu_ref,dec_rv32_ref,dec_bjp_ref,dec_jal_ref,dec_jalr_ref,dec_bxx_ref,dec_jalr_rs1idx_ref,dec_bjp_imm_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (dec_rs1en_ref !== (dec_rs1en_ref ^ dec_rs1en_dut ^ dec_rs1en_ref)) begin
			if (stats1.errors_dec_rs1en == 0) stats1.errortime_dec_rs1en = $time;
			stats1.errors_dec_rs1en++;
		end
		if (dec_rs2en_ref !== (dec_rs2en_ref ^ dec_rs2en_dut ^ dec_rs2en_ref)) begin
			if (stats1.errors_dec_rs2en == 0) stats1.errortime_dec_rs2en = $time;
			stats1.errors_dec_rs2en++;
		end
		if (dec_rs1idx_ref !== (dec_rs1idx_ref ^ dec_rs1idx_dut ^ dec_rs1idx_ref)) begin
			if (stats1.errors_dec_rs1idx == 0) stats1.errortime_dec_rs1idx = $time;
			stats1.errors_dec_rs1idx++;
		end
		if (dec_rs2idx_ref !== (dec_rs2idx_ref ^ dec_rs2idx_dut ^ dec_rs2idx_ref)) begin
			if (stats1.errors_dec_rs2idx == 0) stats1.errortime_dec_rs2idx = $time;
			stats1.errors_dec_rs2idx++;
		end
		if (dec_mulhsu_ref !== (dec_mulhsu_ref ^ dec_mulhsu_dut ^ dec_mulhsu_ref)) begin
			if (stats1.errors_dec_mulhsu == 0) stats1.errortime_dec_mulhsu = $time;
			stats1.errors_dec_mulhsu++;
		end
		if (dec_mul_ref !== (dec_mul_ref ^ dec_mul_dut ^ dec_mul_ref)) begin
			if (stats1.errors_dec_mul == 0) stats1.errortime_dec_mul = $time;
			stats1.errors_dec_mul++;
		end
		if (dec_div_ref !== (dec_div_ref ^ dec_div_dut ^ dec_div_ref)) begin
			if (stats1.errors_dec_div == 0) stats1.errortime_dec_div = $time;
			stats1.errors_dec_div++;
		end
		if (dec_rem_ref !== (dec_rem_ref ^ dec_rem_dut ^ dec_rem_ref)) begin
			if (stats1.errors_dec_rem == 0) stats1.errortime_dec_rem = $time;
			stats1.errors_dec_rem++;
		end
		if (dec_divu_ref !== (dec_divu_ref ^ dec_divu_dut ^ dec_divu_ref)) begin
			if (stats1.errors_dec_divu == 0) stats1.errortime_dec_divu = $time;
			stats1.errors_dec_divu++;
		end
		if (dec_remu_ref !== (dec_remu_ref ^ dec_remu_dut ^ dec_remu_ref)) begin
			if (stats1.errors_dec_remu == 0) stats1.errortime_dec_remu = $time;
			stats1.errors_dec_remu++;
		end
		if (dec_rv32_ref !== (dec_rv32_ref ^ dec_rv32_dut ^ dec_rv32_ref)) begin
			if (stats1.errors_dec_rv32 == 0) stats1.errortime_dec_rv32 = $time;
			stats1.errors_dec_rv32++;
		end
		if (dec_bjp_ref !== (dec_bjp_ref ^ dec_bjp_dut ^ dec_bjp_ref)) begin
			if (stats1.errors_dec_bjp == 0) stats1.errortime_dec_bjp = $time;
			stats1.errors_dec_bjp++;
		end
		if (dec_jal_ref !== (dec_jal_ref ^ dec_jal_dut ^ dec_jal_ref)) begin
			if (stats1.errors_dec_jal == 0) stats1.errortime_dec_jal = $time;
			stats1.errors_dec_jal++;
		end
		if (dec_jalr_ref !== (dec_jalr_ref ^ dec_jalr_dut ^ dec_jalr_ref)) begin
			if (stats1.errors_dec_jalr == 0) stats1.errortime_dec_jalr = $time;
			stats1.errors_dec_jalr++;
		end
		if (dec_bxx_ref !== (dec_bxx_ref ^ dec_bxx_dut ^ dec_bxx_ref)) begin
			if (stats1.errors_dec_bxx == 0) stats1.errortime_dec_bxx = $time;
			stats1.errors_dec_bxx++;
		end
		if (dec_jalr_rs1idx_ref !== (dec_jalr_rs1idx_ref ^ dec_jalr_rs1idx_dut ^ dec_jalr_rs1idx_ref)) begin
			if (stats1.errors_dec_jalr_rs1idx == 0) stats1.errortime_dec_jalr_rs1idx = $time;
			stats1.errors_dec_jalr_rs1idx++;
		end
		if (dec_bjp_imm_ref !== (dec_bjp_imm_ref ^ dec_bjp_imm_dut ^ dec_bjp_imm_ref)) begin
			if (stats1.errors_dec_bjp_imm == 0) stats1.errortime_dec_bjp_imm = $time;
			stats1.errors_dec_bjp_imm++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
