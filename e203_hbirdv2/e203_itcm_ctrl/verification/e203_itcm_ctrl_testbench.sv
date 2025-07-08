`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_itcm_active;
		int errortime_itcm_active;
		int errors_ifu2itcm_icb_cmd_ready;
		int errortime_ifu2itcm_icb_cmd_ready;
		int errors_ifu2itcm_icb_rsp_valid;
		int errortime_ifu2itcm_icb_rsp_valid;
		int errors_ifu2itcm_icb_rsp_err;
		int errortime_ifu2itcm_icb_rsp_err;
		int errors_ifu2itcm_icb_rsp_rdata;
		int errortime_ifu2itcm_icb_rsp_rdata;
		int errors_ifu2itcm_holdup;
		int errortime_ifu2itcm_holdup;
		int errors_lsu2itcm_icb_cmd_ready;
		int errortime_lsu2itcm_icb_cmd_ready;
		int errors_lsu2itcm_icb_rsp_valid;
		int errortime_lsu2itcm_icb_rsp_valid;
		int errors_lsu2itcm_icb_rsp_err;
		int errortime_lsu2itcm_icb_rsp_err;
		int errors_lsu2itcm_icb_rsp_rdata;
		int errortime_lsu2itcm_icb_rsp_rdata;
		int errors_ext2itcm_icb_cmd_ready;
		int errortime_ext2itcm_icb_cmd_ready;
		int errors_ext2itcm_icb_rsp_valid;
		int errortime_ext2itcm_icb_rsp_valid;
		int errors_ext2itcm_icb_rsp_err;
		int errortime_ext2itcm_icb_rsp_err;
		int errors_ext2itcm_icb_rsp_rdata;
		int errortime_ext2itcm_icb_rsp_rdata;
		int errors_itcm_ram_cs;
		int errortime_itcm_ram_cs;
		int errors_itcm_ram_we;
		int errortime_itcm_ram_we;
		int errors_itcm_ram_addr;
		int errortime_itcm_ram_addr;
		int errors_itcm_ram_wem;
		int errortime_itcm_ram_wem;
		int errors_itcm_ram_din;
		int errortime_itcm_ram_din;
		int errors_clk_itcm_ram;
		int errortime_clk_itcm_ram;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic itcm_active_ref;
	logic itcm_active_dut;
	logic tcm_cgstop;
	logic ifu2itcm_icb_cmd_valid;
	logic ifu2itcm_icb_cmd_ready_ref;
	logic ifu2itcm_icb_cmd_ready_dut;
	logic [16-1:0] ifu2itcm_icb_cmd_addr;
	logic ifu2itcm_icb_cmd_read;
	logic [64-1:0] ifu2itcm_icb_cmd_wdata;
	logic [8-1:0] ifu2itcm_icb_cmd_wmask;
	logic ifu2itcm_icb_rsp_valid_ref;
	logic ifu2itcm_icb_rsp_valid_dut;
	logic ifu2itcm_icb_rsp_ready;
	logic ifu2itcm_icb_rsp_err_ref;
	logic ifu2itcm_icb_rsp_err_dut;
	logic [64-1:0] ifu2itcm_icb_rsp_rdata_ref;
	logic [64-1:0] ifu2itcm_icb_rsp_rdata_dut;
	logic ifu2itcm_holdup_ref;
	logic ifu2itcm_holdup_dut;
	logic lsu2itcm_icb_cmd_valid;
	logic lsu2itcm_icb_cmd_ready_ref;
	logic lsu2itcm_icb_cmd_ready_dut;
	logic [16-1:0] lsu2itcm_icb_cmd_addr;
	logic lsu2itcm_icb_cmd_read;
	logic [32-1:0] lsu2itcm_icb_cmd_wdata;
	logic [4-1:0] lsu2itcm_icb_cmd_wmask;
	logic lsu2itcm_icb_rsp_valid_ref;
	logic lsu2itcm_icb_rsp_valid_dut;
	logic lsu2itcm_icb_rsp_ready;
	logic lsu2itcm_icb_rsp_err_ref;
	logic lsu2itcm_icb_rsp_err_dut;
	logic [32-1:0] lsu2itcm_icb_rsp_rdata_ref;
	logic [32-1:0] lsu2itcm_icb_rsp_rdata_dut;
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
	logic itcm_ram_cs_ref;
	logic itcm_ram_cs_dut;
	logic itcm_ram_we_ref;
	logic itcm_ram_we_dut;
	logic [13-1:0] itcm_ram_addr_ref;
	logic [13-1:0] itcm_ram_addr_dut;
	logic [8-1:0] itcm_ram_wem_ref;
	logic [8-1:0] itcm_ram_wem_dut;
	logic [64-1:0] itcm_ram_din_ref;
	logic [64-1:0] itcm_ram_din_dut;
	logic [64-1:0] itcm_ram_dout;
	logic clk_itcm_ram_ref;
	logic clk_itcm_ram_dut;
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
		.tcm_cgstop(tcm_cgstop),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr),
		.ifu2itcm_icb_cmd_read(ifu2itcm_icb_cmd_read),
		.ifu2itcm_icb_cmd_wdata(ifu2itcm_icb_cmd_wdata),
		.ifu2itcm_icb_cmd_wmask(ifu2itcm_icb_cmd_wmask),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready),
		.lsu2itcm_icb_cmd_valid(lsu2itcm_icb_cmd_valid),
		.lsu2itcm_icb_cmd_addr(lsu2itcm_icb_cmd_addr),
		.lsu2itcm_icb_cmd_read(lsu2itcm_icb_cmd_read),
		.lsu2itcm_icb_cmd_wdata(lsu2itcm_icb_cmd_wdata),
		.lsu2itcm_icb_cmd_wmask(lsu2itcm_icb_cmd_wmask),
		.lsu2itcm_icb_rsp_ready(lsu2itcm_icb_rsp_ready),
		.ext2itcm_icb_cmd_valid(ext2itcm_icb_cmd_valid),
		.ext2itcm_icb_cmd_addr(ext2itcm_icb_cmd_addr),
		.ext2itcm_icb_cmd_read(ext2itcm_icb_cmd_read),
		.ext2itcm_icb_cmd_wdata(ext2itcm_icb_cmd_wdata),
		.ext2itcm_icb_cmd_wmask(ext2itcm_icb_cmd_wmask),
		.ext2itcm_icb_rsp_ready(ext2itcm_icb_rsp_ready),
		.itcm_ram_dout(itcm_ram_dout),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_itcm_ctrl good1 (
		.itcm_active(itcm_active_ref),
		.tcm_cgstop(tcm_cgstop),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready_ref),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr),
		.ifu2itcm_icb_cmd_read(ifu2itcm_icb_cmd_read),
		.ifu2itcm_icb_cmd_wdata(ifu2itcm_icb_cmd_wdata),
		.ifu2itcm_icb_cmd_wmask(ifu2itcm_icb_cmd_wmask),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid_ref),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err_ref),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata_ref),
		.ifu2itcm_holdup(ifu2itcm_holdup_ref),
		.lsu2itcm_icb_cmd_valid(lsu2itcm_icb_cmd_valid),
		.lsu2itcm_icb_cmd_ready(lsu2itcm_icb_cmd_ready_ref),
		.lsu2itcm_icb_cmd_addr(lsu2itcm_icb_cmd_addr),
		.lsu2itcm_icb_cmd_read(lsu2itcm_icb_cmd_read),
		.lsu2itcm_icb_cmd_wdata(lsu2itcm_icb_cmd_wdata),
		.lsu2itcm_icb_cmd_wmask(lsu2itcm_icb_cmd_wmask),
		.lsu2itcm_icb_rsp_valid(lsu2itcm_icb_rsp_valid_ref),
		.lsu2itcm_icb_rsp_ready(lsu2itcm_icb_rsp_ready),
		.lsu2itcm_icb_rsp_err(lsu2itcm_icb_rsp_err_ref),
		.lsu2itcm_icb_rsp_rdata(lsu2itcm_icb_rsp_rdata_ref),
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
		.itcm_ram_cs(itcm_ram_cs_ref),
		.itcm_ram_we(itcm_ram_we_ref),
		.itcm_ram_addr(itcm_ram_addr_ref),
		.itcm_ram_wem(itcm_ram_wem_ref),
		.itcm_ram_din(itcm_ram_din_ref),
		.itcm_ram_dout(itcm_ram_dout),
		.clk_itcm_ram(clk_itcm_ram_ref),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_itcm_ctrl top_module1 (
		.itcm_active(itcm_active_dut),
		.tcm_cgstop(tcm_cgstop),
		.ifu2itcm_icb_cmd_valid(ifu2itcm_icb_cmd_valid),
		.ifu2itcm_icb_cmd_ready(ifu2itcm_icb_cmd_ready_dut),
		.ifu2itcm_icb_cmd_addr(ifu2itcm_icb_cmd_addr),
		.ifu2itcm_icb_cmd_read(ifu2itcm_icb_cmd_read),
		.ifu2itcm_icb_cmd_wdata(ifu2itcm_icb_cmd_wdata),
		.ifu2itcm_icb_cmd_wmask(ifu2itcm_icb_cmd_wmask),
		.ifu2itcm_icb_rsp_valid(ifu2itcm_icb_rsp_valid_dut),
		.ifu2itcm_icb_rsp_ready(ifu2itcm_icb_rsp_ready),
		.ifu2itcm_icb_rsp_err(ifu2itcm_icb_rsp_err_dut),
		.ifu2itcm_icb_rsp_rdata(ifu2itcm_icb_rsp_rdata_dut),
		.ifu2itcm_holdup(ifu2itcm_holdup_dut),
		.lsu2itcm_icb_cmd_valid(lsu2itcm_icb_cmd_valid),
		.lsu2itcm_icb_cmd_ready(lsu2itcm_icb_cmd_ready_dut),
		.lsu2itcm_icb_cmd_addr(lsu2itcm_icb_cmd_addr),
		.lsu2itcm_icb_cmd_read(lsu2itcm_icb_cmd_read),
		.lsu2itcm_icb_cmd_wdata(lsu2itcm_icb_cmd_wdata),
		.lsu2itcm_icb_cmd_wmask(lsu2itcm_icb_cmd_wmask),
		.lsu2itcm_icb_rsp_valid(lsu2itcm_icb_rsp_valid_dut),
		.lsu2itcm_icb_rsp_ready(lsu2itcm_icb_rsp_ready),
		.lsu2itcm_icb_rsp_err(lsu2itcm_icb_rsp_err_dut),
		.lsu2itcm_icb_rsp_rdata(lsu2itcm_icb_rsp_rdata_dut),
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
		.itcm_ram_cs(itcm_ram_cs_dut),
		.itcm_ram_we(itcm_ram_we_dut),
		.itcm_ram_addr(itcm_ram_addr_dut),
		.itcm_ram_wem(itcm_ram_wem_dut),
		.itcm_ram_din(itcm_ram_din_dut),
		.itcm_ram_dout(itcm_ram_dout),
		.clk_itcm_ram(clk_itcm_ram_dut),
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
		if (stats1.errors_itcm_active)
			$display("Hint: Output 'itcm_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_active, stats1.errortime_itcm_active);
		else
			$display("Hint: Output 'itcm_active' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_cmd_ready)
			$display("Hint: Output 'ifu2itcm_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_cmd_ready, stats1.errortime_ifu2itcm_icb_cmd_ready);
		else
			$display("Hint: Output 'ifu2itcm_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_rsp_valid)
			$display("Hint: Output 'ifu2itcm_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_rsp_valid, stats1.errortime_ifu2itcm_icb_rsp_valid);
		else
			$display("Hint: Output 'ifu2itcm_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_rsp_err)
			$display("Hint: Output 'ifu2itcm_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_rsp_err, stats1.errortime_ifu2itcm_icb_rsp_err);
		else
			$display("Hint: Output 'ifu2itcm_icb_rsp_err' has no mismatches.");
		if (stats1.errors_ifu2itcm_icb_rsp_rdata)
			$display("Hint: Output 'ifu2itcm_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_icb_rsp_rdata, stats1.errortime_ifu2itcm_icb_rsp_rdata);
		else
			$display("Hint: Output 'ifu2itcm_icb_rsp_rdata' has no mismatches.");
		if (stats1.errors_ifu2itcm_holdup)
			$display("Hint: Output 'ifu2itcm_holdup' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ifu2itcm_holdup, stats1.errortime_ifu2itcm_holdup);
		else
			$display("Hint: Output 'ifu2itcm_holdup' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_cmd_ready)
			$display("Hint: Output 'lsu2itcm_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_cmd_ready, stats1.errortime_lsu2itcm_icb_cmd_ready);
		else
			$display("Hint: Output 'lsu2itcm_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_rsp_valid)
			$display("Hint: Output 'lsu2itcm_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_rsp_valid, stats1.errortime_lsu2itcm_icb_rsp_valid);
		else
			$display("Hint: Output 'lsu2itcm_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_rsp_err)
			$display("Hint: Output 'lsu2itcm_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_rsp_err, stats1.errortime_lsu2itcm_icb_rsp_err);
		else
			$display("Hint: Output 'lsu2itcm_icb_rsp_err' has no mismatches.");
		if (stats1.errors_lsu2itcm_icb_rsp_rdata)
			$display("Hint: Output 'lsu2itcm_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2itcm_icb_rsp_rdata, stats1.errortime_lsu2itcm_icb_rsp_rdata);
		else
			$display("Hint: Output 'lsu2itcm_icb_rsp_rdata' has no mismatches.");
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
		if (stats1.errors_itcm_ram_cs)
			$display("Hint: Output 'itcm_ram_cs' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_cs, stats1.errortime_itcm_ram_cs);
		else
			$display("Hint: Output 'itcm_ram_cs' has no mismatches.");
		if (stats1.errors_itcm_ram_we)
			$display("Hint: Output 'itcm_ram_we' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_we, stats1.errortime_itcm_ram_we);
		else
			$display("Hint: Output 'itcm_ram_we' has no mismatches.");
		if (stats1.errors_itcm_ram_addr)
			$display("Hint: Output 'itcm_ram_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_addr, stats1.errortime_itcm_ram_addr);
		else
			$display("Hint: Output 'itcm_ram_addr' has no mismatches.");
		if (stats1.errors_itcm_ram_wem)
			$display("Hint: Output 'itcm_ram_wem' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_wem, stats1.errortime_itcm_ram_wem);
		else
			$display("Hint: Output 'itcm_ram_wem' has no mismatches.");
		if (stats1.errors_itcm_ram_din)
			$display("Hint: Output 'itcm_ram_din' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_din, stats1.errortime_itcm_ram_din);
		else
			$display("Hint: Output 'itcm_ram_din' has no mismatches.");
		if (stats1.errors_clk_itcm_ram)
			$display("Hint: Output 'clk_itcm_ram' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_itcm_ram, stats1.errortime_clk_itcm_ram);
		else
			$display("Hint: Output 'clk_itcm_ram' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ itcm_active_ref,ifu2itcm_icb_cmd_ready_ref,ifu2itcm_icb_rsp_valid_ref,ifu2itcm_icb_rsp_err_ref,ifu2itcm_icb_rsp_rdata_ref,ifu2itcm_holdup_ref,lsu2itcm_icb_cmd_ready_ref,lsu2itcm_icb_rsp_valid_ref,lsu2itcm_icb_rsp_err_ref,lsu2itcm_icb_rsp_rdata_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,itcm_ram_cs_ref,itcm_ram_we_ref,itcm_ram_addr_ref,itcm_ram_wem_ref,itcm_ram_din_ref,clk_itcm_ram_ref} ===
			( { itcm_active_ref,ifu2itcm_icb_cmd_ready_ref,ifu2itcm_icb_rsp_valid_ref,ifu2itcm_icb_rsp_err_ref,ifu2itcm_icb_rsp_rdata_ref,ifu2itcm_holdup_ref,lsu2itcm_icb_cmd_ready_ref,lsu2itcm_icb_rsp_valid_ref,lsu2itcm_icb_rsp_err_ref,lsu2itcm_icb_rsp_rdata_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,itcm_ram_cs_ref,itcm_ram_we_ref,itcm_ram_addr_ref,itcm_ram_wem_ref,itcm_ram_din_ref,clk_itcm_ram_ref} ^
			  { itcm_active_dut,ifu2itcm_icb_cmd_ready_dut,ifu2itcm_icb_rsp_valid_dut,ifu2itcm_icb_rsp_err_dut,ifu2itcm_icb_rsp_rdata_dut,ifu2itcm_holdup_dut,lsu2itcm_icb_cmd_ready_dut,lsu2itcm_icb_rsp_valid_dut,lsu2itcm_icb_rsp_err_dut,lsu2itcm_icb_rsp_rdata_dut,ext2itcm_icb_cmd_ready_dut,ext2itcm_icb_rsp_valid_dut,ext2itcm_icb_rsp_err_dut,ext2itcm_icb_rsp_rdata_dut,itcm_ram_cs_dut,itcm_ram_we_dut,itcm_ram_addr_dut,itcm_ram_wem_dut,itcm_ram_din_dut,clk_itcm_ram_dut} ^
			  { itcm_active_ref,ifu2itcm_icb_cmd_ready_ref,ifu2itcm_icb_rsp_valid_ref,ifu2itcm_icb_rsp_err_ref,ifu2itcm_icb_rsp_rdata_ref,ifu2itcm_holdup_ref,lsu2itcm_icb_cmd_ready_ref,lsu2itcm_icb_rsp_valid_ref,lsu2itcm_icb_rsp_err_ref,lsu2itcm_icb_rsp_rdata_ref,ext2itcm_icb_cmd_ready_ref,ext2itcm_icb_rsp_valid_ref,ext2itcm_icb_rsp_err_ref,ext2itcm_icb_rsp_rdata_ref,itcm_ram_cs_ref,itcm_ram_we_ref,itcm_ram_addr_ref,itcm_ram_wem_ref,itcm_ram_din_ref,clk_itcm_ram_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (itcm_active_ref !== (itcm_active_ref ^ itcm_active_dut ^ itcm_active_ref)) begin
			if (stats1.errors_itcm_active == 0) stats1.errortime_itcm_active = $time;
			stats1.errors_itcm_active++;
		end
		if (ifu2itcm_icb_cmd_ready_ref !== (ifu2itcm_icb_cmd_ready_ref ^ ifu2itcm_icb_cmd_ready_dut ^ ifu2itcm_icb_cmd_ready_ref)) begin
			if (stats1.errors_ifu2itcm_icb_cmd_ready == 0) stats1.errortime_ifu2itcm_icb_cmd_ready = $time;
			stats1.errors_ifu2itcm_icb_cmd_ready++;
		end
		if (ifu2itcm_icb_rsp_valid_ref !== (ifu2itcm_icb_rsp_valid_ref ^ ifu2itcm_icb_rsp_valid_dut ^ ifu2itcm_icb_rsp_valid_ref)) begin
			if (stats1.errors_ifu2itcm_icb_rsp_valid == 0) stats1.errortime_ifu2itcm_icb_rsp_valid = $time;
			stats1.errors_ifu2itcm_icb_rsp_valid++;
		end
		if (ifu2itcm_icb_rsp_err_ref !== (ifu2itcm_icb_rsp_err_ref ^ ifu2itcm_icb_rsp_err_dut ^ ifu2itcm_icb_rsp_err_ref)) begin
			if (stats1.errors_ifu2itcm_icb_rsp_err == 0) stats1.errortime_ifu2itcm_icb_rsp_err = $time;
			stats1.errors_ifu2itcm_icb_rsp_err++;
		end
		if (ifu2itcm_icb_rsp_rdata_ref !== (ifu2itcm_icb_rsp_rdata_ref ^ ifu2itcm_icb_rsp_rdata_dut ^ ifu2itcm_icb_rsp_rdata_ref)) begin
			if (stats1.errors_ifu2itcm_icb_rsp_rdata == 0) stats1.errortime_ifu2itcm_icb_rsp_rdata = $time;
			stats1.errors_ifu2itcm_icb_rsp_rdata++;
		end
		if (ifu2itcm_holdup_ref !== (ifu2itcm_holdup_ref ^ ifu2itcm_holdup_dut ^ ifu2itcm_holdup_ref)) begin
			if (stats1.errors_ifu2itcm_holdup == 0) stats1.errortime_ifu2itcm_holdup = $time;
			stats1.errors_ifu2itcm_holdup++;
		end
		if (lsu2itcm_icb_cmd_ready_ref !== (lsu2itcm_icb_cmd_ready_ref ^ lsu2itcm_icb_cmd_ready_dut ^ lsu2itcm_icb_cmd_ready_ref)) begin
			if (stats1.errors_lsu2itcm_icb_cmd_ready == 0) stats1.errortime_lsu2itcm_icb_cmd_ready = $time;
			stats1.errors_lsu2itcm_icb_cmd_ready++;
		end
		if (lsu2itcm_icb_rsp_valid_ref !== (lsu2itcm_icb_rsp_valid_ref ^ lsu2itcm_icb_rsp_valid_dut ^ lsu2itcm_icb_rsp_valid_ref)) begin
			if (stats1.errors_lsu2itcm_icb_rsp_valid == 0) stats1.errortime_lsu2itcm_icb_rsp_valid = $time;
			stats1.errors_lsu2itcm_icb_rsp_valid++;
		end
		if (lsu2itcm_icb_rsp_err_ref !== (lsu2itcm_icb_rsp_err_ref ^ lsu2itcm_icb_rsp_err_dut ^ lsu2itcm_icb_rsp_err_ref)) begin
			if (stats1.errors_lsu2itcm_icb_rsp_err == 0) stats1.errortime_lsu2itcm_icb_rsp_err = $time;
			stats1.errors_lsu2itcm_icb_rsp_err++;
		end
		if (lsu2itcm_icb_rsp_rdata_ref !== (lsu2itcm_icb_rsp_rdata_ref ^ lsu2itcm_icb_rsp_rdata_dut ^ lsu2itcm_icb_rsp_rdata_ref)) begin
			if (stats1.errors_lsu2itcm_icb_rsp_rdata == 0) stats1.errortime_lsu2itcm_icb_rsp_rdata = $time;
			stats1.errors_lsu2itcm_icb_rsp_rdata++;
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
		if (itcm_ram_cs_ref !== (itcm_ram_cs_ref ^ itcm_ram_cs_dut ^ itcm_ram_cs_ref)) begin
			if (stats1.errors_itcm_ram_cs == 0) stats1.errortime_itcm_ram_cs = $time;
			stats1.errors_itcm_ram_cs++;
		end
		if (itcm_ram_we_ref !== (itcm_ram_we_ref ^ itcm_ram_we_dut ^ itcm_ram_we_ref)) begin
			if (stats1.errors_itcm_ram_we == 0) stats1.errortime_itcm_ram_we = $time;
			stats1.errors_itcm_ram_we++;
		end
		if (itcm_ram_addr_ref !== (itcm_ram_addr_ref ^ itcm_ram_addr_dut ^ itcm_ram_addr_ref)) begin
			if (stats1.errors_itcm_ram_addr == 0) stats1.errortime_itcm_ram_addr = $time;
			stats1.errors_itcm_ram_addr++;
		end
		if (itcm_ram_wem_ref !== (itcm_ram_wem_ref ^ itcm_ram_wem_dut ^ itcm_ram_wem_ref)) begin
			if (stats1.errors_itcm_ram_wem == 0) stats1.errortime_itcm_ram_wem = $time;
			stats1.errors_itcm_ram_wem++;
		end
		if (itcm_ram_din_ref !== (itcm_ram_din_ref ^ itcm_ram_din_dut ^ itcm_ram_din_ref)) begin
			if (stats1.errors_itcm_ram_din == 0) stats1.errortime_itcm_ram_din = $time;
			stats1.errors_itcm_ram_din++;
		end
		if (clk_itcm_ram_ref !== (clk_itcm_ram_ref ^ clk_itcm_ram_dut ^ clk_itcm_ram_ref)) begin
			if (stats1.errors_clk_itcm_ram == 0) stats1.errortime_clk_itcm_ram = $time;
			stats1.errors_clk_itcm_ram++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
