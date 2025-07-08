`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_itcm_ram_dout;
		int errortime_itcm_ram_dout;
		int errors_dtcm_ram_dout;
		int errortime_dtcm_ram_dout;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic itcm_ram_sd;
	logic itcm_ram_ds;
	logic itcm_ram_ls;
	logic itcm_ram_cs;
	logic itcm_ram_we;
	logic [13-1:0] itcm_ram_addr;
	logic [8-1:0] itcm_ram_wem;
	logic [64-1:0] itcm_ram_din;
	logic [64-1:0] itcm_ram_dout_ref;
	logic [64-1:0] itcm_ram_dout_dut;
	logic clk_itcm_ram;
	logic rst_itcm;
	logic dtcm_ram_sd;
	logic dtcm_ram_ds;
	logic dtcm_ram_ls;
	logic dtcm_ram_cs;
	logic dtcm_ram_we;
	logic [14-1:0] dtcm_ram_addr;
	logic [4-1:0] dtcm_ram_wem;
	logic [32-1:0] dtcm_ram_din;
	logic [32-1:0] dtcm_ram_dout_ref;
	logic [32-1:0] dtcm_ram_dout_dut;
	logic clk_dtcm_ram;
	logic rst_dtcm;
	logic test_mode;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.clk(clk),
		.itcm_ram_sd(itcm_ram_sd),
		.itcm_ram_ds(itcm_ram_ds),
		.itcm_ram_ls(itcm_ram_ls),
		.itcm_ram_cs(itcm_ram_cs),
		.itcm_ram_we(itcm_ram_we),
		.itcm_ram_addr(itcm_ram_addr),
		.itcm_ram_wem(itcm_ram_wem),
		.itcm_ram_din(itcm_ram_din),
		.clk_itcm_ram(clk_itcm_ram),
		.rst_itcm(rst_itcm),
		.dtcm_ram_sd(dtcm_ram_sd),
		.dtcm_ram_ds(dtcm_ram_ds),
		.dtcm_ram_ls(dtcm_ram_ls),
		.dtcm_ram_cs(dtcm_ram_cs),
		.dtcm_ram_we(dtcm_ram_we),
		.dtcm_ram_addr(dtcm_ram_addr),
		.dtcm_ram_wem(dtcm_ram_wem),
		.dtcm_ram_din(dtcm_ram_din),
		.clk_dtcm_ram(clk_dtcm_ram),
		.rst_dtcm(rst_dtcm),
		.test_mode(test_mode),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_srams good1 (
		.itcm_ram_sd(itcm_ram_sd),
		.itcm_ram_ds(itcm_ram_ds),
		.itcm_ram_ls(itcm_ram_ls),
		.itcm_ram_cs(itcm_ram_cs),
		.itcm_ram_we(itcm_ram_we),
		.itcm_ram_addr(itcm_ram_addr),
		.itcm_ram_wem(itcm_ram_wem),
		.itcm_ram_din(itcm_ram_din),
		.itcm_ram_dout(itcm_ram_dout_ref),
		.clk_itcm_ram(clk_itcm_ram),
		.rst_itcm(rst_itcm),
		.dtcm_ram_sd(dtcm_ram_sd),
		.dtcm_ram_ds(dtcm_ram_ds),
		.dtcm_ram_ls(dtcm_ram_ls),
		.dtcm_ram_cs(dtcm_ram_cs),
		.dtcm_ram_we(dtcm_ram_we),
		.dtcm_ram_addr(dtcm_ram_addr),
		.dtcm_ram_wem(dtcm_ram_wem),
		.dtcm_ram_din(dtcm_ram_din),
		.dtcm_ram_dout(dtcm_ram_dout_ref),
		.clk_dtcm_ram(clk_dtcm_ram),
		.rst_dtcm(rst_dtcm),
		.test_mode(test_mode)
	);
       
    // 实例化待测模块
	e203_srams top_module1 (
		.itcm_ram_sd(itcm_ram_sd),
		.itcm_ram_ds(itcm_ram_ds),
		.itcm_ram_ls(itcm_ram_ls),
		.itcm_ram_cs(itcm_ram_cs),
		.itcm_ram_we(itcm_ram_we),
		.itcm_ram_addr(itcm_ram_addr),
		.itcm_ram_wem(itcm_ram_wem),
		.itcm_ram_din(itcm_ram_din),
		.itcm_ram_dout(itcm_ram_dout_dut),
		.clk_itcm_ram(clk_itcm_ram),
		.rst_itcm(rst_itcm),
		.dtcm_ram_sd(dtcm_ram_sd),
		.dtcm_ram_ds(dtcm_ram_ds),
		.dtcm_ram_ls(dtcm_ram_ls),
		.dtcm_ram_cs(dtcm_ram_cs),
		.dtcm_ram_we(dtcm_ram_we),
		.dtcm_ram_addr(dtcm_ram_addr),
		.dtcm_ram_wem(dtcm_ram_wem),
		.dtcm_ram_din(dtcm_ram_din),
		.dtcm_ram_dout(dtcm_ram_dout_dut),
		.clk_dtcm_ram(clk_dtcm_ram),
		.rst_dtcm(rst_dtcm),
		.test_mode(test_mode)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_itcm_ram_dout)
			$display("Hint: Output 'itcm_ram_dout' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ram_dout, stats1.errortime_itcm_ram_dout);
		else
			$display("Hint: Output 'itcm_ram_dout' has no mismatches.");
		if (stats1.errors_dtcm_ram_dout)
			$display("Hint: Output 'dtcm_ram_dout' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ram_dout, stats1.errortime_dtcm_ram_dout);
		else
			$display("Hint: Output 'dtcm_ram_dout' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ itcm_ram_dout_ref,dtcm_ram_dout_ref} ===
			( { itcm_ram_dout_ref,dtcm_ram_dout_ref} ^
			  { itcm_ram_dout_dut,dtcm_ram_dout_dut} ^
			  { itcm_ram_dout_ref,dtcm_ram_dout_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (itcm_ram_dout_ref !== (itcm_ram_dout_ref ^ itcm_ram_dout_dut ^ itcm_ram_dout_ref)) begin
			if (stats1.errors_itcm_ram_dout == 0) stats1.errortime_itcm_ram_dout = $time;
			stats1.errors_itcm_ram_dout++;
		end
		if (dtcm_ram_dout_ref !== (dtcm_ram_dout_ref ^ dtcm_ram_dout_dut ^ dtcm_ram_dout_ref)) begin
			if (stats1.errors_dtcm_ram_dout == 0) stats1.errortime_dtcm_ram_dout = $time;
			stats1.errors_dtcm_ram_dout++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
