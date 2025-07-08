`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_dis_ready;
		int errortime_dis_ready;
		int errors_dis_ptr;
		int errortime_dis_ptr;
		int errors_ret_ptr;
		int errortime_ret_ptr;
		int errors_ret_rdidx;
		int errortime_ret_rdidx;
		int errors_ret_rdwen;
		int errortime_ret_rdwen;
		int errors_ret_rdfpu;
		int errortime_ret_rdfpu;
		int errors_ret_pc;
		int errortime_ret_pc;
		int errors_oitfrd_match_disprs1;
		int errortime_oitfrd_match_disprs1;
		int errors_oitfrd_match_disprs2;
		int errortime_oitfrd_match_disprs2;
		int errors_oitfrd_match_disprs3;
		int errortime_oitfrd_match_disprs3;
		int errors_oitfrd_match_disprd;
		int errortime_oitfrd_match_disprd;
		int errors_oitf_empty;
		int errortime_oitf_empty;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic dis_ready_ref;
	logic dis_ready_dut;
	logic dis_ena;
	logic ret_ena;
	logic dis_ptr_ref;
	logic dis_ptr_dut;
	logic ret_ptr_ref;
	logic ret_ptr_dut;
	logic [5-1:0] ret_rdidx_ref;
	logic [5-1:0] ret_rdidx_dut;
	logic ret_rdwen_ref;
	logic ret_rdwen_dut;
	logic ret_rdfpu_ref;
	logic ret_rdfpu_dut;
	logic [32-1:0] ret_pc_ref;
	logic [32-1:0] ret_pc_dut;
	logic disp_i_rs1en;
	logic disp_i_rs2en;
	logic disp_i_rs3en;
	logic disp_i_rdwen;
	logic disp_i_rs1fpu;
	logic disp_i_rs2fpu;
	logic disp_i_rs3fpu;
	logic disp_i_rdfpu;
	logic [5-1:0] disp_i_rs1idx;
	logic [5-1:0] disp_i_rs2idx;
	logic [5-1:0] disp_i_rs3idx;
	logic [5-1:0] disp_i_rdidx;
	logic [32-1:0] disp_i_pc;
	logic oitfrd_match_disprs1_ref;
	logic oitfrd_match_disprs1_dut;
	logic oitfrd_match_disprs2_ref;
	logic oitfrd_match_disprs2_dut;
	logic oitfrd_match_disprs3_ref;
	logic oitfrd_match_disprs3_dut;
	logic oitfrd_match_disprd_ref;
	logic oitfrd_match_disprd_dut;
	logic oitf_empty_ref;
	logic oitf_empty_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.dis_ena(dis_ena),
		.ret_ena(ret_ena),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs3en(disp_i_rs3en),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rs1fpu(disp_i_rs1fpu),
		.disp_i_rs2fpu(disp_i_rs2fpu),
		.disp_i_rs3fpu(disp_i_rs3fpu),
		.disp_i_rdfpu(disp_i_rdfpu),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs3idx(disp_i_rs3idx),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_pc(disp_i_pc),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_oitf good1 (
		.dis_ready(dis_ready_ref),
		.dis_ena(dis_ena),
		.ret_ena(ret_ena),
		.dis_ptr(dis_ptr_ref),
		.ret_ptr(ret_ptr_ref),
		.ret_rdidx(ret_rdidx_ref),
		.ret_rdwen(ret_rdwen_ref),
		.ret_rdfpu(ret_rdfpu_ref),
		.ret_pc(ret_pc_ref),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs3en(disp_i_rs3en),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rs1fpu(disp_i_rs1fpu),
		.disp_i_rs2fpu(disp_i_rs2fpu),
		.disp_i_rs3fpu(disp_i_rs3fpu),
		.disp_i_rdfpu(disp_i_rdfpu),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs3idx(disp_i_rs3idx),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_pc(disp_i_pc),
		.oitfrd_match_disprs1(oitfrd_match_disprs1_ref),
		.oitfrd_match_disprs2(oitfrd_match_disprs2_ref),
		.oitfrd_match_disprs3(oitfrd_match_disprs3_ref),
		.oitfrd_match_disprd(oitfrd_match_disprd_ref),
		.oitf_empty(oitf_empty_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_oitf top_module1 (
		.dis_ready(dis_ready_dut),
		.dis_ena(dis_ena),
		.ret_ena(ret_ena),
		.dis_ptr(dis_ptr_dut),
		.ret_ptr(ret_ptr_dut),
		.ret_rdidx(ret_rdidx_dut),
		.ret_rdwen(ret_rdwen_dut),
		.ret_rdfpu(ret_rdfpu_dut),
		.ret_pc(ret_pc_dut),
		.disp_i_rs1en(disp_i_rs1en),
		.disp_i_rs2en(disp_i_rs2en),
		.disp_i_rs3en(disp_i_rs3en),
		.disp_i_rdwen(disp_i_rdwen),
		.disp_i_rs1fpu(disp_i_rs1fpu),
		.disp_i_rs2fpu(disp_i_rs2fpu),
		.disp_i_rs3fpu(disp_i_rs3fpu),
		.disp_i_rdfpu(disp_i_rdfpu),
		.disp_i_rs1idx(disp_i_rs1idx),
		.disp_i_rs2idx(disp_i_rs2idx),
		.disp_i_rs3idx(disp_i_rs3idx),
		.disp_i_rdidx(disp_i_rdidx),
		.disp_i_pc(disp_i_pc),
		.oitfrd_match_disprs1(oitfrd_match_disprs1_dut),
		.oitfrd_match_disprs2(oitfrd_match_disprs2_dut),
		.oitfrd_match_disprs3(oitfrd_match_disprs3_dut),
		.oitfrd_match_disprd(oitfrd_match_disprd_dut),
		.oitf_empty(oitf_empty_dut),
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
		if (stats1.errors_dis_ready)
			$display("Hint: Output 'dis_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dis_ready, stats1.errortime_dis_ready);
		else
			$display("Hint: Output 'dis_ready' has no mismatches.");
		if (stats1.errors_dis_ptr)
			$display("Hint: Output 'dis_ptr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_dis_ptr, stats1.errortime_dis_ptr);
		else
			$display("Hint: Output 'dis_ptr' has no mismatches.");
		if (stats1.errors_ret_ptr)
			$display("Hint: Output 'ret_ptr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ret_ptr, stats1.errortime_ret_ptr);
		else
			$display("Hint: Output 'ret_ptr' has no mismatches.");
		if (stats1.errors_ret_rdidx)
			$display("Hint: Output 'ret_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ret_rdidx, stats1.errortime_ret_rdidx);
		else
			$display("Hint: Output 'ret_rdidx' has no mismatches.");
		if (stats1.errors_ret_rdwen)
			$display("Hint: Output 'ret_rdwen' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ret_rdwen, stats1.errortime_ret_rdwen);
		else
			$display("Hint: Output 'ret_rdwen' has no mismatches.");
		if (stats1.errors_ret_rdfpu)
			$display("Hint: Output 'ret_rdfpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ret_rdfpu, stats1.errortime_ret_rdfpu);
		else
			$display("Hint: Output 'ret_rdfpu' has no mismatches.");
		if (stats1.errors_ret_pc)
			$display("Hint: Output 'ret_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_ret_pc, stats1.errortime_ret_pc);
		else
			$display("Hint: Output 'ret_pc' has no mismatches.");
		if (stats1.errors_oitfrd_match_disprs1)
			$display("Hint: Output 'oitfrd_match_disprs1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitfrd_match_disprs1, stats1.errortime_oitfrd_match_disprs1);
		else
			$display("Hint: Output 'oitfrd_match_disprs1' has no mismatches.");
		if (stats1.errors_oitfrd_match_disprs2)
			$display("Hint: Output 'oitfrd_match_disprs2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitfrd_match_disprs2, stats1.errortime_oitfrd_match_disprs2);
		else
			$display("Hint: Output 'oitfrd_match_disprs2' has no mismatches.");
		if (stats1.errors_oitfrd_match_disprs3)
			$display("Hint: Output 'oitfrd_match_disprs3' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitfrd_match_disprs3, stats1.errortime_oitfrd_match_disprs3);
		else
			$display("Hint: Output 'oitfrd_match_disprs3' has no mismatches.");
		if (stats1.errors_oitfrd_match_disprd)
			$display("Hint: Output 'oitfrd_match_disprd' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitfrd_match_disprd, stats1.errortime_oitfrd_match_disprd);
		else
			$display("Hint: Output 'oitfrd_match_disprd' has no mismatches.");
		if (stats1.errors_oitf_empty)
			$display("Hint: Output 'oitf_empty' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitf_empty, stats1.errortime_oitf_empty);
		else
			$display("Hint: Output 'oitf_empty' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ dis_ready_ref,dis_ptr_ref,ret_ptr_ref,ret_rdidx_ref,ret_rdwen_ref,ret_rdfpu_ref,ret_pc_ref,oitfrd_match_disprs1_ref,oitfrd_match_disprs2_ref,oitfrd_match_disprs3_ref,oitfrd_match_disprd_ref,oitf_empty_ref} ===
			( { dis_ready_ref,dis_ptr_ref,ret_ptr_ref,ret_rdidx_ref,ret_rdwen_ref,ret_rdfpu_ref,ret_pc_ref,oitfrd_match_disprs1_ref,oitfrd_match_disprs2_ref,oitfrd_match_disprs3_ref,oitfrd_match_disprd_ref,oitf_empty_ref} ^
			  { dis_ready_dut,dis_ptr_dut,ret_ptr_dut,ret_rdidx_dut,ret_rdwen_dut,ret_rdfpu_dut,ret_pc_dut,oitfrd_match_disprs1_dut,oitfrd_match_disprs2_dut,oitfrd_match_disprs3_dut,oitfrd_match_disprd_dut,oitf_empty_dut} ^
			  { dis_ready_ref,dis_ptr_ref,ret_ptr_ref,ret_rdidx_ref,ret_rdwen_ref,ret_rdfpu_ref,ret_pc_ref,oitfrd_match_disprs1_ref,oitfrd_match_disprs2_ref,oitfrd_match_disprs3_ref,oitfrd_match_disprd_ref,oitf_empty_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (dis_ready_ref !== (dis_ready_ref ^ dis_ready_dut ^ dis_ready_ref)) begin
			if (stats1.errors_dis_ready == 0) stats1.errortime_dis_ready = $time;
			stats1.errors_dis_ready++;
		end
		if (dis_ptr_ref !== (dis_ptr_ref ^ dis_ptr_dut ^ dis_ptr_ref)) begin
			if (stats1.errors_dis_ptr == 0) stats1.errortime_dis_ptr = $time;
			stats1.errors_dis_ptr++;
		end
		if (ret_ptr_ref !== (ret_ptr_ref ^ ret_ptr_dut ^ ret_ptr_ref)) begin
			if (stats1.errors_ret_ptr == 0) stats1.errortime_ret_ptr = $time;
			stats1.errors_ret_ptr++;
		end
		if (ret_rdidx_ref !== (ret_rdidx_ref ^ ret_rdidx_dut ^ ret_rdidx_ref)) begin
			if (stats1.errors_ret_rdidx == 0) stats1.errortime_ret_rdidx = $time;
			stats1.errors_ret_rdidx++;
		end
		if (ret_rdwen_ref !== (ret_rdwen_ref ^ ret_rdwen_dut ^ ret_rdwen_ref)) begin
			if (stats1.errors_ret_rdwen == 0) stats1.errortime_ret_rdwen = $time;
			stats1.errors_ret_rdwen++;
		end
		if (ret_rdfpu_ref !== (ret_rdfpu_ref ^ ret_rdfpu_dut ^ ret_rdfpu_ref)) begin
			if (stats1.errors_ret_rdfpu == 0) stats1.errortime_ret_rdfpu = $time;
			stats1.errors_ret_rdfpu++;
		end
		if (ret_pc_ref !== (ret_pc_ref ^ ret_pc_dut ^ ret_pc_ref)) begin
			if (stats1.errors_ret_pc == 0) stats1.errortime_ret_pc = $time;
			stats1.errors_ret_pc++;
		end
		if (oitfrd_match_disprs1_ref !== (oitfrd_match_disprs1_ref ^ oitfrd_match_disprs1_dut ^ oitfrd_match_disprs1_ref)) begin
			if (stats1.errors_oitfrd_match_disprs1 == 0) stats1.errortime_oitfrd_match_disprs1 = $time;
			stats1.errors_oitfrd_match_disprs1++;
		end
		if (oitfrd_match_disprs2_ref !== (oitfrd_match_disprs2_ref ^ oitfrd_match_disprs2_dut ^ oitfrd_match_disprs2_ref)) begin
			if (stats1.errors_oitfrd_match_disprs2 == 0) stats1.errortime_oitfrd_match_disprs2 = $time;
			stats1.errors_oitfrd_match_disprs2++;
		end
		if (oitfrd_match_disprs3_ref !== (oitfrd_match_disprs3_ref ^ oitfrd_match_disprs3_dut ^ oitfrd_match_disprs3_ref)) begin
			if (stats1.errors_oitfrd_match_disprs3 == 0) stats1.errortime_oitfrd_match_disprs3 = $time;
			stats1.errors_oitfrd_match_disprs3++;
		end
		if (oitfrd_match_disprd_ref !== (oitfrd_match_disprd_ref ^ oitfrd_match_disprd_dut ^ oitfrd_match_disprd_ref)) begin
			if (stats1.errors_oitfrd_match_disprd == 0) stats1.errortime_oitfrd_match_disprd = $time;
			stats1.errors_oitfrd_match_disprd++;
		end
		if (oitf_empty_ref !== (oitf_empty_ref ^ oitf_empty_dut ^ oitf_empty_ref)) begin
			if (stats1.errors_oitf_empty == 0) stats1.errortime_oitf_empty = $time;
			stats1.errors_oitf_empty++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
