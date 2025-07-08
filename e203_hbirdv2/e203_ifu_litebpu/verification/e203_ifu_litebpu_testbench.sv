`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_bpu_wait;
		int errortime_bpu_wait;
		int errors_prdt_taken;
		int errortime_prdt_taken;
		int errors_prdt_pc_add_op1;
		int errortime_prdt_pc_add_op1;
		int errors_prdt_pc_add_op2;
		int errortime_prdt_pc_add_op2;
		int errors_bpu2rf_rs1_ena;
		int errortime_bpu2rf_rs1_ena;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic [32-1:0] pc;
	logic dec_jal;
	logic dec_jalr;
	logic dec_bxx;
	logic [32-1:0] dec_bjp_imm;
	logic [5-1:0] dec_jalr_rs1idx;
	logic oitf_empty;
	logic ir_empty;
	logic ir_rs1en;
	logic jalr_rs1idx_cam_irrdidx;
	logic bpu_wait_ref;
	logic bpu_wait_dut;
	logic prdt_taken_ref;
	logic prdt_taken_dut;
	logic [32-1:0] prdt_pc_add_op1_ref;
	logic [32-1:0] prdt_pc_add_op1_dut;
	logic [32-1:0] prdt_pc_add_op2_ref;
	logic [32-1:0] prdt_pc_add_op2_dut;
	logic dec_i_valid;
	logic bpu2rf_rs1_ena_ref;
	logic bpu2rf_rs1_ena_dut;
	logic ir_valid_clr;
	logic [32-1:0] rf2bpu_x1;
	logic [32-1:0] rf2bpu_rs1;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.pc(pc),
		.dec_jal(dec_jal),
		.dec_jalr(dec_jalr),
		.dec_bxx(dec_bxx),
		.dec_bjp_imm(dec_bjp_imm),
		.dec_jalr_rs1idx(dec_jalr_rs1idx),
		.oitf_empty(oitf_empty),
		.ir_empty(ir_empty),
		.ir_rs1en(ir_rs1en),
		.jalr_rs1idx_cam_irrdidx(jalr_rs1idx_cam_irrdidx),
		.dec_i_valid(dec_i_valid),
		.ir_valid_clr(ir_valid_clr),
		.rf2bpu_x1(rf2bpu_x1),
		.rf2bpu_rs1(rf2bpu_rs1),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_ifu_litebpu good1 (
		.pc(pc),
		.dec_jal(dec_jal),
		.dec_jalr(dec_jalr),
		.dec_bxx(dec_bxx),
		.dec_bjp_imm(dec_bjp_imm),
		.dec_jalr_rs1idx(dec_jalr_rs1idx),
		.oitf_empty(oitf_empty),
		.ir_empty(ir_empty),
		.ir_rs1en(ir_rs1en),
		.jalr_rs1idx_cam_irrdidx(jalr_rs1idx_cam_irrdidx),
		.bpu_wait(bpu_wait_ref),
		.prdt_taken(prdt_taken_ref),
		.prdt_pc_add_op1(prdt_pc_add_op1_ref),
		.prdt_pc_add_op2(prdt_pc_add_op2_ref),
		.dec_i_valid(dec_i_valid),
		.bpu2rf_rs1_ena(bpu2rf_rs1_ena_ref),
		.ir_valid_clr(ir_valid_clr),
		.rf2bpu_x1(rf2bpu_x1),
		.rf2bpu_rs1(rf2bpu_rs1),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_ifu_litebpu top_module1 (
		.pc(pc),
		.dec_jal(dec_jal),
		.dec_jalr(dec_jalr),
		.dec_bxx(dec_bxx),
		.dec_bjp_imm(dec_bjp_imm),
		.dec_jalr_rs1idx(dec_jalr_rs1idx),
		.oitf_empty(oitf_empty),
		.ir_empty(ir_empty),
		.ir_rs1en(ir_rs1en),
		.jalr_rs1idx_cam_irrdidx(jalr_rs1idx_cam_irrdidx),
		.bpu_wait(bpu_wait_dut),
		.prdt_taken(prdt_taken_dut),
		.prdt_pc_add_op1(prdt_pc_add_op1_dut),
		.prdt_pc_add_op2(prdt_pc_add_op2_dut),
		.dec_i_valid(dec_i_valid),
		.bpu2rf_rs1_ena(bpu2rf_rs1_ena_dut),
		.ir_valid_clr(ir_valid_clr),
		.rf2bpu_x1(rf2bpu_x1),
		.rf2bpu_rs1(rf2bpu_rs1),
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
		if (stats1.errors_bpu_wait)
			$display("Hint: Output 'bpu_wait' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bpu_wait, stats1.errortime_bpu_wait);
		else
			$display("Hint: Output 'bpu_wait' has no mismatches.");
		if (stats1.errors_prdt_taken)
			$display("Hint: Output 'prdt_taken' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_prdt_taken, stats1.errortime_prdt_taken);
		else
			$display("Hint: Output 'prdt_taken' has no mismatches.");
		if (stats1.errors_prdt_pc_add_op1)
			$display("Hint: Output 'prdt_pc_add_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_prdt_pc_add_op1, stats1.errortime_prdt_pc_add_op1);
		else
			$display("Hint: Output 'prdt_pc_add_op1' has no mismatches.");
		if (stats1.errors_prdt_pc_add_op2)
			$display("Hint: Output 'prdt_pc_add_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_prdt_pc_add_op2, stats1.errortime_prdt_pc_add_op2);
		else
			$display("Hint: Output 'prdt_pc_add_op2' has no mismatches.");
		if (stats1.errors_bpu2rf_rs1_ena)
			$display("Hint: Output 'bpu2rf_rs1_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_bpu2rf_rs1_ena, stats1.errortime_bpu2rf_rs1_ena);
		else
			$display("Hint: Output 'bpu2rf_rs1_ena' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ bpu_wait_ref,prdt_taken_ref,prdt_pc_add_op1_ref,prdt_pc_add_op2_ref,bpu2rf_rs1_ena_ref} ===
			( { bpu_wait_ref,prdt_taken_ref,prdt_pc_add_op1_ref,prdt_pc_add_op2_ref,bpu2rf_rs1_ena_ref} ^
			  { bpu_wait_dut,prdt_taken_dut,prdt_pc_add_op1_dut,prdt_pc_add_op2_dut,bpu2rf_rs1_ena_dut} ^
			  { bpu_wait_ref,prdt_taken_ref,prdt_pc_add_op1_ref,prdt_pc_add_op2_ref,bpu2rf_rs1_ena_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (bpu_wait_ref !== (bpu_wait_ref ^ bpu_wait_dut ^ bpu_wait_ref)) begin
			if (stats1.errors_bpu_wait == 0) stats1.errortime_bpu_wait = $time;
			stats1.errors_bpu_wait++;
		end
		if (prdt_taken_ref !== (prdt_taken_ref ^ prdt_taken_dut ^ prdt_taken_ref)) begin
			if (stats1.errors_prdt_taken == 0) stats1.errortime_prdt_taken = $time;
			stats1.errors_prdt_taken++;
		end
		if (prdt_pc_add_op1_ref !== (prdt_pc_add_op1_ref ^ prdt_pc_add_op1_dut ^ prdt_pc_add_op1_ref)) begin
			if (stats1.errors_prdt_pc_add_op1 == 0) stats1.errortime_prdt_pc_add_op1 = $time;
			stats1.errors_prdt_pc_add_op1++;
		end
		if (prdt_pc_add_op2_ref !== (prdt_pc_add_op2_ref ^ prdt_pc_add_op2_dut ^ prdt_pc_add_op2_ref)) begin
			if (stats1.errors_prdt_pc_add_op2 == 0) stats1.errortime_prdt_pc_add_op2 = $time;
			stats1.errors_prdt_pc_add_op2++;
		end
		if (bpu2rf_rs1_ena_ref !== (bpu2rf_rs1_ena_ref ^ bpu2rf_rs1_ena_dut ^ bpu2rf_rs1_ena_ref)) begin
			if (stats1.errors_bpu2rf_rs1_ena == 0) stats1.errortime_bpu2rf_rs1_ena = $time;
			stats1.errors_bpu2rf_rs1_ena++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
