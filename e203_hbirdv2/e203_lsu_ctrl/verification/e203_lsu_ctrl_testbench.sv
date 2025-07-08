`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_lsu_ctrl_active;
		int errortime_lsu_ctrl_active;
		int errors_lsu_o_valid;
		int errortime_lsu_o_valid;
		int errors_lsu_o_wbck_wdat;
		int errortime_lsu_o_wbck_wdat;
		int errors_lsu_o_wbck_itag;
		int errortime_lsu_o_wbck_itag;
		int errors_lsu_o_wbck_err;
		int errortime_lsu_o_wbck_err;
		int errors_lsu_o_cmt_buserr;
		int errortime_lsu_o_cmt_buserr;
		int errors_lsu_o_cmt_badaddr;
		int errortime_lsu_o_cmt_badaddr;
		int errors_lsu_o_cmt_ld;
		int errortime_lsu_o_cmt_ld;
		int errors_lsu_o_cmt_st;
		int errortime_lsu_o_cmt_st;
		int errors_agu_icb_cmd_ready;
		int errortime_agu_icb_cmd_ready;
		int errors_agu_icb_rsp_valid;
		int errortime_agu_icb_rsp_valid;
		int errors_agu_icb_rsp_err;
		int errortime_agu_icb_rsp_err;
		int errors_agu_icb_rsp_excl_ok;
		int errortime_agu_icb_rsp_excl_ok;
		int errors_agu_icb_rsp_rdata;
		int errortime_agu_icb_rsp_rdata;
		int errors_nice_icb_cmd_ready;
		int errortime_nice_icb_cmd_ready;
		int errors_nice_icb_rsp_valid;
		int errortime_nice_icb_rsp_valid;
		int errors_nice_icb_rsp_err;
		int errortime_nice_icb_rsp_err;
		int errors_nice_icb_rsp_excl_ok;
		int errortime_nice_icb_rsp_excl_ok;
		int errors_nice_icb_rsp_rdata;
		int errortime_nice_icb_rsp_rdata;
		int errors_dtcm_icb_cmd_valid;
		int errortime_dtcm_icb_cmd_valid;
		int errors_dtcm_icb_cmd_addr;
		int errortime_dtcm_icb_cmd_addr;
		int errors_dtcm_icb_cmd_read;
		int errortime_dtcm_icb_cmd_read;
		int errors_dtcm_icb_cmd_wdata;
		int errortime_dtcm_icb_cmd_wdata;
		int errors_dtcm_icb_cmd_wmask;
		int errortime_dtcm_icb_cmd_wmask;
		int errors_dtcm_icb_cmd_lock;
		int errortime_dtcm_icb_cmd_lock;
		int errors_dtcm_icb_cmd_excl;
		int errortime_dtcm_icb_cmd_excl;
		int errors_dtcm_icb_cmd_size;
		int errortime_dtcm_icb_cmd_size;
		int errors_dtcm_icb_rsp_ready;
		int errortime_dtcm_icb_rsp_ready;
		int errors_itcm_icb_cmd_valid;
		int errortime_itcm_icb_cmd_valid;
		int errors_itcm_icb_cmd_addr;
		int errortime_itcm_icb_cmd_addr;
		int errors_itcm_icb_cmd_read;
		int errortime_itcm_icb_cmd_read;
		int errors_itcm_icb_cmd_wdata;
		int errortime_itcm_icb_cmd_wdata;
		int errors_itcm_icb_cmd_wmask;
		int errortime_itcm_icb_cmd_wmask;
		int errors_itcm_icb_cmd_lock;
		int errortime_itcm_icb_cmd_lock;
		int errors_itcm_icb_cmd_excl;
		int errortime_itcm_icb_cmd_excl;
		int errors_itcm_icb_cmd_size;
		int errortime_itcm_icb_cmd_size;
		int errors_itcm_icb_rsp_ready;
		int errortime_itcm_icb_rsp_ready;
		int errors_biu_icb_cmd_valid;
		int errortime_biu_icb_cmd_valid;
		int errors_biu_icb_cmd_addr;
		int errortime_biu_icb_cmd_addr;
		int errors_biu_icb_cmd_read;
		int errortime_biu_icb_cmd_read;
		int errors_biu_icb_cmd_wdata;
		int errortime_biu_icb_cmd_wdata;
		int errors_biu_icb_cmd_wmask;
		int errortime_biu_icb_cmd_wmask;
		int errors_biu_icb_cmd_lock;
		int errortime_biu_icb_cmd_lock;
		int errors_biu_icb_cmd_excl;
		int errortime_biu_icb_cmd_excl;
		int errors_biu_icb_cmd_size;
		int errortime_biu_icb_cmd_size;
		int errors_biu_icb_rsp_ready;
		int errortime_biu_icb_rsp_ready;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic commit_mret;
	logic commit_trap;
	logic lsu_ctrl_active_ref;
	logic lsu_ctrl_active_dut;
	logic [32-1:0] itcm_region_indic;
	logic [32-1:0] dtcm_region_indic;
	logic lsu_o_valid_ref;
	logic lsu_o_valid_dut;
	logic lsu_o_ready;
	logic [32-1:0] lsu_o_wbck_wdat_ref;
	logic [32-1:0] lsu_o_wbck_wdat_dut;
	logic lsu_o_wbck_itag_ref;
	logic lsu_o_wbck_itag_dut;
	logic lsu_o_wbck_err_ref;
	logic lsu_o_wbck_err_dut;
	logic lsu_o_cmt_buserr_ref;
	logic lsu_o_cmt_buserr_dut;
	logic [32-1:0] lsu_o_cmt_badaddr_ref;
	logic [32-1:0] lsu_o_cmt_badaddr_dut;
	logic lsu_o_cmt_ld_ref;
	logic lsu_o_cmt_ld_dut;
	logic lsu_o_cmt_st_ref;
	logic lsu_o_cmt_st_dut;
	logic agu_icb_cmd_valid;
	logic agu_icb_cmd_ready_ref;
	logic agu_icb_cmd_ready_dut;
	logic [32-1:0] agu_icb_cmd_addr;
	logic agu_icb_cmd_read;
	logic [32-1:0] agu_icb_cmd_wdata;
	logic [4-1:0] agu_icb_cmd_wmask;
	logic agu_icb_cmd_lock;
	logic agu_icb_cmd_excl;
	logic [2-1:0] agu_icb_cmd_size;
	logic agu_icb_cmd_back2agu;
	logic agu_icb_cmd_usign;
	logic agu_icb_cmd_itag;
	logic agu_icb_rsp_valid_ref;
	logic agu_icb_rsp_valid_dut;
	logic agu_icb_rsp_ready;
	logic agu_icb_rsp_err_ref;
	logic agu_icb_rsp_err_dut;
	logic agu_icb_rsp_excl_ok_ref;
	logic agu_icb_rsp_excl_ok_dut;
	logic [32-1:0] agu_icb_rsp_rdata_ref;
	logic [32-1:0] agu_icb_rsp_rdata_dut;
	logic nice_mem_holdup;
	logic nice_icb_cmd_valid;
	logic nice_icb_cmd_ready_ref;
	logic nice_icb_cmd_ready_dut;
	logic [32-1:0] nice_icb_cmd_addr;
	logic nice_icb_cmd_read;
	logic [32-1:0] nice_icb_cmd_wdata;
	logic [4-1:0] nice_icb_cmd_wmask;
	logic nice_icb_cmd_lock;
	logic nice_icb_cmd_excl;
	logic [2-1:0] nice_icb_cmd_size;
	logic nice_icb_rsp_valid_ref;
	logic nice_icb_rsp_valid_dut;
	logic nice_icb_rsp_ready;
	logic nice_icb_rsp_err_ref;
	logic nice_icb_rsp_err_dut;
	logic nice_icb_rsp_excl_ok_ref;
	logic nice_icb_rsp_excl_ok_dut;
	logic [32-1:0] nice_icb_rsp_rdata_ref;
	logic [32-1:0] nice_icb_rsp_rdata_dut;
	logic dtcm_icb_cmd_valid_ref;
	logic dtcm_icb_cmd_valid_dut;
	logic dtcm_icb_cmd_ready;
	logic [16-1:0] dtcm_icb_cmd_addr_ref;
	logic [16-1:0] dtcm_icb_cmd_addr_dut;
	logic dtcm_icb_cmd_read_ref;
	logic dtcm_icb_cmd_read_dut;
	logic [32-1:0] dtcm_icb_cmd_wdata_ref;
	logic [32-1:0] dtcm_icb_cmd_wdata_dut;
	logic [4-1:0] dtcm_icb_cmd_wmask_ref;
	logic [4-1:0] dtcm_icb_cmd_wmask_dut;
	logic dtcm_icb_cmd_lock_ref;
	logic dtcm_icb_cmd_lock_dut;
	logic dtcm_icb_cmd_excl_ref;
	logic dtcm_icb_cmd_excl_dut;
	logic [2-1:0] dtcm_icb_cmd_size_ref;
	logic [2-1:0] dtcm_icb_cmd_size_dut;
	logic dtcm_icb_rsp_valid;
	logic dtcm_icb_rsp_ready_ref;
	logic dtcm_icb_rsp_ready_dut;
	logic dtcm_icb_rsp_err;
	logic dtcm_icb_rsp_excl_ok;
	logic [32-1:0] dtcm_icb_rsp_rdata;
	logic itcm_icb_cmd_valid_ref;
	logic itcm_icb_cmd_valid_dut;
	logic itcm_icb_cmd_ready;
	logic [16-1:0] itcm_icb_cmd_addr_ref;
	logic [16-1:0] itcm_icb_cmd_addr_dut;
	logic itcm_icb_cmd_read_ref;
	logic itcm_icb_cmd_read_dut;
	logic [32-1:0] itcm_icb_cmd_wdata_ref;
	logic [32-1:0] itcm_icb_cmd_wdata_dut;
	logic [4-1:0] itcm_icb_cmd_wmask_ref;
	logic [4-1:0] itcm_icb_cmd_wmask_dut;
	logic itcm_icb_cmd_lock_ref;
	logic itcm_icb_cmd_lock_dut;
	logic itcm_icb_cmd_excl_ref;
	logic itcm_icb_cmd_excl_dut;
	logic [2-1:0] itcm_icb_cmd_size_ref;
	logic [2-1:0] itcm_icb_cmd_size_dut;
	logic itcm_icb_rsp_valid;
	logic itcm_icb_rsp_ready_ref;
	logic itcm_icb_rsp_ready_dut;
	logic itcm_icb_rsp_err;
	logic itcm_icb_rsp_excl_ok;
	logic [32-1:0] itcm_icb_rsp_rdata;
	logic biu_icb_cmd_valid_ref;
	logic biu_icb_cmd_valid_dut;
	logic biu_icb_cmd_ready;
	logic [32-1:0] biu_icb_cmd_addr_ref;
	logic [32-1:0] biu_icb_cmd_addr_dut;
	logic biu_icb_cmd_read_ref;
	logic biu_icb_cmd_read_dut;
	logic [32-1:0] biu_icb_cmd_wdata_ref;
	logic [32-1:0] biu_icb_cmd_wdata_dut;
	logic [4-1:0] biu_icb_cmd_wmask_ref;
	logic [4-1:0] biu_icb_cmd_wmask_dut;
	logic biu_icb_cmd_lock_ref;
	logic biu_icb_cmd_lock_dut;
	logic biu_icb_cmd_excl_ref;
	logic biu_icb_cmd_excl_dut;
	logic [2-1:0] biu_icb_cmd_size_ref;
	logic [2-1:0] biu_icb_cmd_size_dut;
	logic biu_icb_rsp_valid;
	logic biu_icb_rsp_ready_ref;
	logic biu_icb_rsp_ready_dut;
	logic biu_icb_rsp_err;
	logic biu_icb_rsp_excl_ok;
	logic [32-1:0] biu_icb_rsp_rdata;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.commit_mret(commit_mret),
		.commit_trap(commit_trap),
		.itcm_region_indic(itcm_region_indic),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu_o_ready(lsu_o_ready),
		.agu_icb_cmd_valid(agu_icb_cmd_valid),
		.agu_icb_cmd_addr(agu_icb_cmd_addr),
		.agu_icb_cmd_read(agu_icb_cmd_read),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask),
		.agu_icb_cmd_lock(agu_icb_cmd_lock),
		.agu_icb_cmd_excl(agu_icb_cmd_excl),
		.agu_icb_cmd_size(agu_icb_cmd_size),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu),
		.agu_icb_cmd_usign(agu_icb_cmd_usign),
		.agu_icb_cmd_itag(agu_icb_cmd_itag),
		.agu_icb_rsp_ready(agu_icb_rsp_ready),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_wmask(nice_icb_cmd_wmask),
		.nice_icb_cmd_lock(nice_icb_cmd_lock),
		.nice_icb_cmd_excl(nice_icb_cmd_excl),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.dtcm_icb_cmd_ready(dtcm_icb_cmd_ready),
		.dtcm_icb_rsp_valid(dtcm_icb_rsp_valid),
		.dtcm_icb_rsp_err(dtcm_icb_rsp_err),
		.dtcm_icb_rsp_excl_ok(dtcm_icb_rsp_excl_ok),
		.dtcm_icb_rsp_rdata(dtcm_icb_rsp_rdata),
		.itcm_icb_cmd_ready(itcm_icb_cmd_ready),
		.itcm_icb_rsp_valid(itcm_icb_rsp_valid),
		.itcm_icb_rsp_err(itcm_icb_rsp_err),
		.itcm_icb_rsp_excl_ok(itcm_icb_rsp_excl_ok),
		.itcm_icb_rsp_rdata(itcm_icb_rsp_rdata),
		.biu_icb_cmd_ready(biu_icb_cmd_ready),
		.biu_icb_rsp_valid(biu_icb_rsp_valid),
		.biu_icb_rsp_err(biu_icb_rsp_err),
		.biu_icb_rsp_excl_ok(biu_icb_rsp_excl_ok),
		.biu_icb_rsp_rdata(biu_icb_rsp_rdata),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_lsu_ctrl good1 (
		.commit_mret(commit_mret),
		.commit_trap(commit_trap),
		.lsu_ctrl_active(lsu_ctrl_active_ref),
		.itcm_region_indic(itcm_region_indic),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu_o_valid(lsu_o_valid_ref),
		.lsu_o_ready(lsu_o_ready),
		.lsu_o_wbck_wdat(lsu_o_wbck_wdat_ref),
		.lsu_o_wbck_itag(lsu_o_wbck_itag_ref),
		.lsu_o_wbck_err(lsu_o_wbck_err_ref),
		.lsu_o_cmt_buserr(lsu_o_cmt_buserr_ref),
		.lsu_o_cmt_badaddr(lsu_o_cmt_badaddr_ref),
		.lsu_o_cmt_ld(lsu_o_cmt_ld_ref),
		.lsu_o_cmt_st(lsu_o_cmt_st_ref),
		.agu_icb_cmd_valid(agu_icb_cmd_valid),
		.agu_icb_cmd_ready(agu_icb_cmd_ready_ref),
		.agu_icb_cmd_addr(agu_icb_cmd_addr),
		.agu_icb_cmd_read(agu_icb_cmd_read),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask),
		.agu_icb_cmd_lock(agu_icb_cmd_lock),
		.agu_icb_cmd_excl(agu_icb_cmd_excl),
		.agu_icb_cmd_size(agu_icb_cmd_size),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu),
		.agu_icb_cmd_usign(agu_icb_cmd_usign),
		.agu_icb_cmd_itag(agu_icb_cmd_itag),
		.agu_icb_rsp_valid(agu_icb_rsp_valid_ref),
		.agu_icb_rsp_ready(agu_icb_rsp_ready),
		.agu_icb_rsp_err(agu_icb_rsp_err_ref),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok_ref),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata_ref),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_ready(nice_icb_cmd_ready_ref),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_wmask(nice_icb_cmd_wmask),
		.nice_icb_cmd_lock(nice_icb_cmd_lock),
		.nice_icb_cmd_excl(nice_icb_cmd_excl),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_valid(nice_icb_rsp_valid_ref),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.nice_icb_rsp_err(nice_icb_rsp_err_ref),
		.nice_icb_rsp_excl_ok(nice_icb_rsp_excl_ok_ref),
		.nice_icb_rsp_rdata(nice_icb_rsp_rdata_ref),
		.dtcm_icb_cmd_valid(dtcm_icb_cmd_valid_ref),
		.dtcm_icb_cmd_ready(dtcm_icb_cmd_ready),
		.dtcm_icb_cmd_addr(dtcm_icb_cmd_addr_ref),
		.dtcm_icb_cmd_read(dtcm_icb_cmd_read_ref),
		.dtcm_icb_cmd_wdata(dtcm_icb_cmd_wdata_ref),
		.dtcm_icb_cmd_wmask(dtcm_icb_cmd_wmask_ref),
		.dtcm_icb_cmd_lock(dtcm_icb_cmd_lock_ref),
		.dtcm_icb_cmd_excl(dtcm_icb_cmd_excl_ref),
		.dtcm_icb_cmd_size(dtcm_icb_cmd_size_ref),
		.dtcm_icb_rsp_valid(dtcm_icb_rsp_valid),
		.dtcm_icb_rsp_ready(dtcm_icb_rsp_ready_ref),
		.dtcm_icb_rsp_err(dtcm_icb_rsp_err),
		.dtcm_icb_rsp_excl_ok(dtcm_icb_rsp_excl_ok),
		.dtcm_icb_rsp_rdata(dtcm_icb_rsp_rdata),
		.itcm_icb_cmd_valid(itcm_icb_cmd_valid_ref),
		.itcm_icb_cmd_ready(itcm_icb_cmd_ready),
		.itcm_icb_cmd_addr(itcm_icb_cmd_addr_ref),
		.itcm_icb_cmd_read(itcm_icb_cmd_read_ref),
		.itcm_icb_cmd_wdata(itcm_icb_cmd_wdata_ref),
		.itcm_icb_cmd_wmask(itcm_icb_cmd_wmask_ref),
		.itcm_icb_cmd_lock(itcm_icb_cmd_lock_ref),
		.itcm_icb_cmd_excl(itcm_icb_cmd_excl_ref),
		.itcm_icb_cmd_size(itcm_icb_cmd_size_ref),
		.itcm_icb_rsp_valid(itcm_icb_rsp_valid),
		.itcm_icb_rsp_ready(itcm_icb_rsp_ready_ref),
		.itcm_icb_rsp_err(itcm_icb_rsp_err),
		.itcm_icb_rsp_excl_ok(itcm_icb_rsp_excl_ok),
		.itcm_icb_rsp_rdata(itcm_icb_rsp_rdata),
		.biu_icb_cmd_valid(biu_icb_cmd_valid_ref),
		.biu_icb_cmd_ready(biu_icb_cmd_ready),
		.biu_icb_cmd_addr(biu_icb_cmd_addr_ref),
		.biu_icb_cmd_read(biu_icb_cmd_read_ref),
		.biu_icb_cmd_wdata(biu_icb_cmd_wdata_ref),
		.biu_icb_cmd_wmask(biu_icb_cmd_wmask_ref),
		.biu_icb_cmd_lock(biu_icb_cmd_lock_ref),
		.biu_icb_cmd_excl(biu_icb_cmd_excl_ref),
		.biu_icb_cmd_size(biu_icb_cmd_size_ref),
		.biu_icb_rsp_valid(biu_icb_rsp_valid),
		.biu_icb_rsp_ready(biu_icb_rsp_ready_ref),
		.biu_icb_rsp_err(biu_icb_rsp_err),
		.biu_icb_rsp_excl_ok(biu_icb_rsp_excl_ok),
		.biu_icb_rsp_rdata(biu_icb_rsp_rdata),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_lsu_ctrl top_module1 (
		.commit_mret(commit_mret),
		.commit_trap(commit_trap),
		.lsu_ctrl_active(lsu_ctrl_active_dut),
		.itcm_region_indic(itcm_region_indic),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu_o_valid(lsu_o_valid_dut),
		.lsu_o_ready(lsu_o_ready),
		.lsu_o_wbck_wdat(lsu_o_wbck_wdat_dut),
		.lsu_o_wbck_itag(lsu_o_wbck_itag_dut),
		.lsu_o_wbck_err(lsu_o_wbck_err_dut),
		.lsu_o_cmt_buserr(lsu_o_cmt_buserr_dut),
		.lsu_o_cmt_badaddr(lsu_o_cmt_badaddr_dut),
		.lsu_o_cmt_ld(lsu_o_cmt_ld_dut),
		.lsu_o_cmt_st(lsu_o_cmt_st_dut),
		.agu_icb_cmd_valid(agu_icb_cmd_valid),
		.agu_icb_cmd_ready(agu_icb_cmd_ready_dut),
		.agu_icb_cmd_addr(agu_icb_cmd_addr),
		.agu_icb_cmd_read(agu_icb_cmd_read),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask),
		.agu_icb_cmd_lock(agu_icb_cmd_lock),
		.agu_icb_cmd_excl(agu_icb_cmd_excl),
		.agu_icb_cmd_size(agu_icb_cmd_size),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu),
		.agu_icb_cmd_usign(agu_icb_cmd_usign),
		.agu_icb_cmd_itag(agu_icb_cmd_itag),
		.agu_icb_rsp_valid(agu_icb_rsp_valid_dut),
		.agu_icb_rsp_ready(agu_icb_rsp_ready),
		.agu_icb_rsp_err(agu_icb_rsp_err_dut),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok_dut),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata_dut),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_ready(nice_icb_cmd_ready_dut),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_wmask(nice_icb_cmd_wmask),
		.nice_icb_cmd_lock(nice_icb_cmd_lock),
		.nice_icb_cmd_excl(nice_icb_cmd_excl),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_valid(nice_icb_rsp_valid_dut),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.nice_icb_rsp_err(nice_icb_rsp_err_dut),
		.nice_icb_rsp_excl_ok(nice_icb_rsp_excl_ok_dut),
		.nice_icb_rsp_rdata(nice_icb_rsp_rdata_dut),
		.dtcm_icb_cmd_valid(dtcm_icb_cmd_valid_dut),
		.dtcm_icb_cmd_ready(dtcm_icb_cmd_ready),
		.dtcm_icb_cmd_addr(dtcm_icb_cmd_addr_dut),
		.dtcm_icb_cmd_read(dtcm_icb_cmd_read_dut),
		.dtcm_icb_cmd_wdata(dtcm_icb_cmd_wdata_dut),
		.dtcm_icb_cmd_wmask(dtcm_icb_cmd_wmask_dut),
		.dtcm_icb_cmd_lock(dtcm_icb_cmd_lock_dut),
		.dtcm_icb_cmd_excl(dtcm_icb_cmd_excl_dut),
		.dtcm_icb_cmd_size(dtcm_icb_cmd_size_dut),
		.dtcm_icb_rsp_valid(dtcm_icb_rsp_valid),
		.dtcm_icb_rsp_ready(dtcm_icb_rsp_ready_dut),
		.dtcm_icb_rsp_err(dtcm_icb_rsp_err),
		.dtcm_icb_rsp_excl_ok(dtcm_icb_rsp_excl_ok),
		.dtcm_icb_rsp_rdata(dtcm_icb_rsp_rdata),
		.itcm_icb_cmd_valid(itcm_icb_cmd_valid_dut),
		.itcm_icb_cmd_ready(itcm_icb_cmd_ready),
		.itcm_icb_cmd_addr(itcm_icb_cmd_addr_dut),
		.itcm_icb_cmd_read(itcm_icb_cmd_read_dut),
		.itcm_icb_cmd_wdata(itcm_icb_cmd_wdata_dut),
		.itcm_icb_cmd_wmask(itcm_icb_cmd_wmask_dut),
		.itcm_icb_cmd_lock(itcm_icb_cmd_lock_dut),
		.itcm_icb_cmd_excl(itcm_icb_cmd_excl_dut),
		.itcm_icb_cmd_size(itcm_icb_cmd_size_dut),
		.itcm_icb_rsp_valid(itcm_icb_rsp_valid),
		.itcm_icb_rsp_ready(itcm_icb_rsp_ready_dut),
		.itcm_icb_rsp_err(itcm_icb_rsp_err),
		.itcm_icb_rsp_excl_ok(itcm_icb_rsp_excl_ok),
		.itcm_icb_rsp_rdata(itcm_icb_rsp_rdata),
		.biu_icb_cmd_valid(biu_icb_cmd_valid_dut),
		.biu_icb_cmd_ready(biu_icb_cmd_ready),
		.biu_icb_cmd_addr(biu_icb_cmd_addr_dut),
		.biu_icb_cmd_read(biu_icb_cmd_read_dut),
		.biu_icb_cmd_wdata(biu_icb_cmd_wdata_dut),
		.biu_icb_cmd_wmask(biu_icb_cmd_wmask_dut),
		.biu_icb_cmd_lock(biu_icb_cmd_lock_dut),
		.biu_icb_cmd_excl(biu_icb_cmd_excl_dut),
		.biu_icb_cmd_size(biu_icb_cmd_size_dut),
		.biu_icb_rsp_valid(biu_icb_rsp_valid),
		.biu_icb_rsp_ready(biu_icb_rsp_ready_dut),
		.biu_icb_rsp_err(biu_icb_rsp_err),
		.biu_icb_rsp_excl_ok(biu_icb_rsp_excl_ok),
		.biu_icb_rsp_rdata(biu_icb_rsp_rdata),
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
		if (stats1.errors_lsu_ctrl_active)
			$display("Hint: Output 'lsu_ctrl_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_ctrl_active, stats1.errortime_lsu_ctrl_active);
		else
			$display("Hint: Output 'lsu_ctrl_active' has no mismatches.");
		if (stats1.errors_lsu_o_valid)
			$display("Hint: Output 'lsu_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_valid, stats1.errortime_lsu_o_valid);
		else
			$display("Hint: Output 'lsu_o_valid' has no mismatches.");
		if (stats1.errors_lsu_o_wbck_wdat)
			$display("Hint: Output 'lsu_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_wbck_wdat, stats1.errortime_lsu_o_wbck_wdat);
		else
			$display("Hint: Output 'lsu_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_lsu_o_wbck_itag)
			$display("Hint: Output 'lsu_o_wbck_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_wbck_itag, stats1.errortime_lsu_o_wbck_itag);
		else
			$display("Hint: Output 'lsu_o_wbck_itag' has no mismatches.");
		if (stats1.errors_lsu_o_wbck_err)
			$display("Hint: Output 'lsu_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_wbck_err, stats1.errortime_lsu_o_wbck_err);
		else
			$display("Hint: Output 'lsu_o_wbck_err' has no mismatches.");
		if (stats1.errors_lsu_o_cmt_buserr)
			$display("Hint: Output 'lsu_o_cmt_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_cmt_buserr, stats1.errortime_lsu_o_cmt_buserr);
		else
			$display("Hint: Output 'lsu_o_cmt_buserr' has no mismatches.");
		if (stats1.errors_lsu_o_cmt_badaddr)
			$display("Hint: Output 'lsu_o_cmt_badaddr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_cmt_badaddr, stats1.errortime_lsu_o_cmt_badaddr);
		else
			$display("Hint: Output 'lsu_o_cmt_badaddr' has no mismatches.");
		if (stats1.errors_lsu_o_cmt_ld)
			$display("Hint: Output 'lsu_o_cmt_ld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_cmt_ld, stats1.errortime_lsu_o_cmt_ld);
		else
			$display("Hint: Output 'lsu_o_cmt_ld' has no mismatches.");
		if (stats1.errors_lsu_o_cmt_st)
			$display("Hint: Output 'lsu_o_cmt_st' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_o_cmt_st, stats1.errortime_lsu_o_cmt_st);
		else
			$display("Hint: Output 'lsu_o_cmt_st' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_ready)
			$display("Hint: Output 'agu_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_ready, stats1.errortime_agu_icb_cmd_ready);
		else
			$display("Hint: Output 'agu_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_valid)
			$display("Hint: Output 'agu_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_valid, stats1.errortime_agu_icb_rsp_valid);
		else
			$display("Hint: Output 'agu_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_err)
			$display("Hint: Output 'agu_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_err, stats1.errortime_agu_icb_rsp_err);
		else
			$display("Hint: Output 'agu_icb_rsp_err' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_excl_ok)
			$display("Hint: Output 'agu_icb_rsp_excl_ok' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_excl_ok, stats1.errortime_agu_icb_rsp_excl_ok);
		else
			$display("Hint: Output 'agu_icb_rsp_excl_ok' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_rdata)
			$display("Hint: Output 'agu_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_rdata, stats1.errortime_agu_icb_rsp_rdata);
		else
			$display("Hint: Output 'agu_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_nice_icb_cmd_ready)
			$display("Hint: Output 'nice_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_cmd_ready, stats1.errortime_nice_icb_cmd_ready);
		else
			$display("Hint: Output 'nice_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_nice_icb_rsp_valid)
			$display("Hint: Output 'nice_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_valid, stats1.errortime_nice_icb_rsp_valid);
		else
			$display("Hint: Output 'nice_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_nice_icb_rsp_err)
			$display("Hint: Output 'nice_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_err, stats1.errortime_nice_icb_rsp_err);
		else
			$display("Hint: Output 'nice_icb_rsp_err' has no mismatches.");
		if (stats1.errors_nice_icb_rsp_excl_ok)
			$display("Hint: Output 'nice_icb_rsp_excl_ok' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_excl_ok, stats1.errortime_nice_icb_rsp_excl_ok);
		else
			$display("Hint: Output 'nice_icb_rsp_excl_ok' has no mismatches.");
		if (stats1.errors_nice_icb_rsp_rdata)
			$display("Hint: Output 'nice_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_rdata, stats1.errortime_nice_icb_rsp_rdata);
		else
			$display("Hint: Output 'nice_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_valid)
			$display("Hint: Output 'dtcm_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_valid, stats1.errortime_dtcm_icb_cmd_valid);
		else
			$display("Hint: Output 'dtcm_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_addr)
			$display("Hint: Output 'dtcm_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_addr, stats1.errortime_dtcm_icb_cmd_addr);
		else
			$display("Hint: Output 'dtcm_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_read)
			$display("Hint: Output 'dtcm_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_read, stats1.errortime_dtcm_icb_cmd_read);
		else
			$display("Hint: Output 'dtcm_icb_cmd_read' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_wdata)
			$display("Hint: Output 'dtcm_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_wdata, stats1.errortime_dtcm_icb_cmd_wdata);
		else
			$display("Hint: Output 'dtcm_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_wmask)
			$display("Hint: Output 'dtcm_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_wmask, stats1.errortime_dtcm_icb_cmd_wmask);
		else
			$display("Hint: Output 'dtcm_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_lock)
			$display("Hint: Output 'dtcm_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_lock, stats1.errortime_dtcm_icb_cmd_lock);
		else
			$display("Hint: Output 'dtcm_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_excl)
			$display("Hint: Output 'dtcm_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_excl, stats1.errortime_dtcm_icb_cmd_excl);
		else
			$display("Hint: Output 'dtcm_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_dtcm_icb_cmd_size)
			$display("Hint: Output 'dtcm_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_cmd_size, stats1.errortime_dtcm_icb_cmd_size);
		else
			$display("Hint: Output 'dtcm_icb_cmd_size' has no mismatches.");
		if (stats1.errors_dtcm_icb_rsp_ready)
			$display("Hint: Output 'dtcm_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_icb_rsp_ready, stats1.errortime_dtcm_icb_rsp_ready);
		else
			$display("Hint: Output 'dtcm_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_valid)
			$display("Hint: Output 'itcm_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_valid, stats1.errortime_itcm_icb_cmd_valid);
		else
			$display("Hint: Output 'itcm_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_addr)
			$display("Hint: Output 'itcm_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_addr, stats1.errortime_itcm_icb_cmd_addr);
		else
			$display("Hint: Output 'itcm_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_read)
			$display("Hint: Output 'itcm_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_read, stats1.errortime_itcm_icb_cmd_read);
		else
			$display("Hint: Output 'itcm_icb_cmd_read' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_wdata)
			$display("Hint: Output 'itcm_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_wdata, stats1.errortime_itcm_icb_cmd_wdata);
		else
			$display("Hint: Output 'itcm_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_wmask)
			$display("Hint: Output 'itcm_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_wmask, stats1.errortime_itcm_icb_cmd_wmask);
		else
			$display("Hint: Output 'itcm_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_lock)
			$display("Hint: Output 'itcm_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_lock, stats1.errortime_itcm_icb_cmd_lock);
		else
			$display("Hint: Output 'itcm_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_excl)
			$display("Hint: Output 'itcm_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_excl, stats1.errortime_itcm_icb_cmd_excl);
		else
			$display("Hint: Output 'itcm_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_itcm_icb_cmd_size)
			$display("Hint: Output 'itcm_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_cmd_size, stats1.errortime_itcm_icb_cmd_size);
		else
			$display("Hint: Output 'itcm_icb_cmd_size' has no mismatches.");
		if (stats1.errors_itcm_icb_rsp_ready)
			$display("Hint: Output 'itcm_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_icb_rsp_ready, stats1.errortime_itcm_icb_rsp_ready);
		else
			$display("Hint: Output 'itcm_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_valid)
			$display("Hint: Output 'biu_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_valid, stats1.errortime_biu_icb_cmd_valid);
		else
			$display("Hint: Output 'biu_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_addr)
			$display("Hint: Output 'biu_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_addr, stats1.errortime_biu_icb_cmd_addr);
		else
			$display("Hint: Output 'biu_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_read)
			$display("Hint: Output 'biu_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_read, stats1.errortime_biu_icb_cmd_read);
		else
			$display("Hint: Output 'biu_icb_cmd_read' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_wdata)
			$display("Hint: Output 'biu_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_wdata, stats1.errortime_biu_icb_cmd_wdata);
		else
			$display("Hint: Output 'biu_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_wmask)
			$display("Hint: Output 'biu_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_wmask, stats1.errortime_biu_icb_cmd_wmask);
		else
			$display("Hint: Output 'biu_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_lock)
			$display("Hint: Output 'biu_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_lock, stats1.errortime_biu_icb_cmd_lock);
		else
			$display("Hint: Output 'biu_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_excl)
			$display("Hint: Output 'biu_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_excl, stats1.errortime_biu_icb_cmd_excl);
		else
			$display("Hint: Output 'biu_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_biu_icb_cmd_size)
			$display("Hint: Output 'biu_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_cmd_size, stats1.errortime_biu_icb_cmd_size);
		else
			$display("Hint: Output 'biu_icb_cmd_size' has no mismatches.");
		if (stats1.errors_biu_icb_rsp_ready)
			$display("Hint: Output 'biu_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_icb_rsp_ready, stats1.errortime_biu_icb_rsp_ready);
		else
			$display("Hint: Output 'biu_icb_rsp_ready' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ lsu_ctrl_active_ref,lsu_o_valid_ref,lsu_o_wbck_wdat_ref,lsu_o_wbck_itag_ref,lsu_o_wbck_err_ref,lsu_o_cmt_buserr_ref,lsu_o_cmt_badaddr_ref,lsu_o_cmt_ld_ref,lsu_o_cmt_st_ref,agu_icb_cmd_ready_ref,agu_icb_rsp_valid_ref,agu_icb_rsp_err_ref,agu_icb_rsp_excl_ok_ref,agu_icb_rsp_rdata_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_err_ref,nice_icb_rsp_excl_ok_ref,nice_icb_rsp_rdata_ref,dtcm_icb_cmd_valid_ref,dtcm_icb_cmd_addr_ref,dtcm_icb_cmd_read_ref,dtcm_icb_cmd_wdata_ref,dtcm_icb_cmd_wmask_ref,dtcm_icb_cmd_lock_ref,dtcm_icb_cmd_excl_ref,dtcm_icb_cmd_size_ref,dtcm_icb_rsp_ready_ref,itcm_icb_cmd_valid_ref,itcm_icb_cmd_addr_ref,itcm_icb_cmd_read_ref,itcm_icb_cmd_wdata_ref,itcm_icb_cmd_wmask_ref,itcm_icb_cmd_lock_ref,itcm_icb_cmd_excl_ref,itcm_icb_cmd_size_ref,itcm_icb_rsp_ready_ref,biu_icb_cmd_valid_ref,biu_icb_cmd_addr_ref,biu_icb_cmd_read_ref,biu_icb_cmd_wdata_ref,biu_icb_cmd_wmask_ref,biu_icb_cmd_lock_ref,biu_icb_cmd_excl_ref,biu_icb_cmd_size_ref,biu_icb_rsp_ready_ref} ===
			( { lsu_ctrl_active_ref,lsu_o_valid_ref,lsu_o_wbck_wdat_ref,lsu_o_wbck_itag_ref,lsu_o_wbck_err_ref,lsu_o_cmt_buserr_ref,lsu_o_cmt_badaddr_ref,lsu_o_cmt_ld_ref,lsu_o_cmt_st_ref,agu_icb_cmd_ready_ref,agu_icb_rsp_valid_ref,agu_icb_rsp_err_ref,agu_icb_rsp_excl_ok_ref,agu_icb_rsp_rdata_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_err_ref,nice_icb_rsp_excl_ok_ref,nice_icb_rsp_rdata_ref,dtcm_icb_cmd_valid_ref,dtcm_icb_cmd_addr_ref,dtcm_icb_cmd_read_ref,dtcm_icb_cmd_wdata_ref,dtcm_icb_cmd_wmask_ref,dtcm_icb_cmd_lock_ref,dtcm_icb_cmd_excl_ref,dtcm_icb_cmd_size_ref,dtcm_icb_rsp_ready_ref,itcm_icb_cmd_valid_ref,itcm_icb_cmd_addr_ref,itcm_icb_cmd_read_ref,itcm_icb_cmd_wdata_ref,itcm_icb_cmd_wmask_ref,itcm_icb_cmd_lock_ref,itcm_icb_cmd_excl_ref,itcm_icb_cmd_size_ref,itcm_icb_rsp_ready_ref,biu_icb_cmd_valid_ref,biu_icb_cmd_addr_ref,biu_icb_cmd_read_ref,biu_icb_cmd_wdata_ref,biu_icb_cmd_wmask_ref,biu_icb_cmd_lock_ref,biu_icb_cmd_excl_ref,biu_icb_cmd_size_ref,biu_icb_rsp_ready_ref} ^
			  { lsu_ctrl_active_dut,lsu_o_valid_dut,lsu_o_wbck_wdat_dut,lsu_o_wbck_itag_dut,lsu_o_wbck_err_dut,lsu_o_cmt_buserr_dut,lsu_o_cmt_badaddr_dut,lsu_o_cmt_ld_dut,lsu_o_cmt_st_dut,agu_icb_cmd_ready_dut,agu_icb_rsp_valid_dut,agu_icb_rsp_err_dut,agu_icb_rsp_excl_ok_dut,agu_icb_rsp_rdata_dut,nice_icb_cmd_ready_dut,nice_icb_rsp_valid_dut,nice_icb_rsp_err_dut,nice_icb_rsp_excl_ok_dut,nice_icb_rsp_rdata_dut,dtcm_icb_cmd_valid_dut,dtcm_icb_cmd_addr_dut,dtcm_icb_cmd_read_dut,dtcm_icb_cmd_wdata_dut,dtcm_icb_cmd_wmask_dut,dtcm_icb_cmd_lock_dut,dtcm_icb_cmd_excl_dut,dtcm_icb_cmd_size_dut,dtcm_icb_rsp_ready_dut,itcm_icb_cmd_valid_dut,itcm_icb_cmd_addr_dut,itcm_icb_cmd_read_dut,itcm_icb_cmd_wdata_dut,itcm_icb_cmd_wmask_dut,itcm_icb_cmd_lock_dut,itcm_icb_cmd_excl_dut,itcm_icb_cmd_size_dut,itcm_icb_rsp_ready_dut,biu_icb_cmd_valid_dut,biu_icb_cmd_addr_dut,biu_icb_cmd_read_dut,biu_icb_cmd_wdata_dut,biu_icb_cmd_wmask_dut,biu_icb_cmd_lock_dut,biu_icb_cmd_excl_dut,biu_icb_cmd_size_dut,biu_icb_rsp_ready_dut} ^
			  { lsu_ctrl_active_ref,lsu_o_valid_ref,lsu_o_wbck_wdat_ref,lsu_o_wbck_itag_ref,lsu_o_wbck_err_ref,lsu_o_cmt_buserr_ref,lsu_o_cmt_badaddr_ref,lsu_o_cmt_ld_ref,lsu_o_cmt_st_ref,agu_icb_cmd_ready_ref,agu_icb_rsp_valid_ref,agu_icb_rsp_err_ref,agu_icb_rsp_excl_ok_ref,agu_icb_rsp_rdata_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_err_ref,nice_icb_rsp_excl_ok_ref,nice_icb_rsp_rdata_ref,dtcm_icb_cmd_valid_ref,dtcm_icb_cmd_addr_ref,dtcm_icb_cmd_read_ref,dtcm_icb_cmd_wdata_ref,dtcm_icb_cmd_wmask_ref,dtcm_icb_cmd_lock_ref,dtcm_icb_cmd_excl_ref,dtcm_icb_cmd_size_ref,dtcm_icb_rsp_ready_ref,itcm_icb_cmd_valid_ref,itcm_icb_cmd_addr_ref,itcm_icb_cmd_read_ref,itcm_icb_cmd_wdata_ref,itcm_icb_cmd_wmask_ref,itcm_icb_cmd_lock_ref,itcm_icb_cmd_excl_ref,itcm_icb_cmd_size_ref,itcm_icb_rsp_ready_ref,biu_icb_cmd_valid_ref,biu_icb_cmd_addr_ref,biu_icb_cmd_read_ref,biu_icb_cmd_wdata_ref,biu_icb_cmd_wmask_ref,biu_icb_cmd_lock_ref,biu_icb_cmd_excl_ref,biu_icb_cmd_size_ref,biu_icb_rsp_ready_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (lsu_ctrl_active_ref !== (lsu_ctrl_active_ref ^ lsu_ctrl_active_dut ^ lsu_ctrl_active_ref)) begin
			if (stats1.errors_lsu_ctrl_active == 0) stats1.errortime_lsu_ctrl_active = $time;
			stats1.errors_lsu_ctrl_active++;
		end
		if (lsu_o_valid_ref !== (lsu_o_valid_ref ^ lsu_o_valid_dut ^ lsu_o_valid_ref)) begin
			if (stats1.errors_lsu_o_valid == 0) stats1.errortime_lsu_o_valid = $time;
			stats1.errors_lsu_o_valid++;
		end
		if (lsu_o_wbck_wdat_ref !== (lsu_o_wbck_wdat_ref ^ lsu_o_wbck_wdat_dut ^ lsu_o_wbck_wdat_ref)) begin
			if (stats1.errors_lsu_o_wbck_wdat == 0) stats1.errortime_lsu_o_wbck_wdat = $time;
			stats1.errors_lsu_o_wbck_wdat++;
		end
		if (lsu_o_wbck_itag_ref !== (lsu_o_wbck_itag_ref ^ lsu_o_wbck_itag_dut ^ lsu_o_wbck_itag_ref)) begin
			if (stats1.errors_lsu_o_wbck_itag == 0) stats1.errortime_lsu_o_wbck_itag = $time;
			stats1.errors_lsu_o_wbck_itag++;
		end
		if (lsu_o_wbck_err_ref !== (lsu_o_wbck_err_ref ^ lsu_o_wbck_err_dut ^ lsu_o_wbck_err_ref)) begin
			if (stats1.errors_lsu_o_wbck_err == 0) stats1.errortime_lsu_o_wbck_err = $time;
			stats1.errors_lsu_o_wbck_err++;
		end
		if (lsu_o_cmt_buserr_ref !== (lsu_o_cmt_buserr_ref ^ lsu_o_cmt_buserr_dut ^ lsu_o_cmt_buserr_ref)) begin
			if (stats1.errors_lsu_o_cmt_buserr == 0) stats1.errortime_lsu_o_cmt_buserr = $time;
			stats1.errors_lsu_o_cmt_buserr++;
		end
		if (lsu_o_cmt_badaddr_ref !== (lsu_o_cmt_badaddr_ref ^ lsu_o_cmt_badaddr_dut ^ lsu_o_cmt_badaddr_ref)) begin
			if (stats1.errors_lsu_o_cmt_badaddr == 0) stats1.errortime_lsu_o_cmt_badaddr = $time;
			stats1.errors_lsu_o_cmt_badaddr++;
		end
		if (lsu_o_cmt_ld_ref !== (lsu_o_cmt_ld_ref ^ lsu_o_cmt_ld_dut ^ lsu_o_cmt_ld_ref)) begin
			if (stats1.errors_lsu_o_cmt_ld == 0) stats1.errortime_lsu_o_cmt_ld = $time;
			stats1.errors_lsu_o_cmt_ld++;
		end
		if (lsu_o_cmt_st_ref !== (lsu_o_cmt_st_ref ^ lsu_o_cmt_st_dut ^ lsu_o_cmt_st_ref)) begin
			if (stats1.errors_lsu_o_cmt_st == 0) stats1.errortime_lsu_o_cmt_st = $time;
			stats1.errors_lsu_o_cmt_st++;
		end
		if (agu_icb_cmd_ready_ref !== (agu_icb_cmd_ready_ref ^ agu_icb_cmd_ready_dut ^ agu_icb_cmd_ready_ref)) begin
			if (stats1.errors_agu_icb_cmd_ready == 0) stats1.errortime_agu_icb_cmd_ready = $time;
			stats1.errors_agu_icb_cmd_ready++;
		end
		if (agu_icb_rsp_valid_ref !== (agu_icb_rsp_valid_ref ^ agu_icb_rsp_valid_dut ^ agu_icb_rsp_valid_ref)) begin
			if (stats1.errors_agu_icb_rsp_valid == 0) stats1.errortime_agu_icb_rsp_valid = $time;
			stats1.errors_agu_icb_rsp_valid++;
		end
		if (agu_icb_rsp_err_ref !== (agu_icb_rsp_err_ref ^ agu_icb_rsp_err_dut ^ agu_icb_rsp_err_ref)) begin
			if (stats1.errors_agu_icb_rsp_err == 0) stats1.errortime_agu_icb_rsp_err = $time;
			stats1.errors_agu_icb_rsp_err++;
		end
		if (agu_icb_rsp_excl_ok_ref !== (agu_icb_rsp_excl_ok_ref ^ agu_icb_rsp_excl_ok_dut ^ agu_icb_rsp_excl_ok_ref)) begin
			if (stats1.errors_agu_icb_rsp_excl_ok == 0) stats1.errortime_agu_icb_rsp_excl_ok = $time;
			stats1.errors_agu_icb_rsp_excl_ok++;
		end
		if (agu_icb_rsp_rdata_ref !== (agu_icb_rsp_rdata_ref ^ agu_icb_rsp_rdata_dut ^ agu_icb_rsp_rdata_ref)) begin
			if (stats1.errors_agu_icb_rsp_rdata == 0) stats1.errortime_agu_icb_rsp_rdata = $time;
			stats1.errors_agu_icb_rsp_rdata++;
		end
		if (nice_icb_cmd_ready_ref !== (nice_icb_cmd_ready_ref ^ nice_icb_cmd_ready_dut ^ nice_icb_cmd_ready_ref)) begin
			if (stats1.errors_nice_icb_cmd_ready == 0) stats1.errortime_nice_icb_cmd_ready = $time;
			stats1.errors_nice_icb_cmd_ready++;
		end
		if (nice_icb_rsp_valid_ref !== (nice_icb_rsp_valid_ref ^ nice_icb_rsp_valid_dut ^ nice_icb_rsp_valid_ref)) begin
			if (stats1.errors_nice_icb_rsp_valid == 0) stats1.errortime_nice_icb_rsp_valid = $time;
			stats1.errors_nice_icb_rsp_valid++;
		end
		if (nice_icb_rsp_err_ref !== (nice_icb_rsp_err_ref ^ nice_icb_rsp_err_dut ^ nice_icb_rsp_err_ref)) begin
			if (stats1.errors_nice_icb_rsp_err == 0) stats1.errortime_nice_icb_rsp_err = $time;
			stats1.errors_nice_icb_rsp_err++;
		end
		if (nice_icb_rsp_excl_ok_ref !== (nice_icb_rsp_excl_ok_ref ^ nice_icb_rsp_excl_ok_dut ^ nice_icb_rsp_excl_ok_ref)) begin
			if (stats1.errors_nice_icb_rsp_excl_ok == 0) stats1.errortime_nice_icb_rsp_excl_ok = $time;
			stats1.errors_nice_icb_rsp_excl_ok++;
		end
		if (nice_icb_rsp_rdata_ref !== (nice_icb_rsp_rdata_ref ^ nice_icb_rsp_rdata_dut ^ nice_icb_rsp_rdata_ref)) begin
			if (stats1.errors_nice_icb_rsp_rdata == 0) stats1.errortime_nice_icb_rsp_rdata = $time;
			stats1.errors_nice_icb_rsp_rdata++;
		end
		if (dtcm_icb_cmd_valid_ref !== (dtcm_icb_cmd_valid_ref ^ dtcm_icb_cmd_valid_dut ^ dtcm_icb_cmd_valid_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_valid == 0) stats1.errortime_dtcm_icb_cmd_valid = $time;
			stats1.errors_dtcm_icb_cmd_valid++;
		end
		if (dtcm_icb_cmd_addr_ref !== (dtcm_icb_cmd_addr_ref ^ dtcm_icb_cmd_addr_dut ^ dtcm_icb_cmd_addr_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_addr == 0) stats1.errortime_dtcm_icb_cmd_addr = $time;
			stats1.errors_dtcm_icb_cmd_addr++;
		end
		if (dtcm_icb_cmd_read_ref !== (dtcm_icb_cmd_read_ref ^ dtcm_icb_cmd_read_dut ^ dtcm_icb_cmd_read_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_read == 0) stats1.errortime_dtcm_icb_cmd_read = $time;
			stats1.errors_dtcm_icb_cmd_read++;
		end
		if (dtcm_icb_cmd_wdata_ref !== (dtcm_icb_cmd_wdata_ref ^ dtcm_icb_cmd_wdata_dut ^ dtcm_icb_cmd_wdata_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_wdata == 0) stats1.errortime_dtcm_icb_cmd_wdata = $time;
			stats1.errors_dtcm_icb_cmd_wdata++;
		end
		if (dtcm_icb_cmd_wmask_ref !== (dtcm_icb_cmd_wmask_ref ^ dtcm_icb_cmd_wmask_dut ^ dtcm_icb_cmd_wmask_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_wmask == 0) stats1.errortime_dtcm_icb_cmd_wmask = $time;
			stats1.errors_dtcm_icb_cmd_wmask++;
		end
		if (dtcm_icb_cmd_lock_ref !== (dtcm_icb_cmd_lock_ref ^ dtcm_icb_cmd_lock_dut ^ dtcm_icb_cmd_lock_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_lock == 0) stats1.errortime_dtcm_icb_cmd_lock = $time;
			stats1.errors_dtcm_icb_cmd_lock++;
		end
		if (dtcm_icb_cmd_excl_ref !== (dtcm_icb_cmd_excl_ref ^ dtcm_icb_cmd_excl_dut ^ dtcm_icb_cmd_excl_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_excl == 0) stats1.errortime_dtcm_icb_cmd_excl = $time;
			stats1.errors_dtcm_icb_cmd_excl++;
		end
		if (dtcm_icb_cmd_size_ref !== (dtcm_icb_cmd_size_ref ^ dtcm_icb_cmd_size_dut ^ dtcm_icb_cmd_size_ref)) begin
			if (stats1.errors_dtcm_icb_cmd_size == 0) stats1.errortime_dtcm_icb_cmd_size = $time;
			stats1.errors_dtcm_icb_cmd_size++;
		end
		if (dtcm_icb_rsp_ready_ref !== (dtcm_icb_rsp_ready_ref ^ dtcm_icb_rsp_ready_dut ^ dtcm_icb_rsp_ready_ref)) begin
			if (stats1.errors_dtcm_icb_rsp_ready == 0) stats1.errortime_dtcm_icb_rsp_ready = $time;
			stats1.errors_dtcm_icb_rsp_ready++;
		end
		if (itcm_icb_cmd_valid_ref !== (itcm_icb_cmd_valid_ref ^ itcm_icb_cmd_valid_dut ^ itcm_icb_cmd_valid_ref)) begin
			if (stats1.errors_itcm_icb_cmd_valid == 0) stats1.errortime_itcm_icb_cmd_valid = $time;
			stats1.errors_itcm_icb_cmd_valid++;
		end
		if (itcm_icb_cmd_addr_ref !== (itcm_icb_cmd_addr_ref ^ itcm_icb_cmd_addr_dut ^ itcm_icb_cmd_addr_ref)) begin
			if (stats1.errors_itcm_icb_cmd_addr == 0) stats1.errortime_itcm_icb_cmd_addr = $time;
			stats1.errors_itcm_icb_cmd_addr++;
		end
		if (itcm_icb_cmd_read_ref !== (itcm_icb_cmd_read_ref ^ itcm_icb_cmd_read_dut ^ itcm_icb_cmd_read_ref)) begin
			if (stats1.errors_itcm_icb_cmd_read == 0) stats1.errortime_itcm_icb_cmd_read = $time;
			stats1.errors_itcm_icb_cmd_read++;
		end
		if (itcm_icb_cmd_wdata_ref !== (itcm_icb_cmd_wdata_ref ^ itcm_icb_cmd_wdata_dut ^ itcm_icb_cmd_wdata_ref)) begin
			if (stats1.errors_itcm_icb_cmd_wdata == 0) stats1.errortime_itcm_icb_cmd_wdata = $time;
			stats1.errors_itcm_icb_cmd_wdata++;
		end
		if (itcm_icb_cmd_wmask_ref !== (itcm_icb_cmd_wmask_ref ^ itcm_icb_cmd_wmask_dut ^ itcm_icb_cmd_wmask_ref)) begin
			if (stats1.errors_itcm_icb_cmd_wmask == 0) stats1.errortime_itcm_icb_cmd_wmask = $time;
			stats1.errors_itcm_icb_cmd_wmask++;
		end
		if (itcm_icb_cmd_lock_ref !== (itcm_icb_cmd_lock_ref ^ itcm_icb_cmd_lock_dut ^ itcm_icb_cmd_lock_ref)) begin
			if (stats1.errors_itcm_icb_cmd_lock == 0) stats1.errortime_itcm_icb_cmd_lock = $time;
			stats1.errors_itcm_icb_cmd_lock++;
		end
		if (itcm_icb_cmd_excl_ref !== (itcm_icb_cmd_excl_ref ^ itcm_icb_cmd_excl_dut ^ itcm_icb_cmd_excl_ref)) begin
			if (stats1.errors_itcm_icb_cmd_excl == 0) stats1.errortime_itcm_icb_cmd_excl = $time;
			stats1.errors_itcm_icb_cmd_excl++;
		end
		if (itcm_icb_cmd_size_ref !== (itcm_icb_cmd_size_ref ^ itcm_icb_cmd_size_dut ^ itcm_icb_cmd_size_ref)) begin
			if (stats1.errors_itcm_icb_cmd_size == 0) stats1.errortime_itcm_icb_cmd_size = $time;
			stats1.errors_itcm_icb_cmd_size++;
		end
		if (itcm_icb_rsp_ready_ref !== (itcm_icb_rsp_ready_ref ^ itcm_icb_rsp_ready_dut ^ itcm_icb_rsp_ready_ref)) begin
			if (stats1.errors_itcm_icb_rsp_ready == 0) stats1.errortime_itcm_icb_rsp_ready = $time;
			stats1.errors_itcm_icb_rsp_ready++;
		end
		if (biu_icb_cmd_valid_ref !== (biu_icb_cmd_valid_ref ^ biu_icb_cmd_valid_dut ^ biu_icb_cmd_valid_ref)) begin
			if (stats1.errors_biu_icb_cmd_valid == 0) stats1.errortime_biu_icb_cmd_valid = $time;
			stats1.errors_biu_icb_cmd_valid++;
		end
		if (biu_icb_cmd_addr_ref !== (biu_icb_cmd_addr_ref ^ biu_icb_cmd_addr_dut ^ biu_icb_cmd_addr_ref)) begin
			if (stats1.errors_biu_icb_cmd_addr == 0) stats1.errortime_biu_icb_cmd_addr = $time;
			stats1.errors_biu_icb_cmd_addr++;
		end
		if (biu_icb_cmd_read_ref !== (biu_icb_cmd_read_ref ^ biu_icb_cmd_read_dut ^ biu_icb_cmd_read_ref)) begin
			if (stats1.errors_biu_icb_cmd_read == 0) stats1.errortime_biu_icb_cmd_read = $time;
			stats1.errors_biu_icb_cmd_read++;
		end
		if (biu_icb_cmd_wdata_ref !== (biu_icb_cmd_wdata_ref ^ biu_icb_cmd_wdata_dut ^ biu_icb_cmd_wdata_ref)) begin
			if (stats1.errors_biu_icb_cmd_wdata == 0) stats1.errortime_biu_icb_cmd_wdata = $time;
			stats1.errors_biu_icb_cmd_wdata++;
		end
		if (biu_icb_cmd_wmask_ref !== (biu_icb_cmd_wmask_ref ^ biu_icb_cmd_wmask_dut ^ biu_icb_cmd_wmask_ref)) begin
			if (stats1.errors_biu_icb_cmd_wmask == 0) stats1.errortime_biu_icb_cmd_wmask = $time;
			stats1.errors_biu_icb_cmd_wmask++;
		end
		if (biu_icb_cmd_lock_ref !== (biu_icb_cmd_lock_ref ^ biu_icb_cmd_lock_dut ^ biu_icb_cmd_lock_ref)) begin
			if (stats1.errors_biu_icb_cmd_lock == 0) stats1.errortime_biu_icb_cmd_lock = $time;
			stats1.errors_biu_icb_cmd_lock++;
		end
		if (biu_icb_cmd_excl_ref !== (biu_icb_cmd_excl_ref ^ biu_icb_cmd_excl_dut ^ biu_icb_cmd_excl_ref)) begin
			if (stats1.errors_biu_icb_cmd_excl == 0) stats1.errortime_biu_icb_cmd_excl = $time;
			stats1.errors_biu_icb_cmd_excl++;
		end
		if (biu_icb_cmd_size_ref !== (biu_icb_cmd_size_ref ^ biu_icb_cmd_size_dut ^ biu_icb_cmd_size_ref)) begin
			if (stats1.errors_biu_icb_cmd_size == 0) stats1.errortime_biu_icb_cmd_size = $time;
			stats1.errors_biu_icb_cmd_size++;
		end
		if (biu_icb_rsp_ready_ref !== (biu_icb_rsp_ready_ref ^ biu_icb_rsp_ready_dut ^ biu_icb_rsp_ready_ref)) begin
			if (stats1.errors_biu_icb_rsp_ready == 0) stats1.errortime_biu_icb_rsp_ready = $time;
			stats1.errors_biu_icb_rsp_ready++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
