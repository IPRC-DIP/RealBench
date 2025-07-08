`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_inspect_pc;
		int errortime_inspect_pc;
		int errors_inspect_dbg_irq;
		int errortime_inspect_dbg_irq;
		int errors_inspect_mem_cmd_valid;
		int errortime_inspect_mem_cmd_valid;
		int errors_inspect_mem_cmd_ready;
		int errortime_inspect_mem_cmd_ready;
		int errors_inspect_mem_rsp_valid;
		int errortime_inspect_mem_rsp_valid;
		int errors_inspect_mem_rsp_ready;
		int errortime_inspect_mem_rsp_ready;
		int errors_inspect_core_clk;
		int errortime_inspect_core_clk;
		int errors_core_csr_clk;
		int errortime_core_csr_clk;
		int errors_core_wfi;
		int errortime_core_wfi;
		int errors_tm_stop;
		int errortime_tm_stop;
		int errors_dbg_irq_r;
		int errortime_dbg_irq_r;
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
		int errors_ext2itcm_icb_cmd_ready;
		int errortime_ext2itcm_icb_cmd_ready;
		int errors_ext2itcm_icb_rsp_valid;
		int errortime_ext2itcm_icb_rsp_valid;
		int errors_ext2itcm_icb_rsp_err;
		int errortime_ext2itcm_icb_rsp_err;
		int errors_ext2itcm_icb_rsp_rdata;
		int errortime_ext2itcm_icb_rsp_rdata;
		int errors_ext2dtcm_icb_cmd_ready;
		int errortime_ext2dtcm_icb_cmd_ready;
		int errors_ext2dtcm_icb_rsp_valid;
		int errortime_ext2dtcm_icb_rsp_valid;
		int errors_ext2dtcm_icb_rsp_err;
		int errortime_ext2dtcm_icb_rsp_err;
		int errors_ext2dtcm_icb_rsp_rdata;
		int errortime_ext2dtcm_icb_rsp_rdata;
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
		int errors_mem_icb_rsp_ready;
		int errortime_mem_icb_rsp_ready;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [32-1:0] inspect_pc_ref;
	logic [32-1:0] inspect_pc_dut;
	logic inspect_dbg_irq_ref;
	logic inspect_dbg_irq_dut;
	logic inspect_mem_cmd_valid_ref;
	logic inspect_mem_cmd_valid_dut;
	logic inspect_mem_cmd_ready_ref;
	logic inspect_mem_cmd_ready_dut;
	logic inspect_mem_rsp_valid_ref;
	logic inspect_mem_rsp_valid_dut;
	logic inspect_mem_rsp_ready_ref;
	logic inspect_mem_rsp_ready_dut;
	logic inspect_core_clk_ref;
	logic inspect_core_clk_dut;
	logic core_csr_clk_ref;
	logic core_csr_clk_dut;
	logic core_wfi_ref;
	logic core_wfi_dut;
	logic tm_stop_ref;
	logic tm_stop_dut;
	logic [32-1:0] pc_rtvec;
	logic dbg_irq_r_ref;
	logic dbg_irq_r_dut;
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
	logic dbg_irq_a;
	logic core_mhartid;
	logic ext_irq_a;
	logic sft_irq_a;
	logic tmr_irq_a;
	logic tcm_sd;
	logic tcm_ds;
	logic ext2itcm_icb_cmd_valid;
	logic ext2itcm_icb_cmd_ready_ref;
	logic ext2itcm_icb_cmd_ready_dut;
	logic [16-1:0] ext2itcm_icb_cmd_addr;
	logic ext2itcm_icb_cmd_read;
	logic [32-1:0] ext2itcm_icb_cmd_wdata;
	logic [4-1:0] ext2itcm_icb_cmd_wmask;
	logic ext2itcm_icb_rsp_valid_ref;
	logic ext2itcm_icb_rsp_valid_dut;
	logic ext2itcm_icb_rsp_ready;
	logic ext2itcm_icb_rsp_err_ref;
	logic ext2itcm_icb_rsp_err_dut;
	logic [32-1:0] ext2itcm_icb_rsp_rdata_ref;
	logic [32-1:0] ext2itcm_icb_rsp_rdata_dut;
	logic ext2dtcm_icb_cmd_valid;
	logic ext2dtcm_icb_cmd_ready_ref;
	logic ext2dtcm_icb_cmd_ready_dut;
	logic [16-1:0] ext2dtcm_icb_cmd_addr;
	logic ext2dtcm_icb_cmd_read;
	logic [32-1:0] ext2dtcm_icb_cmd_wdata;
	logic [4-1:0] ext2dtcm_icb_cmd_wmask;
	logic ext2dtcm_icb_rsp_valid_ref;
	logic ext2dtcm_icb_rsp_valid_dut;
	logic ext2dtcm_icb_rsp_ready;
	logic ext2dtcm_icb_rsp_err_ref;
	logic ext2dtcm_icb_rsp_err_dut;
	logic [32-1:0] ext2dtcm_icb_rsp_rdata_ref;
	logic [32-1:0] ext2dtcm_icb_rsp_rdata_dut;
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
	logic ppi_icb_rsp_valid;
	logic ppi_icb_rsp_ready_ref;
	logic ppi_icb_rsp_ready_dut;
	logic ppi_icb_rsp_err;
	logic [32-1:0] ppi_icb_rsp_rdata;
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
	logic clint_icb_rsp_valid;
	logic clint_icb_rsp_ready_ref;
	logic clint_icb_rsp_ready_dut;
	logic clint_icb_rsp_err;
	logic [32-1:0] clint_icb_rsp_rdata;
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
	logic plic_icb_rsp_valid;
	logic plic_icb_rsp_ready_ref;
	logic plic_icb_rsp_ready_dut;
	logic plic_icb_rsp_err;
	logic [32-1:0] plic_icb_rsp_rdata;
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
	logic fio_icb_rsp_valid;
	logic fio_icb_rsp_ready_ref;
	logic fio_icb_rsp_ready_dut;
	logic fio_icb_rsp_err;
	logic [32-1:0] fio_icb_rsp_rdata;
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
	logic mem_icb_rsp_valid;
	logic mem_icb_rsp_ready_ref;
	logic mem_icb_rsp_ready_dut;
	logic mem_icb_rsp_err;
	logic [32-1:0] mem_icb_rsp_rdata;
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
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.dbg_mode(dbg_mode),
		.dbg_halt_r(dbg_halt_r),
		.dbg_step_r(dbg_step_r),
		.dbg_ebreakm_r(dbg_ebreakm_r),
		.dbg_stopcycle(dbg_stopcycle),
		.dbg_irq_a(dbg_irq_a),
		.core_mhartid(core_mhartid),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.tcm_sd(tcm_sd),
		.tcm_ds(tcm_ds),
		.ext2itcm_icb_cmd_valid(ext2itcm_icb_cmd_valid),
		.ext2itcm_icb_cmd_addr(ext2itcm_icb_cmd_addr),
		.ext2itcm_icb_cmd_read(ext2itcm_icb_cmd_read),
		.ext2itcm_icb_cmd_wdata(ext2itcm_icb_cmd_wdata),
		.ext2itcm_icb_cmd_wmask(ext2itcm_icb_cmd_wmask),
		.ext2itcm_icb_rsp_ready(ext2itcm_icb_rsp_ready),
		.ext2dtcm_icb_cmd_valid(ext2dtcm_icb_cmd_valid),
		.ext2dtcm_icb_cmd_addr(ext2dtcm_icb_cmd_addr),
		.ext2dtcm_icb_cmd_read(ext2dtcm_icb_cmd_read),
		.ext2dtcm_icb_cmd_wdata(ext2dtcm_icb_cmd_wdata),
		.ext2dtcm_icb_cmd_wmask(ext2dtcm_icb_cmd_wmask),
		.ext2dtcm_icb_rsp_ready(ext2dtcm_icb_rsp_ready),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_cpu_top good1 (
		.inspect_pc(inspect_pc_ref),
		.inspect_dbg_irq(inspect_dbg_irq_ref),
		.inspect_mem_cmd_valid(inspect_mem_cmd_valid_ref),
		.inspect_mem_cmd_ready(inspect_mem_cmd_ready_ref),
		.inspect_mem_rsp_valid(inspect_mem_rsp_valid_ref),
		.inspect_mem_rsp_ready(inspect_mem_rsp_ready_ref),
		.inspect_core_clk(inspect_core_clk_ref),
		.core_csr_clk(core_csr_clk_ref),
		.core_wfi(core_wfi_ref),
		.tm_stop(tm_stop_ref),
		.pc_rtvec(pc_rtvec),
		.dbg_irq_r(dbg_irq_r_ref),
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
		.dbg_irq_a(dbg_irq_a),
		.core_mhartid(core_mhartid),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.tcm_sd(tcm_sd),
		.tcm_ds(tcm_ds),
		.ext2itcm_icb_cmd_valid(ext2itcm_icb_cmd_valid),
		.ext2itcm_icb_cmd_ready(ext2itcm_icb_cmd_ready_ref),
		.ext2itcm_icb_cmd_addr(ext2itcm_icb_cmd_addr),
		.ext2itcm_icb_cmd_read(ext2itcm_icb_cmd_read),
		.ext2itcm_icb_cmd_wdata(ext2itcm_icb_cmd_wdata),
		.ext2itcm_icb_cmd_wmask(ext2itcm_icb_cmd_wmask),
		.ext2itcm_icb_rsp_valid(ext2itcm_icb_rsp_valid_ref),
		.ext2itcm_icb_rsp_ready(ext2itcm_icb_rsp_ready),
		.ext2itcm_icb_rsp_err(ext2itcm_icb_rsp_err_ref),
		.ext2itcm_icb_rsp_rdata(ext2itcm_icb_rsp_rdata_ref),
		.ext2dtcm_icb_cmd_valid(ext2dtcm_icb_cmd_valid),
		.ext2dtcm_icb_cmd_ready(ext2dtcm_icb_cmd_ready_ref),
		.ext2dtcm_icb_cmd_addr(ext2dtcm_icb_cmd_addr),
		.ext2dtcm_icb_cmd_read(ext2dtcm_icb_cmd_read),
		.ext2dtcm_icb_cmd_wdata(ext2dtcm_icb_cmd_wdata),
		.ext2dtcm_icb_cmd_wmask(ext2dtcm_icb_cmd_wmask),
		.ext2dtcm_icb_rsp_valid(ext2dtcm_icb_rsp_valid_ref),
		.ext2dtcm_icb_rsp_ready(ext2dtcm_icb_rsp_ready),
		.ext2dtcm_icb_rsp_err(ext2dtcm_icb_rsp_err_ref),
		.ext2dtcm_icb_rsp_rdata(ext2dtcm_icb_rsp_rdata_ref),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_ref),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_ref),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_ref),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_ref),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_ref),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_ready(ppi_icb_rsp_ready_ref),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_icb_cmd_valid(clint_icb_cmd_valid_ref),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_cmd_addr(clint_icb_cmd_addr_ref),
		.clint_icb_cmd_read(clint_icb_cmd_read_ref),
		.clint_icb_cmd_wdata(clint_icb_cmd_wdata_ref),
		.clint_icb_cmd_wmask(clint_icb_cmd_wmask_ref),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_ready(clint_icb_rsp_ready_ref),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_icb_cmd_valid(plic_icb_cmd_valid_ref),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_cmd_addr(plic_icb_cmd_addr_ref),
		.plic_icb_cmd_read(plic_icb_cmd_read_ref),
		.plic_icb_cmd_wdata(plic_icb_cmd_wdata_ref),
		.plic_icb_cmd_wmask(plic_icb_cmd_wmask_ref),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_ready(plic_icb_rsp_ready_ref),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_icb_cmd_valid(fio_icb_cmd_valid_ref),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_cmd_addr(fio_icb_cmd_addr_ref),
		.fio_icb_cmd_read(fio_icb_cmd_read_ref),
		.fio_icb_cmd_wdata(fio_icb_cmd_wdata_ref),
		.fio_icb_cmd_wmask(fio_icb_cmd_wmask_ref),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_ready(fio_icb_rsp_ready_ref),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_cmd_valid(mem_icb_cmd_valid_ref),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_cmd_addr(mem_icb_cmd_addr_ref),
		.mem_icb_cmd_read(mem_icb_cmd_read_ref),
		.mem_icb_cmd_wdata(mem_icb_cmd_wdata_ref),
		.mem_icb_cmd_wmask(mem_icb_cmd_wmask_ref),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_ref),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_cpu_top top_module1 (
		.inspect_pc(inspect_pc_dut),
		.inspect_dbg_irq(inspect_dbg_irq_dut),
		.inspect_mem_cmd_valid(inspect_mem_cmd_valid_dut),
		.inspect_mem_cmd_ready(inspect_mem_cmd_ready_dut),
		.inspect_mem_rsp_valid(inspect_mem_rsp_valid_dut),
		.inspect_mem_rsp_ready(inspect_mem_rsp_ready_dut),
		.inspect_core_clk(inspect_core_clk_dut),
		.core_csr_clk(core_csr_clk_dut),
		.core_wfi(core_wfi_dut),
		.tm_stop(tm_stop_dut),
		.pc_rtvec(pc_rtvec),
		.dbg_irq_r(dbg_irq_r_dut),
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
		.dbg_irq_a(dbg_irq_a),
		.core_mhartid(core_mhartid),
		.ext_irq_a(ext_irq_a),
		.sft_irq_a(sft_irq_a),
		.tmr_irq_a(tmr_irq_a),
		.tcm_sd(tcm_sd),
		.tcm_ds(tcm_ds),
		.ext2itcm_icb_cmd_valid(ext2itcm_icb_cmd_valid),
		.ext2itcm_icb_cmd_ready(ext2itcm_icb_cmd_ready_dut),
		.ext2itcm_icb_cmd_addr(ext2itcm_icb_cmd_addr),
		.ext2itcm_icb_cmd_read(ext2itcm_icb_cmd_read),
		.ext2itcm_icb_cmd_wdata(ext2itcm_icb_cmd_wdata),
		.ext2itcm_icb_cmd_wmask(ext2itcm_icb_cmd_wmask),
		.ext2itcm_icb_rsp_valid(ext2itcm_icb_rsp_valid_dut),
		.ext2itcm_icb_rsp_ready(ext2itcm_icb_rsp_ready),
		.ext2itcm_icb_rsp_err(ext2itcm_icb_rsp_err_dut),
		.ext2itcm_icb_rsp_rdata(ext2itcm_icb_rsp_rdata_dut),
		.ext2dtcm_icb_cmd_valid(ext2dtcm_icb_cmd_valid),
		.ext2dtcm_icb_cmd_ready(ext2dtcm_icb_cmd_ready_dut),
		.ext2dtcm_icb_cmd_addr(ext2dtcm_icb_cmd_addr),
		.ext2dtcm_icb_cmd_read(ext2dtcm_icb_cmd_read),
		.ext2dtcm_icb_cmd_wdata(ext2dtcm_icb_cmd_wdata),
		.ext2dtcm_icb_cmd_wmask(ext2dtcm_icb_cmd_wmask),
		.ext2dtcm_icb_rsp_valid(ext2dtcm_icb_rsp_valid_dut),
		.ext2dtcm_icb_rsp_ready(ext2dtcm_icb_rsp_ready),
		.ext2dtcm_icb_rsp_err(ext2dtcm_icb_rsp_err_dut),
		.ext2dtcm_icb_rsp_rdata(ext2dtcm_icb_rsp_rdata_dut),
		.ppi_icb_cmd_valid(ppi_icb_cmd_valid_dut),
		.ppi_icb_cmd_ready(ppi_icb_cmd_ready),
		.ppi_icb_cmd_addr(ppi_icb_cmd_addr_dut),
		.ppi_icb_cmd_read(ppi_icb_cmd_read_dut),
		.ppi_icb_cmd_wdata(ppi_icb_cmd_wdata_dut),
		.ppi_icb_cmd_wmask(ppi_icb_cmd_wmask_dut),
		.ppi_icb_rsp_valid(ppi_icb_rsp_valid),
		.ppi_icb_rsp_ready(ppi_icb_rsp_ready_dut),
		.ppi_icb_rsp_err(ppi_icb_rsp_err),
		.ppi_icb_rsp_rdata(ppi_icb_rsp_rdata),
		.clint_icb_cmd_valid(clint_icb_cmd_valid_dut),
		.clint_icb_cmd_ready(clint_icb_cmd_ready),
		.clint_icb_cmd_addr(clint_icb_cmd_addr_dut),
		.clint_icb_cmd_read(clint_icb_cmd_read_dut),
		.clint_icb_cmd_wdata(clint_icb_cmd_wdata_dut),
		.clint_icb_cmd_wmask(clint_icb_cmd_wmask_dut),
		.clint_icb_rsp_valid(clint_icb_rsp_valid),
		.clint_icb_rsp_ready(clint_icb_rsp_ready_dut),
		.clint_icb_rsp_err(clint_icb_rsp_err),
		.clint_icb_rsp_rdata(clint_icb_rsp_rdata),
		.plic_icb_cmd_valid(plic_icb_cmd_valid_dut),
		.plic_icb_cmd_ready(plic_icb_cmd_ready),
		.plic_icb_cmd_addr(plic_icb_cmd_addr_dut),
		.plic_icb_cmd_read(plic_icb_cmd_read_dut),
		.plic_icb_cmd_wdata(plic_icb_cmd_wdata_dut),
		.plic_icb_cmd_wmask(plic_icb_cmd_wmask_dut),
		.plic_icb_rsp_valid(plic_icb_rsp_valid),
		.plic_icb_rsp_ready(plic_icb_rsp_ready_dut),
		.plic_icb_rsp_err(plic_icb_rsp_err),
		.plic_icb_rsp_rdata(plic_icb_rsp_rdata),
		.fio_icb_cmd_valid(fio_icb_cmd_valid_dut),
		.fio_icb_cmd_ready(fio_icb_cmd_ready),
		.fio_icb_cmd_addr(fio_icb_cmd_addr_dut),
		.fio_icb_cmd_read(fio_icb_cmd_read_dut),
		.fio_icb_cmd_wdata(fio_icb_cmd_wdata_dut),
		.fio_icb_cmd_wmask(fio_icb_cmd_wmask_dut),
		.fio_icb_rsp_valid(fio_icb_rsp_valid),
		.fio_icb_rsp_ready(fio_icb_rsp_ready_dut),
		.fio_icb_rsp_err(fio_icb_rsp_err),
		.fio_icb_rsp_rdata(fio_icb_rsp_rdata),
		.mem_icb_cmd_valid(mem_icb_cmd_valid_dut),
		.mem_icb_cmd_ready(mem_icb_cmd_ready),
		.mem_icb_cmd_addr(mem_icb_cmd_addr_dut),
		.mem_icb_cmd_read(mem_icb_cmd_read_dut),
		.mem_icb_cmd_wdata(mem_icb_cmd_wdata_dut),
		.mem_icb_cmd_wmask(mem_icb_cmd_wmask_dut),
		.mem_icb_rsp_valid(mem_icb_rsp_valid),
		.mem_icb_rsp_ready(mem_icb_rsp_ready_dut),
		.mem_icb_rsp_err(mem_icb_rsp_err),
		.mem_icb_rsp_rdata(mem_icb_rsp_rdata),
		.test_mode(test_mode),
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
		if (stats1.errors_inspect_dbg_irq)
			$display("Hint: Output 'inspect_dbg_irq' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_dbg_irq, stats1.errortime_inspect_dbg_irq);
		else
			$display("Hint: Output 'inspect_dbg_irq' has no mismatches.");
		if (stats1.errors_inspect_mem_cmd_valid)
			$display("Hint: Output 'inspect_mem_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_mem_cmd_valid, stats1.errortime_inspect_mem_cmd_valid);
		else
			$display("Hint: Output 'inspect_mem_cmd_valid' has no mismatches.");
		if (stats1.errors_inspect_mem_cmd_ready)
			$display("Hint: Output 'inspect_mem_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_mem_cmd_ready, stats1.errortime_inspect_mem_cmd_ready);
		else
			$display("Hint: Output 'inspect_mem_cmd_ready' has no mismatches.");
		if (stats1.errors_inspect_mem_rsp_valid)
			$display("Hint: Output 'inspect_mem_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_mem_rsp_valid, stats1.errortime_inspect_mem_rsp_valid);
		else
			$display("Hint: Output 'inspect_mem_rsp_valid' has no mismatches.");
		if (stats1.errors_inspect_mem_rsp_ready)
			$display("Hint: Output 'inspect_mem_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_mem_rsp_ready, stats1.errortime_inspect_mem_rsp_ready);
		else
			$display("Hint: Output 'inspect_mem_rsp_ready' has no mismatches.");
		if (stats1.errors_inspect_core_clk)
			$display("Hint: Output 'inspect_core_clk' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_inspect_core_clk, stats1.errortime_inspect_core_clk);
		else
			$display("Hint: Output 'inspect_core_clk' has no mismatches.");
		if (stats1.errors_core_csr_clk)
			$display("Hint: Output 'core_csr_clk' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_core_csr_clk, stats1.errortime_core_csr_clk);
		else
			$display("Hint: Output 'core_csr_clk' has no mismatches.");
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
		if (stats1.errors_dbg_irq_r)
			$display("Hint: Output 'dbg_irq_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dbg_irq_r, stats1.errortime_dbg_irq_r);
		else
			$display("Hint: Output 'dbg_irq_r' has no mismatches.");
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
		if (stats1.errors_ext2itcm_icb_cmd_ready)
			$display("Hint: Output 'ext2itcm_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2itcm_icb_cmd_ready, stats1.errortime_ext2itcm_icb_cmd_ready);
		else
			$display("Hint: Output 'ext2itcm_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_ext2itcm_icb_rsp_valid)
			$display("Hint: Output 'ext2itcm_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2itcm_icb_rsp_valid, stats1.errortime_ext2itcm_icb_rsp_valid);
		else
			$display("Hint: Output 'ext2itcm_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_ext2itcm_icb_rsp_err)
			$display("Hint: Output 'ext2itcm_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2itcm_icb_rsp_err, stats1.errortime_ext2itcm_icb_rsp_err);
		else
			$display("Hint: Output 'ext2itcm_icb_rsp_err' has no mismatches.");
		if (stats1.errors_ext2itcm_icb_rsp_rdata)
			$display("Hint: Output 'ext2itcm_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2itcm_icb_rsp_rdata, stats1.errortime_ext2itcm_icb_rsp_rdata);
		else
			$display("Hint: Output 'ext2itcm_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_ext2dtcm_icb_cmd_ready)
			$display("Hint: Output 'ext2dtcm_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2dtcm_icb_cmd_ready, stats1.errortime_ext2dtcm_icb_cmd_ready);
		else
			$display("Hint: Output 'ext2dtcm_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_ext2dtcm_icb_rsp_valid)
			$display("Hint: Output 'ext2dtcm_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2dtcm_icb_rsp_valid, stats1.errortime_ext2dtcm_icb_rsp_valid);
		else
			$display("Hint: Output 'ext2dtcm_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_ext2dtcm_icb_rsp_err)
			$display("Hint: Output 'ext2dtcm_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2dtcm_icb_rsp_err, stats1.errortime_ext2dtcm_icb_rsp_err);
		else
			$display("Hint: Output 'ext2dtcm_icb_rsp_err' has no mismatches.");
		if (stats1.errors_ext2dtcm_icb_rsp_rdata)
			$display("Hint: Output 'ext2dtcm_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ext2dtcm_icb_rsp_rdata, stats1.errortime_ext2dtcm_icb_rsp_rdata);
		else
			$display("Hint: Output 'ext2dtcm_icb_rsp_rdata' has no mismatches.");
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
		{ inspect_pc_ref,inspect_dbg_irq_ref,inspect_mem_cmd_valid_ref,inspect_mem_cmd_ready_ref,inspect_mem_rsp_valid_ref,inspect_mem_rsp_ready_ref,inspect_core_clk_ref,core_csr_clk_ref,core_wfi_ref,tm_stop_ref,dbg_irq_r_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_rsp_ready_ref} ===
			( { inspect_pc_ref,inspect_dbg_irq_ref,inspect_mem_cmd_valid_ref,inspect_mem_cmd_ready_ref,inspect_mem_rsp_valid_ref,inspect_mem_rsp_ready_ref,inspect_core_clk_ref,core_csr_clk_ref,core_wfi_ref,tm_stop_ref,dbg_irq_r_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_rsp_ready_ref} ^
			  { inspect_pc_dut,inspect_dbg_irq_dut,inspect_mem_cmd_valid_dut,inspect_mem_cmd_ready_dut,inspect_mem_rsp_valid_dut,inspect_mem_rsp_ready_dut,inspect_core_clk_dut,core_csr_clk_dut,core_wfi_dut,tm_stop_dut,dbg_irq_r_dut,cmt_dpc_dut,cmt_dpc_ena_dut,cmt_dcause_dut,cmt_dcause_ena_dut,wr_dcsr_ena_dut,wr_dpc_ena_dut,wr_dscratch_ena_dut,wr_csr_nxt_dut,ext2itcm_icb_cmd_ready_dut,ext2itcm_icb_rsp_valid_dut,ext2itcm_icb_rsp_err_dut,ext2itcm_icb_rsp_rdata_dut,ext2dtcm_icb_cmd_ready_dut,ext2dtcm_icb_rsp_valid_dut,ext2dtcm_icb_rsp_err_dut,ext2dtcm_icb_rsp_rdata_dut,ppi_icb_cmd_valid_dut,ppi_icb_cmd_addr_dut,ppi_icb_cmd_read_dut,ppi_icb_cmd_wdata_dut,ppi_icb_cmd_wmask_dut,ppi_icb_rsp_ready_dut,clint_icb_cmd_valid_dut,clint_icb_cmd_addr_dut,clint_icb_cmd_read_dut,clint_icb_cmd_wdata_dut,clint_icb_cmd_wmask_dut,clint_icb_rsp_ready_dut,plic_icb_cmd_valid_dut,plic_icb_cmd_addr_dut,plic_icb_cmd_read_dut,plic_icb_cmd_wdata_dut,plic_icb_cmd_wmask_dut,plic_icb_rsp_ready_dut,fio_icb_cmd_valid_dut,fio_icb_cmd_addr_dut,fio_icb_cmd_read_dut,fio_icb_cmd_wdata_dut,fio_icb_cmd_wmask_dut,fio_icb_rsp_ready_dut,mem_icb_cmd_valid_dut,mem_icb_cmd_addr_dut,mem_icb_cmd_read_dut,mem_icb_cmd_wdata_dut,mem_icb_cmd_wmask_dut,mem_icb_rsp_ready_dut} ^
			  { inspect_pc_ref,inspect_dbg_irq_ref,inspect_mem_cmd_valid_ref,inspect_mem_cmd_ready_ref,inspect_mem_rsp_valid_ref,inspect_mem_rsp_ready_ref,inspect_core_clk_ref,core_csr_clk_ref,core_wfi_ref,tm_stop_ref,dbg_irq_r_ref,cmt_dpc_ref,cmt_dpc_ena_ref,cmt_dcause_ref,cmt_dcause_ena_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,ppi_icb_cmd_valid_ref,ppi_icb_cmd_addr_ref,ppi_icb_cmd_read_ref,ppi_icb_cmd_wdata_ref,ppi_icb_cmd_wmask_ref,ppi_icb_rsp_ready_ref,clint_icb_cmd_valid_ref,clint_icb_cmd_addr_ref,clint_icb_cmd_read_ref,clint_icb_cmd_wdata_ref,clint_icb_cmd_wmask_ref,clint_icb_rsp_ready_ref,plic_icb_cmd_valid_ref,plic_icb_cmd_addr_ref,plic_icb_cmd_read_ref,plic_icb_cmd_wdata_ref,plic_icb_cmd_wmask_ref,plic_icb_rsp_ready_ref,fio_icb_cmd_valid_ref,fio_icb_cmd_addr_ref,fio_icb_cmd_read_ref,fio_icb_cmd_wdata_ref,fio_icb_cmd_wmask_ref,fio_icb_rsp_ready_ref,mem_icb_cmd_valid_ref,mem_icb_cmd_addr_ref,mem_icb_cmd_read_ref,mem_icb_cmd_wdata_ref,mem_icb_cmd_wmask_ref,mem_icb_rsp_ready_ref} );

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
		if (inspect_dbg_irq_ref !== (inspect_dbg_irq_ref ^ inspect_dbg_irq_dut ^ inspect_dbg_irq_ref)) begin
			if (stats1.errors_inspect_dbg_irq == 0) stats1.errortime_inspect_dbg_irq = $time;
			stats1.errors_inspect_dbg_irq++;
		end
		if (inspect_mem_cmd_valid_ref !== (inspect_mem_cmd_valid_ref ^ inspect_mem_cmd_valid_dut ^ inspect_mem_cmd_valid_ref)) begin
			if (stats1.errors_inspect_mem_cmd_valid == 0) stats1.errortime_inspect_mem_cmd_valid = $time;
			stats1.errors_inspect_mem_cmd_valid++;
		end
		if (inspect_mem_cmd_ready_ref !== (inspect_mem_cmd_ready_ref ^ inspect_mem_cmd_ready_dut ^ inspect_mem_cmd_ready_ref)) begin
			if (stats1.errors_inspect_mem_cmd_ready == 0) stats1.errortime_inspect_mem_cmd_ready = $time;
			stats1.errors_inspect_mem_cmd_ready++;
		end
		if (inspect_mem_rsp_valid_ref !== (inspect_mem_rsp_valid_ref ^ inspect_mem_rsp_valid_dut ^ inspect_mem_rsp_valid_ref)) begin
			if (stats1.errors_inspect_mem_rsp_valid == 0) stats1.errortime_inspect_mem_rsp_valid = $time;
			stats1.errors_inspect_mem_rsp_valid++;
		end
		if (inspect_mem_rsp_ready_ref !== (inspect_mem_rsp_ready_ref ^ inspect_mem_rsp_ready_dut ^ inspect_mem_rsp_ready_ref)) begin
			if (stats1.errors_inspect_mem_rsp_ready == 0) stats1.errortime_inspect_mem_rsp_ready = $time;
			stats1.errors_inspect_mem_rsp_ready++;
		end
		if (inspect_core_clk_ref !== (inspect_core_clk_ref ^ inspect_core_clk_dut ^ inspect_core_clk_ref)) begin
			if (stats1.errors_inspect_core_clk == 0) stats1.errortime_inspect_core_clk = $time;
			stats1.errors_inspect_core_clk++;
		end
		if (core_csr_clk_ref !== (core_csr_clk_ref ^ core_csr_clk_dut ^ core_csr_clk_ref)) begin
			if (stats1.errors_core_csr_clk == 0) stats1.errortime_core_csr_clk = $time;
			stats1.errors_core_csr_clk++;
		end
		if (core_wfi_ref !== (core_wfi_ref ^ core_wfi_dut ^ core_wfi_ref)) begin
			if (stats1.errors_core_wfi == 0) stats1.errortime_core_wfi = $time;
			stats1.errors_core_wfi++;
		end
		if (tm_stop_ref !== (tm_stop_ref ^ tm_stop_dut ^ tm_stop_ref)) begin
			if (stats1.errors_tm_stop == 0) stats1.errortime_tm_stop = $time;
			stats1.errors_tm_stop++;
		end
		if (dbg_irq_r_ref !== (dbg_irq_r_ref ^ dbg_irq_r_dut ^ dbg_irq_r_ref)) begin
			if (stats1.errors_dbg_irq_r == 0) stats1.errortime_dbg_irq_r = $time;
			stats1.errors_dbg_irq_r++;
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
		if (ext2itcm_icb_cmd_ready_ref !== (ext2itcm_icb_cmd_ready_ref ^ ext2itcm_icb_cmd_ready_dut ^ ext2itcm_icb_cmd_ready_ref)) begin
			if (stats1.errors_ext2itcm_icb_cmd_ready == 0) stats1.errortime_ext2itcm_icb_cmd_ready = $time;
			stats1.errors_ext2itcm_icb_cmd_ready++;
		end
		if (ext2itcm_icb_rsp_valid_ref !== (ext2itcm_icb_rsp_valid_ref ^ ext2itcm_icb_rsp_valid_dut ^ ext2itcm_icb_rsp_valid_ref)) begin
			if (stats1.errors_ext2itcm_icb_rsp_valid == 0) stats1.errortime_ext2itcm_icb_rsp_valid = $time;
			stats1.errors_ext2itcm_icb_rsp_valid++;
		end
		if (ext2itcm_icb_rsp_err_ref !== (ext2itcm_icb_rsp_err_ref ^ ext2itcm_icb_rsp_err_dut ^ ext2itcm_icb_rsp_err_ref)) begin
			if (stats1.errors_ext2itcm_icb_rsp_err == 0) stats1.errortime_ext2itcm_icb_rsp_err = $time;
			stats1.errors_ext2itcm_icb_rsp_err++;
		end
		if (ext2itcm_icb_rsp_rdata_ref !== (ext2itcm_icb_rsp_rdata_ref ^ ext2itcm_icb_rsp_rdata_dut ^ ext2itcm_icb_rsp_rdata_ref)) begin
			if (stats1.errors_ext2itcm_icb_rsp_rdata == 0) stats1.errortime_ext2itcm_icb_rsp_rdata = $time;
			stats1.errors_ext2itcm_icb_rsp_rdata++;
		end
		if (ext2dtcm_icb_cmd_ready_ref !== (ext2dtcm_icb_cmd_ready_ref ^ ext2dtcm_icb_cmd_ready_dut ^ ext2dtcm_icb_cmd_ready_ref)) begin
			if (stats1.errors_ext2dtcm_icb_cmd_ready == 0) stats1.errortime_ext2dtcm_icb_cmd_ready = $time;
			stats1.errors_ext2dtcm_icb_cmd_ready++;
		end
		if (ext2dtcm_icb_rsp_valid_ref !== (ext2dtcm_icb_rsp_valid_ref ^ ext2dtcm_icb_rsp_valid_dut ^ ext2dtcm_icb_rsp_valid_ref)) begin
			if (stats1.errors_ext2dtcm_icb_rsp_valid == 0) stats1.errortime_ext2dtcm_icb_rsp_valid = $time;
			stats1.errors_ext2dtcm_icb_rsp_valid++;
		end
		if (ext2dtcm_icb_rsp_err_ref !== (ext2dtcm_icb_rsp_err_ref ^ ext2dtcm_icb_rsp_err_dut ^ ext2dtcm_icb_rsp_err_ref)) begin
			if (stats1.errors_ext2dtcm_icb_rsp_err == 0) stats1.errortime_ext2dtcm_icb_rsp_err = $time;
			stats1.errors_ext2dtcm_icb_rsp_err++;
		end
		if (ext2dtcm_icb_rsp_rdata_ref !== (ext2dtcm_icb_rsp_rdata_ref ^ ext2dtcm_icb_rsp_rdata_dut ^ ext2dtcm_icb_rsp_rdata_ref)) begin
			if (stats1.errors_ext2dtcm_icb_rsp_rdata == 0) stats1.errortime_ext2dtcm_icb_rsp_rdata = $time;
			stats1.errors_ext2dtcm_icb_rsp_rdata++;
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
