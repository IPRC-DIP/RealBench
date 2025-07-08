`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_commit_mret;
		int errortime_commit_mret;
		int errors_commit_trap;
		int errortime_commit_trap;
		int errors_core_wfi;
		int errortime_core_wfi;
		int errors_nonflush_cmt_ena;
		int errortime_nonflush_cmt_ena;
		int errors_excp_active;
		int errortime_excp_active;
		int errors_wfi_halt_ifu_req;
		int errortime_wfi_halt_ifu_req;
		int errors_wfi_halt_exu_req;
		int errortime_wfi_halt_exu_req;
		int errors_alu_cmt_i_ready;
		int errortime_alu_cmt_i_ready;
		int errors_cmt_badaddr;
		int errortime_cmt_badaddr;
		int errors_cmt_badaddr_ena;
		int errortime_cmt_badaddr_ena;
		int errors_cmt_epc;
		int errortime_cmt_epc;
		int errors_cmt_epc_ena;
		int errortime_cmt_epc_ena;
		int errors_cmt_cause;
		int errortime_cmt_cause;
		int errors_cmt_cause_ena;
		int errortime_cmt_cause_ena;
		int errors_cmt_instret_ena;
		int errortime_cmt_instret_ena;
		int errors_cmt_status_ena;
		int errortime_cmt_status_ena;
		int errors_cmt_dpc;
		int errortime_cmt_dpc;
		int errors_cmt_dpc_ena;
		int errortime_cmt_dpc_ena;
		int errors_cmt_dcause;
		int errortime_cmt_dcause;
		int errors_cmt_dcause_ena;
		int errortime_cmt_dcause_ena;
		int errors_cmt_mret_ena;
		int errortime_cmt_mret_ena;
		int errors_longp_excp_i_ready;
		int errortime_longp_excp_i_ready;
		int errors_flush_pulse;
		int errortime_flush_pulse;
		int errors_flush_req;
		int errortime_flush_req;
		int errors_pipe_flush_req;
		int errortime_pipe_flush_req;
		int errors_pipe_flush_add_op1;
		int errortime_pipe_flush_add_op1;
		int errors_pipe_flush_add_op2;
		int errortime_pipe_flush_add_op2;
		int errors_pipe_flush_pc;
		int errortime_pipe_flush_pc;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic commit_mret_ref;
	logic commit_mret_dut;
	logic commit_trap_ref;
	logic commit_trap_dut;
	logic core_wfi_ref;
	logic core_wfi_dut;
	logic nonflush_cmt_ena_ref;
	logic nonflush_cmt_ena_dut;
	logic excp_active_ref;
	logic excp_active_dut;
	logic amo_wait;
	logic wfi_halt_ifu_req_ref;
	logic wfi_halt_ifu_req_dut;
	logic wfi_halt_exu_req_ref;
	logic wfi_halt_exu_req_dut;
	logic wfi_halt_ifu_ack;
	logic wfi_halt_exu_ack;
	logic dbg_irq_r;
	logic lcl_irq_r;
	logic ext_irq_r;
	logic sft_irq_r;
	logic tmr_irq_r;
	logic evt_r;
	logic status_mie_r;
	logic mtie_r;
	logic msie_r;
	logic meie_r;
	logic alu_cmt_i_valid;
	logic alu_cmt_i_ready_ref;
	logic alu_cmt_i_ready_dut;
	logic [32-1:0] alu_cmt_i_pc;
	logic [32-1:0] alu_cmt_i_instr;
	logic alu_cmt_i_pc_vld;
	logic [32-1:0] alu_cmt_i_imm;
	logic alu_cmt_i_rv32;
	logic alu_cmt_i_bjp;
	logic alu_cmt_i_wfi;
	logic alu_cmt_i_fencei;
	logic alu_cmt_i_mret;
	logic alu_cmt_i_dret;
	logic alu_cmt_i_ecall;
	logic alu_cmt_i_ebreak;
	logic alu_cmt_i_ifu_misalgn;
	logic alu_cmt_i_ifu_buserr;
	logic alu_cmt_i_ifu_ilegl;
	logic alu_cmt_i_bjp_prdt;
	logic alu_cmt_i_bjp_rslv;
	logic alu_cmt_i_misalgn;
	logic alu_cmt_i_ld;
	logic alu_cmt_i_stamo;
	logic alu_cmt_i_buserr;
	logic [32-1:0] alu_cmt_i_badaddr;
	logic [32-1:0] cmt_badaddr_ref;
	logic [32-1:0] cmt_badaddr_dut;
	logic cmt_badaddr_ena_ref;
	logic cmt_badaddr_ena_dut;
	logic [32-1:0] cmt_epc_ref;
	logic [32-1:0] cmt_epc_dut;
	logic cmt_epc_ena_ref;
	logic cmt_epc_ena_dut;
	logic [32-1:0] cmt_cause_ref;
	logic [32-1:0] cmt_cause_dut;
	logic cmt_cause_ena_ref;
	logic cmt_cause_ena_dut;
	logic cmt_instret_ena_ref;
	logic cmt_instret_ena_dut;
	logic cmt_status_ena_ref;
	logic cmt_status_ena_dut;
	logic [32-1:0] cmt_dpc_ref;
	logic [32-1:0] cmt_dpc_dut;
	logic cmt_dpc_ena_ref;
	logic cmt_dpc_ena_dut;
	logic [3-1:0] cmt_dcause_ref;
	logic [3-1:0] cmt_dcause_dut;
	logic cmt_dcause_ena_ref;
	logic cmt_dcause_ena_dut;
	logic cmt_mret_ena_ref;
	logic cmt_mret_ena_dut;
	logic [32-1:0] csr_epc_r;
	logic [32-1:0] csr_dpc_r;
	logic [32-1:0] csr_mtvec_r;
	logic dbg_mode;
	logic dbg_halt_r;
	logic dbg_step_r;
	logic dbg_ebreakm_r;
	logic oitf_empty;
	logic u_mode;
	logic s_mode;
	logic h_mode;
	logic m_mode;
	logic longp_excp_i_ready_ref;
	logic longp_excp_i_ready_dut;
	logic longp_excp_i_valid;
	logic longp_excp_i_ld;
	logic longp_excp_i_st;
	logic longp_excp_i_buserr;
	logic [32-1:0] longp_excp_i_badaddr;
	logic longp_excp_i_insterr;
	logic [32-1:0] longp_excp_i_pc;
	logic flush_pulse_ref;
	logic flush_pulse_dut;
	logic flush_req_ref;
	logic flush_req_dut;
	logic pipe_flush_ack;
	logic pipe_flush_req_ref;
	logic pipe_flush_req_dut;
	logic [32-1:0] pipe_flush_add_op1_ref;
	logic [32-1:0] pipe_flush_add_op1_dut;
	logic [32-1:0] pipe_flush_add_op2_ref;
	logic [32-1:0] pipe_flush_add_op2_dut;
	logic [32-1:0] pipe_flush_pc_ref;
	logic [32-1:0] pipe_flush_pc_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.amo_wait(amo_wait),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.wfi_halt_exu_ack(wfi_halt_exu_ack),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.evt_r(evt_r),
		.status_mie_r(status_mie_r),
		.mtie_r(mtie_r),
		.msie_r(msie_r),
		.meie_r(meie_r),
		.alu_cmt_i_valid(alu_cmt_i_valid),
		.alu_cmt_i_pc(alu_cmt_i_pc),
		.alu_cmt_i_instr(alu_cmt_i_instr),
		.alu_cmt_i_pc_vld(alu_cmt_i_pc_vld),
		.alu_cmt_i_imm(alu_cmt_i_imm),
		.alu_cmt_i_rv32(alu_cmt_i_rv32),
		.alu_cmt_i_bjp(alu_cmt_i_bjp),
		.alu_cmt_i_wfi(alu_cmt_i_wfi),
		.alu_cmt_i_fencei(alu_cmt_i_fencei),
		.alu_cmt_i_mret(alu_cmt_i_mret),
		.alu_cmt_i_dret(alu_cmt_i_dret),
		.alu_cmt_i_ecall(alu_cmt_i_ecall),
		.alu_cmt_i_ebreak(alu_cmt_i_ebreak),
		.alu_cmt_i_ifu_misalgn(alu_cmt_i_ifu_misalgn),
		.alu_cmt_i_ifu_buserr(alu_cmt_i_ifu_buserr),
		.alu_cmt_i_ifu_ilegl(alu_cmt_i_ifu_ilegl),
		.alu_cmt_i_bjp_prdt(alu_cmt_i_bjp_prdt),
		.alu_cmt_i_bjp_rslv(alu_cmt_i_bjp_rslv),
		.alu_cmt_i_misalgn(alu_cmt_i_misalgn),
		.alu_cmt_i_ld(alu_cmt_i_ld),
		.alu_cmt_i_stamo(alu_cmt_i_stamo),
		.alu_cmt_i_buserr(alu_cmt_i_buserr),
		.alu_cmt_i_badaddr(alu_cmt_i_badaddr),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.csr_mtvec_r(csr_mtvec_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.oitf_empty(oitf_empty),
		.u_mode(u_mode),
		.s_mode(s_mode),
		.h_mode(h_mode),
		.m_mode(m_mode),
		.longp_excp_i_valid(longp_excp_i_valid),
		.longp_excp_i_ld(longp_excp_i_ld),
		.longp_excp_i_st(longp_excp_i_st),
		.longp_excp_i_buserr(longp_excp_i_buserr),
		.longp_excp_i_badaddr(longp_excp_i_badaddr),
		.longp_excp_i_insterr(longp_excp_i_insterr),
		.longp_excp_i_pc(longp_excp_i_pc),
		.pipe_flush_ack(pipe_flush_ack),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_commit good1 (
		.commit_mret(commit_mret_ref),
		.commit_trap(commit_trap_ref),
		.core_wfi(core_wfi_ref),
		.nonflush_cmt_ena(nonflush_cmt_ena_ref),
		.excp_active(excp_active_ref),
		.amo_wait(amo_wait),
		.wfi_halt_ifu_req(wfi_halt_ifu_req_ref),
		.wfi_halt_exu_req(wfi_halt_exu_req_ref),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.wfi_halt_exu_ack(wfi_halt_exu_ack),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.evt_r(evt_r),
		.status_mie_r(status_mie_r),
		.mtie_r(mtie_r),
		.msie_r(msie_r),
		.meie_r(meie_r),
		.alu_cmt_i_valid(alu_cmt_i_valid),
		.alu_cmt_i_ready(alu_cmt_i_ready_ref),
		.alu_cmt_i_pc(alu_cmt_i_pc),
		.alu_cmt_i_instr(alu_cmt_i_instr),
		.alu_cmt_i_pc_vld(alu_cmt_i_pc_vld),
		.alu_cmt_i_imm(alu_cmt_i_imm),
		.alu_cmt_i_rv32(alu_cmt_i_rv32),
		.alu_cmt_i_bjp(alu_cmt_i_bjp),
		.alu_cmt_i_wfi(alu_cmt_i_wfi),
		.alu_cmt_i_fencei(alu_cmt_i_fencei),
		.alu_cmt_i_mret(alu_cmt_i_mret),
		.alu_cmt_i_dret(alu_cmt_i_dret),
		.alu_cmt_i_ecall(alu_cmt_i_ecall),
		.alu_cmt_i_ebreak(alu_cmt_i_ebreak),
		.alu_cmt_i_ifu_misalgn(alu_cmt_i_ifu_misalgn),
		.alu_cmt_i_ifu_buserr(alu_cmt_i_ifu_buserr),
		.alu_cmt_i_ifu_ilegl(alu_cmt_i_ifu_ilegl),
		.alu_cmt_i_bjp_prdt(alu_cmt_i_bjp_prdt),
		.alu_cmt_i_bjp_rslv(alu_cmt_i_bjp_rslv),
		.alu_cmt_i_misalgn(alu_cmt_i_misalgn),
		.alu_cmt_i_ld(alu_cmt_i_ld),
		.alu_cmt_i_stamo(alu_cmt_i_stamo),
		.alu_cmt_i_buserr(alu_cmt_i_buserr),
		.alu_cmt_i_badaddr(alu_cmt_i_badaddr),
		.cmt_badaddr(cmt_badaddr_ref),
		.cmt_badaddr_ena(cmt_badaddr_ena_ref),
		.cmt_epc(cmt_epc_ref),
		.cmt_epc_ena(cmt_epc_ena_ref),
		.cmt_cause(cmt_cause_ref),
		.cmt_cause_ena(cmt_cause_ena_ref),
		.cmt_instret_ena(cmt_instret_ena_ref),
		.cmt_status_ena(cmt_status_ena_ref),
		.cmt_dpc(cmt_dpc_ref),
		.cmt_dpc_ena(cmt_dpc_ena_ref),
		.cmt_dcause(cmt_dcause_ref),
		.cmt_dcause_ena(cmt_dcause_ena_ref),
		.cmt_mret_ena(cmt_mret_ena_ref),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.csr_mtvec_r(csr_mtvec_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.oitf_empty(oitf_empty),
		.u_mode(u_mode),
		.s_mode(s_mode),
		.h_mode(h_mode),
		.m_mode(m_mode),
		.longp_excp_i_ready(longp_excp_i_ready_ref),
		.longp_excp_i_valid(longp_excp_i_valid),
		.longp_excp_i_ld(longp_excp_i_ld),
		.longp_excp_i_st(longp_excp_i_st),
		.longp_excp_i_buserr(longp_excp_i_buserr),
		.longp_excp_i_badaddr(longp_excp_i_badaddr),
		.longp_excp_i_insterr(longp_excp_i_insterr),
		.longp_excp_i_pc(longp_excp_i_pc),
		.flush_pulse(flush_pulse_ref),
		.flush_req(flush_req_ref),
		.pipe_flush_ack(pipe_flush_ack),
		.pipe_flush_req(pipe_flush_req_ref),
		.pipe_flush_add_op1(pipe_flush_add_op1_ref),
		.pipe_flush_add_op2(pipe_flush_add_op2_ref),
		.pipe_flush_pc(pipe_flush_pc_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_commit top_module1 (
		.commit_mret(commit_mret_dut),
		.commit_trap(commit_trap_dut),
		.core_wfi(core_wfi_dut),
		.nonflush_cmt_ena(nonflush_cmt_ena_dut),
		.excp_active(excp_active_dut),
		.amo_wait(amo_wait),
		.wfi_halt_ifu_req(wfi_halt_ifu_req_dut),
		.wfi_halt_exu_req(wfi_halt_exu_req_dut),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.wfi_halt_exu_ack(wfi_halt_exu_ack),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.evt_r(evt_r),
		.status_mie_r(status_mie_r),
		.mtie_r(mtie_r),
		.msie_r(msie_r),
		.meie_r(meie_r),
		.alu_cmt_i_valid(alu_cmt_i_valid),
		.alu_cmt_i_ready(alu_cmt_i_ready_dut),
		.alu_cmt_i_pc(alu_cmt_i_pc),
		.alu_cmt_i_instr(alu_cmt_i_instr),
		.alu_cmt_i_pc_vld(alu_cmt_i_pc_vld),
		.alu_cmt_i_imm(alu_cmt_i_imm),
		.alu_cmt_i_rv32(alu_cmt_i_rv32),
		.alu_cmt_i_bjp(alu_cmt_i_bjp),
		.alu_cmt_i_wfi(alu_cmt_i_wfi),
		.alu_cmt_i_fencei(alu_cmt_i_fencei),
		.alu_cmt_i_mret(alu_cmt_i_mret),
		.alu_cmt_i_dret(alu_cmt_i_dret),
		.alu_cmt_i_ecall(alu_cmt_i_ecall),
		.alu_cmt_i_ebreak(alu_cmt_i_ebreak),
		.alu_cmt_i_ifu_misalgn(alu_cmt_i_ifu_misalgn),
		.alu_cmt_i_ifu_buserr(alu_cmt_i_ifu_buserr),
		.alu_cmt_i_ifu_ilegl(alu_cmt_i_ifu_ilegl),
		.alu_cmt_i_bjp_prdt(alu_cmt_i_bjp_prdt),
		.alu_cmt_i_bjp_rslv(alu_cmt_i_bjp_rslv),
		.alu_cmt_i_misalgn(alu_cmt_i_misalgn),
		.alu_cmt_i_ld(alu_cmt_i_ld),
		.alu_cmt_i_stamo(alu_cmt_i_stamo),
		.alu_cmt_i_buserr(alu_cmt_i_buserr),
		.alu_cmt_i_badaddr(alu_cmt_i_badaddr),
		.cmt_badaddr(cmt_badaddr_dut),
		.cmt_badaddr_ena(cmt_badaddr_ena_dut),
		.cmt_epc(cmt_epc_dut),
		.cmt_epc_ena(cmt_epc_ena_dut),
		.cmt_cause(cmt_cause_dut),
		.cmt_cause_ena(cmt_cause_ena_dut),
		.cmt_instret_ena(cmt_instret_ena_dut),
		.cmt_status_ena(cmt_status_ena_dut),
		.cmt_dpc(cmt_dpc_dut),
		.cmt_dpc_ena(cmt_dpc_ena_dut),
		.cmt_dcause(cmt_dcause_dut),
		.cmt_dcause_ena(cmt_dcause_ena_dut),
		.cmt_mret_ena(cmt_mret_ena_dut),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.csr_mtvec_r(csr_mtvec_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.oitf_empty(oitf_empty),
		.u_mode(u_mode),
		.s_mode(s_mode),
		.h_mode(h_mode),
		.m_mode(m_mode),
		.longp_excp_i_ready(longp_excp_i_ready_dut),
		.longp_excp_i_valid(longp_excp_i_valid),
		.longp_excp_i_ld(longp_excp_i_ld),
		.longp_excp_i_st(longp_excp_i_st),
		.longp_excp_i_buserr(longp_excp_i_buserr),
		.longp_excp_i_badaddr(longp_excp_i_badaddr),
		.longp_excp_i_insterr(longp_excp_i_insterr),
		.longp_excp_i_pc(longp_excp_i_pc),
		.flush_pulse(flush_pulse_dut),
		.flush_req(flush_req_dut),
		.pipe_flush_ack(pipe_flush_ack),
		.pipe_flush_req(pipe_flush_req_dut),
		.pipe_flush_add_op1(pipe_flush_add_op1_dut),
		.pipe_flush_add_op2(pipe_flush_add_op2_dut),
		.pipe_flush_pc(pipe_flush_pc_dut),
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
		if (stats1.errors_commit_mret)
			$display("Hint: Output 'commit_mret' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_commit_mret, stats1.errortime_commit_mret);
		else
			$display("Hint: Output 'commit_mret' has no mismatches.");
		if (stats1.errors_commit_trap)
			$display("Hint: Output 'commit_trap' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_commit_trap, stats1.errortime_commit_trap);
		else
			$display("Hint: Output 'commit_trap' has no mismatches.");
		if (stats1.errors_core_wfi)
			$display("Hint: Output 'core_wfi' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_core_wfi, stats1.errortime_core_wfi);
		else
			$display("Hint: Output 'core_wfi' has no mismatches.");
		if (stats1.errors_nonflush_cmt_ena)
			$display("Hint: Output 'nonflush_cmt_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nonflush_cmt_ena, stats1.errortime_nonflush_cmt_ena);
		else
			$display("Hint: Output 'nonflush_cmt_ena' has no mismatches.");
		if (stats1.errors_excp_active)
			$display("Hint: Output 'excp_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_excp_active, stats1.errortime_excp_active);
		else
			$display("Hint: Output 'excp_active' has no mismatches.");
		if (stats1.errors_wfi_halt_ifu_req)
			$display("Hint: Output 'wfi_halt_ifu_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wfi_halt_ifu_req, stats1.errortime_wfi_halt_ifu_req);
		else
			$display("Hint: Output 'wfi_halt_ifu_req' has no mismatches.");
		if (stats1.errors_wfi_halt_exu_req)
			$display("Hint: Output 'wfi_halt_exu_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wfi_halt_exu_req, stats1.errortime_wfi_halt_exu_req);
		else
			$display("Hint: Output 'wfi_halt_exu_req' has no mismatches.");
		if (stats1.errors_alu_cmt_i_ready)
			$display("Hint: Output 'alu_cmt_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_alu_cmt_i_ready, stats1.errortime_alu_cmt_i_ready);
		else
			$display("Hint: Output 'alu_cmt_i_ready' has no mismatches.");
		if (stats1.errors_cmt_badaddr)
			$display("Hint: Output 'cmt_badaddr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_badaddr, stats1.errortime_cmt_badaddr);
		else
			$display("Hint: Output 'cmt_badaddr' has no mismatches.");
		if (stats1.errors_cmt_badaddr_ena)
			$display("Hint: Output 'cmt_badaddr_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_badaddr_ena, stats1.errortime_cmt_badaddr_ena);
		else
			$display("Hint: Output 'cmt_badaddr_ena' has no mismatches.");
		if (stats1.errors_cmt_epc)
			$display("Hint: Output 'cmt_epc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_epc, stats1.errortime_cmt_epc);
		else
			$display("Hint: Output 'cmt_epc' has no mismatches.");
		if (stats1.errors_cmt_epc_ena)
			$display("Hint: Output 'cmt_epc_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_epc_ena, stats1.errortime_cmt_epc_ena);
		else
			$display("Hint: Output 'cmt_epc_ena' has no mismatches.");
		if (stats1.errors_cmt_cause)
			$display("Hint: Output 'cmt_cause' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_cause, stats1.errortime_cmt_cause);
		else
			$display("Hint: Output 'cmt_cause' has no mismatches.");
		if (stats1.errors_cmt_cause_ena)
			$display("Hint: Output 'cmt_cause_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_cause_ena, stats1.errortime_cmt_cause_ena);
		else
			$display("Hint: Output 'cmt_cause_ena' has no mismatches.");
		if (stats1.errors_cmt_instret_ena)
			$display("Hint: Output 'cmt_instret_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_instret_ena, stats1.errortime_cmt_instret_ena);
		else
			$display("Hint: Output 'cmt_instret_ena' has no mismatches.");
		if (stats1.errors_cmt_status_ena)
			$display("Hint: Output 'cmt_status_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_status_ena, stats1.errortime_cmt_status_ena);
		else
			$display("Hint: Output 'cmt_status_ena' has no mismatches.");
		if (stats1.errors_cmt_dpc)
			$display("Hint: Output 'cmt_dpc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_dpc, stats1.errortime_cmt_dpc);
		else
			$display("Hint: Output 'cmt_dpc' has no mismatches.");
		if (stats1.errors_cmt_dpc_ena)
			$display("Hint: Output 'cmt_dpc_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_dpc_ena, stats1.errortime_cmt_dpc_ena);
		else
			$display("Hint: Output 'cmt_dpc_ena' has no mismatches.");
		if (stats1.errors_cmt_dcause)
			$display("Hint: Output 'cmt_dcause' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_dcause, stats1.errortime_cmt_dcause);
		else
			$display("Hint: Output 'cmt_dcause' has no mismatches.");
		if (stats1.errors_cmt_dcause_ena)
			$display("Hint: Output 'cmt_dcause_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_dcause_ena, stats1.errortime_cmt_dcause_ena);
		else
			$display("Hint: Output 'cmt_dcause_ena' has no mismatches.");
		if (stats1.errors_cmt_mret_ena)
			$display("Hint: Output 'cmt_mret_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_mret_ena, stats1.errortime_cmt_mret_ena);
		else
			$display("Hint: Output 'cmt_mret_ena' has no mismatches.");
		if (stats1.errors_longp_excp_i_ready)
			$display("Hint: Output 'longp_excp_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_i_ready, stats1.errortime_longp_excp_i_ready);
		else
			$display("Hint: Output 'longp_excp_i_ready' has no mismatches.");
		if (stats1.errors_flush_pulse)
			$display("Hint: Output 'flush_pulse' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_flush_pulse, stats1.errortime_flush_pulse);
		else
			$display("Hint: Output 'flush_pulse' has no mismatches.");
		if (stats1.errors_flush_req)
			$display("Hint: Output 'flush_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_flush_req, stats1.errortime_flush_req);
		else
			$display("Hint: Output 'flush_req' has no mismatches.");
		if (stats1.errors_pipe_flush_req)
			$display("Hint: Output 'pipe_flush_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_pipe_flush_req, stats1.errortime_pipe_flush_req);
		else
			$display("Hint: Output 'pipe_flush_req' has no mismatches.");
		if (stats1.errors_pipe_flush_add_op1)
			$display("Hint: Output 'pipe_flush_add_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_pipe_flush_add_op1, stats1.errortime_pipe_flush_add_op1);
		else
			$display("Hint: Output 'pipe_flush_add_op1' has no mismatches.");
		if (stats1.errors_pipe_flush_add_op2)
			$display("Hint: Output 'pipe_flush_add_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_pipe_flush_add_op2, stats1.errortime_pipe_flush_add_op2);
		else
			$display("Hint: Output 'pipe_flush_add_op2' has no mismatches.");
		if (stats1.errors_pipe_flush_pc)
			$display("Hint: Output 'pipe_flush_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_pipe_flush_pc, stats1.errortime_pipe_flush_pc);
		else
			$display("Hint: Output 'pipe_flush_pc' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ commit_mret_ref,commit_trap_ref,core_wfi_ref,nonflush_cmt_ena_ref,excp_active_ref,wfi_halt_ifu_req_ref,wfi_halt_exu_req_ref,alu_cmt_i_ready_ref,cmt_badaddr_ref,cmt_badaddr_ena_ref,cmt_epc_ref,cmt_epc_ena_ref,cmt_cause_ref,cmt_cause_ena_ref,cmt_instret_ena_ref,cmt_status_ena_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,cmt_mret_ena_ref,longp_excp_i_ready_ref,flush_pulse_ref,flush_req_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref} ===
			( { commit_mret_ref,commit_trap_ref,core_wfi_ref,nonflush_cmt_ena_ref,excp_active_ref,wfi_halt_ifu_req_ref,wfi_halt_exu_req_ref,alu_cmt_i_ready_ref,cmt_badaddr_ref,cmt_badaddr_ena_ref,cmt_epc_ref,cmt_epc_ena_ref,cmt_cause_ref,cmt_cause_ena_ref,cmt_instret_ena_ref,cmt_status_ena_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,cmt_mret_ena_ref,longp_excp_i_ready_ref,flush_pulse_ref,flush_req_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref} ^
			  { commit_mret_dut,commit_trap_dut,core_wfi_dut,nonflush_cmt_ena_dut,excp_active_dut,wfi_halt_ifu_req_dut,wfi_halt_exu_req_dut,alu_cmt_i_ready_dut,cmt_badaddr_dut,cmt_badaddr_ena_dut,cmt_epc_dut,cmt_epc_ena_dut,cmt_cause_dut,cmt_cause_ena_dut,cmt_instret_ena_dut,cmt_status_ena_dut,cmt_dpc_dut,cmt_dpc_ena_dut,cmt_dcause_dut,cmt_dcause_ena_dut,cmt_mret_ena_dut,longp_excp_i_ready_dut,flush_pulse_dut,flush_req_dut,pipe_flush_req_dut,pipe_flush_add_op1_dut,pipe_flush_add_op2_dut,pipe_flush_pc_dut} ^
			  { commit_mret_ref,commit_trap_ref,core_wfi_ref,nonflush_cmt_ena_ref,excp_active_ref,wfi_halt_ifu_req_ref,wfi_halt_exu_req_ref,alu_cmt_i_ready_ref,cmt_badaddr_ref,cmt_badaddr_ena_ref,cmt_epc_ref,cmt_epc_ena_ref,cmt_cause_ref,cmt_cause_ena_ref,cmt_instret_ena_ref,cmt_status_ena_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,cmt_mret_ena_ref,longp_excp_i_ready_ref,flush_pulse_ref,flush_req_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (commit_mret_ref !== (commit_mret_ref ^ commit_mret_dut ^ commit_mret_ref)) begin
			if (stats1.errors_commit_mret == 0) stats1.errortime_commit_mret = $time;
			stats1.errors_commit_mret++;
		end
		if (commit_trap_ref !== (commit_trap_ref ^ commit_trap_dut ^ commit_trap_ref)) begin
			if (stats1.errors_commit_trap == 0) stats1.errortime_commit_trap = $time;
			stats1.errors_commit_trap++;
		end
		if (core_wfi_ref !== (core_wfi_ref ^ core_wfi_dut ^ core_wfi_ref)) begin
			if (stats1.errors_core_wfi == 0) stats1.errortime_core_wfi = $time;
			stats1.errors_core_wfi++;
		end
		if (nonflush_cmt_ena_ref !== (nonflush_cmt_ena_ref ^ nonflush_cmt_ena_dut ^ nonflush_cmt_ena_ref)) begin
			if (stats1.errors_nonflush_cmt_ena == 0) stats1.errortime_nonflush_cmt_ena = $time;
			stats1.errors_nonflush_cmt_ena++;
		end
		if (excp_active_ref !== (excp_active_ref ^ excp_active_dut ^ excp_active_ref)) begin
			if (stats1.errors_excp_active == 0) stats1.errortime_excp_active = $time;
			stats1.errors_excp_active++;
		end
		if (wfi_halt_ifu_req_ref !== (wfi_halt_ifu_req_ref ^ wfi_halt_ifu_req_dut ^ wfi_halt_ifu_req_ref)) begin
			if (stats1.errors_wfi_halt_ifu_req == 0) stats1.errortime_wfi_halt_ifu_req = $time;
			stats1.errors_wfi_halt_ifu_req++;
		end
		if (wfi_halt_exu_req_ref !== (wfi_halt_exu_req_ref ^ wfi_halt_exu_req_dut ^ wfi_halt_exu_req_ref)) begin
			if (stats1.errors_wfi_halt_exu_req == 0) stats1.errortime_wfi_halt_exu_req = $time;
			stats1.errors_wfi_halt_exu_req++;
		end
		if (alu_cmt_i_ready_ref !== (alu_cmt_i_ready_ref ^ alu_cmt_i_ready_dut ^ alu_cmt_i_ready_ref)) begin
			if (stats1.errors_alu_cmt_i_ready == 0) stats1.errortime_alu_cmt_i_ready = $time;
			stats1.errors_alu_cmt_i_ready++;
		end
		if (cmt_badaddr_ref !== (cmt_badaddr_ref ^ cmt_badaddr_dut ^ cmt_badaddr_ref)) begin
			if (stats1.errors_cmt_badaddr == 0) stats1.errortime_cmt_badaddr = $time;
			stats1.errors_cmt_badaddr++;
		end
		if (cmt_badaddr_ena_ref !== (cmt_badaddr_ena_ref ^ cmt_badaddr_ena_dut ^ cmt_badaddr_ena_ref)) begin
			if (stats1.errors_cmt_badaddr_ena == 0) stats1.errortime_cmt_badaddr_ena = $time;
			stats1.errors_cmt_badaddr_ena++;
		end
		if (cmt_epc_ref !== (cmt_epc_ref ^ cmt_epc_dut ^ cmt_epc_ref)) begin
			if (stats1.errors_cmt_epc == 0) stats1.errortime_cmt_epc = $time;
			stats1.errors_cmt_epc++;
		end
		if (cmt_epc_ena_ref !== (cmt_epc_ena_ref ^ cmt_epc_ena_dut ^ cmt_epc_ena_ref)) begin
			if (stats1.errors_cmt_epc_ena == 0) stats1.errortime_cmt_epc_ena = $time;
			stats1.errors_cmt_epc_ena++;
		end
		if (cmt_cause_ref !== (cmt_cause_ref ^ cmt_cause_dut ^ cmt_cause_ref)) begin
			if (stats1.errors_cmt_cause == 0) stats1.errortime_cmt_cause = $time;
			stats1.errors_cmt_cause++;
		end
		if (cmt_cause_ena_ref !== (cmt_cause_ena_ref ^ cmt_cause_ena_dut ^ cmt_cause_ena_ref)) begin
			if (stats1.errors_cmt_cause_ena == 0) stats1.errortime_cmt_cause_ena = $time;
			stats1.errors_cmt_cause_ena++;
		end
		if (cmt_instret_ena_ref !== (cmt_instret_ena_ref ^ cmt_instret_ena_dut ^ cmt_instret_ena_ref)) begin
			if (stats1.errors_cmt_instret_ena == 0) stats1.errortime_cmt_instret_ena = $time;
			stats1.errors_cmt_instret_ena++;
		end
		if (cmt_status_ena_ref !== (cmt_status_ena_ref ^ cmt_status_ena_dut ^ cmt_status_ena_ref)) begin
			if (stats1.errors_cmt_status_ena == 0) stats1.errortime_cmt_status_ena = $time;
			stats1.errors_cmt_status_ena++;
		end
		if (cmt_dpc_ref !== (cmt_dpc_ref ^ cmt_dpc_dut ^ cmt_dpc_ref)) begin
			if (stats1.errors_cmt_dpc == 0) stats1.errortime_cmt_dpc = $time;
			stats1.errors_cmt_dpc++;
		end
		if (cmt_dpc_ena_ref !== (cmt_dpc_ena_ref ^ cmt_dpc_ena_dut ^ cmt_dpc_ena_ref)) begin
			if (stats1.errors_cmt_dpc_ena == 0) stats1.errortime_cmt_dpc_ena = $time;
			stats1.errors_cmt_dpc_ena++;
		end
		if (cmt_dcause_ref !== (cmt_dcause_ref ^ cmt_dcause_dut ^ cmt_dcause_ref)) begin
			if (stats1.errors_cmt_dcause == 0) stats1.errortime_cmt_dcause = $time;
			stats1.errors_cmt_dcause++;
		end
		if (cmt_dcause_ena_ref !== (cmt_dcause_ena_ref ^ cmt_dcause_ena_dut ^ cmt_dcause_ena_ref)) begin
			if (stats1.errors_cmt_dcause_ena == 0) stats1.errortime_cmt_dcause_ena = $time;
			stats1.errors_cmt_dcause_ena++;
		end
		if (cmt_mret_ena_ref !== (cmt_mret_ena_ref ^ cmt_mret_ena_dut ^ cmt_mret_ena_ref)) begin
			if (stats1.errors_cmt_mret_ena == 0) stats1.errortime_cmt_mret_ena = $time;
			stats1.errors_cmt_mret_ena++;
		end
		if (longp_excp_i_ready_ref !== (longp_excp_i_ready_ref ^ longp_excp_i_ready_dut ^ longp_excp_i_ready_ref)) begin
			if (stats1.errors_longp_excp_i_ready == 0) stats1.errortime_longp_excp_i_ready = $time;
			stats1.errors_longp_excp_i_ready++;
		end
		if (flush_pulse_ref !== (flush_pulse_ref ^ flush_pulse_dut ^ flush_pulse_ref)) begin
			if (stats1.errors_flush_pulse == 0) stats1.errortime_flush_pulse = $time;
			stats1.errors_flush_pulse++;
		end
		if (flush_req_ref !== (flush_req_ref ^ flush_req_dut ^ flush_req_ref)) begin
			if (stats1.errors_flush_req == 0) stats1.errortime_flush_req = $time;
			stats1.errors_flush_req++;
		end
		if (pipe_flush_req_ref !== (pipe_flush_req_ref ^ pipe_flush_req_dut ^ pipe_flush_req_ref)) begin
			if (stats1.errors_pipe_flush_req == 0) stats1.errortime_pipe_flush_req = $time;
			stats1.errors_pipe_flush_req++;
		end
		if (pipe_flush_add_op1_ref !== (pipe_flush_add_op1_ref ^ pipe_flush_add_op1_dut ^ pipe_flush_add_op1_ref)) begin
			if (stats1.errors_pipe_flush_add_op1 == 0) stats1.errortime_pipe_flush_add_op1 = $time;
			stats1.errors_pipe_flush_add_op1++;
		end
		if (pipe_flush_add_op2_ref !== (pipe_flush_add_op2_ref ^ pipe_flush_add_op2_dut ^ pipe_flush_add_op2_ref)) begin
			if (stats1.errors_pipe_flush_add_op2 == 0) stats1.errortime_pipe_flush_add_op2 = $time;
			stats1.errors_pipe_flush_add_op2++;
		end
		if (pipe_flush_pc_ref !== (pipe_flush_pc_ref ^ pipe_flush_pc_dut ^ pipe_flush_pc_ref)) begin
			if (stats1.errors_pipe_flush_pc == 0) stats1.errortime_pipe_flush_pc = $time;
			stats1.errors_pipe_flush_pc++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
