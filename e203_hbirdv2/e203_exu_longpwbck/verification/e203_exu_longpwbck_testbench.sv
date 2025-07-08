`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_lsu_wbck_i_ready;
		int errortime_lsu_wbck_i_ready;
		int errors_longp_wbck_o_valid;
		int errortime_longp_wbck_o_valid;
		int errors_longp_wbck_o_wdat;
		int errortime_longp_wbck_o_wdat;
		int errors_longp_wbck_o_flags;
		int errortime_longp_wbck_o_flags;
		int errors_longp_wbck_o_rdidx;
		int errortime_longp_wbck_o_rdidx;
		int errors_longp_wbck_o_rdfpu;
		int errortime_longp_wbck_o_rdfpu;
		int errors_longp_excp_o_valid;
		int errortime_longp_excp_o_valid;
		int errors_longp_excp_o_insterr;
		int errortime_longp_excp_o_insterr;
		int errors_longp_excp_o_ld;
		int errortime_longp_excp_o_ld;
		int errors_longp_excp_o_st;
		int errortime_longp_excp_o_st;
		int errors_longp_excp_o_buserr;
		int errortime_longp_excp_o_buserr;
		int errors_longp_excp_o_badaddr;
		int errortime_longp_excp_o_badaddr;
		int errors_longp_excp_o_pc;
		int errortime_longp_excp_o_pc;
		int errors_oitf_ret_ena;
		int errortime_oitf_ret_ena;
		int errors_nice_longp_wbck_i_ready;
		int errortime_nice_longp_wbck_i_ready;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic lsu_wbck_i_valid;
	logic lsu_wbck_i_ready_ref;
	logic lsu_wbck_i_ready_dut;
	logic [32-1:0] lsu_wbck_i_wdat;
	logic lsu_wbck_i_itag;
	logic lsu_wbck_i_err;
	logic lsu_cmt_i_buserr;
	logic [32-1:0] lsu_cmt_i_badaddr;
	logic lsu_cmt_i_ld;
	logic lsu_cmt_i_st;
	logic longp_wbck_o_valid_ref;
	logic longp_wbck_o_valid_dut;
	logic longp_wbck_o_ready;
	logic [32-1:0] longp_wbck_o_wdat_ref;
	logic [32-1:0] longp_wbck_o_wdat_dut;
	logic [5-1:0] longp_wbck_o_flags_ref;
	logic [5-1:0] longp_wbck_o_flags_dut;
	logic [5-1:0] longp_wbck_o_rdidx_ref;
	logic [5-1:0] longp_wbck_o_rdidx_dut;
	logic longp_wbck_o_rdfpu_ref;
	logic longp_wbck_o_rdfpu_dut;
	logic longp_excp_o_valid_ref;
	logic longp_excp_o_valid_dut;
	logic longp_excp_o_ready;
	logic longp_excp_o_insterr_ref;
	logic longp_excp_o_insterr_dut;
	logic longp_excp_o_ld_ref;
	logic longp_excp_o_ld_dut;
	logic longp_excp_o_st_ref;
	logic longp_excp_o_st_dut;
	logic longp_excp_o_buserr_ref;
	logic longp_excp_o_buserr_dut;
	logic [32-1:0] longp_excp_o_badaddr_ref;
	logic [32-1:0] longp_excp_o_badaddr_dut;
	logic [32-1:0] longp_excp_o_pc_ref;
	logic [32-1:0] longp_excp_o_pc_dut;
	logic oitf_empty;
	logic oitf_ret_ptr;
	logic [5-1:0] oitf_ret_rdidx;
	logic [32-1:0] oitf_ret_pc;
	logic oitf_ret_rdwen;
	logic oitf_ret_rdfpu;
	logic oitf_ret_ena_ref;
	logic oitf_ret_ena_dut;
	logic nice_longp_wbck_i_valid;
	logic nice_longp_wbck_i_ready_ref;
	logic nice_longp_wbck_i_ready_dut;
	logic [32-1:0] nice_longp_wbck_i_wdat;
	logic nice_longp_wbck_i_itag;
	logic nice_longp_wbck_i_err;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.lsu_wbck_i_valid(lsu_wbck_i_valid),
		.lsu_wbck_i_wdat(lsu_wbck_i_wdat),
		.lsu_wbck_i_itag(lsu_wbck_i_itag),
		.lsu_wbck_i_err(lsu_wbck_i_err),
		.lsu_cmt_i_buserr(lsu_cmt_i_buserr),
		.lsu_cmt_i_badaddr(lsu_cmt_i_badaddr),
		.lsu_cmt_i_ld(lsu_cmt_i_ld),
		.lsu_cmt_i_st(lsu_cmt_i_st),
		.longp_wbck_o_ready(longp_wbck_o_ready),
		.longp_excp_o_ready(longp_excp_o_ready),
		.oitf_empty(oitf_empty),
		.oitf_ret_ptr(oitf_ret_ptr),
		.oitf_ret_rdidx(oitf_ret_rdidx),
		.oitf_ret_pc(oitf_ret_pc),
		.oitf_ret_rdwen(oitf_ret_rdwen),
		.oitf_ret_rdfpu(oitf_ret_rdfpu),
		.nice_longp_wbck_i_valid(nice_longp_wbck_i_valid),
		.nice_longp_wbck_i_wdat(nice_longp_wbck_i_wdat),
		.nice_longp_wbck_i_itag(nice_longp_wbck_i_itag),
		.nice_longp_wbck_i_err(nice_longp_wbck_i_err),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_longpwbck good1 (
		.lsu_wbck_i_valid(lsu_wbck_i_valid),
		.lsu_wbck_i_ready(lsu_wbck_i_ready_ref),
		.lsu_wbck_i_wdat(lsu_wbck_i_wdat),
		.lsu_wbck_i_itag(lsu_wbck_i_itag),
		.lsu_wbck_i_err(lsu_wbck_i_err),
		.lsu_cmt_i_buserr(lsu_cmt_i_buserr),
		.lsu_cmt_i_badaddr(lsu_cmt_i_badaddr),
		.lsu_cmt_i_ld(lsu_cmt_i_ld),
		.lsu_cmt_i_st(lsu_cmt_i_st),
		.longp_wbck_o_valid(longp_wbck_o_valid_ref),
		.longp_wbck_o_ready(longp_wbck_o_ready),
		.longp_wbck_o_wdat(longp_wbck_o_wdat_ref),
		.longp_wbck_o_flags(longp_wbck_o_flags_ref),
		.longp_wbck_o_rdidx(longp_wbck_o_rdidx_ref),
		.longp_wbck_o_rdfpu(longp_wbck_o_rdfpu_ref),
		.longp_excp_o_valid(longp_excp_o_valid_ref),
		.longp_excp_o_ready(longp_excp_o_ready),
		.longp_excp_o_insterr(longp_excp_o_insterr_ref),
		.longp_excp_o_ld(longp_excp_o_ld_ref),
		.longp_excp_o_st(longp_excp_o_st_ref),
		.longp_excp_o_buserr(longp_excp_o_buserr_ref),
		.longp_excp_o_badaddr(longp_excp_o_badaddr_ref),
		.longp_excp_o_pc(longp_excp_o_pc_ref),
		.oitf_empty(oitf_empty),
		.oitf_ret_ptr(oitf_ret_ptr),
		.oitf_ret_rdidx(oitf_ret_rdidx),
		.oitf_ret_pc(oitf_ret_pc),
		.oitf_ret_rdwen(oitf_ret_rdwen),
		.oitf_ret_rdfpu(oitf_ret_rdfpu),
		.oitf_ret_ena(oitf_ret_ena_ref),
		.nice_longp_wbck_i_valid(nice_longp_wbck_i_valid),
		.nice_longp_wbck_i_ready(nice_longp_wbck_i_ready_ref),
		.nice_longp_wbck_i_wdat(nice_longp_wbck_i_wdat),
		.nice_longp_wbck_i_itag(nice_longp_wbck_i_itag),
		.nice_longp_wbck_i_err(nice_longp_wbck_i_err),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_longpwbck top_module1 (
		.lsu_wbck_i_valid(lsu_wbck_i_valid),
		.lsu_wbck_i_ready(lsu_wbck_i_ready_dut),
		.lsu_wbck_i_wdat(lsu_wbck_i_wdat),
		.lsu_wbck_i_itag(lsu_wbck_i_itag),
		.lsu_wbck_i_err(lsu_wbck_i_err),
		.lsu_cmt_i_buserr(lsu_cmt_i_buserr),
		.lsu_cmt_i_badaddr(lsu_cmt_i_badaddr),
		.lsu_cmt_i_ld(lsu_cmt_i_ld),
		.lsu_cmt_i_st(lsu_cmt_i_st),
		.longp_wbck_o_valid(longp_wbck_o_valid_dut),
		.longp_wbck_o_ready(longp_wbck_o_ready),
		.longp_wbck_o_wdat(longp_wbck_o_wdat_dut),
		.longp_wbck_o_flags(longp_wbck_o_flags_dut),
		.longp_wbck_o_rdidx(longp_wbck_o_rdidx_dut),
		.longp_wbck_o_rdfpu(longp_wbck_o_rdfpu_dut),
		.longp_excp_o_valid(longp_excp_o_valid_dut),
		.longp_excp_o_ready(longp_excp_o_ready),
		.longp_excp_o_insterr(longp_excp_o_insterr_dut),
		.longp_excp_o_ld(longp_excp_o_ld_dut),
		.longp_excp_o_st(longp_excp_o_st_dut),
		.longp_excp_o_buserr(longp_excp_o_buserr_dut),
		.longp_excp_o_badaddr(longp_excp_o_badaddr_dut),
		.longp_excp_o_pc(longp_excp_o_pc_dut),
		.oitf_empty(oitf_empty),
		.oitf_ret_ptr(oitf_ret_ptr),
		.oitf_ret_rdidx(oitf_ret_rdidx),
		.oitf_ret_pc(oitf_ret_pc),
		.oitf_ret_rdwen(oitf_ret_rdwen),
		.oitf_ret_rdfpu(oitf_ret_rdfpu),
		.oitf_ret_ena(oitf_ret_ena_dut),
		.nice_longp_wbck_i_valid(nice_longp_wbck_i_valid),
		.nice_longp_wbck_i_ready(nice_longp_wbck_i_ready_dut),
		.nice_longp_wbck_i_wdat(nice_longp_wbck_i_wdat),
		.nice_longp_wbck_i_itag(nice_longp_wbck_i_itag),
		.nice_longp_wbck_i_err(nice_longp_wbck_i_err),
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
		if (stats1.errors_lsu_wbck_i_ready)
			$display("Hint: Output 'lsu_wbck_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_lsu_wbck_i_ready, stats1.errortime_lsu_wbck_i_ready);
		else
			$display("Hint: Output 'lsu_wbck_i_ready' has no mismatches.");
		if (stats1.errors_longp_wbck_o_valid)
			$display("Hint: Output 'longp_wbck_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_o_valid, stats1.errortime_longp_wbck_o_valid);
		else
			$display("Hint: Output 'longp_wbck_o_valid' has no mismatches.");
		if (stats1.errors_longp_wbck_o_wdat)
			$display("Hint: Output 'longp_wbck_o_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_o_wdat, stats1.errortime_longp_wbck_o_wdat);
		else
			$display("Hint: Output 'longp_wbck_o_wdat' has no mismatches.");
		if (stats1.errors_longp_wbck_o_flags)
			$display("Hint: Output 'longp_wbck_o_flags' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_o_flags, stats1.errortime_longp_wbck_o_flags);
		else
			$display("Hint: Output 'longp_wbck_o_flags' has no mismatches.");
		if (stats1.errors_longp_wbck_o_rdidx)
			$display("Hint: Output 'longp_wbck_o_rdidx' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_o_rdidx, stats1.errortime_longp_wbck_o_rdidx);
		else
			$display("Hint: Output 'longp_wbck_o_rdidx' has no mismatches.");
		if (stats1.errors_longp_wbck_o_rdfpu)
			$display("Hint: Output 'longp_wbck_o_rdfpu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_wbck_o_rdfpu, stats1.errortime_longp_wbck_o_rdfpu);
		else
			$display("Hint: Output 'longp_wbck_o_rdfpu' has no mismatches.");
		if (stats1.errors_longp_excp_o_valid)
			$display("Hint: Output 'longp_excp_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_valid, stats1.errortime_longp_excp_o_valid);
		else
			$display("Hint: Output 'longp_excp_o_valid' has no mismatches.");
		if (stats1.errors_longp_excp_o_insterr)
			$display("Hint: Output 'longp_excp_o_insterr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_insterr, stats1.errortime_longp_excp_o_insterr);
		else
			$display("Hint: Output 'longp_excp_o_insterr' has no mismatches.");
		if (stats1.errors_longp_excp_o_ld)
			$display("Hint: Output 'longp_excp_o_ld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_ld, stats1.errortime_longp_excp_o_ld);
		else
			$display("Hint: Output 'longp_excp_o_ld' has no mismatches.");
		if (stats1.errors_longp_excp_o_st)
			$display("Hint: Output 'longp_excp_o_st' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_st, stats1.errortime_longp_excp_o_st);
		else
			$display("Hint: Output 'longp_excp_o_st' has no mismatches.");
		if (stats1.errors_longp_excp_o_buserr)
			$display("Hint: Output 'longp_excp_o_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_buserr, stats1.errortime_longp_excp_o_buserr);
		else
			$display("Hint: Output 'longp_excp_o_buserr' has no mismatches.");
		if (stats1.errors_longp_excp_o_badaddr)
			$display("Hint: Output 'longp_excp_o_badaddr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_badaddr, stats1.errortime_longp_excp_o_badaddr);
		else
			$display("Hint: Output 'longp_excp_o_badaddr' has no mismatches.");
		if (stats1.errors_longp_excp_o_pc)
			$display("Hint: Output 'longp_excp_o_pc' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_longp_excp_o_pc, stats1.errortime_longp_excp_o_pc);
		else
			$display("Hint: Output 'longp_excp_o_pc' has no mismatches.");
		if (stats1.errors_oitf_ret_ena)
			$display("Hint: Output 'oitf_ret_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_oitf_ret_ena, stats1.errortime_oitf_ret_ena);
		else
			$display("Hint: Output 'oitf_ret_ena' has no mismatches.");
		if (stats1.errors_nice_longp_wbck_i_ready)
			$display("Hint: Output 'nice_longp_wbck_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_longp_wbck_i_ready, stats1.errortime_nice_longp_wbck_i_ready);
		else
			$display("Hint: Output 'nice_longp_wbck_i_ready' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ lsu_wbck_i_ready_ref,longp_wbck_o_valid_ref,longp_wbck_o_wdat_ref,longp_wbck_o_flags_ref,longp_wbck_o_rdidx_ref,longp_wbck_o_rdfpu_ref,longp_excp_o_valid_ref,longp_excp_o_insterr_ref,longp_excp_o_ld_ref,longp_excp_o_st_ref,longp_excp_o_buserr_ref,longp_excp_o_badaddr_ref,longp_excp_o_pc_ref,oitf_ret_ena_ref,nice_longp_wbck_i_ready_ref} ===
			( { lsu_wbck_i_ready_ref,longp_wbck_o_valid_ref,longp_wbck_o_wdat_ref,longp_wbck_o_flags_ref,longp_wbck_o_rdidx_ref,longp_wbck_o_rdfpu_ref,longp_excp_o_valid_ref,longp_excp_o_insterr_ref,longp_excp_o_ld_ref,longp_excp_o_st_ref,longp_excp_o_buserr_ref,longp_excp_o_badaddr_ref,longp_excp_o_pc_ref,oitf_ret_ena_ref,nice_longp_wbck_i_ready_ref} ^
			  { lsu_wbck_i_ready_dut,longp_wbck_o_valid_dut,longp_wbck_o_wdat_dut,longp_wbck_o_flags_dut,longp_wbck_o_rdidx_dut,longp_wbck_o_rdfpu_dut,longp_excp_o_valid_dut,longp_excp_o_insterr_dut,longp_excp_o_ld_dut,longp_excp_o_st_dut,longp_excp_o_buserr_dut,longp_excp_o_badaddr_dut,longp_excp_o_pc_dut,oitf_ret_ena_dut,nice_longp_wbck_i_ready_dut} ^
			  { lsu_wbck_i_ready_ref,longp_wbck_o_valid_ref,longp_wbck_o_wdat_ref,longp_wbck_o_flags_ref,longp_wbck_o_rdidx_ref,longp_wbck_o_rdfpu_ref,longp_excp_o_valid_ref,longp_excp_o_insterr_ref,longp_excp_o_ld_ref,longp_excp_o_st_ref,longp_excp_o_buserr_ref,longp_excp_o_badaddr_ref,longp_excp_o_pc_ref,oitf_ret_ena_ref,nice_longp_wbck_i_ready_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (lsu_wbck_i_ready_ref !== (lsu_wbck_i_ready_ref ^ lsu_wbck_i_ready_dut ^ lsu_wbck_i_ready_ref)) begin
			if (stats1.errors_lsu_wbck_i_ready == 0) stats1.errortime_lsu_wbck_i_ready = $time;
			stats1.errors_lsu_wbck_i_ready++;
		end
		if (longp_wbck_o_valid_ref !== (longp_wbck_o_valid_ref ^ longp_wbck_o_valid_dut ^ longp_wbck_o_valid_ref)) begin
			if (stats1.errors_longp_wbck_o_valid == 0) stats1.errortime_longp_wbck_o_valid = $time;
			stats1.errors_longp_wbck_o_valid++;
		end
		if (longp_wbck_o_wdat_ref !== (longp_wbck_o_wdat_ref ^ longp_wbck_o_wdat_dut ^ longp_wbck_o_wdat_ref)) begin
			if (stats1.errors_longp_wbck_o_wdat == 0) stats1.errortime_longp_wbck_o_wdat = $time;
			stats1.errors_longp_wbck_o_wdat++;
		end
		if (longp_wbck_o_flags_ref !== (longp_wbck_o_flags_ref ^ longp_wbck_o_flags_dut ^ longp_wbck_o_flags_ref)) begin
			if (stats1.errors_longp_wbck_o_flags == 0) stats1.errortime_longp_wbck_o_flags = $time;
			stats1.errors_longp_wbck_o_flags++;
		end
		if (longp_wbck_o_rdidx_ref !== (longp_wbck_o_rdidx_ref ^ longp_wbck_o_rdidx_dut ^ longp_wbck_o_rdidx_ref)) begin
			if (stats1.errors_longp_wbck_o_rdidx == 0) stats1.errortime_longp_wbck_o_rdidx = $time;
			stats1.errors_longp_wbck_o_rdidx++;
		end
		if (longp_wbck_o_rdfpu_ref !== (longp_wbck_o_rdfpu_ref ^ longp_wbck_o_rdfpu_dut ^ longp_wbck_o_rdfpu_ref)) begin
			if (stats1.errors_longp_wbck_o_rdfpu == 0) stats1.errortime_longp_wbck_o_rdfpu = $time;
			stats1.errors_longp_wbck_o_rdfpu++;
		end
		if (longp_excp_o_valid_ref !== (longp_excp_o_valid_ref ^ longp_excp_o_valid_dut ^ longp_excp_o_valid_ref)) begin
			if (stats1.errors_longp_excp_o_valid == 0) stats1.errortime_longp_excp_o_valid = $time;
			stats1.errors_longp_excp_o_valid++;
		end
		if (longp_excp_o_insterr_ref !== (longp_excp_o_insterr_ref ^ longp_excp_o_insterr_dut ^ longp_excp_o_insterr_ref)) begin
			if (stats1.errors_longp_excp_o_insterr == 0) stats1.errortime_longp_excp_o_insterr = $time;
			stats1.errors_longp_excp_o_insterr++;
		end
		if (longp_excp_o_ld_ref !== (longp_excp_o_ld_ref ^ longp_excp_o_ld_dut ^ longp_excp_o_ld_ref)) begin
			if (stats1.errors_longp_excp_o_ld == 0) stats1.errortime_longp_excp_o_ld = $time;
			stats1.errors_longp_excp_o_ld++;
		end
		if (longp_excp_o_st_ref !== (longp_excp_o_st_ref ^ longp_excp_o_st_dut ^ longp_excp_o_st_ref)) begin
			if (stats1.errors_longp_excp_o_st == 0) stats1.errortime_longp_excp_o_st = $time;
			stats1.errors_longp_excp_o_st++;
		end
		if (longp_excp_o_buserr_ref !== (longp_excp_o_buserr_ref ^ longp_excp_o_buserr_dut ^ longp_excp_o_buserr_ref)) begin
			if (stats1.errors_longp_excp_o_buserr == 0) stats1.errortime_longp_excp_o_buserr = $time;
			stats1.errors_longp_excp_o_buserr++;
		end
		if (longp_excp_o_badaddr_ref !== (longp_excp_o_badaddr_ref ^ longp_excp_o_badaddr_dut ^ longp_excp_o_badaddr_ref)) begin
			if (stats1.errors_longp_excp_o_badaddr == 0) stats1.errortime_longp_excp_o_badaddr = $time;
			stats1.errors_longp_excp_o_badaddr++;
		end
		if (longp_excp_o_pc_ref !== (longp_excp_o_pc_ref ^ longp_excp_o_pc_dut ^ longp_excp_o_pc_ref)) begin
			if (stats1.errors_longp_excp_o_pc == 0) stats1.errortime_longp_excp_o_pc = $time;
			stats1.errors_longp_excp_o_pc++;
		end
		if (oitf_ret_ena_ref !== (oitf_ret_ena_ref ^ oitf_ret_ena_dut ^ oitf_ret_ena_ref)) begin
			if (stats1.errors_oitf_ret_ena == 0) stats1.errortime_oitf_ret_ena = $time;
			stats1.errors_oitf_ret_ena++;
		end
		if (nice_longp_wbck_i_ready_ref !== (nice_longp_wbck_i_ready_ref ^ nice_longp_wbck_i_ready_dut ^ nice_longp_wbck_i_ready_ref)) begin
			if (stats1.errors_nice_longp_wbck_i_ready == 0) stats1.errortime_nice_longp_wbck_i_ready = $time;
			stats1.errors_nice_longp_wbck_i_ready++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
