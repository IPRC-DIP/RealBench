`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_nice_xs_off;
		int errortime_nice_xs_off;
		int errors_csr_access_ilgl;
		int errortime_csr_access_ilgl;
		int errors_tm_stop;
		int errortime_tm_stop;
		int errors_core_cgstop;
		int errortime_core_cgstop;
		int errors_tcm_cgstop;
		int errortime_tcm_cgstop;
		int errors_itcm_nohold;
		int errortime_itcm_nohold;
		int errors_mdv_nob2b;
		int errortime_mdv_nob2b;
		int errors_read_csr_dat;
		int errortime_read_csr_dat;
		int errors_status_mie_r;
		int errortime_status_mie_r;
		int errors_mtie_r;
		int errortime_mtie_r;
		int errors_msie_r;
		int errortime_msie_r;
		int errors_meie_r;
		int errortime_meie_r;
		int errors_wr_dcsr_ena;
		int errortime_wr_dcsr_ena;
		int errors_wr_dpc_ena;
		int errortime_wr_dpc_ena;
		int errors_wr_dscratch_ena;
		int errortime_wr_dscratch_ena;
		int errors_wr_csr_nxt;
		int errortime_wr_csr_nxt;
		int errors_u_mode;
		int errortime_u_mode;
		int errors_s_mode;
		int errortime_s_mode;
		int errors_h_mode;
		int errortime_h_mode;
		int errors_m_mode;
		int errortime_m_mode;
		int errors_csr_epc_r;
		int errortime_csr_epc_r;
		int errors_csr_dpc_r;
		int errortime_csr_dpc_r;
		int errors_csr_mtvec_r;
		int errortime_csr_mtvec_r;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic nonflush_cmt_ena;
	logic nice_xs_off_ref;
	logic nice_xs_off_dut;
	logic csr_ena;
	logic csr_wr_en;
	logic csr_rd_en;
	logic [12-1:0] csr_idx;
	logic csr_access_ilgl_ref;
	logic csr_access_ilgl_dut;
	logic tm_stop_ref;
	logic tm_stop_dut;
	logic core_cgstop_ref;
	logic core_cgstop_dut;
	logic tcm_cgstop_ref;
	logic tcm_cgstop_dut;
	logic itcm_nohold_ref;
	logic itcm_nohold_dut;
	logic mdv_nob2b_ref;
	logic mdv_nob2b_dut;
	logic [32-1:0] read_csr_dat_ref;
	logic [32-1:0] read_csr_dat_dut;
	logic [32-1:0] wbck_csr_dat;
	logic core_mhartid;
	logic ext_irq_r;
	logic sft_irq_r;
	logic tmr_irq_r;
	logic status_mie_r_ref;
	logic status_mie_r_dut;
	logic mtie_r_ref;
	logic mtie_r_dut;
	logic msie_r_ref;
	logic msie_r_dut;
	logic meie_r_ref;
	logic meie_r_dut;
	logic wr_dcsr_ena_ref;
	logic wr_dcsr_ena_dut;
	logic wr_dpc_ena_ref;
	logic wr_dpc_ena_dut;
	logic wr_dscratch_ena_ref;
	logic wr_dscratch_ena_dut;
	logic [32-1:0] dcsr_r;
	logic [32-1:0] dpc_r;
	logic [32-1:0] dscratch_r;
	logic [32-1:0] wr_csr_nxt_ref;
	logic [32-1:0] wr_csr_nxt_dut;
	logic dbg_mode;
	logic dbg_stopcycle;
	logic u_mode_ref;
	logic u_mode_dut;
	logic s_mode_ref;
	logic s_mode_dut;
	logic h_mode_ref;
	logic h_mode_dut;
	logic m_mode_ref;
	logic m_mode_dut;
	logic [32-1:0] cmt_badaddr;
	logic cmt_badaddr_ena;
	logic [32-1:0] cmt_epc;
	logic cmt_epc_ena;
	logic [32-1:0] cmt_cause;
	logic cmt_cause_ena;
	logic cmt_status_ena;
	logic cmt_instret_ena;
	logic cmt_mret_ena;
	logic [32-1:0] csr_epc_r_ref;
	logic [32-1:0] csr_epc_r_dut;
	logic [32-1:0] csr_dpc_r_ref;
	logic [32-1:0] csr_dpc_r_dut;
	logic [32-1:0] csr_mtvec_r_ref;
	logic [32-1:0] csr_mtvec_r_dut;
	logic clk_aon;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.csr_ena(csr_ena),
		.csr_wr_en(csr_wr_en),
		.csr_rd_en(csr_rd_en),
		.csr_idx(csr_idx),
		.wbck_csr_dat(wbck_csr_dat),
		.core_mhartid(core_mhartid),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.dbg_mode(dbg_mode),
		.dbg_stopcycle(dbg_stopcycle),
		.cmt_badaddr(cmt_badaddr),
		.cmt_badaddr_ena(cmt_badaddr_ena),
		.cmt_epc(cmt_epc),
		.cmt_epc_ena(cmt_epc_ena),
		.cmt_cause(cmt_cause),
		.cmt_cause_ena(cmt_cause_ena),
		.cmt_status_ena(cmt_status_ena),
		.cmt_instret_ena(cmt_instret_ena),
		.cmt_mret_ena(cmt_mret_ena),
		.clk_aon(clk_aon),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_csr good1 (
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.nice_xs_off(nice_xs_off_ref),
		.csr_ena(csr_ena),
		.csr_wr_en(csr_wr_en),
		.csr_rd_en(csr_rd_en),
		.csr_idx(csr_idx),
		.csr_access_ilgl(csr_access_ilgl_ref),
		.tm_stop(tm_stop_ref),
		.core_cgstop(core_cgstop_ref),
		.tcm_cgstop(tcm_cgstop_ref),
		.itcm_nohold(itcm_nohold_ref),
		.mdv_nob2b(mdv_nob2b_ref),
		.read_csr_dat(read_csr_dat_ref),
		.wbck_csr_dat(wbck_csr_dat),
		.core_mhartid(core_mhartid),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.status_mie_r(status_mie_r_ref),
		.mtie_r(mtie_r_ref),
		.msie_r(msie_r_ref),
		.meie_r(meie_r_ref),
		.wr_dcsr_ena(wr_dcsr_ena_ref),
		.wr_dpc_ena(wr_dpc_ena_ref),
		.wr_dscratch_ena(wr_dscratch_ena_ref),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.wr_csr_nxt(wr_csr_nxt_ref),
		.dbg_mode(dbg_mode),
		.dbg_stopcycle(dbg_stopcycle),
		.u_mode(u_mode_ref),
		.s_mode(s_mode_ref),
		.h_mode(h_mode_ref),
		.m_mode(m_mode_ref),
		.cmt_badaddr(cmt_badaddr),
		.cmt_badaddr_ena(cmt_badaddr_ena),
		.cmt_epc(cmt_epc),
		.cmt_epc_ena(cmt_epc_ena),
		.cmt_cause(cmt_cause),
		.cmt_cause_ena(cmt_cause_ena),
		.cmt_status_ena(cmt_status_ena),
		.cmt_instret_ena(cmt_instret_ena),
		.cmt_mret_ena(cmt_mret_ena),
		.csr_epc_r(csr_epc_r_ref),
		.csr_dpc_r(csr_dpc_r_ref),
		.csr_mtvec_r(csr_mtvec_r_ref),
		.clk_aon(clk_aon),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_csr top_module1 (
		.nonflush_cmt_ena(nonflush_cmt_ena),
		.nice_xs_off(nice_xs_off_dut),
		.csr_ena(csr_ena),
		.csr_wr_en(csr_wr_en),
		.csr_rd_en(csr_rd_en),
		.csr_idx(csr_idx),
		.csr_access_ilgl(csr_access_ilgl_dut),
		.tm_stop(tm_stop_dut),
		.core_cgstop(core_cgstop_dut),
		.tcm_cgstop(tcm_cgstop_dut),
		.itcm_nohold(itcm_nohold_dut),
		.mdv_nob2b(mdv_nob2b_dut),
		.read_csr_dat(read_csr_dat_dut),
		.wbck_csr_dat(wbck_csr_dat),
		.core_mhartid(core_mhartid),
		.ext_irq_r(ext_irq_r),
		.sft_irq_r(sft_irq_r),
		.tmr_irq_r(tmr_irq_r),
		.status_mie_r(status_mie_r_dut),
		.mtie_r(mtie_r_dut),
		.msie_r(msie_r_dut),
		.meie_r(meie_r_dut),
		.wr_dcsr_ena(wr_dcsr_ena_dut),
		.wr_dpc_ena(wr_dpc_ena_dut),
		.wr_dscratch_ena(wr_dscratch_ena_dut),
		.dcsr_r(dcsr_r),
		.dpc_r(dpc_r),
		.dscratch_r(dscratch_r),
		.wr_csr_nxt(wr_csr_nxt_dut),
		.dbg_mode(dbg_mode),
		.dbg_stopcycle(dbg_stopcycle),
		.u_mode(u_mode_dut),
		.s_mode(s_mode_dut),
		.h_mode(h_mode_dut),
		.m_mode(m_mode_dut),
		.cmt_badaddr(cmt_badaddr),
		.cmt_badaddr_ena(cmt_badaddr_ena),
		.cmt_epc(cmt_epc),
		.cmt_epc_ena(cmt_epc_ena),
		.cmt_cause(cmt_cause),
		.cmt_cause_ena(cmt_cause_ena),
		.cmt_status_ena(cmt_status_ena),
		.cmt_instret_ena(cmt_instret_ena),
		.cmt_mret_ena(cmt_mret_ena),
		.csr_epc_r(csr_epc_r_dut),
		.csr_dpc_r(csr_dpc_r_dut),
		.csr_mtvec_r(csr_mtvec_r_dut),
		.clk_aon(clk_aon),
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
		if (stats1.errors_nice_xs_off)
			$display("Hint: Output 'nice_xs_off' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_nice_xs_off, stats1.errortime_nice_xs_off);
		else
			$display("Hint: Output 'nice_xs_off' has no mismatches.");
		if (stats1.errors_csr_access_ilgl)
			$display("Hint: Output 'csr_access_ilgl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_access_ilgl, stats1.errortime_csr_access_ilgl);
		else
			$display("Hint: Output 'csr_access_ilgl' has no mismatches.");
		if (stats1.errors_tm_stop)
			$display("Hint: Output 'tm_stop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_tm_stop, stats1.errortime_tm_stop);
		else
			$display("Hint: Output 'tm_stop' has no mismatches.");
		if (stats1.errors_core_cgstop)
			$display("Hint: Output 'core_cgstop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_core_cgstop, stats1.errortime_core_cgstop);
		else
			$display("Hint: Output 'core_cgstop' has no mismatches.");
		if (stats1.errors_tcm_cgstop)
			$display("Hint: Output 'tcm_cgstop' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_tcm_cgstop, stats1.errortime_tcm_cgstop);
		else
			$display("Hint: Output 'tcm_cgstop' has no mismatches.");
		if (stats1.errors_itcm_nohold)
			$display("Hint: Output 'itcm_nohold' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_itcm_nohold, stats1.errortime_itcm_nohold);
		else
			$display("Hint: Output 'itcm_nohold' has no mismatches.");
		if (stats1.errors_mdv_nob2b)
			$display("Hint: Output 'mdv_nob2b' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mdv_nob2b, stats1.errortime_mdv_nob2b);
		else
			$display("Hint: Output 'mdv_nob2b' has no mismatches.");
		if (stats1.errors_read_csr_dat)
			$display("Hint: Output 'read_csr_dat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_read_csr_dat, stats1.errortime_read_csr_dat);
		else
			$display("Hint: Output 'read_csr_dat' has no mismatches.");
		if (stats1.errors_status_mie_r)
			$display("Hint: Output 'status_mie_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_status_mie_r, stats1.errortime_status_mie_r);
		else
			$display("Hint: Output 'status_mie_r' has no mismatches.");
		if (stats1.errors_mtie_r)
			$display("Hint: Output 'mtie_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_mtie_r, stats1.errortime_mtie_r);
		else
			$display("Hint: Output 'mtie_r' has no mismatches.");
		if (stats1.errors_msie_r)
			$display("Hint: Output 'msie_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_msie_r, stats1.errortime_msie_r);
		else
			$display("Hint: Output 'msie_r' has no mismatches.");
		if (stats1.errors_meie_r)
			$display("Hint: Output 'meie_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_meie_r, stats1.errortime_meie_r);
		else
			$display("Hint: Output 'meie_r' has no mismatches.");
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
		if (stats1.errors_u_mode)
			$display("Hint: Output 'u_mode' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_u_mode, stats1.errortime_u_mode);
		else
			$display("Hint: Output 'u_mode' has no mismatches.");
		if (stats1.errors_s_mode)
			$display("Hint: Output 's_mode' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_s_mode, stats1.errortime_s_mode);
		else
			$display("Hint: Output 's_mode' has no mismatches.");
		if (stats1.errors_h_mode)
			$display("Hint: Output 'h_mode' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_h_mode, stats1.errortime_h_mode);
		else
			$display("Hint: Output 'h_mode' has no mismatches.");
		if (stats1.errors_m_mode)
			$display("Hint: Output 'm_mode' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_m_mode, stats1.errortime_m_mode);
		else
			$display("Hint: Output 'm_mode' has no mismatches.");
		if (stats1.errors_csr_epc_r)
			$display("Hint: Output 'csr_epc_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_epc_r, stats1.errortime_csr_epc_r);
		else
			$display("Hint: Output 'csr_epc_r' has no mismatches.");
		if (stats1.errors_csr_dpc_r)
			$display("Hint: Output 'csr_dpc_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_dpc_r, stats1.errortime_csr_dpc_r);
		else
			$display("Hint: Output 'csr_dpc_r' has no mismatches.");
		if (stats1.errors_csr_mtvec_r)
			$display("Hint: Output 'csr_mtvec_r' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_csr_mtvec_r, stats1.errortime_csr_mtvec_r);
		else
			$display("Hint: Output 'csr_mtvec_r' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ nice_xs_off_ref,csr_access_ilgl_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,itcm_nohold_ref,mdv_nob2b_ref,read_csr_dat_ref,status_mie_r_ref,mtie_r_ref,msie_r_ref,meie_r_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,u_mode_ref,s_mode_ref,h_mode_ref,m_mode_ref,csr_epc_r_ref,csr_dpc_r_ref,csr_mtvec_r_ref} ===
			( { nice_xs_off_ref,csr_access_ilgl_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,itcm_nohold_ref,mdv_nob2b_ref,read_csr_dat_ref,status_mie_r_ref,mtie_r_ref,msie_r_ref,meie_r_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,u_mode_ref,s_mode_ref,h_mode_ref,m_mode_ref,csr_epc_r_ref,csr_dpc_r_ref,csr_mtvec_r_ref} ^
			  { nice_xs_off_dut,csr_access_ilgl_dut,tm_stop_dut,core_cgstop_dut,tcm_cgstop_dut,itcm_nohold_dut,mdv_nob2b_dut,read_csr_dat_dut,status_mie_r_dut,mtie_r_dut,msie_r_dut,meie_r_dut,wr_dcsr_ena_dut,wr_dpc_ena_dut,wr_dscratch_ena_dut,wr_csr_nxt_dut,u_mode_dut,s_mode_dut,h_mode_dut,m_mode_dut,csr_epc_r_dut,csr_dpc_r_dut,csr_mtvec_r_dut} ^
			  { nice_xs_off_ref,csr_access_ilgl_ref,tm_stop_ref,core_cgstop_ref,tcm_cgstop_ref,itcm_nohold_ref,mdv_nob2b_ref,read_csr_dat_ref,status_mie_r_ref,mtie_r_ref,msie_r_ref,meie_r_ref,wr_dcsr_ena_ref,wr_dpc_ena_ref,wr_dscratch_ena_ref,wr_csr_nxt_ref,u_mode_ref,s_mode_ref,h_mode_ref,m_mode_ref,csr_epc_r_ref,csr_dpc_r_ref,csr_mtvec_r_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (nice_xs_off_ref !== (nice_xs_off_ref ^ nice_xs_off_dut ^ nice_xs_off_ref)) begin
			if (stats1.errors_nice_xs_off == 0) stats1.errortime_nice_xs_off = $time;
			stats1.errors_nice_xs_off++;
		end
		if (csr_access_ilgl_ref !== (csr_access_ilgl_ref ^ csr_access_ilgl_dut ^ csr_access_ilgl_ref)) begin
			if (stats1.errors_csr_access_ilgl == 0) stats1.errortime_csr_access_ilgl = $time;
			stats1.errors_csr_access_ilgl++;
		end
		if (tm_stop_ref !== (tm_stop_ref ^ tm_stop_dut ^ tm_stop_ref)) begin
			if (stats1.errors_tm_stop == 0) stats1.errortime_tm_stop = $time;
			stats1.errors_tm_stop++;
		end
		if (core_cgstop_ref !== (core_cgstop_ref ^ core_cgstop_dut ^ core_cgstop_ref)) begin
			if (stats1.errors_core_cgstop == 0) stats1.errortime_core_cgstop = $time;
			stats1.errors_core_cgstop++;
		end
		if (tcm_cgstop_ref !== (tcm_cgstop_ref ^ tcm_cgstop_dut ^ tcm_cgstop_ref)) begin
			if (stats1.errors_tcm_cgstop == 0) stats1.errortime_tcm_cgstop = $time;
			stats1.errors_tcm_cgstop++;
		end
		if (itcm_nohold_ref !== (itcm_nohold_ref ^ itcm_nohold_dut ^ itcm_nohold_ref)) begin
			if (stats1.errors_itcm_nohold == 0) stats1.errortime_itcm_nohold = $time;
			stats1.errors_itcm_nohold++;
		end
		if (mdv_nob2b_ref !== (mdv_nob2b_ref ^ mdv_nob2b_dut ^ mdv_nob2b_ref)) begin
			if (stats1.errors_mdv_nob2b == 0) stats1.errortime_mdv_nob2b = $time;
			stats1.errors_mdv_nob2b++;
		end
		if (read_csr_dat_ref !== (read_csr_dat_ref ^ read_csr_dat_dut ^ read_csr_dat_ref)) begin
			if (stats1.errors_read_csr_dat == 0) stats1.errortime_read_csr_dat = $time;
			stats1.errors_read_csr_dat++;
		end
		if (status_mie_r_ref !== (status_mie_r_ref ^ status_mie_r_dut ^ status_mie_r_ref)) begin
			if (stats1.errors_status_mie_r == 0) stats1.errortime_status_mie_r = $time;
			stats1.errors_status_mie_r++;
		end
		if (mtie_r_ref !== (mtie_r_ref ^ mtie_r_dut ^ mtie_r_ref)) begin
			if (stats1.errors_mtie_r == 0) stats1.errortime_mtie_r = $time;
			stats1.errors_mtie_r++;
		end
		if (msie_r_ref !== (msie_r_ref ^ msie_r_dut ^ msie_r_ref)) begin
			if (stats1.errors_msie_r == 0) stats1.errortime_msie_r = $time;
			stats1.errors_msie_r++;
		end
		if (meie_r_ref !== (meie_r_ref ^ meie_r_dut ^ meie_r_ref)) begin
			if (stats1.errors_meie_r == 0) stats1.errortime_meie_r = $time;
			stats1.errors_meie_r++;
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
		if (u_mode_ref !== (u_mode_ref ^ u_mode_dut ^ u_mode_ref)) begin
			if (stats1.errors_u_mode == 0) stats1.errortime_u_mode = $time;
			stats1.errors_u_mode++;
		end
		if (s_mode_ref !== (s_mode_ref ^ s_mode_dut ^ s_mode_ref)) begin
			if (stats1.errors_s_mode == 0) stats1.errortime_s_mode = $time;
			stats1.errors_s_mode++;
		end
		if (h_mode_ref !== (h_mode_ref ^ h_mode_dut ^ h_mode_ref)) begin
			if (stats1.errors_h_mode == 0) stats1.errortime_h_mode = $time;
			stats1.errors_h_mode++;
		end
		if (m_mode_ref !== (m_mode_ref ^ m_mode_dut ^ m_mode_ref)) begin
			if (stats1.errors_m_mode == 0) stats1.errortime_m_mode = $time;
			stats1.errors_m_mode++;
		end
		if (csr_epc_r_ref !== (csr_epc_r_ref ^ csr_epc_r_dut ^ csr_epc_r_ref)) begin
			if (stats1.errors_csr_epc_r == 0) stats1.errortime_csr_epc_r = $time;
			stats1.errors_csr_epc_r++;
		end
		if (csr_dpc_r_ref !== (csr_dpc_r_ref ^ csr_dpc_r_dut ^ csr_dpc_r_ref)) begin
			if (stats1.errors_csr_dpc_r == 0) stats1.errortime_csr_dpc_r = $time;
			stats1.errors_csr_dpc_r++;
		end
		if (csr_mtvec_r_ref !== (csr_mtvec_r_ref ^ csr_mtvec_r_dut ^ csr_mtvec_r_ref)) begin
			if (stats1.errors_csr_mtvec_r == 0) stats1.errortime_csr_mtvec_r = $time;
			stats1.errors_csr_mtvec_r++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
