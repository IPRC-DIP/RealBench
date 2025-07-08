`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_inspect_pc;
		int errortime_inspect_pc;
		int errors_core_wfi;
		int errortime_core_wfi;
		int errors_tm_stop;
		int errortime_tm_stop;
		int errors_core_cgstop;
		int errortime_core_cgstop;
		int errors_tcm_cgstop;
		int errortime_tcm_cgstop;
		int errors_wr_dcsr_ena;
		int errortime_wr_dcsr_ena;
		int errors_wr_dpc_ena;
		int errortime_wr_dpc_ena;
		int errors_wr_dscratch_ena;
		int errortime_wr_dscratch_ena;
		int errors_wr_csr_nxt;
		int errortime_wr_csr_nxt;
		int errors_cmt_dpc;
		int errortime_cmt_dpc;
		int errors_cmt_dpc_ena;
		int errortime_cmt_dpc_ena;
		int errors_cmt_dcause;
		int errortime_cmt_dcause;
		int errors_cmt_dcause_ena;
		int errortime_cmt_dcause_ena;
		int errors_ifu2itcm_icb_cmd_valid;
		int errortime_ifu2itcm_icb_cmd_valid;
		int errors_ifu2itcm_icb_cmd_addr;
		int errortime_ifu2itcm_icb_cmd_addr;
		int errors_ifu2itcm_icb_rsp_ready;
		int errortime_ifu2itcm_icb_rsp_ready;
		int errors_ppi_icb_cmd_valid;
		int errortime_ppi_icb_cmd_valid;
		int errors_ppi_icb_cmd_addr;
		int errortime_ppi_icb_cmd_addr;
		int errors_ppi_icb_cmd_read;
		int errortime_ppi_icb_cmd_read;
		int errors_ppi_icb_cmd_wdata;
		int errortime_ppi_icb_cmd_wdata;
		int errors_ppi_icb_cmd_wmask;
		int errortime_ppi_icb_cmd_wmask;
		int errors_ppi_icb_cmd_lock;
		int errortime_ppi_icb_cmd_lock;
		int errors_ppi_icb_cmd_excl;
		int errortime_ppi_icb_cmd_excl;
		int errors_ppi_icb_cmd_size;
		int errortime_ppi_icb_cmd_size;
		int errors_ppi_icb_rsp_ready;
		int errortime_ppi_icb_rsp_ready;
		int errors_clint_icb_cmd_valid;
		int errortime_clint_icb_cmd_valid;
		int errors_clint_icb_cmd_addr;
		int errortime_clint_icb_cmd_addr;
		int errors_clint_icb_cmd_read;
		int errortime_clint_icb_cmd_read;
		int errors_clint_icb_cmd_wdata;
		int errortime_clint_icb_cmd_wdata;
		int errors_clint_icb_cmd_wmask;
		int errortime_clint_icb_cmd_wmask;
		int errors_clint_icb_cmd_lock;
		int errortime_clint_icb_cmd_lock;
		int errors_clint_icb_cmd_excl;
		int errortime_clint_icb_cmd_excl;
		int errors_clint_icb_cmd_size;
		int errortime_clint_icb_cmd_size;
		int errors_clint_icb_rsp_ready;
		int errortime_clint_icb_rsp_ready;
		int errors_plic_icb_cmd_valid;
		int errortime_plic_icb_cmd_valid;
		int errors_plic_icb_cmd_addr;
		int errortime_plic_icb_cmd_addr;
		int errors_plic_icb_cmd_read;
		int errortime_plic_icb_cmd_read;
		int errors_plic_icb_cmd_wdata;
		int errortime_plic_icb_cmd_wdata;
		int errors_plic_icb_cmd_wmask;
		int errortime_plic_icb_cmd_wmask;
		int errors_plic_icb_cmd_lock;
		int errortime_plic_icb_cmd_lock;
		int errors_plic_icb_cmd_excl;
		int errortime_plic_icb_cmd_excl;
		int errors_plic_icb_cmd_size;
		int errortime_plic_icb_cmd_size;
		int errors_plic_icb_rsp_ready;
		int errortime_plic_icb_rsp_ready;
		int errors_fio_icb_cmd_valid;
		int errortime_fio_icb_cmd_valid;
		int errors_fio_icb_cmd_addr;
		int errortime_fio_icb_cmd_addr;
		int errors_fio_icb_cmd_read;
		int errortime_fio_icb_cmd_read;
		int errors_fio_icb_cmd_wdata;
		int errortime_fio_icb_cmd_wdata;
		int errors_fio_icb_cmd_wmask;
		int errortime_fio_icb_cmd_wmask;
		int errors_fio_icb_cmd_lock;
		int errortime_fio_icb_cmd_lock;
		int errors_fio_icb_cmd_excl;
		int errortime_fio_icb_cmd_excl;
		int errors_fio_icb_cmd_size;
		int errortime_fio_icb_cmd_size;
		int errors_fio_icb_rsp_ready;
		int errortime_fio_icb_rsp_ready;
		int errors_mem_icb_cmd_valid;
		int errortime_mem_icb_cmd_valid;
		int errors_mem_icb_cmd_addr;
		int errortime_mem_icb_cmd_addr;
		int errors_mem_icb_cmd_read;
		int errortime_mem_icb_cmd_read;
		int errors_mem_icb_cmd_wdata;
		int errortime_mem_icb_cmd_wdata;
		int errors_mem_icb_cmd_wmask;
		int errortime_mem_icb_cmd_wmask;
		int errors_mem_icb_cmd_lock;
		int errortime_mem_icb_cmd_lock;
		int errors_mem_icb_cmd_excl;
		int errortime_mem_icb_cmd_excl;
		int errors_mem_icb_cmd_size;
		int errortime_mem_icb_cmd_size;
		int errors_mem_icb_cmd_burst;
		int errortime_mem_icb_cmd_burst;
		int errors_mem_icb_cmd_beat;
		int errortime_mem_icb_cmd_beat;
		int errors_mem_icb_rsp_ready;
		int errortime_mem_icb_rsp_ready;
		int errors_lsu2itcm_icb_cmd_valid;
		int errortime_lsu2itcm_icb_cmd_valid;
		int errors_lsu2itcm_icb_cmd_addr;
		int errortime_lsu2itcm_icb_cmd_addr;
		int errors_lsu2itcm_icb_cmd_read;
		int errortime_lsu2itcm_icb_cmd_read;
		int errors_lsu2itcm_icb_cmd_wdata;
		int errortime_lsu2itcm_icb_cmd_wdata;
		int errors_lsu2itcm_icb_cmd_wmask;
		int errortime_lsu2itcm_icb_cmd_wmask;
		int errors_lsu2itcm_icb_cmd_lock;
		int errortime_lsu2itcm_icb_cmd_lock;
		int errors_lsu2itcm_icb_cmd_excl;
		int errortime_lsu2itcm_icb_cmd_excl;
		int errors_lsu2itcm_icb_cmd_size;
		int errortime_lsu2itcm_icb_cmd_size;
		int errors_lsu2itcm_icb_rsp_ready;
		int errortime_lsu2itcm_icb_rsp_ready;
		int errors_lsu2dtcm_icb_cmd_valid;
		int errortime_lsu2dtcm_icb_cmd_valid;
		int errors_lsu2dtcm_icb_cmd_addr;
		int errortime_lsu2dtcm_icb_cmd_addr;
		int errors_lsu2dtcm_icb_cmd_read;
		int errortime_lsu2dtcm_icb_cmd_read;
		int errors_lsu2dtcm_icb_cmd_wdata;
		int errortime_lsu2dtcm_icb_cmd_wdata;
		int errors_lsu2dtcm_icb_cmd_wmask;
		int errortime_lsu2dtcm_icb_cmd_wmask;
		int errors_lsu2dtcm_icb_cmd_lock;
		int errortime_lsu2dtcm_icb_cmd_lock;
		int errors_lsu2dtcm_icb_cmd_excl;
		int errortime_lsu2dtcm_icb_cmd_excl;
		int errors_lsu2dtcm_icb_cmd_size;
		int errortime_lsu2dtcm_icb_cmd_size;
		int errors_lsu2dtcm_icb_rsp_ready;
		int errortime_lsu2dtcm_icb_rsp_ready;
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
		int errors_nice_icb_cmd_ready;
		int errortime_nice_icb_cmd_ready;
		int errors_nice_icb_rsp_valid;
		int errortime_nice_icb_rsp_valid;
		int errors_nice_icb_rsp_rdata;
		int errortime_nice_icb_rsp_rdata;
		int errors_nice_icb_rsp_err;
		int errortime_nice_icb_rsp_err;
		int errors_exu_active;
		int errortime_exu_active;
		int errors_ifu_active;
		int errortime_ifu_active;
		int errors_lsu_active;
		int errortime_lsu_active;
		int errors_biu_active;
		int errortime_biu_active;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [32-1:0] inspect_pc_ref;
	logic [32-1:0] inspect_pc_dut;
	logic core_wfi_ref;
	logic core_wfi_dut;
	logic tm_stop_ref;
	logic tm_stop_dut;
	logic core_cgstop_ref;
	logic core_cgstop_dut;
	logic tcm_cgstop_ref;
	logic tcm_cgstop_dut;
	logic [32-1:0] pc_rtvec;
	logic core_mhartid;
	logic dbg_irq_r;
	logic lcl_irq_r;
	logic evt_r;
	logic ext_irq_r;
	logic sft_irq_r;
	logic tmr_irq_r;
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
	logic [32-1:0] cmt_dpc_ref;
	logic [32-1:0] cmt_dpc_dut;
	logic cmt_dpc_ena_ref;
	logic cmt_dpc_ena_dut;
	logic [3-1:0] cmt_dcause_ref;
	logic [3-1:0] cmt_dcause_dut;
	logic cmt_dcause_ena_ref;
	logic cmt_dcause_ena_dut;
	logic dbg_mode;
	logic dbg_halt_r;
	logic dbg_step_r;
	logic dbg_ebreakm_r;
	logic dbg_stopcycle;
	logic [32-1:0] itcm_region_indic;
	logic ifu2itcm_holdup;
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
	logic [32-1:0] ppi_region_indic;
	logic ppi_icb_enable;
	logic ppi_icb_cmd_valid_ref;
	logic ppi_icb_cmd_valid_dut;
	logic ppi_icb_cmd_ready;
	logic [32-1:0] ppi_icb_cmd_addr_ref;
	logic [32-1:0] ppi_icb_cmd_addr_dut;
	logic ppi_icb_cmd_read_ref;
	logic ppi_icb_cmd_read_dut;
	logic [32-1:0] ppi_icb_cmd_wdata_ref;
	logic [32-1:0] ppi_icb_cmd_wdata_dut;
	logic [4-1:0] ppi_icb_cmd_wmask_ref;
	logic [4-1:0] ppi_icb_cmd_wmask_dut;
	logic ppi_icb_cmd_lock_ref;
	logic ppi_icb_cmd_lock_dut;
	logic ppi_icb_cmd_excl_ref;
	logic ppi_icb_cmd_excl_dut;
	logic [2-1:0] ppi_icb_cmd_size_ref;
	logic [2-1:0] ppi_icb_cmd_size_dut;
	logic ppi_icb_rsp_valid;
	logic ppi_icb_rsp_ready_ref;
	logic ppi_icb_rsp_ready_dut;
	logic ppi_icb_rsp_err;
	logic ppi_icb_rsp_excl_ok;
	logic [32-1:0] ppi_icb_rsp_rdata;
	logic [32-1:0] clint_region_indic;
	logic clint_icb_enable;
	logic clint_icb_cmd_valid_ref;
	logic clint_icb_cmd_valid_dut;
	logic clint_icb_cmd_ready;
	logic [32-1:0] clint_icb_cmd_addr_ref;
	logic [32-1:0] clint_icb_cmd_addr_dut;
	logic clint_icb_cmd_read_ref;
	logic clint_icb_cmd_read_dut;
	logic [32-1:0] clint_icb_cmd_wdata_ref;
	logic [32-1:0] clint_icb_cmd_wdata_dut;
	logic [4-1:0] clint_icb_cmd_wmask_ref;
	logic [4-1:0] clint_icb_cmd_wmask_dut;
	logic clint_icb_cmd_lock_ref;
	logic clint_icb_cmd_lock_dut;
	logic clint_icb_cmd_excl_ref;
	logic clint_icb_cmd_excl_dut;
	logic [2-1:0] clint_icb_cmd_size_ref;
	logic [2-1:0] clint_icb_cmd_size_dut;
	logic clint_icb_rsp_valid;
	logic clint_icb_rsp_ready_ref;
	logic clint_icb_rsp_ready_dut;
	logic clint_icb_rsp_err;
	logic clint_icb_rsp_excl_ok;
	logic [32-1:0] clint_icb_rsp_rdata;
	logic [32-1:0] plic_region_indic;
	logic plic_icb_enable;
	logic plic_icb_cmd_valid_ref;
	logic plic_icb_cmd_valid_dut;
	logic plic_icb_cmd_ready;
	logic [32-1:0] plic_icb_cmd_addr_ref;
	logic [32-1:0] plic_icb_cmd_addr_dut;
	logic plic_icb_cmd_read_ref;
	logic plic_icb_cmd_read_dut;
	logic [32-1:0] plic_icb_cmd_wdata_ref;
	logic [32-1:0] plic_icb_cmd_wdata_dut;
	logic [4-1:0] plic_icb_cmd_wmask_ref;
	logic [4-1:0] plic_icb_cmd_wmask_dut;
	logic plic_icb_cmd_lock_ref;
	logic plic_icb_cmd_lock_dut;
	logic plic_icb_cmd_excl_ref;
	logic plic_icb_cmd_excl_dut;
	logic [2-1:0] plic_icb_cmd_size_ref;
	logic [2-1:0] plic_icb_cmd_size_dut;
	logic plic_icb_rsp_valid;
	logic plic_icb_rsp_ready_ref;
	logic plic_icb_rsp_ready_dut;
	logic plic_icb_rsp_err;
	logic plic_icb_rsp_excl_ok;
	logic [32-1:0] plic_icb_rsp_rdata;
	logic [32-1:0] fio_region_indic;
	logic fio_icb_enable;
	logic fio_icb_cmd_valid_ref;
	logic fio_icb_cmd_valid_dut;
	logic fio_icb_cmd_ready;
	logic [32-1:0] fio_icb_cmd_addr_ref;
	logic [32-1:0] fio_icb_cmd_addr_dut;
	logic fio_icb_cmd_read_ref;
	logic fio_icb_cmd_read_dut;
	logic [32-1:0] fio_icb_cmd_wdata_ref;
	logic [32-1:0] fio_icb_cmd_wdata_dut;
	logic [4-1:0] fio_icb_cmd_wmask_ref;
	logic [4-1:0] fio_icb_cmd_wmask_dut;
	logic fio_icb_cmd_lock_ref;
	logic fio_icb_cmd_lock_dut;
	logic fio_icb_cmd_excl_ref;
	logic fio_icb_cmd_excl_dut;
	logic [2-1:0] fio_icb_cmd_size_ref;
	logic [2-1:0] fio_icb_cmd_size_dut;
	logic fio_icb_rsp_valid;
	logic fio_icb_rsp_ready_ref;
	logic fio_icb_rsp_ready_dut;
	logic fio_icb_rsp_err;
	logic fio_icb_rsp_excl_ok;
	logic [32-1:0] fio_icb_rsp_rdata;
	logic mem_icb_enable;
	logic mem_icb_cmd_valid_ref;
	logic mem_icb_cmd_valid_dut;
	logic mem_icb_cmd_ready;
	logic [32-1:0] mem_icb_cmd_addr_ref;
	logic [32-1:0] mem_icb_cmd_addr_dut;
	logic mem_icb_cmd_read_ref;
	logic mem_icb_cmd_read_dut;
	logic [32-1:0] mem_icb_cmd_wdata_ref;
	logic [32-1:0] mem_icb_cmd_wdata_dut;
	logic [4-1:0] mem_icb_cmd_wmask_ref;
	logic [4-1:0] mem_icb_cmd_wmask_dut;
	logic mem_icb_cmd_lock_ref;
	logic mem_icb_cmd_lock_dut;
	logic mem_icb_cmd_excl_ref;
	logic mem_icb_cmd_excl_dut;
	logic [2-1:0] mem_icb_cmd_size_ref;
	logic [2-1:0] mem_icb_cmd_size_dut;
	logic [2-1:0] mem_icb_cmd_burst_ref;
	logic [2-1:0] mem_icb_cmd_burst_dut;
	logic [2-1:0] mem_icb_cmd_beat_ref;
	logic [2-1:0] mem_icb_cmd_beat_dut;
	logic mem_icb_rsp_valid;
	logic mem_icb_rsp_ready_ref;
	logic mem_icb_rsp_ready_dut;
	logic mem_icb_rsp_err;
	logic mem_icb_rsp_excl_ok;
	logic [32-1:0] mem_icb_rsp_rdata;
	logic lsu2itcm_icb_cmd_valid_ref;
	logic lsu2itcm_icb_cmd_valid_dut;
	logic lsu2itcm_icb_cmd_ready;
	logic [16-1:0] lsu2itcm_icb_cmd_addr_ref;
	logic [16-1:0] lsu2itcm_icb_cmd_addr_dut;
	logic lsu2itcm_icb_cmd_read_ref;
	logic lsu2itcm_icb_cmd_read_dut;
	logic [32-1:0] lsu2itcm_icb_cmd_wdata_ref;
	logic [32-1:0] lsu2itcm_icb_cmd_wdata_dut;
	logic [4-1:0] lsu2itcm_icb_cmd_wmask_ref;
	logic [4-1:0] lsu2itcm_icb_cmd_wmask_dut;
	logic lsu2itcm_icb_cmd_lock_ref;
	logic lsu2itcm_icb_cmd_lock_dut;
	logic lsu2itcm_icb_cmd_excl_ref;
	logic lsu2itcm_icb_cmd_excl_dut;
	logic [2-1:0] lsu2itcm_icb_cmd_size_ref;
	logic [2-1:0] lsu2itcm_icb_cmd_size_dut;
	logic lsu2itcm_icb_rsp_valid;
	logic lsu2itcm_icb_rsp_ready_ref;
	logic lsu2itcm_icb_rsp_ready_dut;
	logic lsu2itcm_icb_rsp_err;
	logic lsu2itcm_icb_rsp_excl_ok;
	logic [32-1:0] lsu2itcm_icb_rsp_rdata;
	logic [32-1:0] dtcm_region_indic;
	logic lsu2dtcm_icb_cmd_valid_ref;
	logic lsu2dtcm_icb_cmd_valid_dut;
	logic lsu2dtcm_icb_cmd_ready;
	logic [16-1:0] lsu2dtcm_icb_cmd_addr_ref;
	logic [16-1:0] lsu2dtcm_icb_cmd_addr_dut;
	logic lsu2dtcm_icb_cmd_read_ref;
	logic lsu2dtcm_icb_cmd_read_dut;
	logic [32-1:0] lsu2dtcm_icb_cmd_wdata_ref;
	logic [32-1:0] lsu2dtcm_icb_cmd_wdata_dut;
	logic [4-1:0] lsu2dtcm_icb_cmd_wmask_ref;
	logic [4-1:0] lsu2dtcm_icb_cmd_wmask_dut;
	logic lsu2dtcm_icb_cmd_lock_ref;
	logic lsu2dtcm_icb_cmd_lock_dut;
	logic lsu2dtcm_icb_cmd_excl_ref;
	logic lsu2dtcm_icb_cmd_excl_dut;
	logic [2-1:0] lsu2dtcm_icb_cmd_size_ref;
	logic [2-1:0] lsu2dtcm_icb_cmd_size_dut;
	logic lsu2dtcm_icb_rsp_valid;
	logic lsu2dtcm_icb_rsp_ready_ref;
	logic lsu2dtcm_icb_rsp_ready_dut;
	logic lsu2dtcm_icb_rsp_err;
	logic lsu2dtcm_icb_rsp_excl_ok;
	logic [32-1:0] lsu2dtcm_icb_rsp_rdata;
	logic nice_mem_holdup;
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
	logic nice_icb_cmd_valid;
	logic nice_icb_cmd_ready_ref;
	logic nice_icb_cmd_ready_dut;
	logic [32-1:0] nice_icb_cmd_addr;
	logic nice_icb_cmd_read;
	logic [32-1:0] nice_icb_cmd_wdata;
	logic [2-1:0] nice_icb_cmd_size;
	logic nice_icb_rsp_valid_ref;
	logic nice_icb_rsp_valid_dut;
	logic nice_icb_rsp_ready;
	logic [32-1:0] nice_icb_rsp_rdata_ref;
	logic [32-1:0] nice_icb_rsp_rdata_dut;
	logic nice_icb_rsp_err_ref;
	logic nice_icb_rsp_err_dut;
	logic exu_active_ref;
	logic exu_active_dut;
	logic ifu_active_ref;
	logic ifu_active_dut;
	logic lsu_active_ref;
	logic lsu_active_dut;
	logic biu_active_ref;
	logic biu_active_dut;
	logic clk_core_ifu;
	logic clk_core_exu;
	logic clk_core_lsu;
	logic clk_core_biu;
	logic clk_aon;
	logic test_mode;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.pc_rtvec(pc_rtvec),
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
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ppi_region_indic(ppi_region_indic),
		.ppi_icb_enable(ppi_icb_enable),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_excl_ok(ppi_icb_rsp_excl_ok),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_region_indic(clint_region_indic),
		.clint_icb_enable(clint_icb_enable),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_excl_ok(clint_icb_rsp_excl_ok),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_region_indic(plic_region_indic),
		.plic_icb_enable(plic_icb_enable),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_excl_ok(plic_icb_rsp_excl_ok),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_region_indic(fio_region_indic),
		.fio_icb_enable(fio_icb_enable),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_excl_ok(fio_icb_rsp_excl_ok),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_enable(mem_icb_enable),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.lsu2itcm_icb_cmd_ready(lsu2itcm_icb_cmd_ready),
		.lsu2itcm_icb_rsp_valid(lsu2itcm_icb_rsp_valid),
		.lsu2itcm_icb_rsp_err(lsu2itcm_icb_rsp_err),
		.lsu2itcm_icb_rsp_excl_ok(lsu2itcm_icb_rsp_excl_ok),
		.lsu2itcm_icb_rsp_rdata(lsu2itcm_icb_rsp_rdata),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu2dtcm_icb_cmd_ready(lsu2dtcm_icb_cmd_ready),
		.lsu2dtcm_icb_rsp_valid(lsu2dtcm_icb_rsp_valid),
		.lsu2dtcm_icb_rsp_err(lsu2dtcm_icb_rsp_err),
		.lsu2dtcm_icb_rsp_excl_ok(lsu2dtcm_icb_rsp_excl_ok),
		.lsu2dtcm_icb_rsp_rdata(lsu2dtcm_icb_rsp_rdata),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_req_ready(nice_req_ready),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.clk_core_ifu(clk_core_ifu),
		.clk_core_exu(clk_core_exu),
		.clk_core_lsu(clk_core_lsu),
		.clk_core_biu(clk_core_biu),
		.clk_aon(clk_aon),
		.test_mode(test_mode),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
		.clk(clk),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_core good1 (
		.inspect_pc(inspect_pc_ref),
		.core_wfi(core_wfi_ref),
		.tm_stop(tm_stop_ref),
		.core_cgstop(core_cgstop_ref),
		.tcm_cgstop(tcm_cgstop_ref),
		.pc_rtvec(pc_rtvec),
		.core_mhartid(core_mhartid),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.evt_r(evt_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.wr_dcsr_ena(wr_dcsr_ena_ref),
		.wr_dpc_ena(wr_dpc_ena_ref),
		.wr_dscratch_ena(wr_dscratch_ena_ref),
		.wr_csr_nxt(wr_csr_nxt_ref),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.cmt_dpc(cmt_dpc_ref),
		.cmt_dpc_ena(cmt_dpc_ena_ref),
		.cmt_dcause(cmt_dcause_ref),
		.cmt_dcause_ena(cmt_dcause_ena_ref),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid_ref),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr_ref),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready_ref),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ppi_region_indic(ppi_region_indic),
		.ppi_icb_enable(ppi_icb_enable),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_ref),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_ref),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_ref),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_ref),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_ref),
		.ppi_icb_cmd_lock(ppi_icb_cmd_lock_ref),
		.ppi_icb_cmd_excl(ppi_icb_cmd_excl_ref),
		.ppi_icb_cmd_size(ppi_icb_cmd_size_ref),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_ready(ppi_icb_rsp_ready_ref),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_excl_ok(ppi_icb_rsp_excl_ok),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_region_indic(clint_region_indic),
		.clint_icb_enable(clint_icb_enable),
		.clint_icb_cmd_valid(clint_icb_cmd_valid_ref),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_cmd_addr(clint_icb_cmd_addr_ref),
		.clint_icb_cmd_read(clint_icb_cmd_read_ref),
		.clint_icb_cmd_wdata(clint_icb_cmd_wdata_ref),
		.clint_icb_cmd_wmask(clint_icb_cmd_wmask_ref),
		.clint_icb_cmd_lock(clint_icb_cmd_lock_ref),
		.clint_icb_cmd_excl(clint_icb_cmd_excl_ref),
		.clint_icb_cmd_size(clint_icb_cmd_size_ref),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_ready(clint_icb_rsp_ready_ref),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_excl_ok(clint_icb_rsp_excl_ok),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_region_indic(plic_region_indic),
		.plic_icb_enable(plic_icb_enable),
		.plic_icb_cmd_valid(plic_icb_cmd_valid_ref),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_cmd_addr(plic_icb_cmd_addr_ref),
		.plic_icb_cmd_read(plic_icb_cmd_read_ref),
		.plic_icb_cmd_wdata(plic_icb_cmd_wdata_ref),
		.plic_icb_cmd_wmask(plic_icb_cmd_wmask_ref),
		.plic_icb_cmd_lock(plic_icb_cmd_lock_ref),
		.plic_icb_cmd_excl(plic_icb_cmd_excl_ref),
		.plic_icb_cmd_size(plic_icb_cmd_size_ref),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_ready(plic_icb_rsp_ready_ref),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_excl_ok(plic_icb_rsp_excl_ok),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_region_indic(fio_region_indic),
		.fio_icb_enable(fio_icb_enable),
		.fio_icb_cmd_valid(fio_icb_cmd_valid_ref),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_cmd_addr(fio_icb_cmd_addr_ref),
		.fio_icb_cmd_read(fio_icb_cmd_read_ref),
		.fio_icb_cmd_wdata(fio_icb_cmd_wdata_ref),
		.fio_icb_cmd_wmask(fio_icb_cmd_wmask_ref),
		.fio_icb_cmd_lock(fio_icb_cmd_lock_ref),
		.fio_icb_cmd_excl(fio_icb_cmd_excl_ref),
		.fio_icb_cmd_size(fio_icb_cmd_size_ref),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_ready(fio_icb_rsp_ready_ref),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_excl_ok(fio_icb_rsp_excl_ok),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_enable(mem_icb_enable),
		.mem_icb_cmd_valid(mem_icb_cmd_valid_ref),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_cmd_addr(mem_icb_cmd_addr_ref),
		.mem_icb_cmd_read(mem_icb_cmd_read_ref),
		.mem_icb_cmd_wdata(mem_icb_cmd_wdata_ref),
		.mem_icb_cmd_wmask(mem_icb_cmd_wmask_ref),
		.mem_icb_cmd_lock(mem_icb_cmd_lock_ref),
		.mem_icb_cmd_excl(mem_icb_cmd_excl_ref),
		.mem_icb_cmd_size(mem_icb_cmd_size_ref),
		.mem_icb_cmd_burst(mem_icb_cmd_burst_ref),
		.mem_icb_cmd_beat(mem_icb_cmd_beat_ref),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_ref),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.lsu2itcm_icb_cmd_valid(lsu2itcm_icb_cmd_valid_ref),
		.lsu2itcm_icb_cmd_ready(lsu2itcm_icb_cmd_ready),
		.lsu2itcm_icb_cmd_addr(lsu2itcm_icb_cmd_addr_ref),
		.lsu2itcm_icb_cmd_read(lsu2itcm_icb_cmd_read_ref),
		.lsu2itcm_icb_cmd_wdata(lsu2itcm_icb_cmd_wdata_ref),
		.lsu2itcm_icb_cmd_wmask(lsu2itcm_icb_cmd_wmask_ref),
		.lsu2itcm_icb_cmd_lock(lsu2itcm_icb_cmd_lock_ref),
		.lsu2itcm_icb_cmd_excl(lsu2itcm_icb_cmd_excl_ref),
		.lsu2itcm_icb_cmd_size(lsu2itcm_icb_cmd_size_ref),
		.lsu2itcm_icb_rsp_valid(lsu2itcm_icb_rsp_valid),
		.lsu2itcm_icb_rsp_ready(lsu2itcm_icb_rsp_ready_ref),
		.lsu2itcm_icb_rsp_err(lsu2itcm_icb_rsp_err),
		.lsu2itcm_icb_rsp_excl_ok(lsu2itcm_icb_rsp_excl_ok),
		.lsu2itcm_icb_rsp_rdata(lsu2itcm_icb_rsp_rdata),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu2dtcm_icb_cmd_valid(lsu2dtcm_icb_cmd_valid_ref),
		.lsu2dtcm_icb_cmd_ready(lsu2dtcm_icb_cmd_ready),
		.lsu2dtcm_icb_cmd_addr(lsu2dtcm_icb_cmd_addr_ref),
		.lsu2dtcm_icb_cmd_read(lsu2dtcm_icb_cmd_read_ref),
		.lsu2dtcm_icb_cmd_wdata(lsu2dtcm_icb_cmd_wdata_ref),
		.lsu2dtcm_icb_cmd_wmask(lsu2dtcm_icb_cmd_wmask_ref),
		.lsu2dtcm_icb_cmd_lock(lsu2dtcm_icb_cmd_lock_ref),
		.lsu2dtcm_icb_cmd_excl(lsu2dtcm_icb_cmd_excl_ref),
		.lsu2dtcm_icb_cmd_size(lsu2dtcm_icb_cmd_size_ref),
		.lsu2dtcm_icb_rsp_valid(lsu2dtcm_icb_rsp_valid),
		.lsu2dtcm_icb_rsp_ready(lsu2dtcm_icb_rsp_ready_ref),
		.lsu2dtcm_icb_rsp_err(lsu2dtcm_icb_rsp_err),
		.lsu2dtcm_icb_rsp_excl_ok(lsu2dtcm_icb_rsp_excl_ok),
		.lsu2dtcm_icb_rsp_rdata(lsu2dtcm_icb_rsp_rdata),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_req_valid(nice_req_valid_ref),
		.nice_req_ready(nice_req_ready),
		.nice_req_inst(nice_req_inst_ref),
		.nice_req_rs1(nice_req_rs1_ref),
		.nice_req_rs2(nice_req_rs2_ref),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_ref),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_ready(nice_icb_cmd_ready_ref),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_valid(nice_icb_rsp_valid_ref),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.nice_icb_rsp_rdata(nice_icb_rsp_rdata_ref),
		.nice_icb_rsp_err(nice_icb_rsp_err_ref),
		.exu_active(exu_active_ref),
		.ifu_active(ifu_active_ref),
		.lsu_active(lsu_active_ref),
		.biu_active(biu_active_ref),
		.clk_core_ifu(clk_core_ifu),
		.clk_core_exu(clk_core_exu),
		.clk_core_lsu(clk_core_lsu),
		.clk_core_biu(clk_core_biu),
		.clk_aon(clk_aon),
		.test_mode(test_mode),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_core top_module1 (
		.inspect_pc(inspect_pc_dut),
		.core_wfi(core_wfi_dut),
		.tm_stop(tm_stop_dut),
		.core_cgstop(core_cgstop_dut),
		.tcm_cgstop(tcm_cgstop_dut),
		.pc_rtvec(pc_rtvec),
		.core_mhartid(core_mhartid),
		.dbg_irq_r(dbg_irq_r),
		.lcl_irq_r(lcl_irq_r),
		.evt_r(evt_r),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.wr_dcsr_ena(wr_dcsr_ena_dut),
		.wr_dpc_ena(wr_dpc_ena_dut),
		.wr_dscratch_ena(wr_dscratch_ena_dut),
		.wr_csr_nxt(wr_csr_nxt_dut),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.cmt_dpc(cmt_dpc_dut),
		.cmt_dpc_ena(cmt_dpc_ena_dut),
		.cmt_dcause(cmt_dcause_dut),
		.cmt_dcause_ena(cmt_dcause_ena_dut),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.itcm_region_indic(itcm_region_indic),
		.ifu2itcm_holdup(ifu2itcm_holdup),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid_dut),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr_dut),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready_dut),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata),
		.ppi_region_indic(ppi_region_indic),
		.ppi_icb_enable(ppi_icb_enable),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_dut),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_dut),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_dut),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_dut),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_dut),
		.ppi_icb_cmd_lock(ppi_icb_cmd_lock_dut),
		.ppi_icb_cmd_excl(ppi_icb_cmd_excl_dut),
		.ppi_icb_cmd_size(ppi_icb_cmd_size_dut),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_ready(ppi_icb_rsp_ready_dut),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_excl_ok(ppi_icb_rsp_excl_ok),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_region_indic(clint_region_indic),
		.clint_icb_enable(clint_icb_enable),
		.clint_icb_cmd_valid(clint_icb_cmd_valid_dut),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_cmd_addr(clint_icb_cmd_addr_dut),
		.clint_icb_cmd_read(clint_icb_cmd_read_dut),
		.clint_icb_cmd_wdata(clint_icb_cmd_wdata_dut),
		.clint_icb_cmd_wmask(clint_icb_cmd_wmask_dut),
		.clint_icb_cmd_lock(clint_icb_cmd_lock_dut),
		.clint_icb_cmd_excl(clint_icb_cmd_excl_dut),
		.clint_icb_cmd_size(clint_icb_cmd_size_dut),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_ready(clint_icb_rsp_ready_dut),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_excl_ok(clint_icb_rsp_excl_ok),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_region_indic(plic_region_indic),
		.plic_icb_enable(plic_icb_enable),
		.plic_icb_cmd_valid(plic_icb_cmd_valid_dut),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_cmd_addr(plic_icb_cmd_addr_dut),
		.plic_icb_cmd_read(plic_icb_cmd_read_dut),
		.plic_icb_cmd_wdata(plic_icb_cmd_wdata_dut),
		.plic_icb_cmd_wmask(plic_icb_cmd_wmask_dut),
		.plic_icb_cmd_lock(plic_icb_cmd_lock_dut),
		.plic_icb_cmd_excl(plic_icb_cmd_excl_dut),
		.plic_icb_cmd_size(plic_icb_cmd_size_dut),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_ready(plic_icb_rsp_ready_dut),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_excl_ok(plic_icb_rsp_excl_ok),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_region_indic(fio_region_indic),
		.fio_icb_enable(fio_icb_enable),
		.fio_icb_cmd_valid(fio_icb_cmd_valid_dut),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_cmd_addr(fio_icb_cmd_addr_dut),
		.fio_icb_cmd_read(fio_icb_cmd_read_dut),
		.fio_icb_cmd_wdata(fio_icb_cmd_wdata_dut),
		.fio_icb_cmd_wmask(fio_icb_cmd_wmask_dut),
		.fio_icb_cmd_lock(fio_icb_cmd_lock_dut),
		.fio_icb_cmd_excl(fio_icb_cmd_excl_dut),
		.fio_icb_cmd_size(fio_icb_cmd_size_dut),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_ready(fio_icb_rsp_ready_dut),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_excl_ok(fio_icb_rsp_excl_ok),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_enable(mem_icb_enable),
		.mem_icb_cmd_valid(mem_icb_cmd_valid_dut),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_cmd_addr(mem_icb_cmd_addr_dut),
		.mem_icb_cmd_read(mem_icb_cmd_read_dut),
		.mem_icb_cmd_wdata(mem_icb_cmd_wdata_dut),
		.mem_icb_cmd_wmask(mem_icb_cmd_wmask_dut),
		.mem_icb_cmd_lock(mem_icb_cmd_lock_dut),
		.mem_icb_cmd_excl(mem_icb_cmd_excl_dut),
		.mem_icb_cmd_size(mem_icb_cmd_size_dut),
		.mem_icb_cmd_burst(mem_icb_cmd_burst_dut),
		.mem_icb_cmd_beat(mem_icb_cmd_beat_dut),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_dut),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.lsu2itcm_icb_cmd_valid(lsu2itcm_icb_cmd_valid_dut),
		.lsu2itcm_icb_cmd_ready(lsu2itcm_icb_cmd_ready),
		.lsu2itcm_icb_cmd_addr(lsu2itcm_icb_cmd_addr_dut),
		.lsu2itcm_icb_cmd_read(lsu2itcm_icb_cmd_read_dut),
		.lsu2itcm_icb_cmd_wdata(lsu2itcm_icb_cmd_wdata_dut),
		.lsu2itcm_icb_cmd_wmask(lsu2itcm_icb_cmd_wmask_dut),
		.lsu2itcm_icb_cmd_lock(lsu2itcm_icb_cmd_lock_dut),
		.lsu2itcm_icb_cmd_excl(lsu2itcm_icb_cmd_excl_dut),
		.lsu2itcm_icb_cmd_size(lsu2itcm_icb_cmd_size_dut),
		.lsu2itcm_icb_rsp_valid(lsu2itcm_icb_rsp_valid),
		.lsu2itcm_icb_rsp_ready(lsu2itcm_icb_rsp_ready_dut),
		.lsu2itcm_icb_rsp_err(lsu2itcm_icb_rsp_err),
		.lsu2itcm_icb_rsp_excl_ok(lsu2itcm_icb_rsp_excl_ok),
		.lsu2itcm_icb_rsp_rdata(lsu2itcm_icb_rsp_rdata),
		.dtcm_region_indic(dtcm_region_indic),
		.lsu2dtcm_icb_cmd_valid(lsu2dtcm_icb_cmd_valid_dut),
		.lsu2dtcm_icb_cmd_ready(lsu2dtcm_icb_cmd_ready),
		.lsu2dtcm_icb_cmd_addr(lsu2dtcm_icb_cmd_addr_dut),
		.lsu2dtcm_icb_cmd_read(lsu2dtcm_icb_cmd_read_dut),
		.lsu2dtcm_icb_cmd_wdata(lsu2dtcm_icb_cmd_wdata_dut),
		.lsu2dtcm_icb_cmd_wmask(lsu2dtcm_icb_cmd_wmask_dut),
		.lsu2dtcm_icb_cmd_lock(lsu2dtcm_icb_cmd_lock_dut),
		.lsu2dtcm_icb_cmd_excl(lsu2dtcm_icb_cmd_excl_dut),
		.lsu2dtcm_icb_cmd_size(lsu2dtcm_icb_cmd_size_dut),
		.lsu2dtcm_icb_rsp_valid(lsu2dtcm_icb_rsp_valid),
		.lsu2dtcm_icb_rsp_ready(lsu2dtcm_icb_rsp_ready_dut),
		.lsu2dtcm_icb_rsp_err(lsu2dtcm_icb_rsp_err),
		.lsu2dtcm_icb_rsp_excl_ok(lsu2dtcm_icb_rsp_excl_ok),
		.lsu2dtcm_icb_rsp_rdata(lsu2dtcm_icb_rsp_rdata),
		.nice_mem_holdup(nice_mem_holdup),
		.nice_req_valid(nice_req_valid_dut),
		.nice_req_ready(nice_req_ready),
		.nice_req_inst(nice_req_inst_dut),
		.nice_req_rs1(nice_req_rs1_dut),
		.nice_req_rs2(nice_req_rs2_dut),
		.nice_rsp_multicyc_valid(nice_rsp_multicyc_valid),
		.nice_rsp_multicyc_ready(nice_rsp_multicyc_ready_dut),
		.nice_rsp_multicyc_dat(nice_rsp_multicyc_dat),
		.nice_rsp_multicyc_err(nice_rsp_multicyc_err),
		.nice_icb_cmd_valid(nice_icb_cmd_valid),
		.nice_icb_cmd_ready(nice_icb_cmd_ready_dut),
		.nice_icb_cmd_addr(nice_icb_cmd_addr),
		.nice_icb_cmd_read(nice_icb_cmd_read),
		.nice_icb_cmd_wdata(nice_icb_cmd_wdata),
		.nice_icb_cmd_size(nice_icb_cmd_size),
		.nice_icb_rsp_valid(nice_icb_rsp_valid_dut),
		.nice_icb_rsp_ready(nice_icb_rsp_ready),
		.nice_icb_rsp_rdata(nice_icb_rsp_rdata_dut),
		.nice_icb_rsp_err(nice_icb_rsp_err_dut),
		.exu_active(exu_active_dut),
		.ifu_active(ifu_active_dut),
		.lsu_active(lsu_active_dut),
		.biu_active(biu_active_dut),
		.clk_core_ifu(clk_core_ifu),
		.clk_core_exu(clk_core_exu),
		.clk_core_lsu(clk_core_lsu),
		.clk_core_biu(clk_core_biu),
		.clk_aon(clk_aon),
		.test_mode(test_mode),
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
		if (stats1.errors_ppi_icb_cmd_valid)
			$display("Hint: Output 'ppi_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_valid, stats1.errortime_ppi_icb_cmd_valid);
		else
			$display("Hint: Output 'ppi_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_addr)
			$display("Hint: Output 'ppi_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_addr, stats1.errortime_ppi_icb_cmd_addr);
		else
			$display("Hint: Output 'ppi_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_read)
			$display("Hint: Output 'ppi_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_read, stats1.errortime_ppi_icb_cmd_read);
		else
			$display("Hint: Output 'ppi_icb_cmd_read' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_wdata)
			$display("Hint: Output 'ppi_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_wdata, stats1.errortime_ppi_icb_cmd_wdata);
		else
			$display("Hint: Output 'ppi_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_wmask)
			$display("Hint: Output 'ppi_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_wmask, stats1.errortime_ppi_icb_cmd_wmask);
		else
			$display("Hint: Output 'ppi_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_lock)
			$display("Hint: Output 'ppi_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_lock, stats1.errortime_ppi_icb_cmd_lock);
		else
			$display("Hint: Output 'ppi_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_excl)
			$display("Hint: Output 'ppi_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_excl, stats1.errortime_ppi_icb_cmd_excl);
		else
			$display("Hint: Output 'ppi_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_size)
			$display("Hint: Output 'ppi_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_size, stats1.errortime_ppi_icb_cmd_size);
		else
			$display("Hint: Output 'ppi_icb_cmd_size' has no mismatches.");
		if (stats1.errors_ppi_icb_rsp_ready)
			$display("Hint: Output 'ppi_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_rsp_ready, stats1.errortime_ppi_icb_rsp_ready);
		else
			$display("Hint: Output 'ppi_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_valid)
			$display("Hint: Output 'clint_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_valid, stats1.errortime_clint_icb_cmd_valid);
		else
			$display("Hint: Output 'clint_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_addr)
			$display("Hint: Output 'clint_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_addr, stats1.errortime_clint_icb_cmd_addr);
		else
			$display("Hint: Output 'clint_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_read)
			$display("Hint: Output 'clint_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_read, stats1.errortime_clint_icb_cmd_read);
		else
			$display("Hint: Output 'clint_icb_cmd_read' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_wdata)
			$display("Hint: Output 'clint_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_wdata, stats1.errortime_clint_icb_cmd_wdata);
		else
			$display("Hint: Output 'clint_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_wmask)
			$display("Hint: Output 'clint_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_wmask, stats1.errortime_clint_icb_cmd_wmask);
		else
			$display("Hint: Output 'clint_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_lock)
			$display("Hint: Output 'clint_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_lock, stats1.errortime_clint_icb_cmd_lock);
		else
			$display("Hint: Output 'clint_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_excl)
			$display("Hint: Output 'clint_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_excl, stats1.errortime_clint_icb_cmd_excl);
		else
			$display("Hint: Output 'clint_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_size)
			$display("Hint: Output 'clint_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_size, stats1.errortime_clint_icb_cmd_size);
		else
			$display("Hint: Output 'clint_icb_cmd_size' has no mismatches.");
		if (stats1.errors_clint_icb_rsp_ready)
			$display("Hint: Output 'clint_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_rsp_ready, stats1.errortime_clint_icb_rsp_ready);
		else
			$display("Hint: Output 'clint_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_valid)
			$display("Hint: Output 'plic_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_valid, stats1.errortime_plic_icb_cmd_valid);
		else
			$display("Hint: Output 'plic_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_addr)
			$display("Hint: Output 'plic_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_addr, stats1.errortime_plic_icb_cmd_addr);
		else
			$display("Hint: Output 'plic_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_read)
			$display("Hint: Output 'plic_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_read, stats1.errortime_plic_icb_cmd_read);
		else
			$display("Hint: Output 'plic_icb_cmd_read' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_wdata)
			$display("Hint: Output 'plic_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_wdata, stats1.errortime_plic_icb_cmd_wdata);
		else
			$display("Hint: Output 'plic_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_wmask)
			$display("Hint: Output 'plic_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_wmask, stats1.errortime_plic_icb_cmd_wmask);
		else
			$display("Hint: Output 'plic_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_lock)
			$display("Hint: Output 'plic_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_lock, stats1.errortime_plic_icb_cmd_lock);
		else
			$display("Hint: Output 'plic_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_excl)
			$display("Hint: Output 'plic_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_excl, stats1.errortime_plic_icb_cmd_excl);
		else
			$display("Hint: Output 'plic_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_size)
			$display("Hint: Output 'plic_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_size, stats1.errortime_plic_icb_cmd_size);
		else
			$display("Hint: Output 'plic_icb_cmd_size' has no mismatches.");
		if (stats1.errors_plic_icb_rsp_ready)
			$display("Hint: Output 'plic_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_rsp_ready, stats1.errortime_plic_icb_rsp_ready);
		else
			$display("Hint: Output 'plic_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_valid)
			$display("Hint: Output 'fio_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_valid, stats1.errortime_fio_icb_cmd_valid);
		else
			$display("Hint: Output 'fio_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_addr)
			$display("Hint: Output 'fio_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_addr, stats1.errortime_fio_icb_cmd_addr);
		else
			$display("Hint: Output 'fio_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_read)
			$display("Hint: Output 'fio_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_read, stats1.errortime_fio_icb_cmd_read);
		else
			$display("Hint: Output 'fio_icb_cmd_read' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_wdata)
			$display("Hint: Output 'fio_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_wdata, stats1.errortime_fio_icb_cmd_wdata);
		else
			$display("Hint: Output 'fio_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_wmask)
			$display("Hint: Output 'fio_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_wmask, stats1.errortime_fio_icb_cmd_wmask);
		else
			$display("Hint: Output 'fio_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_lock)
			$display("Hint: Output 'fio_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_lock, stats1.errortime_fio_icb_cmd_lock);
		else
			$display("Hint: Output 'fio_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_excl)
			$display("Hint: Output 'fio_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_excl, stats1.errortime_fio_icb_cmd_excl);
		else
			$display("Hint: Output 'fio_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_size)
			$display("Hint: Output 'fio_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_size, stats1.errortime_fio_icb_cmd_size);
		else
			$display("Hint: Output 'fio_icb_cmd_size' has no mismatches.");
		if (stats1.errors_fio_icb_rsp_ready)
			$display("Hint: Output 'fio_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_rsp_ready, stats1.errortime_fio_icb_rsp_ready);
		else
			$display("Hint: Output 'fio_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_valid)
			$display("Hint: Output 'mem_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_valid, stats1.errortime_mem_icb_cmd_valid);
		else
			$display("Hint: Output 'mem_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_addr)
			$display("Hint: Output 'mem_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_addr, stats1.errortime_mem_icb_cmd_addr);
		else
			$display("Hint: Output 'mem_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_read)
			$display("Hint: Output 'mem_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_read, stats1.errortime_mem_icb_cmd_read);
		else
			$display("Hint: Output 'mem_icb_cmd_read' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_wdata)
			$display("Hint: Output 'mem_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_wdata, stats1.errortime_mem_icb_cmd_wdata);
		else
			$display("Hint: Output 'mem_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_wmask)
			$display("Hint: Output 'mem_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_wmask, stats1.errortime_mem_icb_cmd_wmask);
		else
			$display("Hint: Output 'mem_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_lock)
			$display("Hint: Output 'mem_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_lock, stats1.errortime_mem_icb_cmd_lock);
		else
			$display("Hint: Output 'mem_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_excl)
			$display("Hint: Output 'mem_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_excl, stats1.errortime_mem_icb_cmd_excl);
		else
			$display("Hint: Output 'mem_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_size)
			$display("Hint: Output 'mem_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_size, stats1.errortime_mem_icb_cmd_size);
		else
			$display("Hint: Output 'mem_icb_cmd_size' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_burst)
			$display("Hint: Output 'mem_icb_cmd_burst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_burst, stats1.errortime_mem_icb_cmd_burst);
		else
			$display("Hint: Output 'mem_icb_cmd_burst' has no mismatches.");
		if (stats1.errors_mem_icb_cmd_beat)
			$display("Hint: Output 'mem_icb_cmd_beat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_cmd_beat, stats1.errortime_mem_icb_cmd_beat);
		else
			$display("Hint: Output 'mem_icb_cmd_beat' has no mismatches.");
		if (stats1.errors_mem_icb_rsp_ready)
			$display("Hint: Output 'mem_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_rsp_ready, stats1.errortime_mem_icb_rsp_ready);
		else
			$display("Hint: Output 'mem_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_valid)
			$display("Hint: Output 'lsu2itcm_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_valid, stats1.errortime_lsu2itcm_icb_cmd_valid);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_addr)
			$display("Hint: Output 'lsu2itcm_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_addr, stats1.errortime_lsu2itcm_icb_cmd_addr);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_read)
			$display("Hint: Output 'lsu2itcm_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_read, stats1.errortime_lsu2itcm_icb_cmd_read);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_read' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_wdata)
			$display("Hint: Output 'lsu2itcm_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_wdata, stats1.errortime_lsu2itcm_icb_cmd_wdata);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_wmask)
			$display("Hint: Output 'lsu2itcm_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_wmask, stats1.errortime_lsu2itcm_icb_cmd_wmask);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_lock)
			$display("Hint: Output 'lsu2itcm_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_lock, stats1.errortime_lsu2itcm_icb_cmd_lock);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_excl)
			$display("Hint: Output 'lsu2itcm_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_excl, stats1.errortime_lsu2itcm_icb_cmd_excl);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_size)
			$display("Hint: Output 'lsu2itcm_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_size, stats1.errortime_lsu2itcm_icb_cmd_size);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_size' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_rsp_ready)
			$display("Hint: Output 'lsu2itcm_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_rsp_ready, stats1.errortime_lsu2itcm_icb_rsp_ready);
		else
			$display("Hint: Output 'lsu2itcm_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_valid)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_valid, stats1.errortime_lsu2dtcm_icb_cmd_valid);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_addr)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_addr, stats1.errortime_lsu2dtcm_icb_cmd_addr);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_read)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_read, stats1.errortime_lsu2dtcm_icb_cmd_read);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_read' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_wdata)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_wdata, stats1.errortime_lsu2dtcm_icb_cmd_wdata);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_wmask)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_wmask, stats1.errortime_lsu2dtcm_icb_cmd_wmask);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_lock)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_lock, stats1.errortime_lsu2dtcm_icb_cmd_lock);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_excl)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_excl, stats1.errortime_lsu2dtcm_icb_cmd_excl);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_size)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_size, stats1.errortime_lsu2dtcm_icb_cmd_size);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_size' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_rsp_ready)
			$display("Hint: Output 'lsu2dtcm_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_rsp_ready, stats1.errortime_lsu2dtcm_icb_rsp_ready);
		else
			$display("Hint: Output 'lsu2dtcm_icb_rsp_ready' has no mismatches.");
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
		if (stats1.errors_nice_icb_rsp_rdata)
			$display("Hint: Output 'nice_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_rdata, stats1.errortime_nice_icb_rsp_rdata);
		else
			$display("Hint: Output 'nice_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_nice_icb_rsp_err)
			$display("Hint: Output 'nice_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_icb_rsp_err, stats1.errortime_nice_icb_rsp_err);
		else
			$display("Hint: Output 'nice_icb_rsp_err' has no mismatches.");
		if (stats1.errors_exu_active)
			$display("Hint: Output 'exu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_exu_active, stats1.errortime_exu_active);
		else
			$display("Hint: Output 'exu_active' has no mismatches.");
		if (stats1.errors_ifu_active)
			$display("Hint: Output 'ifu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu_active, stats1.errortime_ifu_active);
		else
			$display("Hint: Output 'ifu_active' has no mismatches.");
		if (stats1.errors_lsu_active)
			$display("Hint: Output 'lsu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_active, stats1.errortime_lsu_active);
		else
			$display("Hint: Output 'lsu_active' has no mismatches.");
		if (stats1.errors_biu_active)
			$display("Hint: Output 'biu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_active, stats1.errortime_biu_active);
		else
			$display("Hint: Output 'biu_active' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ inspect_pc_ref,core_wfi_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_rsp_ready_ref,lsu2itcm_icb_cmd_valid_ref,lsu2itcm_icb_cmd_addr_ref,lsu2itcm_icb_cmd_read_ref,lsu2itcm_icb_cmd_wdata_ref,lsu2itcm_icb_cmd_wmask_ref,lsu2itcm_icb_cmd_lock_ref,lsu2itcm_icb_cmd_excl_ref,lsu2itcm_icb_cmd_size_ref,lsu2itcm_icb_rsp_ready_ref,lsu2dtcm_icb_cmd_valid_ref,lsu2dtcm_icb_cmd_addr_ref,lsu2dtcm_icb_cmd_read_ref,lsu2dtcm_icb_cmd_wdata_ref,lsu2dtcm_icb_cmd_wmask_ref,lsu2dtcm_icb_cmd_lock_ref,lsu2dtcm_icb_cmd_excl_ref,lsu2dtcm_icb_cmd_size_ref,lsu2dtcm_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_rdata_ref,nice_icb_rsp_err_ref,exu_active_ref,ifu_active_ref,lsu_active_ref,biu_active_ref} ===
			( { inspect_pc_ref,core_wfi_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_rsp_ready_ref,lsu2itcm_icb_cmd_valid_ref,lsu2itcm_icb_cmd_addr_ref,lsu2itcm_icb_cmd_read_ref,lsu2itcm_icb_cmd_wdata_ref,lsu2itcm_icb_cmd_wmask_ref,lsu2itcm_icb_cmd_lock_ref,lsu2itcm_icb_cmd_excl_ref,lsu2itcm_icb_cmd_size_ref,lsu2itcm_icb_rsp_ready_ref,lsu2dtcm_icb_cmd_valid_ref,lsu2dtcm_icb_cmd_addr_ref,lsu2dtcm_icb_cmd_read_ref,lsu2dtcm_icb_cmd_wdata_ref,lsu2dtcm_icb_cmd_wmask_ref,lsu2dtcm_icb_cmd_lock_ref,lsu2dtcm_icb_cmd_excl_ref,lsu2dtcm_icb_cmd_size_ref,lsu2dtcm_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_rdata_ref,nice_icb_rsp_err_ref,exu_active_ref,ifu_active_ref,lsu_active_ref,biu_active_ref} ^
			  { inspect_pc_dut,core_wfi_dut,tm_stop_dut,core_cgstop_dut,tcm_cgstop_dut,wr_dcsr_ena_dut,wr_dpc_ena_dut,wr_dscratch_ena_dut,wr_csr_nxt_dut,cmt_dpc_dut,cmt_dpc_ena_dut,cmt_dcause_dut,cmt_dcause_ena_dut,ifu2itcm_icb_cmd_valid_dut,ifu2itcm_icb_cmd_addr_dut,ifu2itcm_icb_rsp_ready_dut,ppi_icb_cmd_valid_dut,ppi_icb_cmd_addr_dut,ppi_icb_cmd_read_dut,ppi_icb_cmd_wdata_dut,ppi_icb_cmd_wmask_dut,ppi_icb_cmd_lock_dut,ppi_icb_cmd_excl_dut,ppi_icb_cmd_size_dut,ppi_icb_rsp_ready_dut,clint_icb_cmd_valid_dut,clint_icb_cmd_addr_dut,clint_icb_cmd_read_dut,clint_icb_cmd_wdata_dut,clint_icb_cmd_wmask_dut,clint_icb_cmd_lock_dut,clint_icb_cmd_excl_dut,clint_icb_cmd_size_dut,clint_icb_rsp_ready_dut,plic_icb_cmd_valid_dut,plic_icb_cmd_addr_dut,plic_icb_cmd_read_dut,plic_icb_cmd_wdata_dut,plic_icb_cmd_wmask_dut,plic_icb_cmd_lock_dut,plic_icb_cmd_excl_dut,plic_icb_cmd_size_dut,plic_icb_rsp_ready_dut,fio_icb_cmd_valid_dut,fio_icb_cmd_addr_dut,fio_icb_cmd_read_dut,fio_icb_cmd_wdata_dut,fio_icb_cmd_wmask_dut,fio_icb_cmd_lock_dut,fio_icb_cmd_excl_dut,fio_icb_cmd_size_dut,fio_icb_rsp_ready_dut,mem_icb_cmd_valid_dut,mem_icb_cmd_addr_dut,mem_icb_cmd_read_dut,mem_icb_cmd_wdata_dut,mem_icb_cmd_wmask_dut,mem_icb_cmd_lock_dut,mem_icb_cmd_excl_dut,mem_icb_cmd_size_dut,mem_icb_cmd_burst_dut,mem_icb_cmd_beat_dut,mem_icb_rsp_ready_dut,lsu2itcm_icb_cmd_valid_dut,lsu2itcm_icb_cmd_addr_dut,lsu2itcm_icb_cmd_read_dut,lsu2itcm_icb_cmd_wdata_dut,lsu2itcm_icb_cmd_wmask_dut,lsu2itcm_icb_cmd_lock_dut,lsu2itcm_icb_cmd_excl_dut,lsu2itcm_icb_cmd_size_dut,lsu2itcm_icb_rsp_ready_dut,lsu2dtcm_icb_cmd_valid_dut,lsu2dtcm_icb_cmd_addr_dut,lsu2dtcm_icb_cmd_read_dut,lsu2dtcm_icb_cmd_wdata_dut,lsu2dtcm_icb_cmd_wmask_dut,lsu2dtcm_icb_cmd_lock_dut,lsu2dtcm_icb_cmd_excl_dut,lsu2dtcm_icb_cmd_size_dut,lsu2dtcm_icb_rsp_ready_dut,nice_req_valid_dut,nice_req_inst_dut,nice_req_rs1_dut,nice_req_rs2_dut,nice_rsp_multicyc_ready_dut,nice_icb_cmd_ready_dut,nice_icb_rsp_valid_dut,nice_icb_rsp_rdata_dut,nice_icb_rsp_err_dut,exu_active_dut,ifu_active_dut,lsu_active_dut,biu_active_dut} ^
			  { inspect_pc_ref,core_wfi_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,ifu2itcm_icb_cmd_valid_ref,ifu2itcm_icb_cmd_addr_ref,ifu2itcm_icb_rsp_ready_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_rsp_ready_ref,lsu2itcm_icb_cmd_valid_ref,lsu2itcm_icb_cmd_addr_ref,lsu2itcm_icb_cmd_read_ref,lsu2itcm_icb_cmd_wdata_ref,lsu2itcm_icb_cmd_wmask_ref,lsu2itcm_icb_cmd_lock_ref,lsu2itcm_icb_cmd_excl_ref,lsu2itcm_icb_cmd_size_ref,lsu2itcm_icb_rsp_ready_ref,lsu2dtcm_icb_cmd_valid_ref,lsu2dtcm_icb_cmd_addr_ref,lsu2dtcm_icb_cmd_read_ref,lsu2dtcm_icb_cmd_wdata_ref,lsu2dtcm_icb_cmd_wmask_ref,lsu2dtcm_icb_cmd_lock_ref,lsu2dtcm_icb_cmd_excl_ref,lsu2dtcm_icb_cmd_size_ref,lsu2dtcm_icb_rsp_ready_ref,nice_req_valid_ref,nice_req_inst_ref,nice_req_rs1_ref,nice_req_rs2_ref,nice_rsp_multicyc_ready_ref,nice_icb_cmd_ready_ref,nice_icb_rsp_valid_ref,nice_icb_rsp_rdata_ref,nice_icb_rsp_err_ref,exu_active_ref,ifu_active_ref,lsu_active_ref,biu_active_ref} );

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
		if (core_wfi_ref !== (core_wfi_ref ^ core_wfi_dut ^ core_wfi_ref)) begin
			if (stats1.errors_core_wfi == 0) stats1.errortime_core_wfi = $time;
			stats1.errors_core_wfi++;
		end
		if (tm_stop_ref !== (tm_stop_ref ^ tm_stop_dut ^ tm_stop_ref)) begin
			if (stats1.errors_tm_stop == 0) stats1.errortime_tm_stop = $time;
			stats1.errors_tm_stop++;
		end
		if (core_cgstop_ref !== (core_cgstop_ref ^ core_cgstop_dut ^ core_cgstop_ref)) begin
			if (stats1.errors_core_cgstop == 0) stats1.errortime_core_cgstop = $time;
			stats1.errors_core_cgstop++;
		end
		if (tcm_cgstop_ref !== (tcm_cgstop_ref ^ tcm_cgstop_dut ^ tcm_cgstop_ref)) begin
			if (stats1.errors_tcm_cgstop == 0) stats1.errortime_tcm_cgstop = $time;
			stats1.errors_tcm_cgstop++;
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
		if (ppi_icb_cmd_valid_ref !== (ppi_icb_cmd_valid_ref ^ ppi_icb_cmd_valid_dut ^ ppi_icb_cmd_valid_ref)) begin
			if (stats1.errors_ppi_icb_cmd_valid == 0) stats1.errortime_ppi_icb_cmd_valid = $time;
			stats1.errors_ppi_icb_cmd_valid++;
		end
		if (ppi_icb_cmd_addr_ref !== (ppi_icb_cmd_addr_ref ^ ppi_icb_cmd_addr_dut ^ ppi_icb_cmd_addr_ref)) begin
			if (stats1.errors_ppi_icb_cmd_addr == 0) stats1.errortime_ppi_icb_cmd_addr = $time;
			stats1.errors_ppi_icb_cmd_addr++;
		end
		if (ppi_icb_cmd_read_ref !== (ppi_icb_cmd_read_ref ^ ppi_icb_cmd_read_dut ^ ppi_icb_cmd_read_ref)) begin
			if (stats1.errors_ppi_icb_cmd_read == 0) stats1.errortime_ppi_icb_cmd_read = $time;
			stats1.errors_ppi_icb_cmd_read++;
		end
		if (ppi_icb_cmd_wdata_ref !== (ppi_icb_cmd_wdata_ref ^ ppi_icb_cmd_wdata_dut ^ ppi_icb_cmd_wdata_ref)) begin
			if (stats1.errors_ppi_icb_cmd_wdata == 0) stats1.errortime_ppi_icb_cmd_wdata = $time;
			stats1.errors_ppi_icb_cmd_wdata++;
		end
		if (ppi_icb_cmd_wmask_ref !== (ppi_icb_cmd_wmask_ref ^ ppi_icb_cmd_wmask_dut ^ ppi_icb_cmd_wmask_ref)) begin
			if (stats1.errors_ppi_icb_cmd_wmask == 0) stats1.errortime_ppi_icb_cmd_wmask = $time;
			stats1.errors_ppi_icb_cmd_wmask++;
		end
		if (ppi_icb_cmd_lock_ref !== (ppi_icb_cmd_lock_ref ^ ppi_icb_cmd_lock_dut ^ ppi_icb_cmd_lock_ref)) begin
			if (stats1.errors_ppi_icb_cmd_lock == 0) stats1.errortime_ppi_icb_cmd_lock = $time;
			stats1.errors_ppi_icb_cmd_lock++;
		end
		if (ppi_icb_cmd_excl_ref !== (ppi_icb_cmd_excl_ref ^ ppi_icb_cmd_excl_dut ^ ppi_icb_cmd_excl_ref)) begin
			if (stats1.errors_ppi_icb_cmd_excl == 0) stats1.errortime_ppi_icb_cmd_excl = $time;
			stats1.errors_ppi_icb_cmd_excl++;
		end
		if (ppi_icb_cmd_size_ref !== (ppi_icb_cmd_size_ref ^ ppi_icb_cmd_size_dut ^ ppi_icb_cmd_size_ref)) begin
			if (stats1.errors_ppi_icb_cmd_size == 0) stats1.errortime_ppi_icb_cmd_size = $time;
			stats1.errors_ppi_icb_cmd_size++;
		end
		if (ppi_icb_rsp_ready_ref !== (ppi_icb_rsp_ready_ref ^ ppi_icb_rsp_ready_dut ^ ppi_icb_rsp_ready_ref)) begin
			if (stats1.errors_ppi_icb_rsp_ready == 0) stats1.errortime_ppi_icb_rsp_ready = $time;
			stats1.errors_ppi_icb_rsp_ready++;
		end
		if (clint_icb_cmd_valid_ref !== (clint_icb_cmd_valid_ref ^ clint_icb_cmd_valid_dut ^ clint_icb_cmd_valid_ref)) begin
			if (stats1.errors_clint_icb_cmd_valid == 0) stats1.errortime_clint_icb_cmd_valid = $time;
			stats1.errors_clint_icb_cmd_valid++;
		end
		if (clint_icb_cmd_addr_ref !== (clint_icb_cmd_addr_ref ^ clint_icb_cmd_addr_dut ^ clint_icb_cmd_addr_ref)) begin
			if (stats1.errors_clint_icb_cmd_addr == 0) stats1.errortime_clint_icb_cmd_addr = $time;
			stats1.errors_clint_icb_cmd_addr++;
		end
		if (clint_icb_cmd_read_ref !== (clint_icb_cmd_read_ref ^ clint_icb_cmd_read_dut ^ clint_icb_cmd_read_ref)) begin
			if (stats1.errors_clint_icb_cmd_read == 0) stats1.errortime_clint_icb_cmd_read = $time;
			stats1.errors_clint_icb_cmd_read++;
		end
		if (clint_icb_cmd_wdata_ref !== (clint_icb_cmd_wdata_ref ^ clint_icb_cmd_wdata_dut ^ clint_icb_cmd_wdata_ref)) begin
			if (stats1.errors_clint_icb_cmd_wdata == 0) stats1.errortime_clint_icb_cmd_wdata = $time;
			stats1.errors_clint_icb_cmd_wdata++;
		end
		if (clint_icb_cmd_wmask_ref !== (clint_icb_cmd_wmask_ref ^ clint_icb_cmd_wmask_dut ^ clint_icb_cmd_wmask_ref)) begin
			if (stats1.errors_clint_icb_cmd_wmask == 0) stats1.errortime_clint_icb_cmd_wmask = $time;
			stats1.errors_clint_icb_cmd_wmask++;
		end
		if (clint_icb_cmd_lock_ref !== (clint_icb_cmd_lock_ref ^ clint_icb_cmd_lock_dut ^ clint_icb_cmd_lock_ref)) begin
			if (stats1.errors_clint_icb_cmd_lock == 0) stats1.errortime_clint_icb_cmd_lock = $time;
			stats1.errors_clint_icb_cmd_lock++;
		end
		if (clint_icb_cmd_excl_ref !== (clint_icb_cmd_excl_ref ^ clint_icb_cmd_excl_dut ^ clint_icb_cmd_excl_ref)) begin
			if (stats1.errors_clint_icb_cmd_excl == 0) stats1.errortime_clint_icb_cmd_excl = $time;
			stats1.errors_clint_icb_cmd_excl++;
		end
		if (clint_icb_cmd_size_ref !== (clint_icb_cmd_size_ref ^ clint_icb_cmd_size_dut ^ clint_icb_cmd_size_ref)) begin
			if (stats1.errors_clint_icb_cmd_size == 0) stats1.errortime_clint_icb_cmd_size = $time;
			stats1.errors_clint_icb_cmd_size++;
		end
		if (clint_icb_rsp_ready_ref !== (clint_icb_rsp_ready_ref ^ clint_icb_rsp_ready_dut ^ clint_icb_rsp_ready_ref)) begin
			if (stats1.errors_clint_icb_rsp_ready == 0) stats1.errortime_clint_icb_rsp_ready = $time;
			stats1.errors_clint_icb_rsp_ready++;
		end
		if (plic_icb_cmd_valid_ref !== (plic_icb_cmd_valid_ref ^ plic_icb_cmd_valid_dut ^ plic_icb_cmd_valid_ref)) begin
			if (stats1.errors_plic_icb_cmd_valid == 0) stats1.errortime_plic_icb_cmd_valid = $time;
			stats1.errors_plic_icb_cmd_valid++;
		end
		if (plic_icb_cmd_addr_ref !== (plic_icb_cmd_addr_ref ^ plic_icb_cmd_addr_dut ^ plic_icb_cmd_addr_ref)) begin
			if (stats1.errors_plic_icb_cmd_addr == 0) stats1.errortime_plic_icb_cmd_addr = $time;
			stats1.errors_plic_icb_cmd_addr++;
		end
		if (plic_icb_cmd_read_ref !== (plic_icb_cmd_read_ref ^ plic_icb_cmd_read_dut ^ plic_icb_cmd_read_ref)) begin
			if (stats1.errors_plic_icb_cmd_read == 0) stats1.errortime_plic_icb_cmd_read = $time;
			stats1.errors_plic_icb_cmd_read++;
		end
		if (plic_icb_cmd_wdata_ref !== (plic_icb_cmd_wdata_ref ^ plic_icb_cmd_wdata_dut ^ plic_icb_cmd_wdata_ref)) begin
			if (stats1.errors_plic_icb_cmd_wdata == 0) stats1.errortime_plic_icb_cmd_wdata = $time;
			stats1.errors_plic_icb_cmd_wdata++;
		end
		if (plic_icb_cmd_wmask_ref !== (plic_icb_cmd_wmask_ref ^ plic_icb_cmd_wmask_dut ^ plic_icb_cmd_wmask_ref)) begin
			if (stats1.errors_plic_icb_cmd_wmask == 0) stats1.errortime_plic_icb_cmd_wmask = $time;
			stats1.errors_plic_icb_cmd_wmask++;
		end
		if (plic_icb_cmd_lock_ref !== (plic_icb_cmd_lock_ref ^ plic_icb_cmd_lock_dut ^ plic_icb_cmd_lock_ref)) begin
			if (stats1.errors_plic_icb_cmd_lock == 0) stats1.errortime_plic_icb_cmd_lock = $time;
			stats1.errors_plic_icb_cmd_lock++;
		end
		if (plic_icb_cmd_excl_ref !== (plic_icb_cmd_excl_ref ^ plic_icb_cmd_excl_dut ^ plic_icb_cmd_excl_ref)) begin
			if (stats1.errors_plic_icb_cmd_excl == 0) stats1.errortime_plic_icb_cmd_excl = $time;
			stats1.errors_plic_icb_cmd_excl++;
		end
		if (plic_icb_cmd_size_ref !== (plic_icb_cmd_size_ref ^ plic_icb_cmd_size_dut ^ plic_icb_cmd_size_ref)) begin
			if (stats1.errors_plic_icb_cmd_size == 0) stats1.errortime_plic_icb_cmd_size = $time;
			stats1.errors_plic_icb_cmd_size++;
		end
		if (plic_icb_rsp_ready_ref !== (plic_icb_rsp_ready_ref ^ plic_icb_rsp_ready_dut ^ plic_icb_rsp_ready_ref)) begin
			if (stats1.errors_plic_icb_rsp_ready == 0) stats1.errortime_plic_icb_rsp_ready = $time;
			stats1.errors_plic_icb_rsp_ready++;
		end
		if (fio_icb_cmd_valid_ref !== (fio_icb_cmd_valid_ref ^ fio_icb_cmd_valid_dut ^ fio_icb_cmd_valid_ref)) begin
			if (stats1.errors_fio_icb_cmd_valid == 0) stats1.errortime_fio_icb_cmd_valid = $time;
			stats1.errors_fio_icb_cmd_valid++;
		end
		if (fio_icb_cmd_addr_ref !== (fio_icb_cmd_addr_ref ^ fio_icb_cmd_addr_dut ^ fio_icb_cmd_addr_ref)) begin
			if (stats1.errors_fio_icb_cmd_addr == 0) stats1.errortime_fio_icb_cmd_addr = $time;
			stats1.errors_fio_icb_cmd_addr++;
		end
		if (fio_icb_cmd_read_ref !== (fio_icb_cmd_read_ref ^ fio_icb_cmd_read_dut ^ fio_icb_cmd_read_ref)) begin
			if (stats1.errors_fio_icb_cmd_read == 0) stats1.errortime_fio_icb_cmd_read = $time;
			stats1.errors_fio_icb_cmd_read++;
		end
		if (fio_icb_cmd_wdata_ref !== (fio_icb_cmd_wdata_ref ^ fio_icb_cmd_wdata_dut ^ fio_icb_cmd_wdata_ref)) begin
			if (stats1.errors_fio_icb_cmd_wdata == 0) stats1.errortime_fio_icb_cmd_wdata = $time;
			stats1.errors_fio_icb_cmd_wdata++;
		end
		if (fio_icb_cmd_wmask_ref !== (fio_icb_cmd_wmask_ref ^ fio_icb_cmd_wmask_dut ^ fio_icb_cmd_wmask_ref)) begin
			if (stats1.errors_fio_icb_cmd_wmask == 0) stats1.errortime_fio_icb_cmd_wmask = $time;
			stats1.errors_fio_icb_cmd_wmask++;
		end
		if (fio_icb_cmd_lock_ref !== (fio_icb_cmd_lock_ref ^ fio_icb_cmd_lock_dut ^ fio_icb_cmd_lock_ref)) begin
			if (stats1.errors_fio_icb_cmd_lock == 0) stats1.errortime_fio_icb_cmd_lock = $time;
			stats1.errors_fio_icb_cmd_lock++;
		end
		if (fio_icb_cmd_excl_ref !== (fio_icb_cmd_excl_ref ^ fio_icb_cmd_excl_dut ^ fio_icb_cmd_excl_ref)) begin
			if (stats1.errors_fio_icb_cmd_excl == 0) stats1.errortime_fio_icb_cmd_excl = $time;
			stats1.errors_fio_icb_cmd_excl++;
		end
		if (fio_icb_cmd_size_ref !== (fio_icb_cmd_size_ref ^ fio_icb_cmd_size_dut ^ fio_icb_cmd_size_ref)) begin
			if (stats1.errors_fio_icb_cmd_size == 0) stats1.errortime_fio_icb_cmd_size = $time;
			stats1.errors_fio_icb_cmd_size++;
		end
		if (fio_icb_rsp_ready_ref !== (fio_icb_rsp_ready_ref ^ fio_icb_rsp_ready_dut ^ fio_icb_rsp_ready_ref)) begin
			if (stats1.errors_fio_icb_rsp_ready == 0) stats1.errortime_fio_icb_rsp_ready = $time;
			stats1.errors_fio_icb_rsp_ready++;
		end
		if (mem_icb_cmd_valid_ref !== (mem_icb_cmd_valid_ref ^ mem_icb_cmd_valid_dut ^ mem_icb_cmd_valid_ref)) begin
			if (stats1.errors_mem_icb_cmd_valid == 0) stats1.errortime_mem_icb_cmd_valid = $time;
			stats1.errors_mem_icb_cmd_valid++;
		end
		if (mem_icb_cmd_addr_ref !== (mem_icb_cmd_addr_ref ^ mem_icb_cmd_addr_dut ^ mem_icb_cmd_addr_ref)) begin
			if (stats1.errors_mem_icb_cmd_addr == 0) stats1.errortime_mem_icb_cmd_addr = $time;
			stats1.errors_mem_icb_cmd_addr++;
		end
		if (mem_icb_cmd_read_ref !== (mem_icb_cmd_read_ref ^ mem_icb_cmd_read_dut ^ mem_icb_cmd_read_ref)) begin
			if (stats1.errors_mem_icb_cmd_read == 0) stats1.errortime_mem_icb_cmd_read = $time;
			stats1.errors_mem_icb_cmd_read++;
		end
		if (mem_icb_cmd_wdata_ref !== (mem_icb_cmd_wdata_ref ^ mem_icb_cmd_wdata_dut ^ mem_icb_cmd_wdata_ref)) begin
			if (stats1.errors_mem_icb_cmd_wdata == 0) stats1.errortime_mem_icb_cmd_wdata = $time;
			stats1.errors_mem_icb_cmd_wdata++;
		end
		if (mem_icb_cmd_wmask_ref !== (mem_icb_cmd_wmask_ref ^ mem_icb_cmd_wmask_dut ^ mem_icb_cmd_wmask_ref)) begin
			if (stats1.errors_mem_icb_cmd_wmask == 0) stats1.errortime_mem_icb_cmd_wmask = $time;
			stats1.errors_mem_icb_cmd_wmask++;
		end
		if (mem_icb_cmd_lock_ref !== (mem_icb_cmd_lock_ref ^ mem_icb_cmd_lock_dut ^ mem_icb_cmd_lock_ref)) begin
			if (stats1.errors_mem_icb_cmd_lock == 0) stats1.errortime_mem_icb_cmd_lock = $time;
			stats1.errors_mem_icb_cmd_lock++;
		end
		if (mem_icb_cmd_excl_ref !== (mem_icb_cmd_excl_ref ^ mem_icb_cmd_excl_dut ^ mem_icb_cmd_excl_ref)) begin
			if (stats1.errors_mem_icb_cmd_excl == 0) stats1.errortime_mem_icb_cmd_excl = $time;
			stats1.errors_mem_icb_cmd_excl++;
		end
		if (mem_icb_cmd_size_ref !== (mem_icb_cmd_size_ref ^ mem_icb_cmd_size_dut ^ mem_icb_cmd_size_ref)) begin
			if (stats1.errors_mem_icb_cmd_size == 0) stats1.errortime_mem_icb_cmd_size = $time;
			stats1.errors_mem_icb_cmd_size++;
		end
		if (mem_icb_cmd_burst_ref !== (mem_icb_cmd_burst_ref ^ mem_icb_cmd_burst_dut ^ mem_icb_cmd_burst_ref)) begin
			if (stats1.errors_mem_icb_cmd_burst == 0) stats1.errortime_mem_icb_cmd_burst = $time;
			stats1.errors_mem_icb_cmd_burst++;
		end
		if (mem_icb_cmd_beat_ref !== (mem_icb_cmd_beat_ref ^ mem_icb_cmd_beat_dut ^ mem_icb_cmd_beat_ref)) begin
			if (stats1.errors_mem_icb_cmd_beat == 0) stats1.errortime_mem_icb_cmd_beat = $time;
			stats1.errors_mem_icb_cmd_beat++;
		end
		if (mem_icb_rsp_ready_ref !== (mem_icb_rsp_ready_ref ^ mem_icb_rsp_ready_dut ^ mem_icb_rsp_ready_ref)) begin
			if (stats1.errors_mem_icb_rsp_ready == 0) stats1.errortime_mem_icb_rsp_ready = $time;
			stats1.errors_mem_icb_rsp_ready++;
		end
		if (lsu2itcm_icb_cmd_valid_ref !== (lsu2itcm_icb_cmd_valid_ref ^ lsu2itcm_icb_cmd_valid_dut ^ lsu2itcm_icb_cmd_valid_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_valid == 0) stats1.errortime_lsu2itcm_icb_cmd_valid = $time;
			stats1.errors_lsu2itcm_icb_cmd_valid++;
		end
		if (lsu2itcm_icb_cmd_addr_ref !== (lsu2itcm_icb_cmd_addr_ref ^ lsu2itcm_icb_cmd_addr_dut ^ lsu2itcm_icb_cmd_addr_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_addr == 0) stats1.errortime_lsu2itcm_icb_cmd_addr = $time;
			stats1.errors_lsu2itcm_icb_cmd_addr++;
		end
		if (lsu2itcm_icb_cmd_read_ref !== (lsu2itcm_icb_cmd_read_ref ^ lsu2itcm_icb_cmd_read_dut ^ lsu2itcm_icb_cmd_read_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_read == 0) stats1.errortime_lsu2itcm_icb_cmd_read = $time;
			stats1.errors_lsu2itcm_icb_cmd_read++;
		end
		if (lsu2itcm_icb_cmd_wdata_ref !== (lsu2itcm_icb_cmd_wdata_ref ^ lsu2itcm_icb_cmd_wdata_dut ^ lsu2itcm_icb_cmd_wdata_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_wdata == 0) stats1.errortime_lsu2itcm_icb_cmd_wdata = $time;
			stats1.errors_lsu2itcm_icb_cmd_wdata++;
		end
		if (lsu2itcm_icb_cmd_wmask_ref !== (lsu2itcm_icb_cmd_wmask_ref ^ lsu2itcm_icb_cmd_wmask_dut ^ lsu2itcm_icb_cmd_wmask_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_wmask == 0) stats1.errortime_lsu2itcm_icb_cmd_wmask = $time;
			stats1.errors_lsu2itcm_icb_cmd_wmask++;
		end
		if (lsu2itcm_icb_cmd_lock_ref !== (lsu2itcm_icb_cmd_lock_ref ^ lsu2itcm_icb_cmd_lock_dut ^ lsu2itcm_icb_cmd_lock_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_lock == 0) stats1.errortime_lsu2itcm_icb_cmd_lock = $time;
			stats1.errors_lsu2itcm_icb_cmd_lock++;
		end
		if (lsu2itcm_icb_cmd_excl_ref !== (lsu2itcm_icb_cmd_excl_ref ^ lsu2itcm_icb_cmd_excl_dut ^ lsu2itcm_icb_cmd_excl_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_excl == 0) stats1.errortime_lsu2itcm_icb_cmd_excl = $time;
			stats1.errors_lsu2itcm_icb_cmd_excl++;
		end
		if (lsu2itcm_icb_cmd_size_ref !== (lsu2itcm_icb_cmd_size_ref ^ lsu2itcm_icb_cmd_size_dut ^ lsu2itcm_icb_cmd_size_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_size == 0) stats1.errortime_lsu2itcm_icb_cmd_size = $time;
			stats1.errors_lsu2itcm_icb_cmd_size++;
		end
		if (lsu2itcm_icb_rsp_ready_ref !== (lsu2itcm_icb_rsp_ready_ref ^ lsu2itcm_icb_rsp_ready_dut ^ lsu2itcm_icb_rsp_ready_ref)) begin
			if (stats1.errors_lsu2itcm_icb_rsp_ready == 0) stats1.errortime_lsu2itcm_icb_rsp_ready = $time;
			stats1.errors_lsu2itcm_icb_rsp_ready++;
		end
		if (lsu2dtcm_icb_cmd_valid_ref !== (lsu2dtcm_icb_cmd_valid_ref ^ lsu2dtcm_icb_cmd_valid_dut ^ lsu2dtcm_icb_cmd_valid_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_valid == 0) stats1.errortime_lsu2dtcm_icb_cmd_valid = $time;
			stats1.errors_lsu2dtcm_icb_cmd_valid++;
		end
		if (lsu2dtcm_icb_cmd_addr_ref !== (lsu2dtcm_icb_cmd_addr_ref ^ lsu2dtcm_icb_cmd_addr_dut ^ lsu2dtcm_icb_cmd_addr_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_addr == 0) stats1.errortime_lsu2dtcm_icb_cmd_addr = $time;
			stats1.errors_lsu2dtcm_icb_cmd_addr++;
		end
		if (lsu2dtcm_icb_cmd_read_ref !== (lsu2dtcm_icb_cmd_read_ref ^ lsu2dtcm_icb_cmd_read_dut ^ lsu2dtcm_icb_cmd_read_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_read == 0) stats1.errortime_lsu2dtcm_icb_cmd_read = $time;
			stats1.errors_lsu2dtcm_icb_cmd_read++;
		end
		if (lsu2dtcm_icb_cmd_wdata_ref !== (lsu2dtcm_icb_cmd_wdata_ref ^ lsu2dtcm_icb_cmd_wdata_dut ^ lsu2dtcm_icb_cmd_wdata_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_wdata == 0) stats1.errortime_lsu2dtcm_icb_cmd_wdata = $time;
			stats1.errors_lsu2dtcm_icb_cmd_wdata++;
		end
		if (lsu2dtcm_icb_cmd_wmask_ref !== (lsu2dtcm_icb_cmd_wmask_ref ^ lsu2dtcm_icb_cmd_wmask_dut ^ lsu2dtcm_icb_cmd_wmask_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_wmask == 0) stats1.errortime_lsu2dtcm_icb_cmd_wmask = $time;
			stats1.errors_lsu2dtcm_icb_cmd_wmask++;
		end
		if (lsu2dtcm_icb_cmd_lock_ref !== (lsu2dtcm_icb_cmd_lock_ref ^ lsu2dtcm_icb_cmd_lock_dut ^ lsu2dtcm_icb_cmd_lock_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_lock == 0) stats1.errortime_lsu2dtcm_icb_cmd_lock = $time;
			stats1.errors_lsu2dtcm_icb_cmd_lock++;
		end
		if (lsu2dtcm_icb_cmd_excl_ref !== (lsu2dtcm_icb_cmd_excl_ref ^ lsu2dtcm_icb_cmd_excl_dut ^ lsu2dtcm_icb_cmd_excl_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_excl == 0) stats1.errortime_lsu2dtcm_icb_cmd_excl = $time;
			stats1.errors_lsu2dtcm_icb_cmd_excl++;
		end
		if (lsu2dtcm_icb_cmd_size_ref !== (lsu2dtcm_icb_cmd_size_ref ^ lsu2dtcm_icb_cmd_size_dut ^ lsu2dtcm_icb_cmd_size_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_size == 0) stats1.errortime_lsu2dtcm_icb_cmd_size = $time;
			stats1.errors_lsu2dtcm_icb_cmd_size++;
		end
		if (lsu2dtcm_icb_rsp_ready_ref !== (lsu2dtcm_icb_rsp_ready_ref ^ lsu2dtcm_icb_rsp_ready_dut ^ lsu2dtcm_icb_rsp_ready_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_rsp_ready == 0) stats1.errortime_lsu2dtcm_icb_rsp_ready = $time;
			stats1.errors_lsu2dtcm_icb_rsp_ready++;
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
		if (nice_icb_cmd_ready_ref !== (nice_icb_cmd_ready_ref ^ nice_icb_cmd_ready_dut ^ nice_icb_cmd_ready_ref)) begin
			if (stats1.errors_nice_icb_cmd_ready == 0) stats1.errortime_nice_icb_cmd_ready = $time;
			stats1.errors_nice_icb_cmd_ready++;
		end
		if (nice_icb_rsp_valid_ref !== (nice_icb_rsp_valid_ref ^ nice_icb_rsp_valid_dut ^ nice_icb_rsp_valid_ref)) begin
			if (stats1.errors_nice_icb_rsp_valid == 0) stats1.errortime_nice_icb_rsp_valid = $time;
			stats1.errors_nice_icb_rsp_valid++;
		end
		if (nice_icb_rsp_rdata_ref !== (nice_icb_rsp_rdata_ref ^ nice_icb_rsp_rdata_dut ^ nice_icb_rsp_rdata_ref)) begin
			if (stats1.errors_nice_icb_rsp_rdata == 0) stats1.errortime_nice_icb_rsp_rdata = $time;
			stats1.errors_nice_icb_rsp_rdata++;
		end
		if (nice_icb_rsp_err_ref !== (nice_icb_rsp_err_ref ^ nice_icb_rsp_err_dut ^ nice_icb_rsp_err_ref)) begin
			if (stats1.errors_nice_icb_rsp_err == 0) stats1.errortime_nice_icb_rsp_err = $time;
			stats1.errors_nice_icb_rsp_err++;
		end
		if (exu_active_ref !== (exu_active_ref ^ exu_active_dut ^ exu_active_ref)) begin
			if (stats1.errors_exu_active == 0) stats1.errortime_exu_active = $time;
			stats1.errors_exu_active++;
		end
		if (ifu_active_ref !== (ifu_active_ref ^ ifu_active_dut ^ ifu_active_ref)) begin
			if (stats1.errors_ifu_active == 0) stats1.errortime_ifu_active = $time;
			stats1.errors_ifu_active++;
		end
		if (lsu_active_ref !== (lsu_active_ref ^ lsu_active_dut ^ lsu_active_ref)) begin
			if (stats1.errors_lsu_active == 0) stats1.errortime_lsu_active = $time;
			stats1.errors_lsu_active++;
		end
		if (biu_active_ref !== (biu_active_ref ^ biu_active_dut ^ biu_active_ref)) begin
			if (stats1.errors_biu_active == 0) stats1.errortime_biu_active = $time;
			stats1.errors_biu_active++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
