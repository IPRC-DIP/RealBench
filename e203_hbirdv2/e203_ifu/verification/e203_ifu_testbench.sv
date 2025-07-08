`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_inspect_pc;
		int errortime_inspect_pc;
		int errors_ifu_active;
		int errortime_ifu_active;
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
		int errors_ifu_o_ir;
		int errortime_ifu_o_ir;
		int errors_ifu_o_pc;
		int errortime_ifu_o_pc;
		int errors_ifu_o_pc_vld;
		int errortime_ifu_o_pc_vld;
		int errors_ifu_o_misalgn;
		int errortime_ifu_o_misalgn;
		int errors_ifu_o_buserr;
		int errortime_ifu_o_buserr;
		int errors_ifu_o_rs1idx;
		int errortime_ifu_o_rs1idx;
		int errors_ifu_o_rs2idx;
		int errortime_ifu_o_rs2idx;
		int errors_ifu_o_prdt_taken;
		int errortime_ifu_o_prdt_taken;
		int errors_ifu_o_muldiv_b2b;
		int errortime_ifu_o_muldiv_b2b;
		int errors_ifu_o_valid;
		int errortime_ifu_o_valid;
		int errors_pipe_flush_ack;
		int errortime_pipe_flush_ack;
		int errors_ifu_halt_ack;
		int errortime_ifu_halt_ack;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [32-1:0] inspect_pc_ref;
	logic [32-1:0] inspect_pc_dut;
	logic ifu_active_ref;
	logic ifu_active_dut;
	logic itcm_nohold;
	logic [32-1:0] pc_rtvec;
	logic ifu2itcm_holdup;
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
	logic [32-1:0] ifu_o_ir_ref;
	logic [32-1:0] ifu_o_ir_dut;
	logic [32-1:0] ifu_o_pc_ref;
	logic [32-1:0] ifu_o_pc_dut;
	logic ifu_o_pc_vld_ref;
	logic ifu_o_pc_vld_dut;
	logic ifu_o_misalgn_ref;
	logic ifu_o_misalgn_dut;
	logic ifu_o_buserr_ref;
	logic ifu_o_buserr_dut;
	logic [5-1:0] ifu_o_rs1idx_ref;
	logic [5-1:0] ifu_o_rs1idx_dut;
	logic [5-1:0] ifu_o_rs2idx_ref;
	logic [5-1:0] ifu_o_rs2idx_dut;
	logic ifu_o_prdt_taken_ref;
	logic ifu_o_prdt_taken_dut;
	logic ifu_o_muldiv_b2b_ref;
	logic ifu_o_muldiv_b2b_dut;
	logic ifu_o_valid_ref;
	logic ifu_o_valid_dut;
	logic ifu_o_ready;
	logic pipe_flush_ack_ref;
	logic pipe_flush_ack_dut;
	logic pipe_flush_req;
	logic [32-1:0] pipe_flush_add_op1;
	logic [32-1:0] pipe_flush_add_op2;
	logic [32-1:0] pipe_flush_pc;
	logic ifu_halt_req;
	logic ifu_halt_ack_ref;
	logic ifu_halt_ack_dut;
	logic oitf_empty;
	logic [32-1:0] rf2ifu_x1;
	logic [32-1:0] rf2ifu_rs1;
	logic dec2ifu_rden;
	logic dec2ifu_rs1en;
	logic [5-1:0] dec2ifu_rdidx;
	logic dec2ifu_mulhsu;
	logic dec2ifu_div;
	logic dec2ifu_rem;
	logic dec2ifu_divu;
	logic dec2ifu_remu;
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
		.pc_rtvec(pc_rtvec),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata),
		.ifu_o_ready(ifu_o_ready),
		.pipe_flush_req(pipe_flush_req),
		.pipe_flush_add_op1(pipe_flush_add_op1),
		.pipe_flush_add_op2(pipe_flush_add_op2),
		.pipe_flush_pc(pipe_flush_pc),
		.ifu_halt_req(ifu_halt_req),
		.oitf_empty(oitf_empty),
		.rf2ifu_x1(rf2ifu_x1),
		.rf2ifu_rs1(rf2ifu_rs1),
		.dec2ifu_rden(dec2ifu_rden),
		.dec2ifu_rs1en(dec2ifu_rs1en),
		.dec2ifu_rdidx(dec2ifu_rdidx),
		.dec2ifu_mulhsu(dec2ifu_mulhsu),
		.dec2ifu_div(dec2ifu_div),
		.dec2ifu_rem(dec2ifu_rem),
		.dec2ifu_divu(dec2ifu_divu),
		.dec2ifu_remu(dec2ifu_remu),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_ifu good1 (
		.inspect_pc(inspect_pc_ref),
		.ifu_active(ifu_active_ref),
		.itcm_nohold(itcm_nohold),
		.pc_rtvec(pc_rtvec),
		.ifu2itcm_holdup(ifu2itcm_holdup),
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
		.ifu_o_ir(ifu_o_ir_ref),
		.ifu_o_pc(ifu_o_pc_ref),
		.ifu_o_pc_vld(ifu_o_pc_vld_ref),
		.ifu_o_misalgn(ifu_o_misalgn_ref),
		.ifu_o_buserr(ifu_o_buserr_ref),
		.ifu_o_rs1idx(ifu_o_rs1idx_ref),
		.ifu_o_rs2idx(ifu_o_rs2idx_ref),
		.ifu_o_prdt_taken(ifu_o_prdt_taken_ref),
		.ifu_o_muldiv_b2b(ifu_o_muldiv_b2b_ref),
		.ifu_o_valid(ifu_o_valid_ref),
		.ifu_o_ready(ifu_o_ready),
		.pipe_flush_ack(pipe_flush_ack_ref),
		.pipe_flush_req(pipe_flush_req),
		.pipe_flush_add_op1(pipe_flush_add_op1),
		.pipe_flush_add_op2(pipe_flush_add_op2),
		.pipe_flush_pc(pipe_flush_pc),
		.ifu_halt_req(ifu_halt_req),
		.ifu_halt_ack(ifu_halt_ack_ref),
		.oitf_empty(oitf_empty),
		.rf2ifu_x1(rf2ifu_x1),
		.rf2ifu_rs1(rf2ifu_rs1),
		.dec2ifu_rden(dec2ifu_rden),
		.dec2ifu_rs1en(dec2ifu_rs1en),
		.dec2ifu_rdidx(dec2ifu_rdidx),
		.dec2ifu_mulhsu(dec2ifu_mulhsu),
		.dec2ifu_div(dec2ifu_div),
		.dec2ifu_rem(dec2ifu_rem),
		.dec2ifu_divu(dec2ifu_divu),
		.dec2ifu_remu(dec2ifu_remu),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_ifu top_module1 (
		.inspect_pc(inspect_pc_dut),
		.ifu_active(ifu_active_dut),
		.itcm_nohold(itcm_nohold),
		.pc_rtvec(pc_rtvec),
		.ifu2itcm_holdup(ifu2itcm_holdup),
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
		.ifu_o_ir(ifu_o_ir_dut),
		.ifu_o_pc(ifu_o_pc_dut),
		.ifu_o_pc_vld(ifu_o_pc_vld_dut),
		.ifu_o_misalgn(ifu_o_misalgn_dut),
		.ifu_o_buserr(ifu_o_buserr_dut),
		.ifu_o_rs1idx(ifu_o_rs1idx_dut),
		.ifu_o_rs2idx(ifu_o_rs2idx_dut),
		.ifu_o_prdt_taken(ifu_o_prdt_taken_dut),
		.ifu_o_muldiv_b2b(ifu_o_muldiv_b2b_dut),
		.ifu_o_valid(ifu_o_valid_dut),
		.ifu_o_ready(ifu_o_ready),
		.pipe_flush_ack(pipe_flush_ack_dut),
		.pipe_flush_req(pipe_flush_req),
		.pipe_flush_add_op1(pipe_flush_add_op1),
		.pipe_flush_add_op2(pipe_flush_add_op2),
		.pipe_flush_pc(pipe_flush_pc),
		.ifu_halt_req(ifu_halt_req),
		.ifu_halt_ack(ifu_halt_ack_dut),
		.oitf_empty(oitf_empty),
		.rf2ifu_x1(rf2ifu_x1),
		.rf2ifu_rs1(rf2ifu_rs1),
		.dec2ifu_rden(dec2ifu_rden),
		.dec2ifu_rs1en(dec2ifu_rs1en),
		.dec2ifu_rdidx(dec2ifu_rdidx),
		.dec2ifu_mulhsu(dec2ifu_mulhsu),
		.dec2ifu_div(dec2ifu_div),
		.dec2ifu_rem(dec2ifu_rem),
		.dec2ifu_divu(dec2ifu_divu),
		.dec2ifu_remu(dec2ifu_remu),
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
		if (stats1.errors_inspect_pc)
			$display("Hint: Output 'inspect_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_pc, stats1.errortime_inspect_pc);
		else
			$display("Hint: Output 'inspect_pc' has no mismatches.");
		if (stats1.errors_ifu_active)
			$display("Hint: Output 'ifu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_active, stats1.errortime_ifu_active);
		else
			$display("Hint: Output 'ifu_active' has no mismatches.");
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
		if (stats1.errors_ifu_o_ir)
			$display("Hint: Output 'ifu_o_ir' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_ir, stats1.errortime_ifu_o_ir);
		else
			$display("Hint: Output 'ifu_o_ir' has no mismatches.");
		if (stats1.errors_ifu_o_pc)
			$display("Hint: Output 'ifu_o_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_pc, stats1.errortime_ifu_o_pc);
		else
			$display("Hint: Output 'ifu_o_pc' has no mismatches.");
		if (stats1.errors_ifu_o_pc_vld)
			$display("Hint: Output 'ifu_o_pc_vld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_pc_vld, stats1.errortime_ifu_o_pc_vld);
		else
			$display("Hint: Output 'ifu_o_pc_vld' has no mismatches.");
		if (stats1.errors_ifu_o_misalgn)
			$display("Hint: Output 'ifu_o_misalgn' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_misalgn, stats1.errortime_ifu_o_misalgn);
		else
			$display("Hint: Output 'ifu_o_misalgn' has no mismatches.");
		if (stats1.errors_ifu_o_buserr)
			$display("Hint: Output 'ifu_o_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_buserr, stats1.errortime_ifu_o_buserr);
		else
			$display("Hint: Output 'ifu_o_buserr' has no mismatches.");
		if (stats1.errors_ifu_o_rs1idx)
			$display("Hint: Output 'ifu_o_rs1idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_rs1idx, stats1.errortime_ifu_o_rs1idx);
		else
			$display("Hint: Output 'ifu_o_rs1idx' has no mismatches.");
		if (stats1.errors_ifu_o_rs2idx)
			$display("Hint: Output 'ifu_o_rs2idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_rs2idx, stats1.errortime_ifu_o_rs2idx);
		else
			$display("Hint: Output 'ifu_o_rs2idx' has no mismatches.");
		if (stats1.errors_ifu_o_prdt_taken)
			$display("Hint: Output 'ifu_o_prdt_taken' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_prdt_taken, stats1.errortime_ifu_o_prdt_taken);
		else
			$display("Hint: Output 'ifu_o_prdt_taken' has no mismatches.");
		if (stats1.errors_ifu_o_muldiv_b2b)
			$display("Hint: Output 'ifu_o_muldiv_b2b' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_muldiv_b2b, stats1.errortime_ifu_o_muldiv_b2b);
		else
			$display("Hint: Output 'ifu_o_muldiv_b2b' has no mismatches.");
		if (stats1.errors_ifu_o_valid)
			$display("Hint: Output 'ifu_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_o_valid, stats1.errortime_ifu_o_valid);
		else
			$display("Hint: Output 'ifu_o_valid' has no mismatches.");
		if (stats1.errors_pipe_flush_ack)
			$display("Hint: Output 'pipe_flush_ack' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_pipe_flush_ack, stats1.errortime_pipe_flush_ack);
		else
			$display("Hint: Output 'pipe_flush_ack' has no mismatches.");
		if (stats1.errors_ifu_halt_ack)
			$display("Hint: Output 'ifu_halt_ack' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_halt_ack, stats1.errortime_ifu_halt_ack);
		else
			$display("Hint: Output 'ifu_halt_ack' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ inspect_pc_ref,ifu_active_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref,ifu_o_ir_ref,ifu_o_pc_ref,ifu_o_pc_vld_ref,ifu_o_misalgn_ref,ifu_o_buserr_ref,ifu_o_rs1idx_ref,ifu_o_rs2idx_ref,ifu_o_prdt_taken_ref,ifu_o_muldiv_b2b_ref,ifu_o_valid_ref,pipe_flush_ack_ref,ifu_halt_ack_ref} ===
			( { inspect_pc_ref,ifu_active_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref,ifu_o_ir_ref,ifu_o_pc_ref,ifu_o_pc_vld_ref,ifu_o_misalgn_ref,ifu_o_buserr_ref,ifu_o_rs1idx_ref,ifu_o_rs2idx_ref,ifu_o_prdt_taken_ref,ifu_o_muldiv_b2b_ref,ifu_o_valid_ref,pipe_flush_ack_ref,ifu_halt_ack_ref} ^
			  { inspect_pc_dut,ifu_active_dut,ifu2itcm_icb_cmd_valid_dut,ifu2itcm_icb_cmd_addr_dut,ifu2itcm_icb_rsp_ready_dut,ifu2biu_icb_cmd_valid_dut,ifu2biu_icb_cmd_addr_dut,ifu2biu_icb_rsp_ready_dut,ifu_o_ir_dut,ifu_o_pc_dut,ifu_o_pc_vld_dut,ifu_o_misalgn_dut,ifu_o_buserr_dut,ifu_o_rs1idx_dut,ifu_o_rs2idx_dut,ifu_o_prdt_taken_dut,ifu_o_muldiv_b2b_dut,ifu_o_valid_dut,pipe_flush_ack_dut,ifu_halt_ack_dut} ^
			  { inspect_pc_ref,ifu_active_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ifu2biu_icb_cmd_valid_ref,ifu2biu_icb_cmd_addr_ref,ifu2biu_icb_rsp_ready_ref,ifu_o_ir_ref,ifu_o_pc_ref,ifu_o_pc_vld_ref,ifu_o_misalgn_ref,ifu_o_buserr_ref,ifu_o_rs1idx_ref,ifu_o_rs2idx_ref,ifu_o_prdt_taken_ref,ifu_o_muldiv_b2b_ref,ifu_o_valid_ref,pipe_flush_ack_ref,ifu_halt_ack_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (inspect_pc_ref !== (inspect_pc_ref ^ inspect_pc_dut ^ inspect_pc_ref)) begin
			if (stats1.errors_inspect_pc == 0) stats1.errortime_inspect_pc = $time;
			stats1.errors_inspect_pc++;
		end
		if (ifu_active_ref !== (ifu_active_ref ^ ifu_active_dut ^ ifu_active_ref)) begin
			if (stats1.errors_ifu_active == 0) stats1.errortime_ifu_active = $time;
			stats1.errors_ifu_active++;
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
		if (ifu_o_ir_ref !== (ifu_o_ir_ref ^ ifu_o_ir_dut ^ ifu_o_ir_ref)) begin
			if (stats1.errors_ifu_o_ir == 0) stats1.errortime_ifu_o_ir = $time;
			stats1.errors_ifu_o_ir++;
		end
		if (ifu_o_pc_ref !== (ifu_o_pc_ref ^ ifu_o_pc_dut ^ ifu_o_pc_ref)) begin
			if (stats1.errors_ifu_o_pc == 0) stats1.errortime_ifu_o_pc = $time;
			stats1.errors_ifu_o_pc++;
		end
		if (ifu_o_pc_vld_ref !== (ifu_o_pc_vld_ref ^ ifu_o_pc_vld_dut ^ ifu_o_pc_vld_ref)) begin
			if (stats1.errors_ifu_o_pc_vld == 0) stats1.errortime_ifu_o_pc_vld = $time;
			stats1.errors_ifu_o_pc_vld++;
		end
		if (ifu_o_misalgn_ref !== (ifu_o_misalgn_ref ^ ifu_o_misalgn_dut ^ ifu_o_misalgn_ref)) begin
			if (stats1.errors_ifu_o_misalgn == 0) stats1.errortime_ifu_o_misalgn = $time;
			stats1.errors_ifu_o_misalgn++;
		end
		if (ifu_o_buserr_ref !== (ifu_o_buserr_ref ^ ifu_o_buserr_dut ^ ifu_o_buserr_ref)) begin
			if (stats1.errors_ifu_o_buserr == 0) stats1.errortime_ifu_o_buserr = $time;
			stats1.errors_ifu_o_buserr++;
		end
		if (ifu_o_rs1idx_ref !== (ifu_o_rs1idx_ref ^ ifu_o_rs1idx_dut ^ ifu_o_rs1idx_ref)) begin
			if (stats1.errors_ifu_o_rs1idx == 0) stats1.errortime_ifu_o_rs1idx = $time;
			stats1.errors_ifu_o_rs1idx++;
		end
		if (ifu_o_rs2idx_ref !== (ifu_o_rs2idx_ref ^ ifu_o_rs2idx_dut ^ ifu_o_rs2idx_ref)) begin
			if (stats1.errors_ifu_o_rs2idx == 0) stats1.errortime_ifu_o_rs2idx = $time;
			stats1.errors_ifu_o_rs2idx++;
		end
		if (ifu_o_prdt_taken_ref !== (ifu_o_prdt_taken_ref ^ ifu_o_prdt_taken_dut ^ ifu_o_prdt_taken_ref)) begin
			if (stats1.errors_ifu_o_prdt_taken == 0) stats1.errortime_ifu_o_prdt_taken = $time;
			stats1.errors_ifu_o_prdt_taken++;
		end
		if (ifu_o_muldiv_b2b_ref !== (ifu_o_muldiv_b2b_ref ^ ifu_o_muldiv_b2b_dut ^ ifu_o_muldiv_b2b_ref)) begin
			if (stats1.errors_ifu_o_muldiv_b2b == 0) stats1.errortime_ifu_o_muldiv_b2b = $time;
			stats1.errors_ifu_o_muldiv_b2b++;
		end
		if (ifu_o_valid_ref !== (ifu_o_valid_ref ^ ifu_o_valid_dut ^ ifu_o_valid_ref)) begin
			if (stats1.errors_ifu_o_valid == 0) stats1.errortime_ifu_o_valid = $time;
			stats1.errors_ifu_o_valid++;
		end
		if (pipe_flush_ack_ref !== (pipe_flush_ack_ref ^ pipe_flush_ack_dut ^ pipe_flush_ack_ref)) begin
			if (stats1.errors_pipe_flush_ack == 0) stats1.errortime_pipe_flush_ack = $time;
			stats1.errors_pipe_flush_ack++;
		end
		if (ifu_halt_ack_ref !== (ifu_halt_ack_ref ^ ifu_halt_ack_dut ^ ifu_halt_ack_ref)) begin
			if (stats1.errors_ifu_halt_ack == 0) stats1.errortime_ifu_halt_ack = $time;
			stats1.errors_ifu_halt_ack++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
