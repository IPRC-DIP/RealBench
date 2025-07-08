`timescale 1 ps/1 ps
`include "e203_defines.v"
module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_clk_aon;
		int errortime_clk_aon;
		int errors_itcm_ls;
		int errortime_itcm_ls;
		int errors_dtcm_ls;
		int errortime_dtcm_ls;
		int errors_clk_core_ifu;
		int errortime_clk_core_ifu;
		int errors_clk_core_exu;
		int errortime_clk_core_exu;
		int errors_clk_core_lsu;
		int errortime_clk_core_lsu;
		int errors_clk_core_biu;
		int errortime_clk_core_biu;
		int errors_clk_itcm;
		int errortime_clk_itcm;
		int errors_clk_dtcm;
		int errortime_clk_dtcm;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic rst_n;
	logic test_mode;
	logic core_cgstop;
	logic clk_aon_ref;
	logic clk_aon_dut;
	logic core_ifu_active;
	logic core_exu_active;
	logic core_lsu_active;
	logic core_biu_active;
	logic itcm_active;
	logic itcm_ls_ref;
	logic itcm_ls_dut;
	logic dtcm_active;
	logic dtcm_ls_ref;
	logic dtcm_ls_dut;
	logic clk_core_ifu_ref;
	logic clk_core_ifu_dut;
	logic clk_core_exu_ref;
	logic clk_core_exu_dut;
	logic clk_core_lsu_ref;
	logic clk_core_lsu_dut;
	logic clk_core_biu_ref;
	logic clk_core_biu_dut;
	logic clk_itcm_ref;
	logic clk_itcm_dut;
	logic clk_dtcm_ref;
	logic clk_dtcm_dut;
	logic core_wfi;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.clk(clk),
		.tb_match(tb_match),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.core_cgstop(core_cgstop),
		.core_ifu_active(core_ifu_active),
		.core_exu_active(core_exu_active),
		.core_lsu_active(core_lsu_active),
		.core_biu_active(core_biu_active),
		.itcm_active(itcm_active),
		.dtcm_active(dtcm_active),
		.core_wfi(core_wfi),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_clk_ctrl good1 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.core_cgstop(core_cgstop),
		.clk_aon(clk_aon_ref),
		.core_ifu_active(core_ifu_active),
		.core_exu_active(core_exu_active),
		.core_lsu_active(core_lsu_active),
		.core_biu_active(core_biu_active),
		.itcm_active(itcm_active),
		.itcm_ls(itcm_ls_ref),
		.dtcm_active(dtcm_active),
		.dtcm_ls(dtcm_ls_ref),
		.clk_core_ifu(clk_core_ifu_ref),
		.clk_core_exu(clk_core_exu_ref),
		.clk_core_lsu(clk_core_lsu_ref),
		.clk_core_biu(clk_core_biu_ref),
		.clk_itcm(clk_itcm_ref),
		.clk_dtcm(clk_dtcm_ref),
		.core_wfi(core_wfi)
	);
       
    // 实例化待测模块
	e203_clk_ctrl top_module1 (
		.clk(clk),
		.rst_n(rst_n),
		.test_mode(test_mode),
		.core_cgstop(core_cgstop),
		.clk_aon(clk_aon_dut),
		.core_ifu_active(core_ifu_active),
		.core_exu_active(core_exu_active),
		.core_lsu_active(core_lsu_active),
		.core_biu_active(core_biu_active),
		.itcm_active(itcm_active),
		.itcm_ls(itcm_ls_dut),
		.dtcm_active(dtcm_active),
		.dtcm_ls(dtcm_ls_dut),
		.clk_core_ifu(clk_core_ifu_dut),
		.clk_core_exu(clk_core_exu_dut),
		.clk_core_lsu(clk_core_lsu_dut),
		.clk_core_biu(clk_core_biu_dut),
		.clk_itcm(clk_itcm_dut),
		.clk_dtcm(clk_dtcm_dut),
		.core_wfi(core_wfi)
	);

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    // 公式化生成错误信息
    final begin
		if (stats1.errors_clk_aon)
			$display("Hint: Output 'clk_aon' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_aon, stats1.errortime_clk_aon);
		else
			$display("Hint: Output 'clk_aon' has no mismatches.");
		if (stats1.errors_itcm_ls)
			$display("Hint: Output 'itcm_ls' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_ls, stats1.errortime_itcm_ls);
		else
			$display("Hint: Output 'itcm_ls' has no mismatches.");
		if (stats1.errors_dtcm_ls)
			$display("Hint: Output 'dtcm_ls' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dtcm_ls, stats1.errortime_dtcm_ls);
		else
			$display("Hint: Output 'dtcm_ls' has no mismatches.");
		if (stats1.errors_clk_core_ifu)
			$display("Hint: Output 'clk_core_ifu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_core_ifu, stats1.errortime_clk_core_ifu);
		else
			$display("Hint: Output 'clk_core_ifu' has no mismatches.");
		if (stats1.errors_clk_core_exu)
			$display("Hint: Output 'clk_core_exu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_core_exu, stats1.errortime_clk_core_exu);
		else
			$display("Hint: Output 'clk_core_exu' has no mismatches.");
		if (stats1.errors_clk_core_lsu)
			$display("Hint: Output 'clk_core_lsu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_core_lsu, stats1.errortime_clk_core_lsu);
		else
			$display("Hint: Output 'clk_core_lsu' has no mismatches.");
		if (stats1.errors_clk_core_biu)
			$display("Hint: Output 'clk_core_biu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_core_biu, stats1.errortime_clk_core_biu);
		else
			$display("Hint: Output 'clk_core_biu' has no mismatches.");
		if (stats1.errors_clk_itcm)
			$display("Hint: Output 'clk_itcm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_itcm, stats1.errortime_clk_itcm);
		else
			$display("Hint: Output 'clk_itcm' has no mismatches.");
		if (stats1.errors_clk_dtcm)
			$display("Hint: Output 'clk_dtcm' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_clk_dtcm, stats1.errortime_clk_dtcm);
		else
			$display("Hint: Output 'clk_dtcm' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ clk_aon_ref,itcm_ls_ref,dtcm_ls_ref,clk_core_ifu_ref,clk_core_exu_ref,clk_core_lsu_ref,clk_core_biu_ref,clk_itcm_ref,clk_dtcm_ref} ===
			( { clk_aon_ref,itcm_ls_ref,dtcm_ls_ref,clk_core_ifu_ref,clk_core_exu_ref,clk_core_lsu_ref,clk_core_biu_ref,clk_itcm_ref,clk_dtcm_ref} ^
			  { clk_aon_ref,itcm_ls_ref,dtcm_ls_ref,clk_core_ifu_ref,clk_core_exu_ref,clk_core_lsu_ref,clk_core_biu_ref,clk_itcm_ref,clk_dtcm_ref} ^
			  { clk_aon_ref,itcm_ls_ref,dtcm_ls_ref,clk_core_ifu_ref,clk_core_exu_ref,clk_core_lsu_ref,clk_core_biu_ref,clk_itcm_ref,clk_dtcm_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (clk_aon_ref !== (clk_aon_ref ^ clk_aon_dut ^ clk_aon_ref)) begin
			if (stats1.errors_clk_aon == 0) stats1.errortime_clk_aon = $time;
			stats1.errors_clk_aon++;
		end
		if (itcm_ls_ref !== (itcm_ls_ref ^ itcm_ls_dut ^ itcm_ls_ref)) begin
			if (stats1.errors_itcm_ls == 0) stats1.errortime_itcm_ls = $time;
			stats1.errors_itcm_ls++;
		end
		if (dtcm_ls_ref !== (dtcm_ls_ref ^ dtcm_ls_dut ^ dtcm_ls_ref)) begin
			if (stats1.errors_dtcm_ls == 0) stats1.errortime_dtcm_ls = $time;
			stats1.errors_dtcm_ls++;
		end
		if (clk_core_ifu_ref !== (clk_core_ifu_ref ^ clk_core_ifu_dut ^ clk_core_ifu_ref)) begin
			if (stats1.errors_clk_core_ifu == 0) stats1.errortime_clk_core_ifu = $time;
			stats1.errors_clk_core_ifu++;
		end
		if (clk_core_exu_ref !== (clk_core_exu_ref ^ clk_core_exu_dut ^ clk_core_exu_ref)) begin
			if (stats1.errors_clk_core_exu == 0) stats1.errortime_clk_core_exu = $time;
			stats1.errors_clk_core_exu++;
		end
		if (clk_core_lsu_ref !== (clk_core_lsu_ref ^ clk_core_lsu_dut ^ clk_core_lsu_ref)) begin
			if (stats1.errors_clk_core_lsu == 0) stats1.errortime_clk_core_lsu = $time;
			stats1.errors_clk_core_lsu++;
		end
		if (clk_core_biu_ref !== (clk_core_biu_ref ^ clk_core_biu_dut ^ clk_core_biu_ref)) begin
			if (stats1.errors_clk_core_biu == 0) stats1.errortime_clk_core_biu = $time;
			stats1.errors_clk_core_biu++;
		end
		if (clk_itcm_ref !== (clk_itcm_ref ^ clk_itcm_dut ^ clk_itcm_ref)) begin
			if (stats1.errors_clk_itcm == 0) stats1.errortime_clk_itcm = $time;
			stats1.errors_clk_itcm++;
		end
		if (clk_dtcm_ref !== (clk_dtcm_ref ^ clk_dtcm_dut ^ clk_dtcm_ref)) begin
			if (stats1.errors_clk_dtcm == 0) stats1.errortime_clk_dtcm = $time;
			stats1.errors_clk_dtcm++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
