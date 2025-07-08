`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_biu_active;
		int errortime_biu_active;
		int errors_lsu2biu_icb_cmd_ready;
		int errortime_lsu2biu_icb_cmd_ready;
		int errors_lsu2biu_icb_rsp_valid;
		int errortime_lsu2biu_icb_rsp_valid;
		int errors_lsu2biu_icb_rsp_err;
		int errortime_lsu2biu_icb_rsp_err;
		int errors_lsu2biu_icb_rsp_excl_ok;
		int errortime_lsu2biu_icb_rsp_excl_ok;
		int errors_lsu2biu_icb_rsp_rdata;
		int errortime_lsu2biu_icb_rsp_rdata;
		int errors_ifu2biu_icb_cmd_ready;
		int errortime_ifu2biu_icb_cmd_ready;
		int errors_ifu2biu_icb_rsp_valid;
		int errortime_ifu2biu_icb_rsp_valid;
		int errors_ifu2biu_icb_rsp_err;
		int errortime_ifu2biu_icb_rsp_err;
		int errors_ifu2biu_icb_rsp_excl_ok;
		int errortime_ifu2biu_icb_rsp_excl_ok;
		int errors_ifu2biu_icb_rsp_rdata;
		int errortime_ifu2biu_icb_rsp_rdata;
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
		int errors_ppi_icb_cmd_burst;
		int errortime_ppi_icb_cmd_burst;
		int errors_ppi_icb_cmd_beat;
		int errortime_ppi_icb_cmd_beat;
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
		int errors_clint_icb_cmd_burst;
		int errortime_clint_icb_cmd_burst;
		int errors_clint_icb_cmd_beat;
		int errortime_clint_icb_cmd_beat;
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
		int errors_plic_icb_cmd_burst;
		int errortime_plic_icb_cmd_burst;
		int errors_plic_icb_cmd_beat;
		int errortime_plic_icb_cmd_beat;
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
		int errors_fio_icb_cmd_burst;
		int errortime_fio_icb_cmd_burst;
		int errors_fio_icb_cmd_beat;
		int errortime_fio_icb_cmd_beat;
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
		int errors_mem_icb_cmd_burst;
		int errortime_mem_icb_cmd_burst;
		int errors_mem_icb_cmd_beat;
		int errortime_mem_icb_cmd_beat;
		int errors_mem_icb_cmd_lock;
		int errortime_mem_icb_cmd_lock;
		int errors_mem_icb_cmd_excl;
		int errortime_mem_icb_cmd_excl;
		int errors_mem_icb_cmd_size;
		int errortime_mem_icb_cmd_size;
		int errors_mem_icb_rsp_ready;
		int errortime_mem_icb_rsp_ready;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic biu_active_ref;
	logic biu_active_dut;
	logic lsu2biu_icb_cmd_valid;
	logic lsu2biu_icb_cmd_ready_ref;
	logic lsu2biu_icb_cmd_ready_dut;
	logic [32-1:0] lsu2biu_icb_cmd_addr;
	logic lsu2biu_icb_cmd_read;
	logic [32-1:0] lsu2biu_icb_cmd_wdata;
	logic [4-1:0] lsu2biu_icb_cmd_wmask;
	logic [2-1:0] lsu2biu_icb_cmd_burst;
	logic [2-1:0] lsu2biu_icb_cmd_beat;
	logic lsu2biu_icb_cmd_lock;
	logic lsu2biu_icb_cmd_excl;
	logic [2-1:0] lsu2biu_icb_cmd_size;
	logic lsu2biu_icb_rsp_valid_ref;
	logic lsu2biu_icb_rsp_valid_dut;
	logic lsu2biu_icb_rsp_ready;
	logic lsu2biu_icb_rsp_err_ref;
	logic lsu2biu_icb_rsp_err_dut;
	logic lsu2biu_icb_rsp_excl_ok_ref;
	logic lsu2biu_icb_rsp_excl_ok_dut;
	logic [32-1:0] lsu2biu_icb_rsp_rdata_ref;
	logic [32-1:0] lsu2biu_icb_rsp_rdata_dut;
	logic ifu2biu_icb_cmd_valid;
	logic ifu2biu_icb_cmd_ready_ref;
	logic ifu2biu_icb_cmd_ready_dut;
	logic [32-1:0] ifu2biu_icb_cmd_addr;
	logic ifu2biu_icb_cmd_read;
	logic [32-1:0] ifu2biu_icb_cmd_wdata;
	logic [4-1:0] ifu2biu_icb_cmd_wmask;
	logic [2-1:0] ifu2biu_icb_cmd_burst;
	logic [2-1:0] ifu2biu_icb_cmd_beat;
	logic ifu2biu_icb_cmd_lock;
	logic ifu2biu_icb_cmd_excl;
	logic [2-1:0] ifu2biu_icb_cmd_size;
	logic ifu2biu_icb_rsp_valid_ref;
	logic ifu2biu_icb_rsp_valid_dut;
	logic ifu2biu_icb_rsp_ready;
	logic ifu2biu_icb_rsp_err_ref;
	logic ifu2biu_icb_rsp_err_dut;
	logic ifu2biu_icb_rsp_excl_ok_ref;
	logic ifu2biu_icb_rsp_excl_ok_dut;
	logic [32-1:0] ifu2biu_icb_rsp_rdata_ref;
	logic [32-1:0] ifu2biu_icb_rsp_rdata_dut;
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
	logic [2-1:0] ppi_icb_cmd_burst_ref;
	logic [2-1:0] ppi_icb_cmd_burst_dut;
	logic [2-1:0] ppi_icb_cmd_beat_ref;
	logic [2-1:0] ppi_icb_cmd_beat_dut;
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
	logic [2-1:0] clint_icb_cmd_burst_ref;
	logic [2-1:0] clint_icb_cmd_burst_dut;
	logic [2-1:0] clint_icb_cmd_beat_ref;
	logic [2-1:0] clint_icb_cmd_beat_dut;
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
	logic [2-1:0] plic_icb_cmd_burst_ref;
	logic [2-1:0] plic_icb_cmd_burst_dut;
	logic [2-1:0] plic_icb_cmd_beat_ref;
	logic [2-1:0] plic_icb_cmd_beat_dut;
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
	logic [2-1:0] fio_icb_cmd_burst_ref;
	logic [2-1:0] fio_icb_cmd_burst_dut;
	logic [2-1:0] fio_icb_cmd_beat_ref;
	logic [2-1:0] fio_icb_cmd_beat_dut;
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
	logic [2-1:0] mem_icb_cmd_burst_ref;
	logic [2-1:0] mem_icb_cmd_burst_dut;
	logic [2-1:0] mem_icb_cmd_beat_ref;
	logic [2-1:0] mem_icb_cmd_beat_dut;
	logic mem_icb_cmd_lock_ref;
	logic mem_icb_cmd_lock_dut;
	logic mem_icb_cmd_excl_ref;
	logic mem_icb_cmd_excl_dut;
	logic [2-1:0] mem_icb_cmd_size_ref;
	logic [2-1:0] mem_icb_cmd_size_dut;
	logic mem_icb_rsp_valid;
	logic mem_icb_rsp_ready_ref;
	logic mem_icb_rsp_ready_dut;
	logic mem_icb_rsp_err;
	logic mem_icb_rsp_excl_ok;
	logic [32-1:0] mem_icb_rsp_rdata;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.lsu2biu_icb_cmd_valid(lsu2biu_icb_cmd_valid),
		.lsu2biu_icb_cmd_addr(lsu2biu_icb_cmd_addr),
		.lsu2biu_icb_cmd_read(lsu2biu_icb_cmd_read),
		.lsu2biu_icb_cmd_wdata(lsu2biu_icb_cmd_wdata),
		.lsu2biu_icb_cmd_wmask(lsu2biu_icb_cmd_wmask),
		.lsu2biu_icb_cmd_burst(lsu2biu_icb_cmd_burst),
		.lsu2biu_icb_cmd_beat(lsu2biu_icb_cmd_beat),
		.lsu2biu_icb_cmd_lock(lsu2biu_icb_cmd_lock),
		.lsu2biu_icb_cmd_excl(lsu2biu_icb_cmd_excl),
		.lsu2biu_icb_cmd_size(lsu2biu_icb_cmd_size),
		.lsu2biu_icb_rsp_ready(lsu2biu_icb_rsp_ready),
		.ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid),
		.ifu2biu_icb_cmd_addr(ifu2biu_icb_cmd_addr),
		.ifu2biu_icb_cmd_read(ifu2biu_icb_cmd_read),
		.ifu2biu_icb_cmd_wdata(ifu2biu_icb_cmd_wdata),
		.ifu2biu_icb_cmd_wmask(ifu2biu_icb_cmd_wmask),
		.ifu2biu_icb_cmd_burst(ifu2biu_icb_cmd_burst),
		.ifu2biu_icb_cmd_beat(ifu2biu_icb_cmd_beat),
		.ifu2biu_icb_cmd_lock(ifu2biu_icb_cmd_lock),
		.ifu2biu_icb_cmd_excl(ifu2biu_icb_cmd_excl),
		.ifu2biu_icb_cmd_size(ifu2biu_icb_cmd_size),
		.ifu2biu_icb_rsp_ready(ifu2biu_icb_rsp_ready),
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
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_biu good1 (
		.biu_active(biu_active_ref),
		.lsu2biu_icb_cmd_valid(lsu2biu_icb_cmd_valid),
		.lsu2biu_icb_cmd_ready(lsu2biu_icb_cmd_ready_ref),
		.lsu2biu_icb_cmd_addr(lsu2biu_icb_cmd_addr),
		.lsu2biu_icb_cmd_read(lsu2biu_icb_cmd_read),
		.lsu2biu_icb_cmd_wdata(lsu2biu_icb_cmd_wdata),
		.lsu2biu_icb_cmd_wmask(lsu2biu_icb_cmd_wmask),
		.lsu2biu_icb_cmd_burst(lsu2biu_icb_cmd_burst),
		.lsu2biu_icb_cmd_beat(lsu2biu_icb_cmd_beat),
		.lsu2biu_icb_cmd_lock(lsu2biu_icb_cmd_lock),
		.lsu2biu_icb_cmd_excl(lsu2biu_icb_cmd_excl),
		.lsu2biu_icb_cmd_size(lsu2biu_icb_cmd_size),
		.lsu2biu_icb_rsp_valid(lsu2biu_icb_rsp_valid_ref),
		.lsu2biu_icb_rsp_ready(lsu2biu_icb_rsp_ready),
		.lsu2biu_icb_rsp_err(lsu2biu_icb_rsp_err_ref),
		.lsu2biu_icb_rsp_excl_ok(lsu2biu_icb_rsp_excl_ok_ref),
		.lsu2biu_icb_rsp_rdata(lsu2biu_icb_rsp_rdata_ref),
		.ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready_ref),
		.ifu2biu_icb_cmd_addr(ifu2biu_icb_cmd_addr),
		.ifu2biu_icb_cmd_read(ifu2biu_icb_cmd_read),
		.ifu2biu_icb_cmd_wdata(ifu2biu_icb_cmd_wdata),
		.ifu2biu_icb_cmd_wmask(ifu2biu_icb_cmd_wmask),
		.ifu2biu_icb_cmd_burst(ifu2biu_icb_cmd_burst),
		.ifu2biu_icb_cmd_beat(ifu2biu_icb_cmd_beat),
		.ifu2biu_icb_cmd_lock(ifu2biu_icb_cmd_lock),
		.ifu2biu_icb_cmd_excl(ifu2biu_icb_cmd_excl),
		.ifu2biu_icb_cmd_size(ifu2biu_icb_cmd_size),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid_ref),
		.ifu2biu_icb_rsp_ready(ifu2biu_icb_rsp_ready),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err_ref),
		.ifu2biu_icb_rsp_excl_ok(ifu2biu_icb_rsp_excl_ok_ref),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata_ref),
		.ppi_region_indic(ppi_region_indic),
		.ppi_icb_enable(ppi_icb_enable),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_ref),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_ref),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_ref),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_ref),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_ref),
		.ppi_icb_cmd_burst(ppi_icb_cmd_burst_ref),
		.ppi_icb_cmd_beat(ppi_icb_cmd_beat_ref),
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
		.clint_icb_cmd_burst(clint_icb_cmd_burst_ref),
		.clint_icb_cmd_beat(clint_icb_cmd_beat_ref),
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
		.plic_icb_cmd_burst(plic_icb_cmd_burst_ref),
		.plic_icb_cmd_beat(plic_icb_cmd_beat_ref),
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
		.fio_icb_cmd_burst(fio_icb_cmd_burst_ref),
		.fio_icb_cmd_beat(fio_icb_cmd_beat_ref),
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
		.mem_icb_cmd_burst(mem_icb_cmd_burst_ref),
		.mem_icb_cmd_beat(mem_icb_cmd_beat_ref),
		.mem_icb_cmd_lock(mem_icb_cmd_lock_ref),
		.mem_icb_cmd_excl(mem_icb_cmd_excl_ref),
		.mem_icb_cmd_size(mem_icb_cmd_size_ref),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_ref),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_biu top_module1 (
		.biu_active(biu_active_dut),
		.lsu2biu_icb_cmd_valid(lsu2biu_icb_cmd_valid),
		.lsu2biu_icb_cmd_ready(lsu2biu_icb_cmd_ready_dut),
		.lsu2biu_icb_cmd_addr(lsu2biu_icb_cmd_addr),
		.lsu2biu_icb_cmd_read(lsu2biu_icb_cmd_read),
		.lsu2biu_icb_cmd_wdata(lsu2biu_icb_cmd_wdata),
		.lsu2biu_icb_cmd_wmask(lsu2biu_icb_cmd_wmask),
		.lsu2biu_icb_cmd_burst(lsu2biu_icb_cmd_burst),
		.lsu2biu_icb_cmd_beat(lsu2biu_icb_cmd_beat),
		.lsu2biu_icb_cmd_lock(lsu2biu_icb_cmd_lock),
		.lsu2biu_icb_cmd_excl(lsu2biu_icb_cmd_excl),
		.lsu2biu_icb_cmd_size(lsu2biu_icb_cmd_size),
		.lsu2biu_icb_rsp_valid(lsu2biu_icb_rsp_valid_dut),
		.lsu2biu_icb_rsp_ready(lsu2biu_icb_rsp_ready),
		.lsu2biu_icb_rsp_err(lsu2biu_icb_rsp_err_dut),
		.lsu2biu_icb_rsp_excl_ok(lsu2biu_icb_rsp_excl_ok_dut),
		.lsu2biu_icb_rsp_rdata(lsu2biu_icb_rsp_rdata_dut),
		.ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid),
		.ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready_dut),
		.ifu2biu_icb_cmd_addr(ifu2biu_icb_cmd_addr),
		.ifu2biu_icb_cmd_read(ifu2biu_icb_cmd_read),
		.ifu2biu_icb_cmd_wdata(ifu2biu_icb_cmd_wdata),
		.ifu2biu_icb_cmd_wmask(ifu2biu_icb_cmd_wmask),
		.ifu2biu_icb_cmd_burst(ifu2biu_icb_cmd_burst),
		.ifu2biu_icb_cmd_beat(ifu2biu_icb_cmd_beat),
		.ifu2biu_icb_cmd_lock(ifu2biu_icb_cmd_lock),
		.ifu2biu_icb_cmd_excl(ifu2biu_icb_cmd_excl),
		.ifu2biu_icb_cmd_size(ifu2biu_icb_cmd_size),
		.ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid_dut),
		.ifu2biu_icb_rsp_ready(ifu2biu_icb_rsp_ready),
		.ifu2biu_icb_rsp_err(ifu2biu_icb_rsp_err_dut),
		.ifu2biu_icb_rsp_excl_ok(ifu2biu_icb_rsp_excl_ok_dut),
		.ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata_dut),
		.ppi_region_indic(ppi_region_indic),
		.ppi_icb_enable(ppi_icb_enable),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_dut),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_dut),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_dut),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_dut),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_dut),
		.ppi_icb_cmd_burst(ppi_icb_cmd_burst_dut),
		.ppi_icb_cmd_beat(ppi_icb_cmd_beat_dut),
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
		.clint_icb_cmd_burst(clint_icb_cmd_burst_dut),
		.clint_icb_cmd_beat(clint_icb_cmd_beat_dut),
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
		.plic_icb_cmd_burst(plic_icb_cmd_burst_dut),
		.plic_icb_cmd_beat(plic_icb_cmd_beat_dut),
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
		.fio_icb_cmd_burst(fio_icb_cmd_burst_dut),
		.fio_icb_cmd_beat(fio_icb_cmd_beat_dut),
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
		.mem_icb_cmd_burst(mem_icb_cmd_burst_dut),
		.mem_icb_cmd_beat(mem_icb_cmd_beat_dut),
		.mem_icb_cmd_lock(mem_icb_cmd_lock_dut),
		.mem_icb_cmd_excl(mem_icb_cmd_excl_dut),
		.mem_icb_cmd_size(mem_icb_cmd_size_dut),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_dut),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
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
		if (stats1.errors_biu_active)
			$display("Hint: Output 'biu_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_biu_active, stats1.errortime_biu_active);
		else
			$display("Hint: Output 'biu_active' has no mismatches.");
		if (stats1.errors_lsu2biu_icb_cmd_ready)
			$display("Hint: Output 'lsu2biu_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2biu_icb_cmd_ready, stats1.errortime_lsu2biu_icb_cmd_ready);
		else
			$display("Hint: Output 'lsu2biu_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_lsu2biu_icb_rsp_valid)
			$display("Hint: Output 'lsu2biu_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2biu_icb_rsp_valid, stats1.errortime_lsu2biu_icb_rsp_valid);
		else
			$display("Hint: Output 'lsu2biu_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_lsu2biu_icb_rsp_err)
			$display("Hint: Output 'lsu2biu_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2biu_icb_rsp_err, stats1.errortime_lsu2biu_icb_rsp_err);
		else
			$display("Hint: Output 'lsu2biu_icb_rsp_err' has no mismatches.");
		if (stats1.errors_lsu2biu_icb_rsp_excl_ok)
			$display("Hint: Output 'lsu2biu_icb_rsp_excl_ok' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2biu_icb_rsp_excl_ok, stats1.errortime_lsu2biu_icb_rsp_excl_ok);
		else
			$display("Hint: Output 'lsu2biu_icb_rsp_excl_ok' has no mismatches.");
		if (stats1.errors_lsu2biu_icb_rsp_rdata)
			$display("Hint: Output 'lsu2biu_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2biu_icb_rsp_rdata, stats1.errortime_lsu2biu_icb_rsp_rdata);
		else
			$display("Hint: Output 'lsu2biu_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_cmd_ready)
			$display("Hint: Output 'ifu2biu_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_cmd_ready, stats1.errortime_ifu2biu_icb_cmd_ready);
		else
			$display("Hint: Output 'ifu2biu_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_rsp_valid)
			$display("Hint: Output 'ifu2biu_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_rsp_valid, stats1.errortime_ifu2biu_icb_rsp_valid);
		else
			$display("Hint: Output 'ifu2biu_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_rsp_err)
			$display("Hint: Output 'ifu2biu_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_rsp_err, stats1.errortime_ifu2biu_icb_rsp_err);
		else
			$display("Hint: Output 'ifu2biu_icb_rsp_err' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_rsp_excl_ok)
			$display("Hint: Output 'ifu2biu_icb_rsp_excl_ok' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_rsp_excl_ok, stats1.errortime_ifu2biu_icb_rsp_excl_ok);
		else
			$display("Hint: Output 'ifu2biu_icb_rsp_excl_ok' has no mismatches.");
		if (stats1.errors_ifu2biu_icb_rsp_rdata)
			$display("Hint: Output 'ifu2biu_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2biu_icb_rsp_rdata, stats1.errortime_ifu2biu_icb_rsp_rdata);
		else
			$display("Hint: Output 'ifu2biu_icb_rsp_rdata' has no mismatches.");
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
		if (stats1.errors_ppi_icb_cmd_burst)
			$display("Hint: Output 'ppi_icb_cmd_burst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_burst, stats1.errortime_ppi_icb_cmd_burst);
		else
			$display("Hint: Output 'ppi_icb_cmd_burst' has no mismatches.");
		if (stats1.errors_ppi_icb_cmd_beat)
			$display("Hint: Output 'ppi_icb_cmd_beat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ppi_icb_cmd_beat, stats1.errortime_ppi_icb_cmd_beat);
		else
			$display("Hint: Output 'ppi_icb_cmd_beat' has no mismatches.");
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
		if (stats1.errors_clint_icb_cmd_burst)
			$display("Hint: Output 'clint_icb_cmd_burst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_burst, stats1.errortime_clint_icb_cmd_burst);
		else
			$display("Hint: Output 'clint_icb_cmd_burst' has no mismatches.");
		if (stats1.errors_clint_icb_cmd_beat)
			$display("Hint: Output 'clint_icb_cmd_beat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clint_icb_cmd_beat, stats1.errortime_clint_icb_cmd_beat);
		else
			$display("Hint: Output 'clint_icb_cmd_beat' has no mismatches.");
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
		if (stats1.errors_plic_icb_cmd_burst)
			$display("Hint: Output 'plic_icb_cmd_burst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_burst, stats1.errortime_plic_icb_cmd_burst);
		else
			$display("Hint: Output 'plic_icb_cmd_burst' has no mismatches.");
		if (stats1.errors_plic_icb_cmd_beat)
			$display("Hint: Output 'plic_icb_cmd_beat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_plic_icb_cmd_beat, stats1.errortime_plic_icb_cmd_beat);
		else
			$display("Hint: Output 'plic_icb_cmd_beat' has no mismatches.");
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
		if (stats1.errors_fio_icb_cmd_burst)
			$display("Hint: Output 'fio_icb_cmd_burst' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_burst, stats1.errortime_fio_icb_cmd_burst);
		else
			$display("Hint: Output 'fio_icb_cmd_burst' has no mismatches.");
		if (stats1.errors_fio_icb_cmd_beat)
			$display("Hint: Output 'fio_icb_cmd_beat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_fio_icb_cmd_beat, stats1.errortime_fio_icb_cmd_beat);
		else
			$display("Hint: Output 'fio_icb_cmd_beat' has no mismatches.");
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
		if (stats1.errors_mem_icb_rsp_ready)
			$display("Hint: Output 'mem_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mem_icb_rsp_ready, stats1.errortime_mem_icb_rsp_ready);
		else
			$display("Hint: Output 'mem_icb_rsp_ready' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ biu_active_ref,lsu2biu_icb_cmd_ready_ref,lsu2biu_icb_rsp_valid_ref,lsu2biu_icb_rsp_err_ref,lsu2biu_icb_rsp_excl_ok_ref,lsu2biu_icb_rsp_rdata_ref,ifu2biu_icb_cmd_ready_ref,ifu2biu_icb_rsp_valid_ref,ifu2biu_icb_rsp_err_ref,ifu2biu_icb_rsp_excl_ok_ref,ifu2biu_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_burst_ref,ppi_icb_cmd_beat_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_burst_ref,clint_icb_cmd_beat_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_burst_ref,plic_icb_cmd_beat_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_burst_ref,fio_icb_cmd_beat_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_rsp_ready_ref} ===
			( { biu_active_ref,lsu2biu_icb_cmd_ready_ref,lsu2biu_icb_rsp_valid_ref,lsu2biu_icb_rsp_err_ref,lsu2biu_icb_rsp_excl_ok_ref,lsu2biu_icb_rsp_rdata_ref,ifu2biu_icb_cmd_ready_ref,ifu2biu_icb_rsp_valid_ref,ifu2biu_icb_rsp_err_ref,ifu2biu_icb_rsp_excl_ok_ref,ifu2biu_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_burst_ref,ppi_icb_cmd_beat_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_burst_ref,clint_icb_cmd_beat_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_burst_ref,plic_icb_cmd_beat_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_burst_ref,fio_icb_cmd_beat_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_rsp_ready_ref} ^
			  { biu_active_dut,lsu2biu_icb_cmd_ready_dut,lsu2biu_icb_rsp_valid_dut,lsu2biu_icb_rsp_err_dut,lsu2biu_icb_rsp_excl_ok_dut,lsu2biu_icb_rsp_rdata_dut,ifu2biu_icb_cmd_ready_dut,ifu2biu_icb_rsp_valid_dut,ifu2biu_icb_rsp_err_dut,ifu2biu_icb_rsp_excl_ok_dut,ifu2biu_icb_rsp_rdata_dut,ppi_icb_cmd_valid_dut,ppi_icb_cmd_addr_dut,ppi_icb_cmd_read_dut,ppi_icb_cmd_wdata_dut,ppi_icb_cmd_wmask_dut,ppi_icb_cmd_burst_dut,ppi_icb_cmd_beat_dut,ppi_icb_cmd_lock_dut,ppi_icb_cmd_excl_dut,ppi_icb_cmd_size_dut,ppi_icb_rsp_ready_dut,clint_icb_cmd_valid_dut,clint_icb_cmd_addr_dut,clint_icb_cmd_read_dut,clint_icb_cmd_wdata_dut,clint_icb_cmd_wmask_dut,clint_icb_cmd_burst_dut,clint_icb_cmd_beat_dut,clint_icb_cmd_lock_dut,clint_icb_cmd_excl_dut,clint_icb_cmd_size_dut,clint_icb_rsp_ready_dut,plic_icb_cmd_valid_dut,plic_icb_cmd_addr_dut,plic_icb_cmd_read_dut,plic_icb_cmd_wdata_dut,plic_icb_cmd_wmask_dut,plic_icb_cmd_burst_dut,plic_icb_cmd_beat_dut,plic_icb_cmd_lock_dut,plic_icb_cmd_excl_dut,plic_icb_cmd_size_dut,plic_icb_rsp_ready_dut,fio_icb_cmd_valid_dut,fio_icb_cmd_addr_dut,fio_icb_cmd_read_dut,fio_icb_cmd_wdata_dut,fio_icb_cmd_wmask_dut,fio_icb_cmd_burst_dut,fio_icb_cmd_beat_dut,fio_icb_cmd_lock_dut,fio_icb_cmd_excl_dut,fio_icb_cmd_size_dut,fio_icb_rsp_ready_dut,mem_icb_cmd_valid_dut,mem_icb_cmd_addr_dut,mem_icb_cmd_read_dut,mem_icb_cmd_wdata_dut,mem_icb_cmd_wmask_dut,mem_icb_cmd_burst_dut,mem_icb_cmd_beat_dut,mem_icb_cmd_lock_dut,mem_icb_cmd_excl_dut,mem_icb_cmd_size_dut,mem_icb_rsp_ready_dut} ^
			  { biu_active_ref,lsu2biu_icb_cmd_ready_ref,lsu2biu_icb_rsp_valid_ref,lsu2biu_icb_rsp_err_ref,lsu2biu_icb_rsp_excl_ok_ref,lsu2biu_icb_rsp_rdata_ref,ifu2biu_icb_cmd_ready_ref,ifu2biu_icb_rsp_valid_ref,ifu2biu_icb_rsp_err_ref,ifu2biu_icb_rsp_excl_ok_ref,ifu2biu_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_cmd_burst_ref,ppi_icb_cmd_beat_ref,ppi_icb_cmd_lock_ref,ppi_icb_cmd_excl_ref,ppi_icb_cmd_size_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_cmd_burst_ref,clint_icb_cmd_beat_ref,clint_icb_cmd_lock_ref,clint_icb_cmd_excl_ref,clint_icb_cmd_size_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_cmd_burst_ref,plic_icb_cmd_beat_ref,plic_icb_cmd_lock_ref,plic_icb_cmd_excl_ref,plic_icb_cmd_size_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_cmd_burst_ref,fio_icb_cmd_beat_ref,fio_icb_cmd_lock_ref,fio_icb_cmd_excl_ref,fio_icb_cmd_size_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_cmd_burst_ref,mem_icb_cmd_beat_ref,mem_icb_cmd_lock_ref,mem_icb_cmd_excl_ref,mem_icb_cmd_size_ref,mem_icb_rsp_ready_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (biu_active_ref !== (biu_active_ref ^ biu_active_dut ^ biu_active_ref)) begin
			if (stats1.errors_biu_active == 0) stats1.errortime_biu_active = $time;
			stats1.errors_biu_active++;
		end
		if (lsu2biu_icb_cmd_ready_ref !== (lsu2biu_icb_cmd_ready_ref ^ lsu2biu_icb_cmd_ready_dut ^ lsu2biu_icb_cmd_ready_ref)) begin
			if (stats1.errors_lsu2biu_icb_cmd_ready == 0) stats1.errortime_lsu2biu_icb_cmd_ready = $time;
			stats1.errors_lsu2biu_icb_cmd_ready++;
		end
		if (lsu2biu_icb_rsp_valid_ref !== (lsu2biu_icb_rsp_valid_ref ^ lsu2biu_icb_rsp_valid_dut ^ lsu2biu_icb_rsp_valid_ref)) begin
			if (stats1.errors_lsu2biu_icb_rsp_valid == 0) stats1.errortime_lsu2biu_icb_rsp_valid = $time;
			stats1.errors_lsu2biu_icb_rsp_valid++;
		end
		if (lsu2biu_icb_rsp_err_ref !== (lsu2biu_icb_rsp_err_ref ^ lsu2biu_icb_rsp_err_dut ^ lsu2biu_icb_rsp_err_ref)) begin
			if (stats1.errors_lsu2biu_icb_rsp_err == 0) stats1.errortime_lsu2biu_icb_rsp_err = $time;
			stats1.errors_lsu2biu_icb_rsp_err++;
		end
		if (lsu2biu_icb_rsp_excl_ok_ref !== (lsu2biu_icb_rsp_excl_ok_ref ^ lsu2biu_icb_rsp_excl_ok_dut ^ lsu2biu_icb_rsp_excl_ok_ref)) begin
			if (stats1.errors_lsu2biu_icb_rsp_excl_ok == 0) stats1.errortime_lsu2biu_icb_rsp_excl_ok = $time;
			stats1.errors_lsu2biu_icb_rsp_excl_ok++;
		end
		if (lsu2biu_icb_rsp_rdata_ref !== (lsu2biu_icb_rsp_rdata_ref ^ lsu2biu_icb_rsp_rdata_dut ^ lsu2biu_icb_rsp_rdata_ref)) begin
			if (stats1.errors_lsu2biu_icb_rsp_rdata == 0) stats1.errortime_lsu2biu_icb_rsp_rdata = $time;
			stats1.errors_lsu2biu_icb_rsp_rdata++;
		end
		if (ifu2biu_icb_cmd_ready_ref !== (ifu2biu_icb_cmd_ready_ref ^ ifu2biu_icb_cmd_ready_dut ^ ifu2biu_icb_cmd_ready_ref)) begin
			if (stats1.errors_ifu2biu_icb_cmd_ready == 0) stats1.errortime_ifu2biu_icb_cmd_ready = $time;
			stats1.errors_ifu2biu_icb_cmd_ready++;
		end
		if (ifu2biu_icb_rsp_valid_ref !== (ifu2biu_icb_rsp_valid_ref ^ ifu2biu_icb_rsp_valid_dut ^ ifu2biu_icb_rsp_valid_ref)) begin
			if (stats1.errors_ifu2biu_icb_rsp_valid == 0) stats1.errortime_ifu2biu_icb_rsp_valid = $time;
			stats1.errors_ifu2biu_icb_rsp_valid++;
		end
		if (ifu2biu_icb_rsp_err_ref !== (ifu2biu_icb_rsp_err_ref ^ ifu2biu_icb_rsp_err_dut ^ ifu2biu_icb_rsp_err_ref)) begin
			if (stats1.errors_ifu2biu_icb_rsp_err == 0) stats1.errortime_ifu2biu_icb_rsp_err = $time;
			stats1.errors_ifu2biu_icb_rsp_err++;
		end
		if (ifu2biu_icb_rsp_excl_ok_ref !== (ifu2biu_icb_rsp_excl_ok_ref ^ ifu2biu_icb_rsp_excl_ok_dut ^ ifu2biu_icb_rsp_excl_ok_ref)) begin
			if (stats1.errors_ifu2biu_icb_rsp_excl_ok == 0) stats1.errortime_ifu2biu_icb_rsp_excl_ok = $time;
			stats1.errors_ifu2biu_icb_rsp_excl_ok++;
		end
		if (ifu2biu_icb_rsp_rdata_ref !== (ifu2biu_icb_rsp_rdata_ref ^ ifu2biu_icb_rsp_rdata_dut ^ ifu2biu_icb_rsp_rdata_ref)) begin
			if (stats1.errors_ifu2biu_icb_rsp_rdata == 0) stats1.errortime_ifu2biu_icb_rsp_rdata = $time;
			stats1.errors_ifu2biu_icb_rsp_rdata++;
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
		if (ppi_icb_cmd_burst_ref !== (ppi_icb_cmd_burst_ref ^ ppi_icb_cmd_burst_dut ^ ppi_icb_cmd_burst_ref)) begin
			if (stats1.errors_ppi_icb_cmd_burst == 0) stats1.errortime_ppi_icb_cmd_burst = $time;
			stats1.errors_ppi_icb_cmd_burst++;
		end
		if (ppi_icb_cmd_beat_ref !== (ppi_icb_cmd_beat_ref ^ ppi_icb_cmd_beat_dut ^ ppi_icb_cmd_beat_ref)) begin
			if (stats1.errors_ppi_icb_cmd_beat == 0) stats1.errortime_ppi_icb_cmd_beat = $time;
			stats1.errors_ppi_icb_cmd_beat++;
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
		if (clint_icb_cmd_burst_ref !== (clint_icb_cmd_burst_ref ^ clint_icb_cmd_burst_dut ^ clint_icb_cmd_burst_ref)) begin
			if (stats1.errors_clint_icb_cmd_burst == 0) stats1.errortime_clint_icb_cmd_burst = $time;
			stats1.errors_clint_icb_cmd_burst++;
		end
		if (clint_icb_cmd_beat_ref !== (clint_icb_cmd_beat_ref ^ clint_icb_cmd_beat_dut ^ clint_icb_cmd_beat_ref)) begin
			if (stats1.errors_clint_icb_cmd_beat == 0) stats1.errortime_clint_icb_cmd_beat = $time;
			stats1.errors_clint_icb_cmd_beat++;
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
		if (plic_icb_cmd_burst_ref !== (plic_icb_cmd_burst_ref ^ plic_icb_cmd_burst_dut ^ plic_icb_cmd_burst_ref)) begin
			if (stats1.errors_plic_icb_cmd_burst == 0) stats1.errortime_plic_icb_cmd_burst = $time;
			stats1.errors_plic_icb_cmd_burst++;
		end
		if (plic_icb_cmd_beat_ref !== (plic_icb_cmd_beat_ref ^ plic_icb_cmd_beat_dut ^ plic_icb_cmd_beat_ref)) begin
			if (stats1.errors_plic_icb_cmd_beat == 0) stats1.errortime_plic_icb_cmd_beat = $time;
			stats1.errors_plic_icb_cmd_beat++;
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
		if (fio_icb_cmd_burst_ref !== (fio_icb_cmd_burst_ref ^ fio_icb_cmd_burst_dut ^ fio_icb_cmd_burst_ref)) begin
			if (stats1.errors_fio_icb_cmd_burst == 0) stats1.errortime_fio_icb_cmd_burst = $time;
			stats1.errors_fio_icb_cmd_burst++;
		end
		if (fio_icb_cmd_beat_ref !== (fio_icb_cmd_beat_ref ^ fio_icb_cmd_beat_dut ^ fio_icb_cmd_beat_ref)) begin
			if (stats1.errors_fio_icb_cmd_beat == 0) stats1.errortime_fio_icb_cmd_beat = $time;
			stats1.errors_fio_icb_cmd_beat++;
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
		if (mem_icb_cmd_burst_ref !== (mem_icb_cmd_burst_ref ^ mem_icb_cmd_burst_dut ^ mem_icb_cmd_burst_ref)) begin
			if (stats1.errors_mem_icb_cmd_burst == 0) stats1.errortime_mem_icb_cmd_burst = $time;
			stats1.errors_mem_icb_cmd_burst++;
		end
		if (mem_icb_cmd_beat_ref !== (mem_icb_cmd_beat_ref ^ mem_icb_cmd_beat_dut ^ mem_icb_cmd_beat_ref)) begin
			if (stats1.errors_mem_icb_cmd_beat == 0) stats1.errortime_mem_icb_cmd_beat = $time;
			stats1.errors_mem_icb_cmd_beat++;
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
		if (mem_icb_rsp_ready_ref !== (mem_icb_rsp_ready_ref ^ mem_icb_rsp_ready_dut ^ mem_icb_rsp_ready_ref)) begin
			if (stats1.errors_mem_icb_rsp_ready == 0) stats1.errortime_mem_icb_rsp_ready = $time;
			stats1.errors_mem_icb_rsp_ready++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
