`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_i_ready;
		int errortime_i_ready;
		int errors_i_longpipe;
		int errortime_i_longpipe;
		int errors_amo_wait;
		int errortime_amo_wait;
		int errors_cmt_o_valid;
		int errortime_cmt_o_valid;
		int errors_cmt_o_pc_vld;
		int errortime_cmt_o_pc_vld;
		int errors_cmt_o_pc;
		int errortime_cmt_o_pc;
		int errors_cmt_o_instr;
		int errortime_cmt_o_instr;
		int errors_cmt_o_imm;
		int errortime_cmt_o_imm;
		int errors_cmt_o_rv32;
		int errortime_cmt_o_rv32;
		int errors_cmt_o_bjp;
		int errortime_cmt_o_bjp;
		int errors_cmt_o_mret;
		int errortime_cmt_o_mret;
		int errors_cmt_o_dret;
		int errortime_cmt_o_dret;
		int errors_cmt_o_ecall;
		int errortime_cmt_o_ecall;
		int errors_cmt_o_ebreak;
		int errortime_cmt_o_ebreak;
		int errors_cmt_o_fencei;
		int errortime_cmt_o_fencei;
		int errors_cmt_o_wfi;
		int errortime_cmt_o_wfi;
		int errors_cmt_o_ifu_misalgn;
		int errortime_cmt_o_ifu_misalgn;
		int errors_cmt_o_ifu_buserr;
		int errortime_cmt_o_ifu_buserr;
		int errors_cmt_o_ifu_ilegl;
		int errortime_cmt_o_ifu_ilegl;
		int errors_cmt_o_bjp_prdt;
		int errortime_cmt_o_bjp_prdt;
		int errors_cmt_o_bjp_rslv;
		int errortime_cmt_o_bjp_rslv;
		int errors_cmt_o_misalgn;
		int errortime_cmt_o_misalgn;
		int errors_cmt_o_ld;
		int errortime_cmt_o_ld;
		int errors_cmt_o_stamo;
		int errortime_cmt_o_stamo;
		int errors_cmt_o_buserr;
		int errortime_cmt_o_buserr;
		int errors_cmt_o_badaddr;
		int errortime_cmt_o_badaddr;
		int errors_wbck_o_valid;
		int errortime_wbck_o_valid;
		int errors_wbck_o_wdat;
		int errortime_wbck_o_wdat;
		int errors_wbck_o_rdidx;
		int errortime_wbck_o_rdidx;
		int errors_csr_ena;
		int errortime_csr_ena;
		int errors_csr_wr_en;
		int errortime_csr_wr_en;
		int errors_csr_rd_en;
		int errortime_csr_rd_en;
		int errors_csr_idx;
		int errortime_csr_idx;
		int errors_wbck_csr_dat;
		int errortime_wbck_csr_dat;
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
		int errors_nice_req_instr;
		int errortime_nice_req_instr;
		int errors_nice_req_rs1;
		int errortime_nice_req_rs1;
		int errors_nice_req_rs2;
		int errortime_nice_req_rs2;
		int errors_nice_rsp_multicyc_ready;
		int errortime_nice_rsp_multicyc_ready;
		int errors_nice_longp_wbck_valid;
		int errortime_nice_longp_wbck_valid;
		int errors_nice_o_itag;
		int errortime_nice_o_itag;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic i_valid;
	logic i_ready_ref;
	logic i_ready_dut;
	logic i_longpipe_ref;
	logic i_longpipe_dut;
	logic nice_xs_off;
	logic amo_wait_ref;
	logic amo_wait_dut;
	logic oitf_empty;
	logic i_itag;
	logic [32-1:0] i_rs1;
	logic [32-1:0] i_rs2;
	logic [32-1:0] i_imm;
	logic [32-1:0] i_info;
	logic [32-1:0] i_pc;
	logic [32-1:0] i_instr;
	logic i_pc_vld;
	logic [5-1:0] i_rdidx;
	logic i_rdwen;
	logic i_ilegl;
	logic i_buserr;
	logic i_misalgn;
	logic flush_req;
	logic flush_pulse;
	logic cmt_o_valid_ref;
	logic cmt_o_valid_dut;
	logic cmt_o_ready;
	logic cmt_o_pc_vld_ref;
	logic cmt_o_pc_vld_dut;
	logic [32-1:0] cmt_o_pc_ref;
	logic [32-1:0] cmt_o_pc_dut;
	logic [32-1:0] cmt_o_instr_ref;
	logic [32-1:0] cmt_o_instr_dut;
	logic [32-1:0] cmt_o_imm_ref;
	logic [32-1:0] cmt_o_imm_dut;
	logic cmt_o_rv32_ref;
	logic cmt_o_rv32_dut;
	logic cmt_o_bjp_ref;
	logic cmt_o_bjp_dut;
	logic cmt_o_mret_ref;
	logic cmt_o_mret_dut;
	logic cmt_o_dret_ref;
	logic cmt_o_dret_dut;
	logic cmt_o_ecall_ref;
	logic cmt_o_ecall_dut;
	logic cmt_o_ebreak_ref;
	logic cmt_o_ebreak_dut;
	logic cmt_o_fencei_ref;
	logic cmt_o_fencei_dut;
	logic cmt_o_wfi_ref;
	logic cmt_o_wfi_dut;
	logic cmt_o_ifu_misalgn_ref;
	logic cmt_o_ifu_misalgn_dut;
	logic cmt_o_ifu_buserr_ref;
	logic cmt_o_ifu_buserr_dut;
	logic cmt_o_ifu_ilegl_ref;
	logic cmt_o_ifu_ilegl_dut;
	logic cmt_o_bjp_prdt_ref;
	logic cmt_o_bjp_prdt_dut;
	logic cmt_o_bjp_rslv_ref;
	logic cmt_o_bjp_rslv_dut;
	logic cmt_o_misalgn_ref;
	logic cmt_o_misalgn_dut;
	logic cmt_o_ld_ref;
	logic cmt_o_ld_dut;
	logic cmt_o_stamo_ref;
	logic cmt_o_stamo_dut;
	logic cmt_o_buserr_ref;
	logic cmt_o_buserr_dut;
	logic [32-1:0] cmt_o_badaddr_ref;
	logic [32-1:0] cmt_o_badaddr_dut;
	logic wbck_o_valid_ref;
	logic wbck_o_valid_dut;
	logic wbck_o_ready;
	logic [32-1:0] wbck_o_wdat_ref;
	logic [32-1:0] wbck_o_wdat_dut;
	logic [5-1:0] wbck_o_rdidx_ref;
	logic [5-1:0] wbck_o_rdidx_dut;
	logic mdv_nob2b;
	logic csr_ena_ref;
	logic csr_ena_dut;
	logic csr_wr_en_ref;
	logic csr_wr_en_dut;
	logic csr_rd_en_ref;
	logic csr_rd_en_dut;
	logic [12-1:0] csr_idx_ref;
	logic [12-1:0] csr_idx_dut;
	logic nonflush_cmt_ena;
	logic csr_access_ilgl;
	logic [32-1:0] read_csr_dat;
	logic [32-1:0] wbck_csr_dat_ref;
	logic [32-1:0] wbck_csr_dat_dut;
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
	logic [32-1:0] nice_req_instr_ref;
	logic [32-1:0] nice_req_instr_dut;
	logic [32-1:0] nice_req_rs1_ref;
	logic [32-1:0] nice_req_rs1_dut;
	logic [32-1:0] nice_req_rs2_ref;
	logic [32-1:0] nice_req_rs2_dut;
	logic nice_rsp_multicyc_valid;
	logic nice_rsp_multicyc_ready_ref;
	logic nice_rsp_multicyc_ready_dut;
	logic nice_longp_wbck_valid_ref;
	logic nice_longp_wbck_valid_dut;
	logic nice_longp_wbck_ready;
	logic nice_o_itag_ref;
	logic nice_o_itag_dut;
	logic i_nice_cmt_off_ilgl;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.i_valid(i_valid),
		.nice_xs_off(nice_xs_off),
		.oitf_empty(oitf_empty),
		.i_itag(i_itag),
		.i_rs1(i_rs1),
		.i_rs2(i_rs2),
		.i_imm(i_imm),
		.i_info(i_info),
		.i_pc(i_pc),
		.i_instr(i_instr),
		.i_pc_vld(i_pc_vld),
		.i_rdidx(i_rdidx),
		.i_rdwen(i_rdwen),
		.i_ilegl(i_ilegl),
		.i_buserr(i_buserr),
		.i_misalgn(i_misalgn),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.cmt_o_ready(cmt_o_ready),
		.wbck_o_ready(wbck_o_ready),
		.mdv_nob2b(mdv_nob2b),
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.nice_req_ready(nice_req_ready),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_longp_wbck_ready(nice_longp_wbck_ready),
		.i_nice_cmt_off_ilgl(i_nice_cmt_off_ilgl),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu good1 (
		.i_valid(i_valid),
		.i_ready(i_ready_ref),
		.i_longpipe(i_longpipe_ref),
		.nice_xs_off(nice_xs_off),
		.amo_wait(amo_wait_ref),
		.oitf_empty(oitf_empty),
		.i_itag(i_itag),
		.i_rs1(i_rs1),
		.i_rs2(i_rs2),
		.i_imm(i_imm),
		.i_info(i_info),
		.i_pc(i_pc),
		.i_instr(i_instr),
		.i_pc_vld(i_pc_vld),
		.i_rdidx(i_rdidx),
		.i_rdwen(i_rdwen),
		.i_ilegl(i_ilegl),
		.i_buserr(i_buserr),
		.i_misalgn(i_misalgn),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.cmt_o_valid(cmt_o_valid_ref),
		.cmt_o_ready(cmt_o_ready),
		.cmt_o_pc_vld(cmt_o_pc_vld_ref),
		.cmt_o_pc(cmt_o_pc_ref),
		.cmt_o_instr(cmt_o_instr_ref),
		.cmt_o_imm(cmt_o_imm_ref),
		.cmt_o_rv32(cmt_o_rv32_ref),
		.cmt_o_bjp(cmt_o_bjp_ref),
		.cmt_o_mret(cmt_o_mret_ref),
		.cmt_o_dret(cmt_o_dret_ref),
		.cmt_o_ecall(cmt_o_ecall_ref),
		.cmt_o_ebreak(cmt_o_ebreak_ref),
		.cmt_o_fencei(cmt_o_fencei_ref),
		.cmt_o_wfi(cmt_o_wfi_ref),
		.cmt_o_ifu_misalgn(cmt_o_ifu_misalgn_ref),
		.cmt_o_ifu_buserr(cmt_o_ifu_buserr_ref),
		.cmt_o_ifu_ilegl(cmt_o_ifu_ilegl_ref),
		.cmt_o_bjp_prdt(cmt_o_bjp_prdt_ref),
		.cmt_o_bjp_rslv(cmt_o_bjp_rslv_ref),
		.cmt_o_misalgn(cmt_o_misalgn_ref),
		.cmt_o_ld(cmt_o_ld_ref),
		.cmt_o_stamo(cmt_o_stamo_ref),
		.cmt_o_buserr(cmt_o_buserr_ref),
		.cmt_o_badaddr(cmt_o_badaddr_ref),
		.wbck_o_valid(wbck_o_valid_ref),
		.wbck_o_ready(wbck_o_ready),
		.wbck_o_wdat(wbck_o_wdat_ref),
		.wbck_o_rdidx(wbck_o_rdidx_ref),
		.mdv_nob2b(mdv_nob2b),
		.csr_ena(csr_ena_ref),
		.csr_wr_en(csr_wr_en_ref),
		.csr_rd_en(csr_rd_en_ref),
		.csr_idx(csr_idx_ref),
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.wbck_csr_dat(wbck_csr_dat_ref),
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
		.nice_req_instr(nice_req_instr_ref),
		.nice_req_rs1(nice_req_rs1_ref),
		.nice_req_rs2(nice_req_rs2_ref),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_ref),
		.nice_longp_wbck_valid(nice_longp_wbck_valid_ref),
		.nice_longp_wbck_ready(nice_longp_wbck_ready),
		.nice_o_itag(nice_o_itag_ref),
		.i_nice_cmt_off_ilgl(i_nice_cmt_off_ilgl),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu top_module1 (
		.i_valid(i_valid),
		.i_ready(i_ready_dut),
		.i_longpipe(i_longpipe_dut),
		.nice_xs_off(nice_xs_off),
		.amo_wait(amo_wait_dut),
		.oitf_empty(oitf_empty),
		.i_itag(i_itag),
		.i_rs1(i_rs1),
		.i_rs2(i_rs2),
		.i_imm(i_imm),
		.i_info(i_info),
		.i_pc(i_pc),
		.i_instr(i_instr),
		.i_pc_vld(i_pc_vld),
		.i_rdidx(i_rdidx),
		.i_rdwen(i_rdwen),
		.i_ilegl(i_ilegl),
		.i_buserr(i_buserr),
		.i_misalgn(i_misalgn),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.cmt_o_valid(cmt_o_valid_dut),
		.cmt_o_ready(cmt_o_ready),
		.cmt_o_pc_vld(cmt_o_pc_vld_dut),
		.cmt_o_pc(cmt_o_pc_dut),
		.cmt_o_instr(cmt_o_instr_dut),
		.cmt_o_imm(cmt_o_imm_dut),
		.cmt_o_rv32(cmt_o_rv32_dut),
		.cmt_o_bjp(cmt_o_bjp_dut),
		.cmt_o_mret(cmt_o_mret_dut),
		.cmt_o_dret(cmt_o_dret_dut),
		.cmt_o_ecall(cmt_o_ecall_dut),
		.cmt_o_ebreak(cmt_o_ebreak_dut),
		.cmt_o_fencei(cmt_o_fencei_dut),
		.cmt_o_wfi(cmt_o_wfi_dut),
		.cmt_o_ifu_misalgn(cmt_o_ifu_misalgn_dut),
		.cmt_o_ifu_buserr(cmt_o_ifu_buserr_dut),
		.cmt_o_ifu_ilegl(cmt_o_ifu_ilegl_dut),
		.cmt_o_bjp_prdt(cmt_o_bjp_prdt_dut),
		.cmt_o_bjp_rslv(cmt_o_bjp_rslv_dut),
		.cmt_o_misalgn(cmt_o_misalgn_dut),
		.cmt_o_ld(cmt_o_ld_dut),
		.cmt_o_stamo(cmt_o_stamo_dut),
		.cmt_o_buserr(cmt_o_buserr_dut),
		.cmt_o_badaddr(cmt_o_badaddr_dut),
		.wbck_o_valid(wbck_o_valid_dut),
		.wbck_o_ready(wbck_o_ready),
		.wbck_o_wdat(wbck_o_wdat_dut),
		.wbck_o_rdidx(wbck_o_rdidx_dut),
		.mdv_nob2b(mdv_nob2b),
		.csr_ena(csr_ena_dut),
		.csr_wr_en(csr_wr_en_dut),
		.csr_rd_en(csr_rd_en_dut),
		.csr_idx(csr_idx_dut),
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.csr_access_ilgl(csr_access_ilgl),
		.read_csr_dat(read_csr_dat),
		.wbck_csr_dat(wbck_csr_dat_dut),
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
		.nice_req_instr(nice_req_instr_dut),
		.nice_req_rs1(nice_req_rs1_dut),
		.nice_req_rs2(nice_req_rs2_dut),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_dut),
		.nice_longp_wbck_valid(nice_longp_wbck_valid_dut),
		.nice_longp_wbck_ready(nice_longp_wbck_ready),
		.nice_o_itag(nice_o_itag_dut),
		.i_nice_cmt_off_ilgl(i_nice_cmt_off_ilgl),
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
		if (stats1.errors_i_ready)
			$display("Hint: Output 'i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_i_ready, stats1.errortime_i_ready);
		else
			$display("Hint: Output 'i_ready' has no mismatches.");
		if (stats1.errors_i_longpipe)
			$display("Hint: Output 'i_longpipe' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_i_longpipe, stats1.errortime_i_longpipe);
		else
			$display("Hint: Output 'i_longpipe' has no mismatches.");
		if (stats1.errors_amo_wait)
			$display("Hint: Output 'amo_wait' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_amo_wait, stats1.errortime_amo_wait);
		else
			$display("Hint: Output 'amo_wait' has no mismatches.");
		if (stats1.errors_cmt_o_valid)
			$display("Hint: Output 'cmt_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_valid, stats1.errortime_cmt_o_valid);
		else
			$display("Hint: Output 'cmt_o_valid' has no mismatches.");
		if (stats1.errors_cmt_o_pc_vld)
			$display("Hint: Output 'cmt_o_pc_vld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_pc_vld, stats1.errortime_cmt_o_pc_vld);
		else
			$display("Hint: Output 'cmt_o_pc_vld' has no mismatches.");
		if (stats1.errors_cmt_o_pc)
			$display("Hint: Output 'cmt_o_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_pc, stats1.errortime_cmt_o_pc);
		else
			$display("Hint: Output 'cmt_o_pc' has no mismatches.");
		if (stats1.errors_cmt_o_instr)
			$display("Hint: Output 'cmt_o_instr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_instr, stats1.errortime_cmt_o_instr);
		else
			$display("Hint: Output 'cmt_o_instr' has no mismatches.");
		if (stats1.errors_cmt_o_imm)
			$display("Hint: Output 'cmt_o_imm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_imm, stats1.errortime_cmt_o_imm);
		else
			$display("Hint: Output 'cmt_o_imm' has no mismatches.");
		if (stats1.errors_cmt_o_rv32)
			$display("Hint: Output 'cmt_o_rv32' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_rv32, stats1.errortime_cmt_o_rv32);
		else
			$display("Hint: Output 'cmt_o_rv32' has no mismatches.");
		if (stats1.errors_cmt_o_bjp)
			$display("Hint: Output 'cmt_o_bjp' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_bjp, stats1.errortime_cmt_o_bjp);
		else
			$display("Hint: Output 'cmt_o_bjp' has no mismatches.");
		if (stats1.errors_cmt_o_mret)
			$display("Hint: Output 'cmt_o_mret' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_mret, stats1.errortime_cmt_o_mret);
		else
			$display("Hint: Output 'cmt_o_mret' has no mismatches.");
		if (stats1.errors_cmt_o_dret)
			$display("Hint: Output 'cmt_o_dret' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_dret, stats1.errortime_cmt_o_dret);
		else
			$display("Hint: Output 'cmt_o_dret' has no mismatches.");
		if (stats1.errors_cmt_o_ecall)
			$display("Hint: Output 'cmt_o_ecall' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ecall, stats1.errortime_cmt_o_ecall);
		else
			$display("Hint: Output 'cmt_o_ecall' has no mismatches.");
		if (stats1.errors_cmt_o_ebreak)
			$display("Hint: Output 'cmt_o_ebreak' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ebreak, stats1.errortime_cmt_o_ebreak);
		else
			$display("Hint: Output 'cmt_o_ebreak' has no mismatches.");
		if (stats1.errors_cmt_o_fencei)
			$display("Hint: Output 'cmt_o_fencei' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_fencei, stats1.errortime_cmt_o_fencei);
		else
			$display("Hint: Output 'cmt_o_fencei' has no mismatches.");
		if (stats1.errors_cmt_o_wfi)
			$display("Hint: Output 'cmt_o_wfi' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_wfi, stats1.errortime_cmt_o_wfi);
		else
			$display("Hint: Output 'cmt_o_wfi' has no mismatches.");
		if (stats1.errors_cmt_o_ifu_misalgn)
			$display("Hint: Output 'cmt_o_ifu_misalgn' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ifu_misalgn, stats1.errortime_cmt_o_ifu_misalgn);
		else
			$display("Hint: Output 'cmt_o_ifu_misalgn' has no mismatches.");
		if (stats1.errors_cmt_o_ifu_buserr)
			$display("Hint: Output 'cmt_o_ifu_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ifu_buserr, stats1.errortime_cmt_o_ifu_buserr);
		else
			$display("Hint: Output 'cmt_o_ifu_buserr' has no mismatches.");
		if (stats1.errors_cmt_o_ifu_ilegl)
			$display("Hint: Output 'cmt_o_ifu_ilegl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ifu_ilegl, stats1.errortime_cmt_o_ifu_ilegl);
		else
			$display("Hint: Output 'cmt_o_ifu_ilegl' has no mismatches.");
		if (stats1.errors_cmt_o_bjp_prdt)
			$display("Hint: Output 'cmt_o_bjp_prdt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_bjp_prdt, stats1.errortime_cmt_o_bjp_prdt);
		else
			$display("Hint: Output 'cmt_o_bjp_prdt' has no mismatches.");
		if (stats1.errors_cmt_o_bjp_rslv)
			$display("Hint: Output 'cmt_o_bjp_rslv' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_bjp_rslv, stats1.errortime_cmt_o_bjp_rslv);
		else
			$display("Hint: Output 'cmt_o_bjp_rslv' has no mismatches.");
		if (stats1.errors_cmt_o_misalgn)
			$display("Hint: Output 'cmt_o_misalgn' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_misalgn, stats1.errortime_cmt_o_misalgn);
		else
			$display("Hint: Output 'cmt_o_misalgn' has no mismatches.");
		if (stats1.errors_cmt_o_ld)
			$display("Hint: Output 'cmt_o_ld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_ld, stats1.errortime_cmt_o_ld);
		else
			$display("Hint: Output 'cmt_o_ld' has no mismatches.");
		if (stats1.errors_cmt_o_stamo)
			$display("Hint: Output 'cmt_o_stamo' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_stamo, stats1.errortime_cmt_o_stamo);
		else
			$display("Hint: Output 'cmt_o_stamo' has no mismatches.");
		if (stats1.errors_cmt_o_buserr)
			$display("Hint: Output 'cmt_o_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_buserr, stats1.errortime_cmt_o_buserr);
		else
			$display("Hint: Output 'cmt_o_buserr' has no mismatches.");
		if (stats1.errors_cmt_o_badaddr)
			$display("Hint: Output 'cmt_o_badaddr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_o_badaddr, stats1.errortime_cmt_o_badaddr);
		else
			$display("Hint: Output 'cmt_o_badaddr' has no mismatches.");
		if (stats1.errors_wbck_o_valid)
			$display("Hint: Output 'wbck_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wbck_o_valid, stats1.errortime_wbck_o_valid);
		else
			$display("Hint: Output 'wbck_o_valid' has no mismatches.");
		if (stats1.errors_wbck_o_wdat)
			$display("Hint: Output 'wbck_o_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wbck_o_wdat, stats1.errortime_wbck_o_wdat);
		else
			$display("Hint: Output 'wbck_o_wdat' has no mismatches.");
		if (stats1.errors_wbck_o_rdidx)
			$display("Hint: Output 'wbck_o_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wbck_o_rdidx, stats1.errortime_wbck_o_rdidx);
		else
			$display("Hint: Output 'wbck_o_rdidx' has no mismatches.");
		if (stats1.errors_csr_ena)
			$display("Hint: Output 'csr_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_ena, stats1.errortime_csr_ena);
		else
			$display("Hint: Output 'csr_ena' has no mismatches.");
		if (stats1.errors_csr_wr_en)
			$display("Hint: Output 'csr_wr_en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_wr_en, stats1.errortime_csr_wr_en);
		else
			$display("Hint: Output 'csr_wr_en' has no mismatches.");
		if (stats1.errors_csr_rd_en)
			$display("Hint: Output 'csr_rd_en' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_rd_en, stats1.errortime_csr_rd_en);
		else
			$display("Hint: Output 'csr_rd_en' has no mismatches.");
		if (stats1.errors_csr_idx)
			$display("Hint: Output 'csr_idx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_idx, stats1.errortime_csr_idx);
		else
			$display("Hint: Output 'csr_idx' has no mismatches.");
		if (stats1.errors_wbck_csr_dat)
			$display("Hint: Output 'wbck_csr_dat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_wbck_csr_dat, stats1.errortime_wbck_csr_dat);
		else
			$display("Hint: Output 'wbck_csr_dat' has no mismatches.");
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
		if (stats1.errors_nice_rsp_multicyc_ready)
			$display("Hint: Output 'nice_rsp_multicyc_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_rsp_multicyc_ready, stats1.errortime_nice_rsp_multicyc_ready);
		else
			$display("Hint: Output 'nice_rsp_multicyc_ready' has no mismatches.");
		if (stats1.errors_nice_longp_wbck_valid)
			$display("Hint: Output 'nice_longp_wbck_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_longp_wbck_valid, stats1.errortime_nice_longp_wbck_valid);
		else
			$display("Hint: Output 'nice_longp_wbck_valid' has no mismatches.");
		if (stats1.errors_nice_o_itag)
			$display("Hint: Output 'nice_o_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_o_itag, stats1.errortime_nice_o_itag);
		else
			$display("Hint: Output 'nice_o_itag' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ i_ready_ref,i_longpipe_ref,amo_wait_ref,cmt_o_valid_ref,cmt_o_pc_vld_ref,cmt_o_pc_ref,cmt_o_instr_ref,cmt_o_imm_ref,cmt_o_rv32_ref,cmt_o_bjp_ref,cmt_o_mret_ref,cmt_o_dret_ref,cmt_o_ecall_ref,cmt_o_ebreak_ref,cmt_o_fencei_ref,cmt_o_wfi_ref,cmt_o_ifu_misalgn_ref,cmt_o_ifu_buserr_ref,cmt_o_ifu_ilegl_ref,cmt_o_bjp_prdt_ref,cmt_o_bjp_rslv_ref,cmt_o_misalgn_ref,cmt_o_ld_ref,cmt_o_stamo_ref,cmt_o_buserr_ref,cmt_o_badaddr_ref,wbck_o_valid_ref,wbck_o_wdat_ref,wbck_o_rdidx_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_longp_wbck_valid_ref,nice_o_itag_ref} ===
			( { i_ready_ref,i_longpipe_ref,amo_wait_ref,cmt_o_valid_ref,cmt_o_pc_vld_ref,cmt_o_pc_ref,cmt_o_instr_ref,cmt_o_imm_ref,cmt_o_rv32_ref,cmt_o_bjp_ref,cmt_o_mret_ref,cmt_o_dret_ref,cmt_o_ecall_ref,cmt_o_ebreak_ref,cmt_o_fencei_ref,cmt_o_wfi_ref,cmt_o_ifu_misalgn_ref,cmt_o_ifu_buserr_ref,cmt_o_ifu_ilegl_ref,cmt_o_bjp_prdt_ref,cmt_o_bjp_rslv_ref,cmt_o_misalgn_ref,cmt_o_ld_ref,cmt_o_stamo_ref,cmt_o_buserr_ref,cmt_o_badaddr_ref,wbck_o_valid_ref,wbck_o_wdat_ref,wbck_o_rdidx_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_longp_wbck_valid_ref,nice_o_itag_ref} ^
			  { i_ready_dut,i_longpipe_dut,amo_wait_dut,cmt_o_valid_dut,cmt_o_pc_vld_dut,cmt_o_pc_dut,cmt_o_instr_dut,cmt_o_imm_dut,cmt_o_rv32_dut,cmt_o_bjp_dut,cmt_o_mret_dut,cmt_o_dret_dut,cmt_o_ecall_dut,cmt_o_ebreak_dut,cmt_o_fencei_dut,cmt_o_wfi_dut,cmt_o_ifu_misalgn_dut,cmt_o_ifu_buserr_dut,cmt_o_ifu_ilegl_dut,cmt_o_bjp_prdt_dut,cmt_o_bjp_rslv_dut,cmt_o_misalgn_dut,cmt_o_ld_dut,cmt_o_stamo_dut,cmt_o_buserr_dut,cmt_o_badaddr_dut,wbck_o_valid_dut,wbck_o_wdat_dut,wbck_o_rdidx_dut,csr_ena_dut,csr_wr_en_dut,csr_rd_en_dut,csr_idx_dut,wbck_csr_dat_dut,agu_icb_cmd_valid_dut,agu_icb_cmd_addr_dut,agu_icb_cmd_read_dut,agu_icb_cmd_wdata_dut,agu_icb_cmd_wmask_dut,agu_icb_cmd_lock_dut,agu_icb_cmd_excl_dut,agu_icb_cmd_size_dut,agu_icb_cmd_back2agu_dut,agu_icb_cmd_usign_dut,agu_icb_cmd_itag_dut,agu_icb_rsp_ready_dut,nice_req_valid_dut,nice_req_instr_dut,nice_req_rs1_dut,nice_req_rs2_dut,nice_rsp_multicyc_ready_dut,nice_longp_wbck_valid_dut,nice_o_itag_dut} ^
			  { i_ready_ref,i_longpipe_ref,amo_wait_ref,cmt_o_valid_ref,cmt_o_pc_vld_ref,cmt_o_pc_ref,cmt_o_instr_ref,cmt_o_imm_ref,cmt_o_rv32_ref,cmt_o_bjp_ref,cmt_o_mret_ref,cmt_o_dret_ref,cmt_o_ecall_ref,cmt_o_ebreak_ref,cmt_o_fencei_ref,cmt_o_wfi_ref,cmt_o_ifu_misalgn_ref,cmt_o_ifu_buserr_ref,cmt_o_ifu_ilegl_ref,cmt_o_bjp_prdt_ref,cmt_o_bjp_rslv_ref,cmt_o_misalgn_ref,cmt_o_ld_ref,cmt_o_stamo_ref,cmt_o_buserr_ref,cmt_o_badaddr_ref,wbck_o_valid_ref,wbck_o_wdat_ref,wbck_o_rdidx_ref,csr_ena_ref,csr_wr_en_ref,csr_rd_en_ref,csr_idx_ref,wbck_csr_dat_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_usign_ref,agu_icb_cmd_itag_ref,agu_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_instr_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_longp_wbck_valid_ref,nice_o_itag_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (i_ready_ref !== (i_ready_ref ^ i_ready_dut ^ i_ready_ref)) begin
			if (stats1.errors_i_ready == 0) stats1.errortime_i_ready = $time;
			stats1.errors_i_ready++;
		end
		if (i_longpipe_ref !== (i_longpipe_ref ^ i_longpipe_dut ^ i_longpipe_ref)) begin
			if (stats1.errors_i_longpipe == 0) stats1.errortime_i_longpipe = $time;
			stats1.errors_i_longpipe++;
		end
		if (amo_wait_ref !== (amo_wait_ref ^ amo_wait_dut ^ amo_wait_ref)) begin
			if (stats1.errors_amo_wait == 0) stats1.errortime_amo_wait = $time;
			stats1.errors_amo_wait++;
		end
		if (cmt_o_valid_ref !== (cmt_o_valid_ref ^ cmt_o_valid_dut ^ cmt_o_valid_ref)) begin
			if (stats1.errors_cmt_o_valid == 0) stats1.errortime_cmt_o_valid = $time;
			stats1.errors_cmt_o_valid++;
		end
		if (cmt_o_pc_vld_ref !== (cmt_o_pc_vld_ref ^ cmt_o_pc_vld_dut ^ cmt_o_pc_vld_ref)) begin
			if (stats1.errors_cmt_o_pc_vld == 0) stats1.errortime_cmt_o_pc_vld = $time;
			stats1.errors_cmt_o_pc_vld++;
		end
		if (cmt_o_pc_ref !== (cmt_o_pc_ref ^ cmt_o_pc_dut ^ cmt_o_pc_ref)) begin
			if (stats1.errors_cmt_o_pc == 0) stats1.errortime_cmt_o_pc = $time;
			stats1.errors_cmt_o_pc++;
		end
		if (cmt_o_instr_ref !== (cmt_o_instr_ref ^ cmt_o_instr_dut ^ cmt_o_instr_ref)) begin
			if (stats1.errors_cmt_o_instr == 0) stats1.errortime_cmt_o_instr = $time;
			stats1.errors_cmt_o_instr++;
		end
		if (cmt_o_imm_ref !== (cmt_o_imm_ref ^ cmt_o_imm_dut ^ cmt_o_imm_ref)) begin
			if (stats1.errors_cmt_o_imm == 0) stats1.errortime_cmt_o_imm = $time;
			stats1.errors_cmt_o_imm++;
		end
		if (cmt_o_rv32_ref !== (cmt_o_rv32_ref ^ cmt_o_rv32_dut ^ cmt_o_rv32_ref)) begin
			if (stats1.errors_cmt_o_rv32 == 0) stats1.errortime_cmt_o_rv32 = $time;
			stats1.errors_cmt_o_rv32++;
		end
		if (cmt_o_bjp_ref !== (cmt_o_bjp_ref ^ cmt_o_bjp_dut ^ cmt_o_bjp_ref)) begin
			if (stats1.errors_cmt_o_bjp == 0) stats1.errortime_cmt_o_bjp = $time;
			stats1.errors_cmt_o_bjp++;
		end
		if (cmt_o_mret_ref !== (cmt_o_mret_ref ^ cmt_o_mret_dut ^ cmt_o_mret_ref)) begin
			if (stats1.errors_cmt_o_mret == 0) stats1.errortime_cmt_o_mret = $time;
			stats1.errors_cmt_o_mret++;
		end
		if (cmt_o_dret_ref !== (cmt_o_dret_ref ^ cmt_o_dret_dut ^ cmt_o_dret_ref)) begin
			if (stats1.errors_cmt_o_dret == 0) stats1.errortime_cmt_o_dret = $time;
			stats1.errors_cmt_o_dret++;
		end
		if (cmt_o_ecall_ref !== (cmt_o_ecall_ref ^ cmt_o_ecall_dut ^ cmt_o_ecall_ref)) begin
			if (stats1.errors_cmt_o_ecall == 0) stats1.errortime_cmt_o_ecall = $time;
			stats1.errors_cmt_o_ecall++;
		end
		if (cmt_o_ebreak_ref !== (cmt_o_ebreak_ref ^ cmt_o_ebreak_dut ^ cmt_o_ebreak_ref)) begin
			if (stats1.errors_cmt_o_ebreak == 0) stats1.errortime_cmt_o_ebreak = $time;
			stats1.errors_cmt_o_ebreak++;
		end
		if (cmt_o_fencei_ref !== (cmt_o_fencei_ref ^ cmt_o_fencei_dut ^ cmt_o_fencei_ref)) begin
			if (stats1.errors_cmt_o_fencei == 0) stats1.errortime_cmt_o_fencei = $time;
			stats1.errors_cmt_o_fencei++;
		end
		if (cmt_o_wfi_ref !== (cmt_o_wfi_ref ^ cmt_o_wfi_dut ^ cmt_o_wfi_ref)) begin
			if (stats1.errors_cmt_o_wfi == 0) stats1.errortime_cmt_o_wfi = $time;
			stats1.errors_cmt_o_wfi++;
		end
		if (cmt_o_ifu_misalgn_ref !== (cmt_o_ifu_misalgn_ref ^ cmt_o_ifu_misalgn_dut ^ cmt_o_ifu_misalgn_ref)) begin
			if (stats1.errors_cmt_o_ifu_misalgn == 0) stats1.errortime_cmt_o_ifu_misalgn = $time;
			stats1.errors_cmt_o_ifu_misalgn++;
		end
		if (cmt_o_ifu_buserr_ref !== (cmt_o_ifu_buserr_ref ^ cmt_o_ifu_buserr_dut ^ cmt_o_ifu_buserr_ref)) begin
			if (stats1.errors_cmt_o_ifu_buserr == 0) stats1.errortime_cmt_o_ifu_buserr = $time;
			stats1.errors_cmt_o_ifu_buserr++;
		end
		if (cmt_o_ifu_ilegl_ref !== (cmt_o_ifu_ilegl_ref ^ cmt_o_ifu_ilegl_dut ^ cmt_o_ifu_ilegl_ref)) begin
			if (stats1.errors_cmt_o_ifu_ilegl == 0) stats1.errortime_cmt_o_ifu_ilegl = $time;
			stats1.errors_cmt_o_ifu_ilegl++;
		end
		if (cmt_o_bjp_prdt_ref !== (cmt_o_bjp_prdt_ref ^ cmt_o_bjp_prdt_dut ^ cmt_o_bjp_prdt_ref)) begin
			if (stats1.errors_cmt_o_bjp_prdt == 0) stats1.errortime_cmt_o_bjp_prdt = $time;
			stats1.errors_cmt_o_bjp_prdt++;
		end
		if (cmt_o_bjp_rslv_ref !== (cmt_o_bjp_rslv_ref ^ cmt_o_bjp_rslv_dut ^ cmt_o_bjp_rslv_ref)) begin
			if (stats1.errors_cmt_o_bjp_rslv == 0) stats1.errortime_cmt_o_bjp_rslv = $time;
			stats1.errors_cmt_o_bjp_rslv++;
		end
		if (cmt_o_misalgn_ref !== (cmt_o_misalgn_ref ^ cmt_o_misalgn_dut ^ cmt_o_misalgn_ref)) begin
			if (stats1.errors_cmt_o_misalgn == 0) stats1.errortime_cmt_o_misalgn = $time;
			stats1.errors_cmt_o_misalgn++;
		end
		if (cmt_o_ld_ref !== (cmt_o_ld_ref ^ cmt_o_ld_dut ^ cmt_o_ld_ref)) begin
			if (stats1.errors_cmt_o_ld == 0) stats1.errortime_cmt_o_ld = $time;
			stats1.errors_cmt_o_ld++;
		end
		if (cmt_o_stamo_ref !== (cmt_o_stamo_ref ^ cmt_o_stamo_dut ^ cmt_o_stamo_ref)) begin
			if (stats1.errors_cmt_o_stamo == 0) stats1.errortime_cmt_o_stamo = $time;
			stats1.errors_cmt_o_stamo++;
		end
		if (cmt_o_buserr_ref !== (cmt_o_buserr_ref ^ cmt_o_buserr_dut ^ cmt_o_buserr_ref)) begin
			if (stats1.errors_cmt_o_buserr == 0) stats1.errortime_cmt_o_buserr = $time;
			stats1.errors_cmt_o_buserr++;
		end
		if (cmt_o_badaddr_ref !== (cmt_o_badaddr_ref ^ cmt_o_badaddr_dut ^ cmt_o_badaddr_ref)) begin
			if (stats1.errors_cmt_o_badaddr == 0) stats1.errortime_cmt_o_badaddr = $time;
			stats1.errors_cmt_o_badaddr++;
		end
		if (wbck_o_valid_ref !== (wbck_o_valid_ref ^ wbck_o_valid_dut ^ wbck_o_valid_ref)) begin
			if (stats1.errors_wbck_o_valid == 0) stats1.errortime_wbck_o_valid = $time;
			stats1.errors_wbck_o_valid++;
		end
		if (wbck_o_wdat_ref !== (wbck_o_wdat_ref ^ wbck_o_wdat_dut ^ wbck_o_wdat_ref)) begin
			if (stats1.errors_wbck_o_wdat == 0) stats1.errortime_wbck_o_wdat = $time;
			stats1.errors_wbck_o_wdat++;
		end
		if (wbck_o_rdidx_ref !== (wbck_o_rdidx_ref ^ wbck_o_rdidx_dut ^ wbck_o_rdidx_ref)) begin
			if (stats1.errors_wbck_o_rdidx == 0) stats1.errortime_wbck_o_rdidx = $time;
			stats1.errors_wbck_o_rdidx++;
		end
		if (csr_ena_ref !== (csr_ena_ref ^ csr_ena_dut ^ csr_ena_ref)) begin
			if (stats1.errors_csr_ena == 0) stats1.errortime_csr_ena = $time;
			stats1.errors_csr_ena++;
		end
		if (csr_wr_en_ref !== (csr_wr_en_ref ^ csr_wr_en_dut ^ csr_wr_en_ref)) begin
			if (stats1.errors_csr_wr_en == 0) stats1.errortime_csr_wr_en = $time;
			stats1.errors_csr_wr_en++;
		end
		if (csr_rd_en_ref !== (csr_rd_en_ref ^ csr_rd_en_dut ^ csr_rd_en_ref)) begin
			if (stats1.errors_csr_rd_en == 0) stats1.errortime_csr_rd_en = $time;
			stats1.errors_csr_rd_en++;
		end
		if (csr_idx_ref !== (csr_idx_ref ^ csr_idx_dut ^ csr_idx_ref)) begin
			if (stats1.errors_csr_idx == 0) stats1.errortime_csr_idx = $time;
			stats1.errors_csr_idx++;
		end
		if (wbck_csr_dat_ref !== (wbck_csr_dat_ref ^ wbck_csr_dat_dut ^ wbck_csr_dat_ref)) begin
			if (stats1.errors_wbck_csr_dat == 0) stats1.errortime_wbck_csr_dat = $time;
			stats1.errors_wbck_csr_dat++;
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
		if (nice_rsp_multicyc_ready_ref !== (nice_rsp_multicyc_ready_ref ^ nice_rsp_multicyc_ready_dut ^ nice_rsp_multicyc_ready_ref)) begin
			if (stats1.errors_nice_rsp_multicyc_ready == 0) stats1.errortime_nice_rsp_multicyc_ready = $time;
			stats1.errors_nice_rsp_multicyc_ready++;
		end
		if (nice_longp_wbck_valid_ref !== (nice_longp_wbck_valid_ref ^ nice_longp_wbck_valid_dut ^ nice_longp_wbck_valid_ref)) begin
			if (stats1.errors_nice_longp_wbck_valid == 0) stats1.errortime_nice_longp_wbck_valid = $time;
			stats1.errors_nice_longp_wbck_valid++;
		end
		if (nice_o_itag_ref !== (nice_o_itag_ref ^ nice_o_itag_dut ^ nice_o_itag_ref)) begin
			if (stats1.errors_nice_o_itag == 0) stats1.errortime_nice_o_itag = $time;
			stats1.errors_nice_o_itag++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
