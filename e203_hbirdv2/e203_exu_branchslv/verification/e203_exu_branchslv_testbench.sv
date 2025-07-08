`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_cmt_i_ready;
		int errortime_cmt_i_ready;
		int errors_brchmis_flush_req;
		int errortime_brchmis_flush_req;
		int errors_brchmis_flush_add_op1;
		int errortime_brchmis_flush_add_op1;
		int errors_brchmis_flush_add_op2;
		int errortime_brchmis_flush_add_op2;
		int errors_brchmis_flush_pc;
		int errortime_brchmis_flush_pc;
		int errors_cmt_mret_ena;
		int errortime_cmt_mret_ena;
		int errors_cmt_dret_ena;
		int errortime_cmt_dret_ena;
		int errors_cmt_fencei_ena;
		int errortime_cmt_fencei_ena;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic cmt_i_valid;
	logic cmt_i_ready_ref;
	logic cmt_i_ready_dut;
	logic cmt_i_rv32;
	logic cmt_i_dret;
	logic cmt_i_mret;
	logic cmt_i_fencei;
	logic cmt_i_bjp;
	logic cmt_i_bjp_prdt;
	logic cmt_i_bjp_rslv;
	logic [32-1:0] cmt_i_pc;
	logic [32-1:0] cmt_i_imm;
	logic [32-1:0] csr_epc_r;
	logic [32-1:0] csr_dpc_r;
	logic nonalu_excpirq_flush_req_raw;
	logic brchmis_flush_ack;
	logic brchmis_flush_req_ref;
	logic brchmis_flush_req_dut;
	logic [32-1:0] brchmis_flush_add_op1_ref;
	logic [32-1:0] brchmis_flush_add_op1_dut;
	logic [32-1:0] brchmis_flush_add_op2_ref;
	logic [32-1:0] brchmis_flush_add_op2_dut;
	logic [32-1:0] brchmis_flush_pc_ref;
	logic [32-1:0] brchmis_flush_pc_dut;
	logic cmt_mret_ena_ref;
	logic cmt_mret_ena_dut;
	logic cmt_dret_ena_ref;
	logic cmt_dret_ena_dut;
	logic cmt_fencei_ena_ref;
	logic cmt_fencei_ena_dut;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.cmt_i_valid(cmt_i_valid),
		.cmt_i_rv32(cmt_i_rv32),
		.cmt_i_dret(cmt_i_dret),
		.cmt_i_mret(cmt_i_mret),
		.cmt_i_fencei(cmt_i_fencei),
		.cmt_i_bjp(cmt_i_bjp),
		.cmt_i_bjp_prdt(cmt_i_bjp_prdt),
		.cmt_i_bjp_rslv(cmt_i_bjp_rslv),
		.cmt_i_pc(cmt_i_pc),
		.cmt_i_imm(cmt_i_imm),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.nonalu_excpirq_flush_req_raw(nonalu_excpirq_flush_req_raw),
		.brchmis_flush_ack(brchmis_flush_ack),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_branchslv good1 (
		.cmt_i_valid(cmt_i_valid),
		.cmt_i_ready(cmt_i_ready_ref),
		.cmt_i_rv32(cmt_i_rv32),
		.cmt_i_dret(cmt_i_dret),
		.cmt_i_mret(cmt_i_mret),
		.cmt_i_fencei(cmt_i_fencei),
		.cmt_i_bjp(cmt_i_bjp),
		.cmt_i_bjp_prdt(cmt_i_bjp_prdt),
		.cmt_i_bjp_rslv(cmt_i_bjp_rslv),
		.cmt_i_pc(cmt_i_pc),
		.cmt_i_imm(cmt_i_imm),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.nonalu_excpirq_flush_req_raw(nonalu_excpirq_flush_req_raw),
		.brchmis_flush_ack(brchmis_flush_ack),
		.brchmis_flush_req(brchmis_flush_req_ref),
		.brchmis_flush_add_op1(brchmis_flush_add_op1_ref),
		.brchmis_flush_add_op2(brchmis_flush_add_op2_ref),
		.brchmis_flush_pc(brchmis_flush_pc_ref),
		.cmt_mret_ena(cmt_mret_ena_ref),
		.cmt_dret_ena(cmt_dret_ena_ref),
		.cmt_fencei_ena(cmt_fencei_ena_ref),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_branchslv top_module1 (
		.cmt_i_valid(cmt_i_valid),
		.cmt_i_ready(cmt_i_ready_dut),
		.cmt_i_rv32(cmt_i_rv32),
		.cmt_i_dret(cmt_i_dret),
		.cmt_i_mret(cmt_i_mret),
		.cmt_i_fencei(cmt_i_fencei),
		.cmt_i_bjp(cmt_i_bjp),
		.cmt_i_bjp_prdt(cmt_i_bjp_prdt),
		.cmt_i_bjp_rslv(cmt_i_bjp_rslv),
		.cmt_i_pc(cmt_i_pc),
		.cmt_i_imm(cmt_i_imm),
		.csr_epc_r(csr_epc_r),
		.csr_dpc_r(csr_dpc_r),
		.nonalu_excpirq_flush_req_raw(nonalu_excpirq_flush_req_raw),
		.brchmis_flush_ack(brchmis_flush_ack),
		.brchmis_flush_req(brchmis_flush_req_dut),
		.brchmis_flush_add_op1(brchmis_flush_add_op1_dut),
		.brchmis_flush_add_op2(brchmis_flush_add_op2_dut),
		.brchmis_flush_pc(brchmis_flush_pc_dut),
		.cmt_mret_ena(cmt_mret_ena_dut),
		.cmt_dret_ena(cmt_dret_ena_dut),
		.cmt_fencei_ena(cmt_fencei_ena_dut),
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
		if (stats1.errors_cmt_i_ready)
			$display("Hint: Output 'cmt_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_i_ready, stats1.errortime_cmt_i_ready);
		else
			$display("Hint: Output 'cmt_i_ready' has no mismatches.");
		if (stats1.errors_brchmis_flush_req)
			$display("Hint: Output 'brchmis_flush_req' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_brchmis_flush_req, stats1.errortime_brchmis_flush_req);
		else
			$display("Hint: Output 'brchmis_flush_req' has no mismatches.");
		if (stats1.errors_brchmis_flush_add_op1)
			$display("Hint: Output 'brchmis_flush_add_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_brchmis_flush_add_op1, stats1.errortime_brchmis_flush_add_op1);
		else
			$display("Hint: Output 'brchmis_flush_add_op1' has no mismatches.");
		if (stats1.errors_brchmis_flush_add_op2)
			$display("Hint: Output 'brchmis_flush_add_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_brchmis_flush_add_op2, stats1.errortime_brchmis_flush_add_op2);
		else
			$display("Hint: Output 'brchmis_flush_add_op2' has no mismatches.");
		if (stats1.errors_brchmis_flush_pc)
			$display("Hint: Output 'brchmis_flush_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_brchmis_flush_pc, stats1.errortime_brchmis_flush_pc);
		else
			$display("Hint: Output 'brchmis_flush_pc' has no mismatches.");
		if (stats1.errors_cmt_mret_ena)
			$display("Hint: Output 'cmt_mret_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_mret_ena, stats1.errortime_cmt_mret_ena);
		else
			$display("Hint: Output 'cmt_mret_ena' has no mismatches.");
		if (stats1.errors_cmt_dret_ena)
			$display("Hint: Output 'cmt_dret_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_dret_ena, stats1.errortime_cmt_dret_ena);
		else
			$display("Hint: Output 'cmt_dret_ena' has no mismatches.");
		if (stats1.errors_cmt_fencei_ena)
			$display("Hint: Output 'cmt_fencei_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_cmt_fencei_ena, stats1.errortime_cmt_fencei_ena);
		else
			$display("Hint: Output 'cmt_fencei_ena' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ cmt_i_ready_ref,brchmis_flush_req_ref,brchmis_flush_add_op1_ref,brchmis_flush_add_op2_ref,brchmis_flush_pc_ref,cmt_mret_ena_ref,cmt_dret_ena_ref,cmt_fencei_ena_ref} ===
			( { cmt_i_ready_ref,brchmis_flush_req_ref,brchmis_flush_add_op1_ref,brchmis_flush_add_op2_ref,brchmis_flush_pc_ref,cmt_mret_ena_ref,cmt_dret_ena_ref,cmt_fencei_ena_ref} ^
			  { cmt_i_ready_dut,brchmis_flush_req_dut,brchmis_flush_add_op1_dut,brchmis_flush_add_op2_dut,brchmis_flush_pc_dut,cmt_mret_ena_dut,cmt_dret_ena_dut,cmt_fencei_ena_dut} ^
			  { cmt_i_ready_ref,brchmis_flush_req_ref,brchmis_flush_add_op1_ref,brchmis_flush_add_op2_ref,brchmis_flush_pc_ref,cmt_mret_ena_ref,cmt_dret_ena_ref,cmt_fencei_ena_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (cmt_i_ready_ref !== (cmt_i_ready_ref ^ cmt_i_ready_dut ^ cmt_i_ready_ref)) begin
			if (stats1.errors_cmt_i_ready == 0) stats1.errortime_cmt_i_ready = $time;
			stats1.errors_cmt_i_ready++;
		end
		if (brchmis_flush_req_ref !== (brchmis_flush_req_ref ^ brchmis_flush_req_dut ^ brchmis_flush_req_ref)) begin
			if (stats1.errors_brchmis_flush_req == 0) stats1.errortime_brchmis_flush_req = $time;
			stats1.errors_brchmis_flush_req++;
		end
		if (brchmis_flush_add_op1_ref !== (brchmis_flush_add_op1_ref ^ brchmis_flush_add_op1_dut ^ brchmis_flush_add_op1_ref)) begin
			if (stats1.errors_brchmis_flush_add_op1 == 0) stats1.errortime_brchmis_flush_add_op1 = $time;
			stats1.errors_brchmis_flush_add_op1++;
		end
		if (brchmis_flush_add_op2_ref !== (brchmis_flush_add_op2_ref ^ brchmis_flush_add_op2_dut ^ brchmis_flush_add_op2_ref)) begin
			if (stats1.errors_brchmis_flush_add_op2 == 0) stats1.errortime_brchmis_flush_add_op2 = $time;
			stats1.errors_brchmis_flush_add_op2++;
		end
		if (brchmis_flush_pc_ref !== (brchmis_flush_pc_ref ^ brchmis_flush_pc_dut ^ brchmis_flush_pc_ref)) begin
			if (stats1.errors_brchmis_flush_pc == 0) stats1.errortime_brchmis_flush_pc = $time;
			stats1.errors_brchmis_flush_pc++;
		end
		if (cmt_mret_ena_ref !== (cmt_mret_ena_ref ^ cmt_mret_ena_dut ^ cmt_mret_ena_ref)) begin
			if (stats1.errors_cmt_mret_ena == 0) stats1.errortime_cmt_mret_ena = $time;
			stats1.errors_cmt_mret_ena++;
		end
		if (cmt_dret_ena_ref !== (cmt_dret_ena_ref ^ cmt_dret_ena_dut ^ cmt_dret_ena_ref)) begin
			if (stats1.errors_cmt_dret_ena == 0) stats1.errortime_cmt_dret_ena = $time;
			stats1.errors_cmt_dret_ena++;
		end
		if (cmt_fencei_ena_ref !== (cmt_fencei_ena_ref ^ cmt_fencei_ena_dut ^ cmt_fencei_ena_ref)) begin
			if (stats1.errors_cmt_fencei_ena == 0) stats1.errortime_cmt_fencei_ena = $time;
			stats1.errors_cmt_fencei_ena++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
