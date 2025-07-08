`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_commit_mret;
		int errortime_commit_mret;
		int errors_commit_trap;
		int errortime_commit_trap;
		int errors_exu_active;
		int errortime_exu_active;
		int errors_excp_active;
		int errortime_excp_active;
		int errors_core_wfi;
		int errortime_core_wfi;
		int errors_tm_stop;
		int errortime_tm_stop;
		int errors_itcm_nohold;
		int errortime_itcm_nohold;
		int errors_core_cgstop;
		int errortime_core_cgstop;
		int errors_tcm_cgstop;
		int errortime_tcm_cgstop;
		int errors_cmt_dpc;
		int errortime_cmt_dpc;
		int errors_cmt_dpc_ena;
		int errortime_cmt_dpc_ena;
		int errors_cmt_dcause;
		int errortime_cmt_dcause;
		int errors_cmt_dcause_ena;
		int errortime_cmt_dcause_ena;
		int errors_wr_dcsr_ena;
		int errortime_wr_dcsr_ena;
		int errors_wr_dpc_ena;
		int errortime_wr_dpc_ena;
		int errors_wr_dscratch_ena;
		int errortime_wr_dscratch_ena;
		int errors_wr_csr_nxt;
		int errortime_wr_csr_nxt;
		int errors_i_ready;
		int errortime_i_ready;
		int errors_pipe_flush_req;
		int errortime_pipe_flush_req;
		int errors_pipe_flush_add_op1;
		int errortime_pipe_flush_add_op1;
		int errors_pipe_flush_add_op2;
		int errortime_pipe_flush_add_op2;
		int errors_pipe_flush_pc;
		int errortime_pipe_flush_pc;
		int errors_lsu_o_ready;
		int errortime_lsu_o_ready;
		int errors_wfi_halt_ifu_req;
		int errortime_wfi_halt_ifu_req;
		int errors_oitf_empty;
		int errortime_oitf_empty;
		int errors_rf2ifu_x1;
		int errortime_rf2ifu_x1;
		int errors_rf2ifu_rs1;
		int errortime_rf2ifu_rs1;
		int errors_dec2ifu_rden;
		int errortime_dec2ifu_rden;
		int errors_dec2ifu_rs1en;
		int errortime_dec2ifu_rs1en;
		int errors_dec2ifu_rdidx;
		int errortime_dec2ifu_rdidx;
		int errors_dec2ifu_mulhsu;
		int errortime_dec2ifu_mulhsu;
		int errors_dec2ifu_div;
		int errortime_dec2ifu_div;
		int errors_dec2ifu_rem;
		int errortime_dec2ifu_rem;
		int errors_dec2ifu_divu;
		int errortime_dec2ifu_divu;
		int errors_dec2ifu_remu;
		int errortime_dec2ifu_remu;
		int errors_agu_icb_cmd_valid;
		int errortime_agu_icb_cmd_valid;
		int errors_agu_icb_cmd_addr;
		int errortime_agu_icb_cmd_addr;
		int errors_agu_icb_cmd_read;
		int errortime_agu_icb_cmd_read;
		int errors_agu_icb_cmd_wdata;
		int errortime_agu_icb_cmd_wdata;
		int errors_agu_icb_cmd_wmask;
		int errortime_agu_icb_cmd_wmask;
		int errors_agu_icb_cmd_lock;
		int errortime_agu_icb_cmd_lock;
		int errors_agu_icb_cmd_excl;
		int errortime_agu_icb_cmd_excl;
		int errors_agu_icb_cmd_size;
		int errortime_agu_icb_cmd_size;
		int errors_agu_icb_cmd_back2agu;
		int errortime_agu_icb_cmd_back2agu;
		int errors_agu_icb_cmd_usign;
		int errortime_agu_icb_cmd_usign;
		int errors_agu_icb_cmd_itag;
		int errortime_agu_icb_cmd_itag;
		int errors_agu_icb_rsp_ready;
		int errortime_agu_icb_rsp_ready;
		int errors_nice_req_valid;
		int errortime_nice_req_valid;
		int errors_nice_req_inst;
		int errortime_nice_req_inst;
		int errors_nice_req_rs1;
		int errortime_nice_req_rs1;
		int errors_nice_req_rs2;
		int errortime_nice_req_rs2;
		int errors_nice_rsp_multicyc_ready;
		int errortime_nice_rsp_multicyc_ready;
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
	logic exu_active_ref;
	logic exu_active_dut;
	logic excp_active_ref;
	logic excp_active_dut;
	logic core_wfi_ref;
	logic core_wfi_dut;
	logic tm_stop_ref;
	logic tm_stop_dut;
	logic itcm_nohold_ref;
	logic itcm_nohold_dut;
	logic core_cgstop_ref;
	logic core_cgstop_dut;
	logic tcm_cgstop_ref;
	logic tcm_cgstop_dut;
	logic core_mhartid;
	logic dbg_irq_r;
	logic lcl_irq_r;
	logic evt_r;
	logic ext_irq_r;
	logic sft_irq_r;
	logic tmr_irq_r;
	logic [32-1:0] cmt_dpc_ref;
	logic [32-1:0] cmt_dpc_dut;
	logic cmt_dpc_ena_ref;
	logic cmt_dpc_ena_dut;
	logic [3-1:0] cmt_dcause_ref;
	logic [3-1:0] cmt_dcause_dut;
	logic cmt_dcause_ena_ref;
	logic cmt_dcause_ena_dut;
	logic wr_dcsr_ena_ref;
	logic wr_dcsr_ena_dut;
	logic wr_dpc_ena_ref;
	logic wr_dpc_ena_dut;
	logic wr_dscratch_ena_ref;
	logic wr_dscratch_ena_dut;
	logic [32-1:0] wr_csr_nxt_ref;
	logic [32-1:0] wr_csr_nxt_dut;
	logic [32-1:0] dcsr_r;
	logic [32-1:0] dpc_r;
	logic [32-1:0] dscratch_r;
	logic dbg_mode;
	logic dbg_halt_r;
	logic dbg_step_r;
	logic dbg_ebreakm_r;
	logic dbg_stopcycle;
	logic i_valid;
	logic i_ready_ref;
	logic i_ready_dut;
	logic [32-1:0] i_ir;
	logic [32-1:0] i_pc;
	logic i_pc_vld;
	logic i_misalgn;
	logic i_buserr;
	logic i_prdt_taken;
	logic i_muldiv_b2b;
	logic [5-1:0] i_rs1idx;
	logic [5-1:0] i_rs2idx;
	logic pipe_flush_ack;
	logic pipe_flush_req_ref;
	logic pipe_flush_req_dut;
	logic [32-1:0] pipe_flush_add_op1_ref;
	logic [32-1:0] pipe_flush_add_op1_dut;
	logic [32-1:0] pipe_flush_add_op2_ref;
	logic [32-1:0] pipe_flush_add_op2_dut;
	logic [32-1:0] pipe_flush_pc_ref;
	logic [32-1:0] pipe_flush_pc_dut;
	logic lsu_o_valid;
	logic lsu_o_ready_ref;
	logic lsu_o_ready_dut;
	logic [32-1:0] lsu_o_wbck_wdat;
	logic lsu_o_wbck_itag;
	logic lsu_o_wbck_err;
	logic lsu_o_cmt_ld;
	logic lsu_o_cmt_st;
	logic [32-1:0] lsu_o_cmt_badaddr;
	logic lsu_o_cmt_buserr;
	logic wfi_halt_ifu_req_ref;
	logic wfi_halt_ifu_req_dut;
	logic wfi_halt_ifu_ack;
	logic oitf_empty_ref;
	logic oitf_empty_dut;
	logic [32-1:0] rf2ifu_x1_ref;
	logic [32-1:0] rf2ifu_x1_dut;
	logic [32-1:0] rf2ifu_rs1_ref;
	logic [32-1:0] rf2ifu_rs1_dut;
	logic dec2ifu_rden_ref;
	logic dec2ifu_rden_dut;
	logic dec2ifu_rs1en_ref;
	logic dec2ifu_rs1en_dut;
	logic [5-1:0] dec2ifu_rdidx_ref;
	logic [5-1:0] dec2ifu_rdidx_dut;
	logic dec2ifu_mulhsu_ref;
	logic dec2ifu_mulhsu_dut;
	logic dec2ifu_div_ref;
	logic dec2ifu_div_dut;
	logic dec2ifu_rem_ref;
	logic dec2ifu_rem_dut;
	logic dec2ifu_divu_ref;
	logic dec2ifu_divu_dut;
	logic dec2ifu_remu_ref;
	logic dec2ifu_remu_dut;
	logic agu_icb_cmd_valid_ref;
	logic agu_icb_cmd_valid_dut;
	logic agu_icb_cmd_ready;
	logic [32-1:0] agu_icb_cmd_addr_ref;
	logic [32-1:0] agu_icb_cmd_addr_dut;
	logic agu_icb_cmd_read_ref;
	logic agu_icb_cmd_read_dut;
	logic [32-1:0] agu_icb_cmd_wdata_ref;
	logic [32-1:0] agu_icb_cmd_wdata_dut;
	logic [4-1:0] agu_icb_cmd_wmask_ref;
	logic [4-1:0] agu_icb_cmd_wmask_dut;
	logic agu_icb_cmd_lock_ref;
	logic agu_icb_cmd_lock_dut;
	logic agu_icb_cmd_excl_ref;
	logic agu_icb_cmd_excl_dut;
	logic [2-1:0] agu_icb_cmd_size_ref;
	logic [2-1:0] agu_icb_cmd_size_dut;
	logic agu_icb_cmd_back2agu_ref;
	logic agu_icb_cmd_back2agu_dut;
	logic agu_icb_cmd_usign_ref;
	logic agu_icb_cmd_usign_dut;
	logic agu_icb_cmd_itag_ref;
	logic agu_icb_cmd_itag_dut;
	logic agu_icb_rsp_valid;
	logic agu_icb_rsp_ready_ref;
	logic agu_icb_rsp_ready_dut;
	logic agu_icb_rsp_err;
	logic agu_icb_rsp_excl_ok;
	logic [32-1:0] agu_icb_rsp_rdata;
	logic nice_req_valid_ref;
	logic nice_req_valid_dut;
	logic nice_req_ready;
	logic [32-1:0] nice_req_inst_ref;
	logic [32-1:0] nice_req_inst_dut;
	logic [32-1:0] nice_req_rs1_ref;
	logic [32-1:0] nice_req_rs1_dut;
	logic [32-1:0] nice_req_rs2_ref;
	logic [32-1:0] nice_req_rs2_dut;
	logic nice_rsp_multicyc_valid;
	logic nice_rsp_multicyc_ready_ref;
	logic nice_rsp_multicyc_ready_dut;
	logic [32-1:0] nice_rsp_multicyc_dat;
	logic nice_rsp_multicyc_err;
	logic test_mode;
	logic clk_aon;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.core_mhartid(core_mhartid),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.evt_r(evt_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.i_valid(i_valid),
		.i_ir(i_ir),
		.i_pc(i_pc),
		.i_pc_vld(i_pc_vld),
		.i_misalgn(i_misalgn),
		.i_buserr(i_buserr),
		.i_prdt_taken(i_prdt_taken),
		.i_muldiv_b2b(i_muldiv_b2b),
		.i_rs1idx(i_rs1idx),
		.i_rs2idx(i_rs2idx),
		.pipe_flush_ack(pipe_flush_ack),
		.lsu_o_valid(lsu_o_valid),
		.lsu_o_wbck_wdat(lsu_o_wbck_wdat),
		.lsu_o_wbck_itag(lsu_o_wbck_itag),
		.lsu_o_wbck_err(lsu_o_wbck_err),
		.lsu_o_cmt_ld(lsu_o_cmt_ld),
		.lsu_o_cmt_st(lsu_o_cmt_st),
		.lsu_o_cmt_badaddr(lsu_o_cmt_badaddr),
		.lsu_o_cmt_buserr(lsu_o_cmt_buserr),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.nice_req_ready(nice_req_ready),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.test_mode(test_mode),
		.clk_aon(clk_aon),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu good1 (
		.commit_mret(commit_mret_ref),
		.commit_trap(commit_trap_ref),
		.exu_active(exu_active_ref),
		.excp_active(excp_active_ref),
		.core_wfi(core_wfi_ref),
		.tm_stop(tm_stop_ref),
		.itcm_nohold(itcm_nohold_ref),
		.core_cgstop(core_cgstop_ref),
		.tcm_cgstop(tcm_cgstop_ref),
		.core_mhartid(core_mhartid),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.evt_r(evt_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.cmt_dpc(cmt_dpc_ref),
		.cmt_dpc_ena(cmt_dpc_ena_ref),
		.cmt_dcause(cmt_dcause_ref),
		.cmt_dcause_ena(cmt_dcause_ena_ref),
		.wr_dcsr_ena(wr_dcsr_ena_ref),
		.wr_dpc_ena(wr_dpc_ena_ref),
		.wr_dscratch_ena(wr_dscratch_ena_ref),
		.wr_csr_nxt(wr_csr_nxt_ref),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.i_valid(i_valid),
		.i_ready(i_ready_ref),
		.i_ir(i_ir),
		.i_pc(i_pc),
		.i_pc_vld(i_pc_vld),
		.i_misalgn(i_misalgn),
		.i_buserr(i_buserr),
		.i_prdt_taken(i_prdt_taken),
		.i_muldiv_b2b(i_muldiv_b2b),
		.i_rs1idx(i_rs1idx),
		.i_rs2idx(i_rs2idx),
		.pipe_flush_ack(pipe_flush_ack),
		.pipe_flush_req(pipe_flush_req_ref),
		.pipe_flush_add_op1(pipe_flush_add_op1_ref),
		.pipe_flush_add_op2(pipe_flush_add_op2_ref),
		.pipe_flush_pc(pipe_flush_pc_ref),
		.lsu_o_valid(lsu_o_valid),
		.lsu_o_ready(lsu_o_ready_ref),
		.lsu_o_wbck_wdat(lsu_o_wbck_wdat),
		.lsu_o_wbck_itag(lsu_o_wbck_itag),
		.lsu_o_wbck_err(lsu_o_wbck_err),
		.lsu_o_cmt_ld(lsu_o_cmt_ld),
		.lsu_o_cmt_st(lsu_o_cmt_st),
		.lsu_o_cmt_badaddr(lsu_o_cmt_badaddr),
		.lsu_o_cmt_buserr(lsu_o_cmt_buserr),
		.wfi_halt_ifu_req(wfi_halt_ifu_req_ref),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.oitf_empty(oitf_empty_ref),
		.rf2ifu_x1(rf2ifu_x1_ref),
		.rf2ifu_rs1(rf2ifu_rs1_ref),
		.dec2ifu_rden(dec2ifu_rden_ref),
		.dec2ifu_rs1en(dec2ifu_rs1en_ref),
		.dec2ifu_rdidx(dec2ifu_rdidx_ref),
		.dec2ifu_mulhsu(dec2ifu_mulhsu_ref),
		.dec2ifu_div(dec2ifu_div_ref),
		.dec2ifu_rem(dec2ifu_rem_ref),
		.dec2ifu_divu(dec2ifu_divu_ref),
		.dec2ifu_remu(dec2ifu_remu_ref),
		.agu_icb_cmd_valid(agu_icb_cmd_valid_ref),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_cmd_addr(agu_icb_cmd_addr_ref),
		.agu_icb_cmd_read(agu_icb_cmd_read_ref),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata_ref),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask_ref),
		.agu_icb_cmd_lock(agu_icb_cmd_lock_ref),
		.agu_icb_cmd_excl(agu_icb_cmd_excl_ref),
		.agu_icb_cmd_size(agu_icb_cmd_size_ref),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu_ref),
		.agu_icb_cmd_usign(agu_icb_cmd_usign_ref),
		.agu_icb_cmd_itag(agu_icb_cmd_itag_ref),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_ready(agu_icb_rsp_ready_ref),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.nice_req_valid(nice_req_valid_ref),
		.nice_req_ready(nice_req_ready),
		.nice_req_inst(nice_req_inst_ref),
		.nice_req_rs1(nice_req_rs1_ref),
		.nice_req_rs2(nice_req_rs2_ref),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_ref),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.test_mode(test_mode),
		.clk_aon(clk_aon),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu top_module1 (
		.commit_mret(commit_mret_dut),
		.commit_trap(commit_trap_dut),
		.exu_active(exu_active_dut),
		.excp_active(excp_active_dut),
		.core_wfi(core_wfi_dut),
		.tm_stop(tm_stop_dut),
		.itcm_nohold(itcm_nohold_dut),
		.core_cgstop(core_cgstop_dut),
		.tcm_cgstop(tcm_cgstop_dut),
		.core_mhartid(core_mhartid),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.evt_r(evt_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.cmt_dpc(cmt_dpc_dut),
		.cmt_dpc_ena(cmt_dpc_ena_dut),
		.cmt_dcause(cmt_dcause_dut),
		.cmt_dcause_ena(cmt_dcause_ena_dut),
		.wr_dcsr_ena(wr_dcsr_ena_dut),
		.wr_dpc_ena(wr_dpc_ena_dut),
		.wr_dscratch_ena(wr_dscratch_ena_dut),
		.wr_csr_nxt(wr_csr_nxt_dut),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.i_valid(i_valid),
		.i_ready(i_ready_dut),
		.i_ir(i_ir),
		.i_pc(i_pc),
		.i_pc_vld(i_pc_vld),
		.i_misalgn(i_misalgn),
		.i_buserr(i_buserr),
		.i_prdt_taken(i_prdt_taken),
		.i_muldiv_b2b(i_muldiv_b2b),
		.i_rs1idx(i_rs1idx),
		.i_rs2idx(i_rs2idx),
		.pipe_flush_ack(pipe_flush_ack),
		.pipe_flush_req(pipe_flush_req_dut),
		.pipe_flush_add_op1(pipe_flush_add_op1_dut),
		.pipe_flush_add_op2(pipe_flush_add_op2_dut),
		.pipe_flush_pc(pipe_flush_pc_dut),
		.lsu_o_valid(lsu_o_valid),
		.lsu_o_ready(lsu_o_ready_dut),
		.lsu_o_wbck_wdat(lsu_o_wbck_wdat),
		.lsu_o_wbck_itag(lsu_o_wbck_itag),
		.lsu_o_wbck_err(lsu_o_wbck_err),
		.lsu_o_cmt_ld(lsu_o_cmt_ld),
		.lsu_o_cmt_st(lsu_o_cmt_st),
		.lsu_o_cmt_badaddr(lsu_o_cmt_badaddr),
		.lsu_o_cmt_buserr(lsu_o_cmt_buserr),
		.wfi_halt_ifu_req(wfi_halt_ifu_req_dut),
		.wfi_halt_ifu_ack(wfi_halt_ifu_ack),
		.oitf_empty(oitf_empty_dut),
		.rf2ifu_x1(rf2ifu_x1_dut),
		.rf2ifu_rs1(rf2ifu_rs1_dut),
		.dec2ifu_rden(dec2ifu_rden_dut),
		.dec2ifu_rs1en(dec2ifu_rs1en_dut),
		.dec2ifu_rdidx(dec2ifu_rdidx_dut),
		.dec2ifu_mulhsu(dec2ifu_mulhsu_dut),
		.dec2ifu_div(dec2ifu_div_dut),
		.dec2ifu_rem(dec2ifu_rem_dut),
		.dec2ifu_divu(dec2ifu_divu_dut),
		.dec2ifu_remu(dec2ifu_remu_dut),
		.agu_icb_cmd_valid(agu_icb_cmd_valid_dut),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_cmd_addr(agu_icb_cmd_addr_dut),
		.agu_icb_cmd_read(agu_icb_cmd_read_dut),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata_dut),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask_dut),
		.agu_icb_cmd_lock(agu_icb_cmd_lock_dut),
		.agu_icb_cmd_excl(agu_icb_cmd_excl_dut),
		.agu_icb_cmd_size(agu_icb_cmd_size_dut),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu_dut),
		.agu_icb_cmd_usign(agu_icb_cmd_usign_dut),
		.agu_icb_cmd_itag(agu_icb_cmd_itag_dut),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_ready(agu_icb_rsp_ready_dut),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.nice_req_valid(nice_req_valid_dut),
		.nice_req_ready(nice_req_ready),
		.nice_req_inst(nice_req_inst_dut),
		.nice_req_rs1(nice_req_rs1_dut),
		.nice_req_rs2(nice_req_rs2_dut),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_dut),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.test_mode(test_mode),
		.clk_aon(clk_aon),
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
		if (stats1.errors_exu_active)
			$display("Hint: Output 'exu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_exu_active, stats1.errortime_exu_active);
		else
			$display("Hint: Output 'exu_active' has no mismatches.");
		if (stats1.errors_excp_active)
			$display("Hint: Output 'excp_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_excp_active, stats1.errortime_excp_active);
		else
			$display("Hint: Output 'excp_active' has no mismatches.");
		if (stats1.errors_core_wfi)
			$display("Hint: Output 'core_wfi' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_core_wfi, stats1.errortime_core_wfi);
		else
			$display("Hint: Output 'core_wfi' has no mismatches.");
		if (stats1.errors_tm_stop)
			$display("Hint: Output 'tm_stop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_tm_stop, stats1.errortime_tm_stop);
		else
			$display("Hint: Output 'tm_stop' has no mismatches.");
		if (stats1.errors_itcm_nohold)
			$display("Hint: Output 'itcm_nohold' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_nohold, stats1.errortime_itcm_nohold);
		else
			$display("Hint: Output 'itcm_nohold' has no mismatches.");
		if (stats1.errors_core_cgstop)
			$display("Hint: Output 'core_cgstop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_core_cgstop, stats1.errortime_core_cgstop);
		else
			$display("Hint: Output 'core_cgstop' has no mismatches.");
		if (stats1.errors_tcm_cgstop)
			$display("Hint: Output 'tcm_cgstop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_tcm_cgstop, stats1.errortime_tcm_cgstop);
		else
			$display("Hint: Output 'tcm_cgstop' has no mismatches.");
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
		if (stats1.errors_wr_dcsr_ena)
			$display("Hint: Output 'wr_dcsr_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wr_dcsr_ena, stats1.errortime_wr_dcsr_ena);
		else
			$display("Hint: Output 'wr_dcsr_ena' has no mismatches.");
		if (stats1.errors_wr_dpc_ena)
			$display("Hint: Output 'wr_dpc_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wr_dpc_ena, stats1.errortime_wr_dpc_ena);
		else
			$display("Hint: Output 'wr_dpc_ena' has no mismatches.");
		if (stats1.errors_wr_dscratch_ena)
			$display("Hint: Output 'wr_dscratch_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wr_dscratch_ena, stats1.errortime_wr_dscratch_ena);
		else
			$display("Hint: Output 'wr_dscratch_ena' has no mismatches.");
		if (stats1.errors_wr_csr_nxt)
			$display("Hint: Output 'wr_csr_nxt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wr_csr_nxt, stats1.errortime_wr_csr_nxt);
		else
			$display("Hint: Output 'wr_csr_nxt' has no mismatches.");
		if (stats1.errors_i_ready)
			$display("Hint: Output 'i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_i_ready, stats1.errortime_i_ready);
		else
			$display("Hint: Output 'i_ready' has no mismatches.");
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
		if (stats1.errors_lsu_o_ready)
			$display("Hint: Output 'lsu_o_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_ready, stats1.errortime_lsu_o_ready);
		else
			$display("Hint: Output 'lsu_o_ready' has no mismatches.");
		if (stats1.errors_wfi_halt_ifu_req)
			$display("Hint: Output 'wfi_halt_ifu_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wfi_halt_ifu_req, stats1.errortime_wfi_halt_ifu_req);
		else
			$display("Hint: Output 'wfi_halt_ifu_req' has no mismatches.");
		if (stats1.errors_oitf_empty)
			$display("Hint: Output 'oitf_empty' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitf_empty, stats1.errortime_oitf_empty);
		else
			$display("Hint: Output 'oitf_empty' has no mismatches.");
		if (stats1.errors_rf2ifu_x1)
			$display("Hint: Output 'rf2ifu_x1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rf2ifu_x1, stats1.errortime_rf2ifu_x1);
		else
			$display("Hint: Output 'rf2ifu_x1' has no mismatches.");
		if (stats1.errors_rf2ifu_rs1)
			$display("Hint: Output 'rf2ifu_rs1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_rf2ifu_rs1, stats1.errortime_rf2ifu_rs1);
		else
			$display("Hint: Output 'rf2ifu_rs1' has no mismatches.");
		if (stats1.errors_dec2ifu_rden)
			$display("Hint: Output 'dec2ifu_rden' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_rden, stats1.errortime_dec2ifu_rden);
		else
			$display("Hint: Output 'dec2ifu_rden' has no mismatches.");
		if (stats1.errors_dec2ifu_rs1en)
			$display("Hint: Output 'dec2ifu_rs1en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_rs1en, stats1.errortime_dec2ifu_rs1en);
		else
			$display("Hint: Output 'dec2ifu_rs1en' has no mismatches.");
		if (stats1.errors_dec2ifu_rdidx)
			$display("Hint: Output 'dec2ifu_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_rdidx, stats1.errortime_dec2ifu_rdidx);
		else
			$display("Hint: Output 'dec2ifu_rdidx' has no mismatches.");
		if (stats1.errors_dec2ifu_mulhsu)
			$display("Hint: Output 'dec2ifu_mulhsu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_mulhsu, stats1.errortime_dec2ifu_mulhsu);
		else
			$display("Hint: Output 'dec2ifu_mulhsu' has no mismatches.");
		if (stats1.errors_dec2ifu_div)
			$display("Hint: Output 'dec2ifu_div' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_div, stats1.errortime_dec2ifu_div);
		else
			$display("Hint: Output 'dec2ifu_div' has no mismatches.");
		if (stats1.errors_dec2ifu_rem)
			$display("Hint: Output 'dec2ifu_rem' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_rem, stats1.errortime_dec2ifu_rem);
		else
			$display("Hint: Output 'dec2ifu_rem' has no mismatches.");
		if (stats1.errors_dec2ifu_divu)
			$display("Hint: Output 'dec2ifu_divu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_divu, stats1.errortime_dec2ifu_divu);
		else
			$display("Hint: Output 'dec2ifu_divu' has no mismatches.");
		if (stats1.errors_dec2ifu_remu)
			$display("Hint: Output 'dec2ifu_remu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dec2ifu_remu, stats1.errortime_dec2ifu_remu);
		else
			$display("Hint: Output 'dec2ifu_remu' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_valid)
			$display("Hint: Output 'agu_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_valid, stats1.errortime_agu_icb_cmd_valid);
		else
			$display("Hint: Output 'agu_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_addr)
			$display("Hint: Output 'agu_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_addr, stats1.errortime_agu_icb_cmd_addr);
		else
			$display("Hint: Output 'agu_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_read)
			$display("Hint: Output 'agu_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_read, stats1.errortime_agu_icb_cmd_read);
		else
			$display("Hint: Output 'agu_icb_cmd_read' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_wdata)
			$display("Hint: Output 'agu_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_wdata, stats1.errortime_agu_icb_cmd_wdata);
		else
			$display("Hint: Output 'agu_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_wmask)
			$display("Hint: Output 'agu_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_wmask, stats1.errortime_agu_icb_cmd_wmask);
		else
			$display("Hint: Output 'agu_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_lock)
			$display("Hint: Output 'agu_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_lock, stats1.errortime_agu_icb_cmd_lock);
		else
			$display("Hint: Output 'agu_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_excl)
			$display("Hint: Output 'agu_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_excl, stats1.errortime_agu_icb_cmd_excl);
		else
			$display("Hint: Output 'agu_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_size)
			$display("Hint: Output 'agu_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_size, stats1.errortime_agu_icb_cmd_size);
		else
			$display("Hint: Output 'agu_icb_cmd_size' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_back2agu)
			$display("Hint: Output 'agu_icb_cmd_back2agu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_back2agu, stats1.errortime_agu_icb_cmd_back2agu);
		else
			$display("Hint: Output 'agu_icb_cmd_back2agu' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_usign)
			$display("Hint: Output 'agu_icb_cmd_usign' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_usign, stats1.errortime_agu_icb_cmd_usign);
		else
			$display("Hint: Output 'agu_icb_cmd_usign' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_itag)
			$display("Hint: Output 'agu_icb_cmd_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_itag, stats1.errortime_agu_icb_cmd_itag);
		else
			$display("Hint: Output 'agu_icb_cmd_itag' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_ready)
			$display("Hint: Output 'agu_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_ready, stats1.errortime_agu_icb_rsp_ready);
		else
			$display("Hint: Output 'agu_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_nice_req_valid)
			$display("Hint: Output 'nice_req_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_valid, stats1.errortime_nice_req_valid);
		else
			$display("Hint: Output 'nice_req_valid' has no mismatches.");
		if (stats1.errors_nice_req_inst)
			$display("Hint: Output 'nice_req_inst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_req_inst, stats1.errortime_nice_req_inst);
		else
			$display("Hint: Output 'nice_req_inst' has no mismatches.");
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
		if (stats1.errors_nice_rsp_multicyc_ready)
			$display("Hint: Output 'nice_rsp_multicyc_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_rsp_multicyc_ready, stats1.errortime_nice_rsp_multicyc_ready);
		else
			$display("Hint: Output 'nice_rsp_multicyc_ready' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ commit_mret_ref,commit_trap_ref,exu_active_ref,excp_active_ref,core_wfi_ref,tm_stop_ref,itcm_nohold_ref,core_cgstop_ref,tcm_cgstop_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,i_ready_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref,lsu_o_ready_ref,wfi_halt_ifu_req_ref,oitf_empty_ref,rf2ifu_x1_ref,rf2ifu_rs1_ref,dec2ifu_rden_ref,dec2ifu_rs1en_ref,dec2ifu_rdidx_ref,dec2ifu_mulhsu_ref,dec2ifu_div_ref,dec2ifu_rem_ref,dec2ifu_divu_ref,dec2ifu_remu_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref} ===
			( { commit_mret_ref,commit_trap_ref,exu_active_ref,excp_active_ref,core_wfi_ref,tm_stop_ref,itcm_nohold_ref,core_cgstop_ref,tcm_cgstop_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,i_ready_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref,lsu_o_ready_ref,wfi_halt_ifu_req_ref,oitf_empty_ref,rf2ifu_x1_ref,rf2ifu_rs1_ref,dec2ifu_rden_ref,dec2ifu_rs1en_ref,dec2ifu_rdidx_ref,dec2ifu_mulhsu_ref,dec2ifu_div_ref,dec2ifu_rem_ref,dec2ifu_divu_ref,dec2ifu_remu_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref} ^
			  { commit_mret_dut,commit_trap_dut,exu_active_dut,excp_active_dut,core_wfi_dut,tm_stop_dut,itcm_nohold_dut,core_cgstop_dut,tcm_cgstop_dut,cmt_dpc_dut,cmt_dpc_ena_dut,cmt_dcause_dut,cmt_dcause_ena_dut,wr_dcsr_ena_dut,wr_dpc_ena_dut,wr_dscratch_ena_dut,wr_csr_nxt_dut,i_ready_dut,pipe_flush_req_dut,pipe_flush_add_op1_dut,pipe_flush_add_op2_dut,pipe_flush_pc_dut,lsu_o_ready_dut,wfi_halt_ifu_req_dut,oitf_empty_dut,rf2ifu_x1_dut,rf2ifu_rs1_dut,dec2ifu_rden_dut,dec2ifu_rs1en_dut,dec2ifu_rdidx_dut,dec2ifu_mulhsu_dut,dec2ifu_div_dut,dec2ifu_rem_dut,dec2ifu_divu_dut,dec2ifu_remu_dut,agu_icb_cmd_valid_dut,agu_icb_cmd_addr_dut,agu_icb_cmd_read_dut,agu_icb_cmd_wdata_dut,agu_icb_cmd_wmask_dut,agu_icb_cmd_lock_dut,agu_icb_cmd_excl_dut,agu_icb_cmd_size_dut,agu_icb_cmd_back2agu_dut,agu_icb_cmd_usign_dut,agu_icb_cmd_itag_dut,agu_icb_rsp_ready_dut,nice_req_valid_dut,nice_req_inst_dut,nice_req_rs1_dut,nice_req_rs2_dut,nice_rsp_multicyc_ready_dut} ^
			  { commit_mret_ref,commit_trap_ref,exu_active_ref,excp_active_ref,core_wfi_ref,tm_stop_ref,itcm_nohold_ref,core_cgstop_ref,tcm_cgstop_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,i_ready_ref,pipe_flush_req_ref,pipe_flush_add_op1_ref,pipe_flush_add_op2_ref,pipe_flush_pc_ref,lsu_o_ready_ref,wfi_halt_ifu_req_ref,oitf_empty_ref,rf2ifu_x1_ref,rf2ifu_rs1_ref,dec2ifu_rden_ref,dec2ifu_rs1en_ref,dec2ifu_rdidx_ref,dec2ifu_mulhsu_ref,dec2ifu_div_ref,dec2ifu_rem_ref,dec2ifu_divu_ref,dec2ifu_remu_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref} );

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
		if (exu_active_ref !== (exu_active_ref ^ exu_active_dut ^ exu_active_ref)) begin
			if (stats1.errors_exu_active == 0) stats1.errortime_exu_active = $time;
			stats1.errors_exu_active++;
		end
		if (excp_active_ref !== (excp_active_ref ^ excp_active_dut ^ excp_active_ref)) begin
			if (stats1.errors_excp_active == 0) stats1.errortime_excp_active = $time;
			stats1.errors_excp_active++;
		end
		if (core_wfi_ref !== (core_wfi_ref ^ core_wfi_dut ^ core_wfi_ref)) begin
			if (stats1.errors_core_wfi == 0) stats1.errortime_core_wfi = $time;
			stats1.errors_core_wfi++;
		end
		if (tm_stop_ref !== (tm_stop_ref ^ tm_stop_dut ^ tm_stop_ref)) begin
			if (stats1.errors_tm_stop == 0) stats1.errortime_tm_stop = $time;
			stats1.errors_tm_stop++;
		end
		if (itcm_nohold_ref !== (itcm_nohold_ref ^ itcm_nohold_dut ^ itcm_nohold_ref)) begin
			if (stats1.errors_itcm_nohold == 0) stats1.errortime_itcm_nohold = $time;
			stats1.errors_itcm_nohold++;
		end
		if (core_cgstop_ref !== (core_cgstop_ref ^ core_cgstop_dut ^ core_cgstop_ref)) begin
			if (stats1.errors_core_cgstop == 0) stats1.errortime_core_cgstop = $time;
			stats1.errors_core_cgstop++;
		end
		if (tcm_cgstop_ref !== (tcm_cgstop_ref ^ tcm_cgstop_dut ^ tcm_cgstop_ref)) begin
			if (stats1.errors_tcm_cgstop == 0) stats1.errortime_tcm_cgstop = $time;
			stats1.errors_tcm_cgstop++;
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
		if (wr_dcsr_ena_ref !== (wr_dcsr_ena_ref ^ wr_dcsr_ena_dut ^ wr_dcsr_ena_ref)) begin
			if (stats1.errors_wr_dcsr_ena == 0) stats1.errortime_wr_dcsr_ena = $time;
			stats1.errors_wr_dcsr_ena++;
		end
		if (wr_dpc_ena_ref !== (wr_dpc_ena_ref ^ wr_dpc_ena_dut ^ wr_dpc_ena_ref)) begin
			if (stats1.errors_wr_dpc_ena == 0) stats1.errortime_wr_dpc_ena = $time;
			stats1.errors_wr_dpc_ena++;
		end
		if (wr_dscratch_ena_ref !== (wr_dscratch_ena_ref ^ wr_dscratch_ena_dut ^ wr_dscratch_ena_ref)) begin
			if (stats1.errors_wr_dscratch_ena == 0) stats1.errortime_wr_dscratch_ena = $time;
			stats1.errors_wr_dscratch_ena++;
		end
		if (wr_csr_nxt_ref !== (wr_csr_nxt_ref ^ wr_csr_nxt_dut ^ wr_csr_nxt_ref)) begin
			if (stats1.errors_wr_csr_nxt == 0) stats1.errortime_wr_csr_nxt = $time;
			stats1.errors_wr_csr_nxt++;
		end
		if (i_ready_ref !== (i_ready_ref ^ i_ready_dut ^ i_ready_ref)) begin
			if (stats1.errors_i_ready == 0) stats1.errortime_i_ready = $time;
			stats1.errors_i_ready++;
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
		if (lsu_o_ready_ref !== (lsu_o_ready_ref ^ lsu_o_ready_dut ^ lsu_o_ready_ref)) begin
			if (stats1.errors_lsu_o_ready == 0) stats1.errortime_lsu_o_ready = $time;
			stats1.errors_lsu_o_ready++;
		end
		if (wfi_halt_ifu_req_ref !== (wfi_halt_ifu_req_ref ^ wfi_halt_ifu_req_dut ^ wfi_halt_ifu_req_ref)) begin
			if (stats1.errors_wfi_halt_ifu_req == 0) stats1.errortime_wfi_halt_ifu_req = $time;
			stats1.errors_wfi_halt_ifu_req++;
		end
		if (oitf_empty_ref !== (oitf_empty_ref ^ oitf_empty_dut ^ oitf_empty_ref)) begin
			if (stats1.errors_oitf_empty == 0) stats1.errortime_oitf_empty = $time;
			stats1.errors_oitf_empty++;
		end
		if (rf2ifu_x1_ref !== (rf2ifu_x1_ref ^ rf2ifu_x1_dut ^ rf2ifu_x1_ref)) begin
			if (stats1.errors_rf2ifu_x1 == 0) stats1.errortime_rf2ifu_x1 = $time;
			stats1.errors_rf2ifu_x1++;
		end
		if (rf2ifu_rs1_ref !== (rf2ifu_rs1_ref ^ rf2ifu_rs1_dut ^ rf2ifu_rs1_ref)) begin
			if (stats1.errors_rf2ifu_rs1 == 0) stats1.errortime_rf2ifu_rs1 = $time;
			stats1.errors_rf2ifu_rs1++;
		end
		if (dec2ifu_rden_ref !== (dec2ifu_rden_ref ^ dec2ifu_rden_dut ^ dec2ifu_rden_ref)) begin
			if (stats1.errors_dec2ifu_rden == 0) stats1.errortime_dec2ifu_rden = $time;
			stats1.errors_dec2ifu_rden++;
		end
		if (dec2ifu_rs1en_ref !== (dec2ifu_rs1en_ref ^ dec2ifu_rs1en_dut ^ dec2ifu_rs1en_ref)) begin
			if (stats1.errors_dec2ifu_rs1en == 0) stats1.errortime_dec2ifu_rs1en = $time;
			stats1.errors_dec2ifu_rs1en++;
		end
		if (dec2ifu_rdidx_ref !== (dec2ifu_rdidx_ref ^ dec2ifu_rdidx_dut ^ dec2ifu_rdidx_ref)) begin
			if (stats1.errors_dec2ifu_rdidx == 0) stats1.errortime_dec2ifu_rdidx = $time;
			stats1.errors_dec2ifu_rdidx++;
		end
		if (dec2ifu_mulhsu_ref !== (dec2ifu_mulhsu_ref ^ dec2ifu_mulhsu_dut ^ dec2ifu_mulhsu_ref)) begin
			if (stats1.errors_dec2ifu_mulhsu == 0) stats1.errortime_dec2ifu_mulhsu = $time;
			stats1.errors_dec2ifu_mulhsu++;
		end
		if (dec2ifu_div_ref !== (dec2ifu_div_ref ^ dec2ifu_div_dut ^ dec2ifu_div_ref)) begin
			if (stats1.errors_dec2ifu_div == 0) stats1.errortime_dec2ifu_div = $time;
			stats1.errors_dec2ifu_div++;
		end
		if (dec2ifu_rem_ref !== (dec2ifu_rem_ref ^ dec2ifu_rem_dut ^ dec2ifu_rem_ref)) begin
			if (stats1.errors_dec2ifu_rem == 0) stats1.errortime_dec2ifu_rem = $time;
			stats1.errors_dec2ifu_rem++;
		end
		if (dec2ifu_divu_ref !== (dec2ifu_divu_ref ^ dec2ifu_divu_dut ^ dec2ifu_divu_ref)) begin
			if (stats1.errors_dec2ifu_divu == 0) stats1.errortime_dec2ifu_divu = $time;
			stats1.errors_dec2ifu_divu++;
		end
		if (dec2ifu_remu_ref !== (dec2ifu_remu_ref ^ dec2ifu_remu_dut ^ dec2ifu_remu_ref)) begin
			if (stats1.errors_dec2ifu_remu == 0) stats1.errortime_dec2ifu_remu = $time;
			stats1.errors_dec2ifu_remu++;
		end
		if (agu_icb_cmd_valid_ref !== (agu_icb_cmd_valid_ref ^ agu_icb_cmd_valid_dut ^ agu_icb_cmd_valid_ref)) begin
			if (stats1.errors_agu_icb_cmd_valid == 0) stats1.errortime_agu_icb_cmd_valid = $time;
			stats1.errors_agu_icb_cmd_valid++;
		end
		if (agu_icb_cmd_addr_ref !== (agu_icb_cmd_addr_ref ^ agu_icb_cmd_addr_dut ^ agu_icb_cmd_addr_ref)) begin
			if (stats1.errors_agu_icb_cmd_addr == 0) stats1.errortime_agu_icb_cmd_addr = $time;
			stats1.errors_agu_icb_cmd_addr++;
		end
		if (agu_icb_cmd_read_ref !== (agu_icb_cmd_read_ref ^ agu_icb_cmd_read_dut ^ agu_icb_cmd_read_ref)) begin
			if (stats1.errors_agu_icb_cmd_read == 0) stats1.errortime_agu_icb_cmd_read = $time;
			stats1.errors_agu_icb_cmd_read++;
		end
		if (agu_icb_cmd_wdata_ref !== (agu_icb_cmd_wdata_ref ^ agu_icb_cmd_wdata_dut ^ agu_icb_cmd_wdata_ref)) begin
			if (stats1.errors_agu_icb_cmd_wdata == 0) stats1.errortime_agu_icb_cmd_wdata = $time;
			stats1.errors_agu_icb_cmd_wdata++;
		end
		if (agu_icb_cmd_wmask_ref !== (agu_icb_cmd_wmask_ref ^ agu_icb_cmd_wmask_dut ^ agu_icb_cmd_wmask_ref)) begin
			if (stats1.errors_agu_icb_cmd_wmask == 0) stats1.errortime_agu_icb_cmd_wmask = $time;
			stats1.errors_agu_icb_cmd_wmask++;
		end
		if (agu_icb_cmd_lock_ref !== (agu_icb_cmd_lock_ref ^ agu_icb_cmd_lock_dut ^ agu_icb_cmd_lock_ref)) begin
			if (stats1.errors_agu_icb_cmd_lock == 0) stats1.errortime_agu_icb_cmd_lock = $time;
			stats1.errors_agu_icb_cmd_lock++;
		end
		if (agu_icb_cmd_excl_ref !== (agu_icb_cmd_excl_ref ^ agu_icb_cmd_excl_dut ^ agu_icb_cmd_excl_ref)) begin
			if (stats1.errors_agu_icb_cmd_excl == 0) stats1.errortime_agu_icb_cmd_excl = $time;
			stats1.errors_agu_icb_cmd_excl++;
		end
		if (agu_icb_cmd_size_ref !== (agu_icb_cmd_size_ref ^ agu_icb_cmd_size_dut ^ agu_icb_cmd_size_ref)) begin
			if (stats1.errors_agu_icb_cmd_size == 0) stats1.errortime_agu_icb_cmd_size = $time;
			stats1.errors_agu_icb_cmd_size++;
		end
		if (agu_icb_cmd_back2agu_ref !== (agu_icb_cmd_back2agu_ref ^ agu_icb_cmd_back2agu_dut ^ agu_icb_cmd_back2agu_ref)) begin
			if (stats1.errors_agu_icb_cmd_back2agu == 0) stats1.errortime_agu_icb_cmd_back2agu = $time;
			stats1.errors_agu_icb_cmd_back2agu++;
		end
		if (agu_icb_cmd_usign_ref !== (agu_icb_cmd_usign_ref ^ agu_icb_cmd_usign_dut ^ agu_icb_cmd_usign_ref)) begin
			if (stats1.errors_agu_icb_cmd_usign == 0) stats1.errortime_agu_icb_cmd_usign = $time;
			stats1.errors_agu_icb_cmd_usign++;
		end
		if (agu_icb_cmd_itag_ref !== (agu_icb_cmd_itag_ref ^ agu_icb_cmd_itag_dut ^ agu_icb_cmd_itag_ref)) begin
			if (stats1.errors_agu_icb_cmd_itag == 0) stats1.errortime_agu_icb_cmd_itag = $time;
			stats1.errors_agu_icb_cmd_itag++;
		end
		if (agu_icb_rsp_ready_ref !== (agu_icb_rsp_ready_ref ^ agu_icb_rsp_ready_dut ^ agu_icb_rsp_ready_ref)) begin
			if (stats1.errors_agu_icb_rsp_ready == 0) stats1.errortime_agu_icb_rsp_ready = $time;
			stats1.errors_agu_icb_rsp_ready++;
		end
		if (nice_req_valid_ref !== (nice_req_valid_ref ^ nice_req_valid_dut ^ nice_req_valid_ref)) begin
			if (stats1.errors_nice_req_valid == 0) stats1.errortime_nice_req_valid = $time;
			stats1.errors_nice_req_valid++;
		end
		if (nice_req_inst_ref !== (nice_req_inst_ref ^ nice_req_inst_dut ^ nice_req_inst_ref)) begin
			if (stats1.errors_nice_req_inst == 0) stats1.errortime_nice_req_inst = $time;
			stats1.errors_nice_req_inst++;
		end
		if (nice_req_rs1_ref !== (nice_req_rs1_ref ^ nice_req_rs1_dut ^ nice_req_rs1_ref)) begin
			if (stats1.errors_nice_req_rs1 == 0) stats1.errortime_nice_req_rs1 = $time;
			stats1.errors_nice_req_rs1++;
		end
		if (nice_req_rs2_ref !== (nice_req_rs2_ref ^ nice_req_rs2_dut ^ nice_req_rs2_ref)) begin
			if (stats1.errors_nice_req_rs2 == 0) stats1.errortime_nice_req_rs2 = $time;
			stats1.errors_nice_req_rs2++;
		end
		if (nice_rsp_multicyc_ready_ref !== (nice_rsp_multicyc_ready_ref ^ nice_rsp_multicyc_ready_dut ^ nice_rsp_multicyc_ready_ref)) begin
			if (stats1.errors_nice_rsp_multicyc_ready == 0) stats1.errortime_nice_rsp_multicyc_ready = $time;
			stats1.errors_nice_rsp_multicyc_ready++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
