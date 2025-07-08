`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_dtcm_active;
		int errortime_dtcm_active;
		int errors_lsu2dtcm_icb_cmd_ready;
		int errortime_lsu2dtcm_icb_cmd_ready;
		int errors_lsu2dtcm_icb_rsp_valid;
		int errortime_lsu2dtcm_icb_rsp_valid;
		int errors_lsu2dtcm_icb_rsp_err;
		int errortime_lsu2dtcm_icb_rsp_err;
		int errors_lsu2dtcm_icb_rsp_rdata;
		int errortime_lsu2dtcm_icb_rsp_rdata;
		int errors_ext2dtcm_icb_cmd_ready;
		int errortime_ext2dtcm_icb_cmd_ready;
		int errors_ext2dtcm_icb_rsp_valid;
		int errortime_ext2dtcm_icb_rsp_valid;
		int errors_ext2dtcm_icb_rsp_err;
		int errortime_ext2dtcm_icb_rsp_err;
		int errors_ext2dtcm_icb_rsp_rdata;
		int errortime_ext2dtcm_icb_rsp_rdata;
		int errors_dtcm_ram_cs;
		int errortime_dtcm_ram_cs;
		int errors_dtcm_ram_we;
		int errortime_dtcm_ram_we;
		int errors_dtcm_ram_addr;
		int errortime_dtcm_ram_addr;
		int errors_dtcm_ram_wem;
		int errortime_dtcm_ram_wem;
		int errors_dtcm_ram_din;
		int errortime_dtcm_ram_din;
		int errors_clk_dtcm_ram;
		int errortime_clk_dtcm_ram;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic dtcm_active_ref;
	logic dtcm_active_dut;
	logic tcm_cgstop;
	logic lsu2dtcm_icb_cmd_valid;
	logic lsu2dtcm_icb_cmd_ready_ref;
	logic lsu2dtcm_icb_cmd_ready_dut;
	logic [16-1:0] lsu2dtcm_icb_cmd_addr;
	logic lsu2dtcm_icb_cmd_read;
	logic [32-1:0] lsu2dtcm_icb_cmd_wdata;
	logic [4-1:0] lsu2dtcm_icb_cmd_wmask;
	logic lsu2dtcm_icb_rsp_valid_ref;
	logic lsu2dtcm_icb_rsp_valid_dut;
	logic lsu2dtcm_icb_rsp_ready;
	logic lsu2dtcm_icb_rsp_err_ref;
	logic lsu2dtcm_icb_rsp_err_dut;
	logic [32-1:0] lsu2dtcm_icb_rsp_rdata_ref;
	logic [32-1:0] lsu2dtcm_icb_rsp_rdata_dut;
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
	logic dtcm_ram_cs_ref;
	logic dtcm_ram_cs_dut;
	logic dtcm_ram_we_ref;
	logic dtcm_ram_we_dut;
	logic [14-1:0] dtcm_ram_addr_ref;
	logic [14-1:0] dtcm_ram_addr_dut;
	logic [4-1:0] dtcm_ram_wem_ref;
	logic [4-1:0] dtcm_ram_wem_dut;
	logic [32-1:0] dtcm_ram_din_ref;
	logic [32-1:0] dtcm_ram_din_dut;
	logic [32-1:0] dtcm_ram_dout;
	logic clk_dtcm_ram_ref;
	logic clk_dtcm_ram_dut;
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
		.lsu2dtcm_icb_cmd_valid(lsu2dtcm_icb_cmd_valid),
		.lsu2dtcm_icb_cmd_addr(lsu2dtcm_icb_cmd_addr),
		.lsu2dtcm_icb_cmd_read(lsu2dtcm_icb_cmd_read),
		.lsu2dtcm_icb_cmd_wdata(lsu2dtcm_icb_cmd_wdata),
		.lsu2dtcm_icb_cmd_wmask(lsu2dtcm_icb_cmd_wmask),
		.lsu2dtcm_icb_rsp_ready(lsu2dtcm_icb_rsp_ready),
		.ext2dtcm_icb_cmd_valid(ext2dtcm_icb_cmd_valid),
		.ext2dtcm_icb_cmd_addr(ext2dtcm_icb_cmd_addr),
		.ext2dtcm_icb_cmd_read(ext2dtcm_icb_cmd_read),
		.ext2dtcm_icb_cmd_wdata(ext2dtcm_icb_cmd_wdata),
		.ext2dtcm_icb_cmd_wmask(ext2dtcm_icb_cmd_wmask),
		.ext2dtcm_icb_rsp_ready(ext2dtcm_icb_rsp_ready),
		.dtcm_ram_dout(dtcm_ram_dout),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_dtcm_ctrl good1 (
		.dtcm_active(dtcm_active_ref),
		.tcm_cgstop(tcm_cgstop),
		.lsu2dtcm_icb_cmd_valid(lsu2dtcm_icb_cmd_valid),
		.lsu2dtcm_icb_cmd_ready(lsu2dtcm_icb_cmd_ready_ref),
		.lsu2dtcm_icb_cmd_addr(lsu2dtcm_icb_cmd_addr),
		.lsu2dtcm_icb_cmd_read(lsu2dtcm_icb_cmd_read),
		.lsu2dtcm_icb_cmd_wdata(lsu2dtcm_icb_cmd_wdata),
		.lsu2dtcm_icb_cmd_wmask(lsu2dtcm_icb_cmd_wmask),
		.lsu2dtcm_icb_rsp_valid(lsu2dtcm_icb_rsp_valid_ref),
		.lsu2dtcm_icb_rsp_ready(lsu2dtcm_icb_rsp_ready),
		.lsu2dtcm_icb_rsp_err(lsu2dtcm_icb_rsp_err_ref),
		.lsu2dtcm_icb_rsp_rdata(lsu2dtcm_icb_rsp_rdata_ref),
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
		.dtcm_ram_cs(dtcm_ram_cs_ref),
		.dtcm_ram_we(dtcm_ram_we_ref),
		.dtcm_ram_addr(dtcm_ram_addr_ref),
		.dtcm_ram_wem(dtcm_ram_wem_ref),
		.dtcm_ram_din(dtcm_ram_din_ref),
		.dtcm_ram_dout(dtcm_ram_dout),
		.clk_dtcm_ram(clk_dtcm_ram_ref),
		.test_mode(test_mode),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_dtcm_ctrl top_module1 (
		.dtcm_active(dtcm_active_dut),
		.tcm_cgstop(tcm_cgstop),
		.lsu2dtcm_icb_cmd_valid(lsu2dtcm_icb_cmd_valid),
		.lsu2dtcm_icb_cmd_ready(lsu2dtcm_icb_cmd_ready_dut),
		.lsu2dtcm_icb_cmd_addr(lsu2dtcm_icb_cmd_addr),
		.lsu2dtcm_icb_cmd_read(lsu2dtcm_icb_cmd_read),
		.lsu2dtcm_icb_cmd_wdata(lsu2dtcm_icb_cmd_wdata),
		.lsu2dtcm_icb_cmd_wmask(lsu2dtcm_icb_cmd_wmask),
		.lsu2dtcm_icb_rsp_valid(lsu2dtcm_icb_rsp_valid_dut),
		.lsu2dtcm_icb_rsp_ready(lsu2dtcm_icb_rsp_ready),
		.lsu2dtcm_icb_rsp_err(lsu2dtcm_icb_rsp_err_dut),
		.lsu2dtcm_icb_rsp_rdata(lsu2dtcm_icb_rsp_rdata_dut),
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
		.dtcm_ram_cs(dtcm_ram_cs_dut),
		.dtcm_ram_we(dtcm_ram_we_dut),
		.dtcm_ram_addr(dtcm_ram_addr_dut),
		.dtcm_ram_wem(dtcm_ram_wem_dut),
		.dtcm_ram_din(dtcm_ram_din_dut),
		.dtcm_ram_dout(dtcm_ram_dout),
		.clk_dtcm_ram(clk_dtcm_ram_dut),
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
		if (stats1.errors_dtcm_active)
			$display("Hint: Output 'dtcm_active' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_active, stats1.errortime_dtcm_active);
		else
			$display("Hint: Output 'dtcm_active' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_cmd_ready)
			$display("Hint: Output 'lsu2dtcm_icb_cmd_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_cmd_ready, stats1.errortime_lsu2dtcm_icb_cmd_ready);
		else
			$display("Hint: Output 'lsu2dtcm_icb_cmd_ready' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_rsp_valid)
			$display("Hint: Output 'lsu2dtcm_icb_rsp_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_rsp_valid, stats1.errortime_lsu2dtcm_icb_rsp_valid);
		else
			$display("Hint: Output 'lsu2dtcm_icb_rsp_valid' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_rsp_err)
			$display("Hint: Output 'lsu2dtcm_icb_rsp_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_rsp_err, stats1.errortime_lsu2dtcm_icb_rsp_err);
		else
			$display("Hint: Output 'lsu2dtcm_icb_rsp_err' has no mismatches.");
		if (stats1.errors_lsu2dtcm_icb_rsp_rdata)
			$display("Hint: Output 'lsu2dtcm_icb_rsp_rdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu2dtcm_icb_rsp_rdata, stats1.errortime_lsu2dtcm_icb_rsp_rdata);
		else
			$display("Hint: Output 'lsu2dtcm_icb_rsp_rdata' has no mismatches.");
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
		if (stats1.errors_dtcm_ram_cs)
			$display("Hint: Output 'dtcm_ram_cs' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_cs, stats1.errortime_dtcm_ram_cs);
		else
			$display("Hint: Output 'dtcm_ram_cs' has no mismatches.");
		if (stats1.errors_dtcm_ram_we)
			$display("Hint: Output 'dtcm_ram_we' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_we, stats1.errortime_dtcm_ram_we);
		else
			$display("Hint: Output 'dtcm_ram_we' has no mismatches.");
		if (stats1.errors_dtcm_ram_addr)
			$display("Hint: Output 'dtcm_ram_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_addr, stats1.errortime_dtcm_ram_addr);
		else
			$display("Hint: Output 'dtcm_ram_addr' has no mismatches.");
		if (stats1.errors_dtcm_ram_wem)
			$display("Hint: Output 'dtcm_ram_wem' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_wem, stats1.errortime_dtcm_ram_wem);
		else
			$display("Hint: Output 'dtcm_ram_wem' has no mismatches.");
		if (stats1.errors_dtcm_ram_din)
			$display("Hint: Output 'dtcm_ram_din' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_din, stats1.errortime_dtcm_ram_din);
		else
			$display("Hint: Output 'dtcm_ram_din' has no mismatches.");
		if (stats1.errors_clk_dtcm_ram)
			$display("Hint: Output 'clk_dtcm_ram' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_dtcm_ram, stats1.errortime_clk_dtcm_ram);
		else
			$display("Hint: Output 'clk_dtcm_ram' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ dtcm_active_ref,lsu2dtcm_icb_cmd_ready_ref,lsu2dtcm_icb_rsp_valid_ref,lsu2dtcm_icb_rsp_err_ref,lsu2dtcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,dtcm_ram_cs_ref,dtcm_ram_we_ref,dtcm_ram_addr_ref,dtcm_ram_wem_ref,dtcm_ram_din_ref,clk_dtcm_ram_ref} ===
			( { dtcm_active_ref,lsu2dtcm_icb_cmd_ready_ref,lsu2dtcm_icb_rsp_valid_ref,lsu2dtcm_icb_rsp_err_ref,lsu2dtcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,dtcm_ram_cs_ref,dtcm_ram_we_ref,dtcm_ram_addr_ref,dtcm_ram_wem_ref,dtcm_ram_din_ref,clk_dtcm_ram_ref} ^
			  { dtcm_active_dut,lsu2dtcm_icb_cmd_ready_dut,lsu2dtcm_icb_rsp_valid_dut,lsu2dtcm_icb_rsp_err_dut,lsu2dtcm_icb_rsp_rdata_dut,ext2dtcm_icb_cmd_ready_dut,ext2dtcm_icb_rsp_valid_dut,ext2dtcm_icb_rsp_err_dut,ext2dtcm_icb_rsp_rdata_dut,dtcm_ram_cs_dut,dtcm_ram_we_dut,dtcm_ram_addr_dut,dtcm_ram_wem_dut,dtcm_ram_din_dut,clk_dtcm_ram_dut} ^
			  { dtcm_active_ref,lsu2dtcm_icb_cmd_ready_ref,lsu2dtcm_icb_rsp_valid_ref,lsu2dtcm_icb_rsp_err_ref,lsu2dtcm_icb_rsp_rdata_ref,ext2dtcm_icb_cmd_ready_ref,ext2dtcm_icb_rsp_valid_ref,ext2dtcm_icb_rsp_err_ref,ext2dtcm_icb_rsp_rdata_ref,dtcm_ram_cs_ref,dtcm_ram_we_ref,dtcm_ram_addr_ref,dtcm_ram_wem_ref,dtcm_ram_din_ref,clk_dtcm_ram_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (dtcm_active_ref !== (dtcm_active_ref ^ dtcm_active_dut ^ dtcm_active_ref)) begin
			if (stats1.errors_dtcm_active == 0) stats1.errortime_dtcm_active = $time;
			stats1.errors_dtcm_active++;
		end
		if (lsu2dtcm_icb_cmd_ready_ref !== (lsu2dtcm_icb_cmd_ready_ref ^ lsu2dtcm_icb_cmd_ready_dut ^ lsu2dtcm_icb_cmd_ready_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_cmd_ready == 0) stats1.errortime_lsu2dtcm_icb_cmd_ready = $time;
			stats1.errors_lsu2dtcm_icb_cmd_ready++;
		end
		if (lsu2dtcm_icb_rsp_valid_ref !== (lsu2dtcm_icb_rsp_valid_ref ^ lsu2dtcm_icb_rsp_valid_dut ^ lsu2dtcm_icb_rsp_valid_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_rsp_valid == 0) stats1.errortime_lsu2dtcm_icb_rsp_valid = $time;
			stats1.errors_lsu2dtcm_icb_rsp_valid++;
		end
		if (lsu2dtcm_icb_rsp_err_ref !== (lsu2dtcm_icb_rsp_err_ref ^ lsu2dtcm_icb_rsp_err_dut ^ lsu2dtcm_icb_rsp_err_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_rsp_err == 0) stats1.errortime_lsu2dtcm_icb_rsp_err = $time;
			stats1.errors_lsu2dtcm_icb_rsp_err++;
		end
		if (lsu2dtcm_icb_rsp_rdata_ref !== (lsu2dtcm_icb_rsp_rdata_ref ^ lsu2dtcm_icb_rsp_rdata_dut ^ lsu2dtcm_icb_rsp_rdata_ref)) begin
			if (stats1.errors_lsu2dtcm_icb_rsp_rdata == 0) stats1.errortime_lsu2dtcm_icb_rsp_rdata = $time;
			stats1.errors_lsu2dtcm_icb_rsp_rdata++;
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
		if (dtcm_ram_cs_ref !== (dtcm_ram_cs_ref ^ dtcm_ram_cs_dut ^ dtcm_ram_cs_ref)) begin
			if (stats1.errors_dtcm_ram_cs == 0) stats1.errortime_dtcm_ram_cs = $time;
			stats1.errors_dtcm_ram_cs++;
		end
		if (dtcm_ram_we_ref !== (dtcm_ram_we_ref ^ dtcm_ram_we_dut ^ dtcm_ram_we_ref)) begin
			if (stats1.errors_dtcm_ram_we == 0) stats1.errortime_dtcm_ram_we = $time;
			stats1.errors_dtcm_ram_we++;
		end
		if (dtcm_ram_addr_ref !== (dtcm_ram_addr_ref ^ dtcm_ram_addr_dut ^ dtcm_ram_addr_ref)) begin
			if (stats1.errors_dtcm_ram_addr == 0) stats1.errortime_dtcm_ram_addr = $time;
			stats1.errors_dtcm_ram_addr++;
		end
		if (dtcm_ram_wem_ref !== (dtcm_ram_wem_ref ^ dtcm_ram_wem_dut ^ dtcm_ram_wem_ref)) begin
			if (stats1.errors_dtcm_ram_wem == 0) stats1.errortime_dtcm_ram_wem = $time;
			stats1.errors_dtcm_ram_wem++;
		end
		if (dtcm_ram_din_ref !== (dtcm_ram_din_ref ^ dtcm_ram_din_dut ^ dtcm_ram_din_ref)) begin
			if (stats1.errors_dtcm_ram_din == 0) stats1.errortime_dtcm_ram_din = $time;
			stats1.errors_dtcm_ram_din++;
		end
		if (clk_dtcm_ram_ref !== (clk_dtcm_ram_ref ^ clk_dtcm_ram_dut ^ clk_dtcm_ram_ref)) begin
			if (stats1.errors_clk_dtcm_ram == 0) stats1.errortime_clk_dtcm_ram = $time;
			stats1.errors_clk_dtcm_ram++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
