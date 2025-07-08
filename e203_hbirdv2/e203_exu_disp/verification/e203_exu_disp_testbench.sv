`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_wfi_halt_exu_ack;
		int errortime_wfi_halt_exu_ack;
		int errors_disp_i_ready;
		int errortime_disp_i_ready;
		int errors_disp_o_alu_valid;
		int errortime_disp_o_alu_valid;
		int errors_disp_o_alu_rs1;
		int errortime_disp_o_alu_rs1;
		int errors_disp_o_alu_rs2;
		int errortime_disp_o_alu_rs2;
		int errors_disp_o_alu_rdwen;
		int errortime_disp_o_alu_rdwen;
		int errors_disp_o_alu_rdidx;
		int errortime_disp_o_alu_rdidx;
		int errors_disp_o_alu_info;
		int errortime_disp_o_alu_info;
		int errors_disp_o_alu_imm;
		int errortime_disp_o_alu_imm;
		int errors_disp_o_alu_pc;
		int errortime_disp_o_alu_pc;
		int errors_disp_o_alu_itag;
		int errortime_disp_o_alu_itag;
		int errors_disp_o_alu_misalgn;
		int errortime_disp_o_alu_misalgn;
		int errors_disp_o_alu_buserr;
		int errortime_disp_o_alu_buserr;
		int errors_disp_o_alu_ilegl;
		int errortime_disp_o_alu_ilegl;
		int errors_disp_oitf_ena;
		int errortime_disp_oitf_ena;
		int errors_disp_oitf_rs1fpu;
		int errortime_disp_oitf_rs1fpu;
		int errors_disp_oitf_rs2fpu;
		int errortime_disp_oitf_rs2fpu;
		int errors_disp_oitf_rs3fpu;
		int errortime_disp_oitf_rs3fpu;
		int errors_disp_oitf_rdfpu;
		int errortime_disp_oitf_rdfpu;
		int errors_disp_oitf_rs1en;
		int errortime_disp_oitf_rs1en;
		int errors_disp_oitf_rs2en;
		int errortime_disp_oitf_rs2en;
		int errors_disp_oitf_rs3en;
		int errortime_disp_oitf_rs3en;
		int errors_disp_oitf_rdwen;
		int errortime_disp_oitf_rdwen;
		int errors_disp_oitf_rs1idx;
		int errortime_disp_oitf_rs1idx;
		int errors_disp_oitf_rs2idx;
		int errortime_disp_oitf_rs2idx;
		int errors_disp_oitf_rs3idx;
		int errortime_disp_oitf_rs3idx;
		int errors_disp_oitf_rdidx;
		int errortime_disp_oitf_rdidx;
		int errors_disp_oitf_pc;
		int errortime_disp_oitf_pc;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic wfi_halt_exu_req;
	logic wfi_halt_exu_ack_ref;
	logic wfi_halt_exu_ack_dut;
	logic oitf_empty;
	logic amo_wait;
	logic disp_i_valid;
	logic disp_i_ready_ref;
	logic disp_i_ready_dut;
	logic disp_i_rs1x0;
	logic disp_i_rs2x0;
	logic disp_i_rs1en;
	logic disp_i_rs2en;
	logic [5-1:0] disp_i_rs1idx;
	logic [5-1:0] disp_i_rs2idx;
	logic [32-1:0] disp_i_rs1;
	logic [32-1:0] disp_i_rs2;
	logic disp_i_rdwen;
	logic [5-1:0] disp_i_rdidx;
	logic [32-1:0] disp_i_info;
	logic [32-1:0] disp_i_imm;
	logic [32-1:0] disp_i_pc;
	logic disp_i_misalgn;
	logic disp_i_buserr;
	logic disp_i_ilegl;
	logic disp_o_alu_valid_ref;
	logic disp_o_alu_valid_dut;
	logic disp_o_alu_ready;
	logic disp_o_alu_longpipe;
	logic [32-1:0] disp_o_alu_rs1_ref;
	logic [32-1:0] disp_o_alu_rs1_dut;
	logic [32-1:0] disp_o_alu_rs2_ref;
	logic [32-1:0] disp_o_alu_rs2_dut;
	logic disp_o_alu_rdwen_ref;
	logic disp_o_alu_rdwen_dut;
	logic [5-1:0] disp_o_alu_rdidx_ref;
	logic [5-1:0] disp_o_alu_rdidx_dut;
	logic [32-1:0] disp_o_alu_info_ref;
	logic [32-1:0] disp_o_alu_info_dut;
	logic [32-1:0] disp_o_alu_imm_ref;
	logic [32-1:0] disp_o_alu_imm_dut;
	logic [32-1:0] disp_o_alu_pc_ref;
	logic [32-1:0] disp_o_alu_pc_dut;
	logic disp_o_alu_itag_ref;
	logic disp_o_alu_itag_dut;
	logic disp_o_alu_misalgn_ref;
	logic disp_o_alu_misalgn_dut;
	logic disp_o_alu_buserr_ref;
	logic disp_o_alu_buserr_dut;
	logic disp_o_alu_ilegl_ref;
	logic disp_o_alu_ilegl_dut;
	logic oitfrd_match_disprs1;
	logic oitfrd_match_disprs2;
	logic oitfrd_match_disprs3;
	logic oitfrd_match_disprd;
	logic disp_oitf_ptr;
	logic disp_oitf_ena_ref;
	logic disp_oitf_ena_dut;
	logic disp_oitf_ready;
	logic disp_oitf_rs1fpu_ref;
	logic disp_oitf_rs1fpu_dut;
	logic disp_oitf_rs2fpu_ref;
	logic disp_oitf_rs2fpu_dut;
	logic disp_oitf_rs3fpu_ref;
	logic disp_oitf_rs3fpu_dut;
	logic disp_oitf_rdfpu_ref;
	logic disp_oitf_rdfpu_dut;
	logic disp_oitf_rs1en_ref;
	logic disp_oitf_rs1en_dut;
	logic disp_oitf_rs2en_ref;
	logic disp_oitf_rs2en_dut;
	logic disp_oitf_rs3en_ref;
	logic disp_oitf_rs3en_dut;
	logic disp_oitf_rdwen_ref;
	logic disp_oitf_rdwen_dut;
	logic [5-1:0] disp_oitf_rs1idx_ref;
	logic [5-1:0] disp_oitf_rs1idx_dut;
	logic [5-1:0] disp_oitf_rs2idx_ref;
	logic [5-1:0] disp_oitf_rs2idx_dut;
	logic [5-1:0] disp_oitf_rs3idx_ref;
	logic [5-1:0] disp_oitf_rs3idx_dut;
	logic [5-1:0] disp_oitf_rdidx_ref;
	logic [5-1:0] disp_oitf_rdidx_dut;
	logic [32-1:0] disp_oitf_pc_ref;
	logic [32-1:0] disp_oitf_pc_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.wfi_halt_exu_req(wfi_halt_exu_req),
		.oitf_empty(oitf_empty),
		.amo_wait(amo_wait),
		.disp_i_valid(disp_i_valid),
		.disp_i_rs1x0(disp_i_rs1x0),
		.disp_i_rs2x0(disp_i_rs2x0),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs1(disp_i_rs1),
		.disp_i_rs2(disp_i_rs2),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_info(disp_i_info),
		.disp_i_imm(disp_i_imm),
		.disp_i_pc(disp_i_pc),
		.disp_i_misalgn(disp_i_misalgn),
		.disp_i_buserr(disp_i_buserr),
		.disp_i_ilegl(disp_i_ilegl),
		.disp_o_alu_ready(disp_o_alu_ready),
		.disp_o_alu_longpipe(disp_o_alu_longpipe),
		.oitfrd_match_disprs1(oitfrd_match_disprs1),
		.oitfrd_match_disprs2(oitfrd_match_disprs2),
		.oitfrd_match_disprs3(oitfrd_match_disprs3),
		.oitfrd_match_disprd(oitfrd_match_disprd),
		.disp_oitf_ptr(disp_oitf_ptr),
		.disp_oitf_ready(disp_oitf_ready),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_disp good1 (
		.wfi_halt_exu_req(wfi_halt_exu_req),
		.wfi_halt_exu_ack(wfi_halt_exu_ack_ref),
		.oitf_empty(oitf_empty),
		.amo_wait(amo_wait),
		.disp_i_valid(disp_i_valid),
		.disp_i_ready(disp_i_ready_ref),
		.disp_i_rs1x0(disp_i_rs1x0),
		.disp_i_rs2x0(disp_i_rs2x0),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs1(disp_i_rs1),
		.disp_i_rs2(disp_i_rs2),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_info(disp_i_info),
		.disp_i_imm(disp_i_imm),
		.disp_i_pc(disp_i_pc),
		.disp_i_misalgn(disp_i_misalgn),
		.disp_i_buserr(disp_i_buserr),
		.disp_i_ilegl(disp_i_ilegl),
		.disp_o_alu_valid(disp_o_alu_valid_ref),
		.disp_o_alu_ready(disp_o_alu_ready),
		.disp_o_alu_longpipe(disp_o_alu_longpipe),
		.disp_o_alu_rs1(disp_o_alu_rs1_ref),
		.disp_o_alu_rs2(disp_o_alu_rs2_ref),
		.disp_o_alu_rdwen(disp_o_alu_rdwen_ref),
		.disp_o_alu_rdidx(disp_o_alu_rdidx_ref),
		.disp_o_alu_info(disp_o_alu_info_ref),
		.disp_o_alu_imm(disp_o_alu_imm_ref),
		.disp_o_alu_pc(disp_o_alu_pc_ref),
		.disp_o_alu_itag(disp_o_alu_itag_ref),
		.disp_o_alu_misalgn(disp_o_alu_misalgn_ref),
		.disp_o_alu_buserr(disp_o_alu_buserr_ref),
		.disp_o_alu_ilegl(disp_o_alu_ilegl_ref),
		.oitfrd_match_disprs1(oitfrd_match_disprs1),
		.oitfrd_match_disprs2(oitfrd_match_disprs2),
		.oitfrd_match_disprs3(oitfrd_match_disprs3),
		.oitfrd_match_disprd(oitfrd_match_disprd),
		.disp_oitf_ptr(disp_oitf_ptr),
		.disp_oitf_ena(disp_oitf_ena_ref),
		.disp_oitf_ready(disp_oitf_ready),
		.disp_oitf_rs1fpu(disp_oitf_rs1fpu_ref),
		.disp_oitf_rs2fpu(disp_oitf_rs2fpu_ref),
		.disp_oitf_rs3fpu(disp_oitf_rs3fpu_ref),
		.disp_oitf_rdfpu(disp_oitf_rdfpu_ref),
		.disp_oitf_rs1en(disp_oitf_rs1en_ref),
		.disp_oitf_rs2en(disp_oitf_rs2en_ref),
		.disp_oitf_rs3en(disp_oitf_rs3en_ref),
		.disp_oitf_rdwen(disp_oitf_rdwen_ref),
		.disp_oitf_rs1idx(disp_oitf_rs1idx_ref),
		.disp_oitf_rs2idx(disp_oitf_rs2idx_ref),
		.disp_oitf_rs3idx(disp_oitf_rs3idx_ref),
		.disp_oitf_rdidx(disp_oitf_rdidx_ref),
		.disp_oitf_pc(disp_oitf_pc_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_disp top_module1 (
		.wfi_halt_exu_req(wfi_halt_exu_req),
		.wfi_halt_exu_ack(wfi_halt_exu_ack_dut),
		.oitf_empty(oitf_empty),
		.amo_wait(amo_wait),
		.disp_i_valid(disp_i_valid),
		.disp_i_ready(disp_i_ready_dut),
		.disp_i_rs1x0(disp_i_rs1x0),
		.disp_i_rs2x0(disp_i_rs2x0),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs1(disp_i_rs1),
		.disp_i_rs2(disp_i_rs2),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_info(disp_i_info),
		.disp_i_imm(disp_i_imm),
		.disp_i_pc(disp_i_pc),
		.disp_i_misalgn(disp_i_misalgn),
		.disp_i_buserr(disp_i_buserr),
		.disp_i_ilegl(disp_i_ilegl),
		.disp_o_alu_valid(disp_o_alu_valid_dut),
		.disp_o_alu_ready(disp_o_alu_ready),
		.disp_o_alu_longpipe(disp_o_alu_longpipe),
		.disp_o_alu_rs1(disp_o_alu_rs1_dut),
		.disp_o_alu_rs2(disp_o_alu_rs2_dut),
		.disp_o_alu_rdwen(disp_o_alu_rdwen_dut),
		.disp_o_alu_rdidx(disp_o_alu_rdidx_dut),
		.disp_o_alu_info(disp_o_alu_info_dut),
		.disp_o_alu_imm(disp_o_alu_imm_dut),
		.disp_o_alu_pc(disp_o_alu_pc_dut),
		.disp_o_alu_itag(disp_o_alu_itag_dut),
		.disp_o_alu_misalgn(disp_o_alu_misalgn_dut),
		.disp_o_alu_buserr(disp_o_alu_buserr_dut),
		.disp_o_alu_ilegl(disp_o_alu_ilegl_dut),
		.oitfrd_match_disprs1(oitfrd_match_disprs1),
		.oitfrd_match_disprs2(oitfrd_match_disprs2),
		.oitfrd_match_disprs3(oitfrd_match_disprs3),
		.oitfrd_match_disprd(oitfrd_match_disprd),
		.disp_oitf_ptr(disp_oitf_ptr),
		.disp_oitf_ena(disp_oitf_ena_dut),
		.disp_oitf_ready(disp_oitf_ready),
		.disp_oitf_rs1fpu(disp_oitf_rs1fpu_dut),
		.disp_oitf_rs2fpu(disp_oitf_rs2fpu_dut),
		.disp_oitf_rs3fpu(disp_oitf_rs3fpu_dut),
		.disp_oitf_rdfpu(disp_oitf_rdfpu_dut),
		.disp_oitf_rs1en(disp_oitf_rs1en_dut),
		.disp_oitf_rs2en(disp_oitf_rs2en_dut),
		.disp_oitf_rs3en(disp_oitf_rs3en_dut),
		.disp_oitf_rdwen(disp_oitf_rdwen_dut),
		.disp_oitf_rs1idx(disp_oitf_rs1idx_dut),
		.disp_oitf_rs2idx(disp_oitf_rs2idx_dut),
		.disp_oitf_rs3idx(disp_oitf_rs3idx_dut),
		.disp_oitf_rdidx(disp_oitf_rdidx_dut),
		.disp_oitf_pc(disp_oitf_pc_dut),
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
		if (stats1.errors_wfi_halt_exu_ack)
			$display("Hint: Output 'wfi_halt_exu_ack' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wfi_halt_exu_ack, stats1.errortime_wfi_halt_exu_ack);
		else
			$display("Hint: Output 'wfi_halt_exu_ack' has no mismatches.");
		if (stats1.errors_disp_i_ready)
			$display("Hint: Output 'disp_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_i_ready, stats1.errortime_disp_i_ready);
		else
			$display("Hint: Output 'disp_i_ready' has no mismatches.");
		if (stats1.errors_disp_o_alu_valid)
			$display("Hint: Output 'disp_o_alu_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_valid, stats1.errortime_disp_o_alu_valid);
		else
			$display("Hint: Output 'disp_o_alu_valid' has no mismatches.");
		if (stats1.errors_disp_o_alu_rs1)
			$display("Hint: Output 'disp_o_alu_rs1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_rs1, stats1.errortime_disp_o_alu_rs1);
		else
			$display("Hint: Output 'disp_o_alu_rs1' has no mismatches.");
		if (stats1.errors_disp_o_alu_rs2)
			$display("Hint: Output 'disp_o_alu_rs2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_rs2, stats1.errortime_disp_o_alu_rs2);
		else
			$display("Hint: Output 'disp_o_alu_rs2' has no mismatches.");
		if (stats1.errors_disp_o_alu_rdwen)
			$display("Hint: Output 'disp_o_alu_rdwen' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_rdwen, stats1.errortime_disp_o_alu_rdwen);
		else
			$display("Hint: Output 'disp_o_alu_rdwen' has no mismatches.");
		if (stats1.errors_disp_o_alu_rdidx)
			$display("Hint: Output 'disp_o_alu_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_rdidx, stats1.errortime_disp_o_alu_rdidx);
		else
			$display("Hint: Output 'disp_o_alu_rdidx' has no mismatches.");
		if (stats1.errors_disp_o_alu_info)
			$display("Hint: Output 'disp_o_alu_info' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_info, stats1.errortime_disp_o_alu_info);
		else
			$display("Hint: Output 'disp_o_alu_info' has no mismatches.");
		if (stats1.errors_disp_o_alu_imm)
			$display("Hint: Output 'disp_o_alu_imm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_imm, stats1.errortime_disp_o_alu_imm);
		else
			$display("Hint: Output 'disp_o_alu_imm' has no mismatches.");
		if (stats1.errors_disp_o_alu_pc)
			$display("Hint: Output 'disp_o_alu_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_pc, stats1.errortime_disp_o_alu_pc);
		else
			$display("Hint: Output 'disp_o_alu_pc' has no mismatches.");
		if (stats1.errors_disp_o_alu_itag)
			$display("Hint: Output 'disp_o_alu_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_itag, stats1.errortime_disp_o_alu_itag);
		else
			$display("Hint: Output 'disp_o_alu_itag' has no mismatches.");
		if (stats1.errors_disp_o_alu_misalgn)
			$display("Hint: Output 'disp_o_alu_misalgn' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_misalgn, stats1.errortime_disp_o_alu_misalgn);
		else
			$display("Hint: Output 'disp_o_alu_misalgn' has no mismatches.");
		if (stats1.errors_disp_o_alu_buserr)
			$display("Hint: Output 'disp_o_alu_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_buserr, stats1.errortime_disp_o_alu_buserr);
		else
			$display("Hint: Output 'disp_o_alu_buserr' has no mismatches.");
		if (stats1.errors_disp_o_alu_ilegl)
			$display("Hint: Output 'disp_o_alu_ilegl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_o_alu_ilegl, stats1.errortime_disp_o_alu_ilegl);
		else
			$display("Hint: Output 'disp_o_alu_ilegl' has no mismatches.");
		if (stats1.errors_disp_oitf_ena)
			$display("Hint: Output 'disp_oitf_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_ena, stats1.errortime_disp_oitf_ena);
		else
			$display("Hint: Output 'disp_oitf_ena' has no mismatches.");
		if (stats1.errors_disp_oitf_rs1fpu)
			$display("Hint: Output 'disp_oitf_rs1fpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs1fpu, stats1.errortime_disp_oitf_rs1fpu);
		else
			$display("Hint: Output 'disp_oitf_rs1fpu' has no mismatches.");
		if (stats1.errors_disp_oitf_rs2fpu)
			$display("Hint: Output 'disp_oitf_rs2fpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs2fpu, stats1.errortime_disp_oitf_rs2fpu);
		else
			$display("Hint: Output 'disp_oitf_rs2fpu' has no mismatches.");
		if (stats1.errors_disp_oitf_rs3fpu)
			$display("Hint: Output 'disp_oitf_rs3fpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs3fpu, stats1.errortime_disp_oitf_rs3fpu);
		else
			$display("Hint: Output 'disp_oitf_rs3fpu' has no mismatches.");
		if (stats1.errors_disp_oitf_rdfpu)
			$display("Hint: Output 'disp_oitf_rdfpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rdfpu, stats1.errortime_disp_oitf_rdfpu);
		else
			$display("Hint: Output 'disp_oitf_rdfpu' has no mismatches.");
		if (stats1.errors_disp_oitf_rs1en)
			$display("Hint: Output 'disp_oitf_rs1en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs1en, stats1.errortime_disp_oitf_rs1en);
		else
			$display("Hint: Output 'disp_oitf_rs1en' has no mismatches.");
		if (stats1.errors_disp_oitf_rs2en)
			$display("Hint: Output 'disp_oitf_rs2en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs2en, stats1.errortime_disp_oitf_rs2en);
		else
			$display("Hint: Output 'disp_oitf_rs2en' has no mismatches.");
		if (stats1.errors_disp_oitf_rs3en)
			$display("Hint: Output 'disp_oitf_rs3en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs3en, stats1.errortime_disp_oitf_rs3en);
		else
			$display("Hint: Output 'disp_oitf_rs3en' has no mismatches.");
		if (stats1.errors_disp_oitf_rdwen)
			$display("Hint: Output 'disp_oitf_rdwen' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rdwen, stats1.errortime_disp_oitf_rdwen);
		else
			$display("Hint: Output 'disp_oitf_rdwen' has no mismatches.");
		if (stats1.errors_disp_oitf_rs1idx)
			$display("Hint: Output 'disp_oitf_rs1idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs1idx, stats1.errortime_disp_oitf_rs1idx);
		else
			$display("Hint: Output 'disp_oitf_rs1idx' has no mismatches.");
		if (stats1.errors_disp_oitf_rs2idx)
			$display("Hint: Output 'disp_oitf_rs2idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs2idx, stats1.errortime_disp_oitf_rs2idx);
		else
			$display("Hint: Output 'disp_oitf_rs2idx' has no mismatches.");
		if (stats1.errors_disp_oitf_rs3idx)
			$display("Hint: Output 'disp_oitf_rs3idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rs3idx, stats1.errortime_disp_oitf_rs3idx);
		else
			$display("Hint: Output 'disp_oitf_rs3idx' has no mismatches.");
		if (stats1.errors_disp_oitf_rdidx)
			$display("Hint: Output 'disp_oitf_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_rdidx, stats1.errortime_disp_oitf_rdidx);
		else
			$display("Hint: Output 'disp_oitf_rdidx' has no mismatches.");
		if (stats1.errors_disp_oitf_pc)
			$display("Hint: Output 'disp_oitf_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_disp_oitf_pc, stats1.errortime_disp_oitf_pc);
		else
			$display("Hint: Output 'disp_oitf_pc' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ wfi_halt_exu_ack_ref,disp_i_ready_ref,disp_o_alu_valid_ref,disp_o_alu_rs1_ref,disp_o_alu_rs2_ref,disp_o_alu_rdwen_ref,disp_o_alu_rdidx_ref,disp_o_alu_info_ref,disp_o_alu_imm_ref,disp_o_alu_pc_ref,disp_o_alu_itag_ref,disp_o_alu_misalgn_ref,disp_o_alu_buserr_ref,disp_o_alu_ilegl_ref,disp_oitf_ena_ref,disp_oitf_rs1fpu_ref,disp_oitf_rs2fpu_ref,disp_oitf_rs3fpu_ref,disp_oitf_rdfpu_ref,disp_oitf_rs1en_ref,disp_oitf_rs2en_ref,disp_oitf_rs3en_ref,disp_oitf_rdwen_ref,disp_oitf_rs1idx_ref,disp_oitf_rs2idx_ref,disp_oitf_rs3idx_ref,disp_oitf_rdidx_ref,disp_oitf_pc_ref} ===
			( { wfi_halt_exu_ack_ref,disp_i_ready_ref,disp_o_alu_valid_ref,disp_o_alu_rs1_ref,disp_o_alu_rs2_ref,disp_o_alu_rdwen_ref,disp_o_alu_rdidx_ref,disp_o_alu_info_ref,disp_o_alu_imm_ref,disp_o_alu_pc_ref,disp_o_alu_itag_ref,disp_o_alu_misalgn_ref,disp_o_alu_buserr_ref,disp_o_alu_ilegl_ref,disp_oitf_ena_ref,disp_oitf_rs1fpu_ref,disp_oitf_rs2fpu_ref,disp_oitf_rs3fpu_ref,disp_oitf_rdfpu_ref,disp_oitf_rs1en_ref,disp_oitf_rs2en_ref,disp_oitf_rs3en_ref,disp_oitf_rdwen_ref,disp_oitf_rs1idx_ref,disp_oitf_rs2idx_ref,disp_oitf_rs3idx_ref,disp_oitf_rdidx_ref,disp_oitf_pc_ref} ^
			  { wfi_halt_exu_ack_dut,disp_i_ready_dut,disp_o_alu_valid_dut,disp_o_alu_rs1_dut,disp_o_alu_rs2_dut,disp_o_alu_rdwen_dut,disp_o_alu_rdidx_dut,disp_o_alu_info_dut,disp_o_alu_imm_dut,disp_o_alu_pc_dut,disp_o_alu_itag_dut,disp_o_alu_misalgn_dut,disp_o_alu_buserr_dut,disp_o_alu_ilegl_dut,disp_oitf_ena_dut,disp_oitf_rs1fpu_dut,disp_oitf_rs2fpu_dut,disp_oitf_rs3fpu_dut,disp_oitf_rdfpu_dut,disp_oitf_rs1en_dut,disp_oitf_rs2en_dut,disp_oitf_rs3en_dut,disp_oitf_rdwen_dut,disp_oitf_rs1idx_dut,disp_oitf_rs2idx_dut,disp_oitf_rs3idx_dut,disp_oitf_rdidx_dut,disp_oitf_pc_dut} ^
			  { wfi_halt_exu_ack_ref,disp_i_ready_ref,disp_o_alu_valid_ref,disp_o_alu_rs1_ref,disp_o_alu_rs2_ref,disp_o_alu_rdwen_ref,disp_o_alu_rdidx_ref,disp_o_alu_info_ref,disp_o_alu_imm_ref,disp_o_alu_pc_ref,disp_o_alu_itag_ref,disp_o_alu_misalgn_ref,disp_o_alu_buserr_ref,disp_o_alu_ilegl_ref,disp_oitf_ena_ref,disp_oitf_rs1fpu_ref,disp_oitf_rs2fpu_ref,disp_oitf_rs3fpu_ref,disp_oitf_rdfpu_ref,disp_oitf_rs1en_ref,disp_oitf_rs2en_ref,disp_oitf_rs3en_ref,disp_oitf_rdwen_ref,disp_oitf_rs1idx_ref,disp_oitf_rs2idx_ref,disp_oitf_rs3idx_ref,disp_oitf_rdidx_ref,disp_oitf_pc_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (wfi_halt_exu_ack_ref !== (wfi_halt_exu_ack_ref ^ wfi_halt_exu_ack_dut ^ wfi_halt_exu_ack_ref)) begin
			if (stats1.errors_wfi_halt_exu_ack == 0) stats1.errortime_wfi_halt_exu_ack = $time;
			stats1.errors_wfi_halt_exu_ack++;
		end
		if (disp_i_ready_ref !== (disp_i_ready_ref ^ disp_i_ready_dut ^ disp_i_ready_ref)) begin
			if (stats1.errors_disp_i_ready == 0) stats1.errortime_disp_i_ready = $time;
			stats1.errors_disp_i_ready++;
		end
		if (disp_o_alu_valid_ref !== (disp_o_alu_valid_ref ^ disp_o_alu_valid_dut ^ disp_o_alu_valid_ref)) begin
			if (stats1.errors_disp_o_alu_valid == 0) stats1.errortime_disp_o_alu_valid = $time;
			stats1.errors_disp_o_alu_valid++;
		end
		if (disp_o_alu_rs1_ref !== (disp_o_alu_rs1_ref ^ disp_o_alu_rs1_dut ^ disp_o_alu_rs1_ref)) begin
			if (stats1.errors_disp_o_alu_rs1 == 0) stats1.errortime_disp_o_alu_rs1 = $time;
			stats1.errors_disp_o_alu_rs1++;
		end
		if (disp_o_alu_rs2_ref !== (disp_o_alu_rs2_ref ^ disp_o_alu_rs2_dut ^ disp_o_alu_rs2_ref)) begin
			if (stats1.errors_disp_o_alu_rs2 == 0) stats1.errortime_disp_o_alu_rs2 = $time;
			stats1.errors_disp_o_alu_rs2++;
		end
		if (disp_o_alu_rdwen_ref !== (disp_o_alu_rdwen_ref ^ disp_o_alu_rdwen_dut ^ disp_o_alu_rdwen_ref)) begin
			if (stats1.errors_disp_o_alu_rdwen == 0) stats1.errortime_disp_o_alu_rdwen = $time;
			stats1.errors_disp_o_alu_rdwen++;
		end
		if (disp_o_alu_rdidx_ref !== (disp_o_alu_rdidx_ref ^ disp_o_alu_rdidx_dut ^ disp_o_alu_rdidx_ref)) begin
			if (stats1.errors_disp_o_alu_rdidx == 0) stats1.errortime_disp_o_alu_rdidx = $time;
			stats1.errors_disp_o_alu_rdidx++;
		end
		if (disp_o_alu_info_ref !== (disp_o_alu_info_ref ^ disp_o_alu_info_dut ^ disp_o_alu_info_ref)) begin
			if (stats1.errors_disp_o_alu_info == 0) stats1.errortime_disp_o_alu_info = $time;
			stats1.errors_disp_o_alu_info++;
		end
		if (disp_o_alu_imm_ref !== (disp_o_alu_imm_ref ^ disp_o_alu_imm_dut ^ disp_o_alu_imm_ref)) begin
			if (stats1.errors_disp_o_alu_imm == 0) stats1.errortime_disp_o_alu_imm = $time;
			stats1.errors_disp_o_alu_imm++;
		end
		if (disp_o_alu_pc_ref !== (disp_o_alu_pc_ref ^ disp_o_alu_pc_dut ^ disp_o_alu_pc_ref)) begin
			if (stats1.errors_disp_o_alu_pc == 0) stats1.errortime_disp_o_alu_pc = $time;
			stats1.errors_disp_o_alu_pc++;
		end
		if (disp_o_alu_itag_ref !== (disp_o_alu_itag_ref ^ disp_o_alu_itag_dut ^ disp_o_alu_itag_ref)) begin
			if (stats1.errors_disp_o_alu_itag == 0) stats1.errortime_disp_o_alu_itag = $time;
			stats1.errors_disp_o_alu_itag++;
		end
		if (disp_o_alu_misalgn_ref !== (disp_o_alu_misalgn_ref ^ disp_o_alu_misalgn_dut ^ disp_o_alu_misalgn_ref)) begin
			if (stats1.errors_disp_o_alu_misalgn == 0) stats1.errortime_disp_o_alu_misalgn = $time;
			stats1.errors_disp_o_alu_misalgn++;
		end
		if (disp_o_alu_buserr_ref !== (disp_o_alu_buserr_ref ^ disp_o_alu_buserr_dut ^ disp_o_alu_buserr_ref)) begin
			if (stats1.errors_disp_o_alu_buserr == 0) stats1.errortime_disp_o_alu_buserr = $time;
			stats1.errors_disp_o_alu_buserr++;
		end
		if (disp_o_alu_ilegl_ref !== (disp_o_alu_ilegl_ref ^ disp_o_alu_ilegl_dut ^ disp_o_alu_ilegl_ref)) begin
			if (stats1.errors_disp_o_alu_ilegl == 0) stats1.errortime_disp_o_alu_ilegl = $time;
			stats1.errors_disp_o_alu_ilegl++;
		end
		if (disp_oitf_ena_ref !== (disp_oitf_ena_ref ^ disp_oitf_ena_dut ^ disp_oitf_ena_ref)) begin
			if (stats1.errors_disp_oitf_ena == 0) stats1.errortime_disp_oitf_ena = $time;
			stats1.errors_disp_oitf_ena++;
		end
		if (disp_oitf_rs1fpu_ref !== (disp_oitf_rs1fpu_ref ^ disp_oitf_rs1fpu_dut ^ disp_oitf_rs1fpu_ref)) begin
			if (stats1.errors_disp_oitf_rs1fpu == 0) stats1.errortime_disp_oitf_rs1fpu = $time;
			stats1.errors_disp_oitf_rs1fpu++;
		end
		if (disp_oitf_rs2fpu_ref !== (disp_oitf_rs2fpu_ref ^ disp_oitf_rs2fpu_dut ^ disp_oitf_rs2fpu_ref)) begin
			if (stats1.errors_disp_oitf_rs2fpu == 0) stats1.errortime_disp_oitf_rs2fpu = $time;
			stats1.errors_disp_oitf_rs2fpu++;
		end
		if (disp_oitf_rs3fpu_ref !== (disp_oitf_rs3fpu_ref ^ disp_oitf_rs3fpu_dut ^ disp_oitf_rs3fpu_ref)) begin
			if (stats1.errors_disp_oitf_rs3fpu == 0) stats1.errortime_disp_oitf_rs3fpu = $time;
			stats1.errors_disp_oitf_rs3fpu++;
		end
		if (disp_oitf_rdfpu_ref !== (disp_oitf_rdfpu_ref ^ disp_oitf_rdfpu_dut ^ disp_oitf_rdfpu_ref)) begin
			if (stats1.errors_disp_oitf_rdfpu == 0) stats1.errortime_disp_oitf_rdfpu = $time;
			stats1.errors_disp_oitf_rdfpu++;
		end
		if (disp_oitf_rs1en_ref !== (disp_oitf_rs1en_ref ^ disp_oitf_rs1en_dut ^ disp_oitf_rs1en_ref)) begin
			if (stats1.errors_disp_oitf_rs1en == 0) stats1.errortime_disp_oitf_rs1en = $time;
			stats1.errors_disp_oitf_rs1en++;
		end
		if (disp_oitf_rs2en_ref !== (disp_oitf_rs2en_ref ^ disp_oitf_rs2en_dut ^ disp_oitf_rs2en_ref)) begin
			if (stats1.errors_disp_oitf_rs2en == 0) stats1.errortime_disp_oitf_rs2en = $time;
			stats1.errors_disp_oitf_rs2en++;
		end
		if (disp_oitf_rs3en_ref !== (disp_oitf_rs3en_ref ^ disp_oitf_rs3en_dut ^ disp_oitf_rs3en_ref)) begin
			if (stats1.errors_disp_oitf_rs3en == 0) stats1.errortime_disp_oitf_rs3en = $time;
			stats1.errors_disp_oitf_rs3en++;
		end
		if (disp_oitf_rdwen_ref !== (disp_oitf_rdwen_ref ^ disp_oitf_rdwen_dut ^ disp_oitf_rdwen_ref)) begin
			if (stats1.errors_disp_oitf_rdwen == 0) stats1.errortime_disp_oitf_rdwen = $time;
			stats1.errors_disp_oitf_rdwen++;
		end
		if (disp_oitf_rs1idx_ref !== (disp_oitf_rs1idx_ref ^ disp_oitf_rs1idx_dut ^ disp_oitf_rs1idx_ref)) begin
			if (stats1.errors_disp_oitf_rs1idx == 0) stats1.errortime_disp_oitf_rs1idx = $time;
			stats1.errors_disp_oitf_rs1idx++;
		end
		if (disp_oitf_rs2idx_ref !== (disp_oitf_rs2idx_ref ^ disp_oitf_rs2idx_dut ^ disp_oitf_rs2idx_ref)) begin
			if (stats1.errors_disp_oitf_rs2idx == 0) stats1.errortime_disp_oitf_rs2idx = $time;
			stats1.errors_disp_oitf_rs2idx++;
		end
		if (disp_oitf_rs3idx_ref !== (disp_oitf_rs3idx_ref ^ disp_oitf_rs3idx_dut ^ disp_oitf_rs3idx_ref)) begin
			if (stats1.errors_disp_oitf_rs3idx == 0) stats1.errortime_disp_oitf_rs3idx = $time;
			stats1.errors_disp_oitf_rs3idx++;
		end
		if (disp_oitf_rdidx_ref !== (disp_oitf_rdidx_ref ^ disp_oitf_rdidx_dut ^ disp_oitf_rdidx_ref)) begin
			if (stats1.errors_disp_oitf_rdidx == 0) stats1.errortime_disp_oitf_rdidx = $time;
			stats1.errors_disp_oitf_rdidx++;
		end
		if (disp_oitf_pc_ref !== (disp_oitf_pc_ref ^ disp_oitf_pc_dut ^ disp_oitf_pc_ref)) begin
			if (stats1.errors_disp_oitf_pc == 0) stats1.errortime_disp_oitf_pc = $time;
			stats1.errors_disp_oitf_pc++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
