`timescale 1 ps/1 ps

module tb();
    
    typedef struct packed {
        int errors;
        int errortime;
		int errors_agu_i_ready;
		int errortime_agu_i_ready;
		int errors_agu_i_longpipe;
		int errortime_agu_i_longpipe;
		int errors_amo_wait;
		int errortime_amo_wait;
		int errors_agu_o_valid;
		int errortime_agu_o_valid;
		int errors_agu_o_wbck_wdat;
		int errortime_agu_o_wbck_wdat;
		int errors_agu_o_wbck_err;
		int errortime_agu_o_wbck_err;
		int errors_agu_o_cmt_misalgn;
		int errortime_agu_o_cmt_misalgn;
		int errors_agu_o_cmt_ld;
		int errortime_agu_o_cmt_ld;
		int errors_agu_o_cmt_stamo;
		int errortime_agu_o_cmt_stamo;
		int errors_agu_o_cmt_buserr;
		int errortime_agu_o_cmt_buserr;
		int errors_agu_o_cmt_badaddr;
		int errortime_agu_o_cmt_badaddr;
		int errors_agu_icb_cmd_valid;
		int errortime_agu_icb_cmd_valid;
		int errors_agu_icb_cmd_addr;
		int errortime_agu_icb_cmd_addr;
		int errors_agu_icb_cmd_read;
		int errortime_agu_icb_cmd_read;
		int errors_agu_icb_cmd_wdata;
		int errortime_agu_icb_cmd_wdata;
		int errors_agu_icb_cmd_wmask;
		int errortime_agu_icb_cmd_wmask;
		int errors_agu_icb_cmd_back2agu;
		int errortime_agu_icb_cmd_back2agu;
		int errors_agu_icb_cmd_lock;
		int errortime_agu_icb_cmd_lock;
		int errors_agu_icb_cmd_excl;
		int errortime_agu_icb_cmd_excl;
		int errors_agu_icb_cmd_size;
		int errortime_agu_icb_cmd_size;
		int errors_agu_icb_cmd_itag;
		int errortime_agu_icb_cmd_itag;
		int errors_agu_icb_cmd_usign;
		int errortime_agu_icb_cmd_usign;
		int errors_agu_icb_rsp_ready;
		int errortime_agu_icb_rsp_ready;
		int errors_agu_req_alu_op1;
		int errortime_agu_req_alu_op1;
		int errors_agu_req_alu_op2;
		int errortime_agu_req_alu_op2;
		int errors_agu_req_alu_swap;
		int errortime_agu_req_alu_swap;
		int errors_agu_req_alu_add;
		int errortime_agu_req_alu_add;
		int errors_agu_req_alu_and;
		int errortime_agu_req_alu_and;
		int errors_agu_req_alu_or;
		int errortime_agu_req_alu_or;
		int errors_agu_req_alu_xor;
		int errortime_agu_req_alu_xor;
		int errors_agu_req_alu_max;
		int errortime_agu_req_alu_max;
		int errors_agu_req_alu_min;
		int errortime_agu_req_alu_min;
		int errors_agu_req_alu_maxu;
		int errortime_agu_req_alu_maxu;
		int errors_agu_req_alu_minu;
		int errortime_agu_req_alu_minu;
		int errors_agu_sbf_0_ena;
		int errortime_agu_sbf_0_ena;
		int errors_agu_sbf_0_nxt;
		int errortime_agu_sbf_0_nxt;
		int errors_agu_sbf_1_ena;
		int errortime_agu_sbf_1_ena;
		int errors_agu_sbf_1_nxt;
		int errortime_agu_sbf_1_nxt;
        int clocks;
    } stats;
   
    stats stats1;
   
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
	logic agu_i_valid;
	logic agu_i_ready_ref;
	logic agu_i_ready_dut;
	logic [32-1:0] agu_i_rs1;
	logic [32-1:0] agu_i_rs2;
	logic [32-1:0] agu_i_imm;
	logic [21-1:0] agu_i_info;
	logic agu_i_itag;
	logic agu_i_longpipe_ref;
	logic agu_i_longpipe_dut;
	logic flush_req;
	logic flush_pulse;
	logic amo_wait_ref;
	logic amo_wait_dut;
	logic oitf_empty;
	logic agu_o_valid_ref;
	logic agu_o_valid_dut;
	logic agu_o_ready;
	logic [32-1:0] agu_o_wbck_wdat_ref;
	logic [32-1:0] agu_o_wbck_wdat_dut;
	logic agu_o_wbck_err_ref;
	logic agu_o_wbck_err_dut;
	logic agu_o_cmt_misalgn_ref;
	logic agu_o_cmt_misalgn_dut;
	logic agu_o_cmt_ld_ref;
	logic agu_o_cmt_ld_dut;
	logic agu_o_cmt_stamo_ref;
	logic agu_o_cmt_stamo_dut;
	logic agu_o_cmt_buserr_ref;
	logic agu_o_cmt_buserr_dut;
	logic [32-1:0] agu_o_cmt_badaddr_ref;
	logic [32-1:0] agu_o_cmt_badaddr_dut;
	logic agu_icb_cmd_valid_ref;
	logic agu_icb_cmd_valid_dut;
	logic agu_icb_cmd_ready;
	logic [32-1:0] agu_icb_cmd_addr_ref;
	logic [32-1:0] agu_icb_cmd_addr_dut;
	logic agu_icb_cmd_read_ref;
	logic agu_icb_cmd_read_dut;
	logic [32-1:0] agu_icb_cmd_wdata_ref;
	logic [32-1:0] agu_icb_cmd_wdata_dut;
	logic [4-1:0] agu_icb_cmd_wmask_ref;
	logic [4-1:0] agu_icb_cmd_wmask_dut;
	logic agu_icb_cmd_back2agu_ref;
	logic agu_icb_cmd_back2agu_dut;
	logic agu_icb_cmd_lock_ref;
	logic agu_icb_cmd_lock_dut;
	logic agu_icb_cmd_excl_ref;
	logic agu_icb_cmd_excl_dut;
	logic [2-1:0] agu_icb_cmd_size_ref;
	logic [2-1:0] agu_icb_cmd_size_dut;
	logic agu_icb_cmd_itag_ref;
	logic agu_icb_cmd_itag_dut;
	logic agu_icb_cmd_usign_ref;
	logic agu_icb_cmd_usign_dut;
	logic agu_icb_rsp_valid;
	logic agu_icb_rsp_ready_ref;
	logic agu_icb_rsp_ready_dut;
	logic agu_icb_rsp_err;
	logic agu_icb_rsp_excl_ok;
	logic [32-1:0] agu_icb_rsp_rdata;
	logic [32-1:0] agu_req_alu_op1_ref;
	logic [32-1:0] agu_req_alu_op1_dut;
	logic [32-1:0] agu_req_alu_op2_ref;
	logic [32-1:0] agu_req_alu_op2_dut;
	logic agu_req_alu_swap_ref;
	logic agu_req_alu_swap_dut;
	logic agu_req_alu_add_ref;
	logic agu_req_alu_add_dut;
	logic agu_req_alu_and_ref;
	logic agu_req_alu_and_dut;
	logic agu_req_alu_or_ref;
	logic agu_req_alu_or_dut;
	logic agu_req_alu_xor_ref;
	logic agu_req_alu_xor_dut;
	logic agu_req_alu_max_ref;
	logic agu_req_alu_max_dut;
	logic agu_req_alu_min_ref;
	logic agu_req_alu_min_dut;
	logic agu_req_alu_maxu_ref;
	logic agu_req_alu_maxu_dut;
	logic agu_req_alu_minu_ref;
	logic agu_req_alu_minu_dut;
	logic [32-1:0] agu_req_alu_res;
	logic agu_sbf_0_ena_ref;
	logic agu_sbf_0_ena_dut;
	logic [32-1:0] agu_sbf_0_nxt_ref;
	logic [32-1:0] agu_sbf_0_nxt_dut;
	logic [32-1:0] agu_sbf_0_r;
	logic agu_sbf_1_ena_ref;
	logic agu_sbf_1_ena_dut;
	logic [32-1:0] agu_sbf_1_nxt_ref;
	logic [32-1:0] agu_sbf_1_nxt_dut;
	logic [32-1:0] agu_sbf_1_r;
	logic rst_n;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
    // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化激励模块
    stimulus_gen stim1 (
		.agu_i_valid(agu_i_valid),
		.agu_i_rs1(agu_i_rs1),
		.agu_i_rs2(agu_i_rs2),
		.agu_i_imm(agu_i_imm),
		.agu_i_info(agu_i_info),
		.agu_i_itag(agu_i_itag),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.oitf_empty(oitf_empty),
		.agu_o_ready(agu_o_ready),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.agu_req_alu_res(agu_req_alu_res),
		.agu_sbf_0_r(agu_sbf_0_r),
		.agu_sbf_1_r(agu_sbf_1_r),
		.clk(clk),
		.rst_n(rst_n),
        .wavedrom_title(wavedrom_title),
        .tb_match(tb_match),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模块
	ref_e203_exu_alu_lsuagu good1 (
		.agu_i_valid(agu_i_valid),
		.agu_i_ready(agu_i_ready_ref),
		.agu_i_rs1(agu_i_rs1),
		.agu_i_rs2(agu_i_rs2),
		.agu_i_imm(agu_i_imm),
		.agu_i_info(agu_i_info),
		.agu_i_itag(agu_i_itag),
		.agu_i_longpipe(agu_i_longpipe_ref),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.amo_wait(amo_wait_ref),
		.oitf_empty(oitf_empty),
		.agu_o_valid(agu_o_valid_ref),
		.agu_o_ready(agu_o_ready),
		.agu_o_wbck_wdat(agu_o_wbck_wdat_ref),
		.agu_o_wbck_err(agu_o_wbck_err_ref),
		.agu_o_cmt_misalgn(agu_o_cmt_misalgn_ref),
		.agu_o_cmt_ld(agu_o_cmt_ld_ref),
		.agu_o_cmt_stamo(agu_o_cmt_stamo_ref),
		.agu_o_cmt_buserr(agu_o_cmt_buserr_ref),
		.agu_o_cmt_badaddr(agu_o_cmt_badaddr_ref),
		.agu_icb_cmd_valid(agu_icb_cmd_valid_ref),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_cmd_addr(agu_icb_cmd_addr_ref),
		.agu_icb_cmd_read(agu_icb_cmd_read_ref),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata_ref),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask_ref),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu_ref),
		.agu_icb_cmd_lock(agu_icb_cmd_lock_ref),
		.agu_icb_cmd_excl(agu_icb_cmd_excl_ref),
		.agu_icb_cmd_size(agu_icb_cmd_size_ref),
		.agu_icb_cmd_itag(agu_icb_cmd_itag_ref),
		.agu_icb_cmd_usign(agu_icb_cmd_usign_ref),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_ready(agu_icb_rsp_ready_ref),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.agu_req_alu_op1(agu_req_alu_op1_ref),
		.agu_req_alu_op2(agu_req_alu_op2_ref),
		.agu_req_alu_swap(agu_req_alu_swap_ref),
		.agu_req_alu_add(agu_req_alu_add_ref),
		.agu_req_alu_and(agu_req_alu_and_ref),
		.agu_req_alu_or(agu_req_alu_or_ref),
		.agu_req_alu_xor(agu_req_alu_xor_ref),
		.agu_req_alu_max(agu_req_alu_max_ref),
		.agu_req_alu_min(agu_req_alu_min_ref),
		.agu_req_alu_maxu(agu_req_alu_maxu_ref),
		.agu_req_alu_minu(agu_req_alu_minu_ref),
		.agu_req_alu_res(agu_req_alu_res),
		.agu_sbf_0_ena(agu_sbf_0_ena_ref),
		.agu_sbf_0_nxt(agu_sbf_0_nxt_ref),
		.agu_sbf_0_r(agu_sbf_0_r),
		.agu_sbf_1_ena(agu_sbf_1_ena_ref),
		.agu_sbf_1_nxt(agu_sbf_1_nxt_ref),
		.agu_sbf_1_r(agu_sbf_1_r),
		.clk(clk),
		.rst_n(rst_n)
	);
       
    // 实例化待测模块
	e203_exu_alu_lsuagu top_module1 (
		.agu_i_valid(agu_i_valid),
		.agu_i_ready(agu_i_ready_dut),
		.agu_i_rs1(agu_i_rs1),
		.agu_i_rs2(agu_i_rs2),
		.agu_i_imm(agu_i_imm),
		.agu_i_info(agu_i_info),
		.agu_i_itag(agu_i_itag),
		.agu_i_longpipe(agu_i_longpipe_dut),
		.flush_req(flush_req),
		.flush_pulse(flush_pulse),
		.amo_wait(amo_wait_dut),
		.oitf_empty(oitf_empty),
		.agu_o_valid(agu_o_valid_dut),
		.agu_o_ready(agu_o_ready),
		.agu_o_wbck_wdat(agu_o_wbck_wdat_dut),
		.agu_o_wbck_err(agu_o_wbck_err_dut),
		.agu_o_cmt_misalgn(agu_o_cmt_misalgn_dut),
		.agu_o_cmt_ld(agu_o_cmt_ld_dut),
		.agu_o_cmt_stamo(agu_o_cmt_stamo_dut),
		.agu_o_cmt_buserr(agu_o_cmt_buserr_dut),
		.agu_o_cmt_badaddr(agu_o_cmt_badaddr_dut),
		.agu_icb_cmd_valid(agu_icb_cmd_valid_dut),
		.agu_icb_cmd_ready(agu_icb_cmd_ready),
		.agu_icb_cmd_addr(agu_icb_cmd_addr_dut),
		.agu_icb_cmd_read(agu_icb_cmd_read_dut),
		.agu_icb_cmd_wdata(agu_icb_cmd_wdata_dut),
		.agu_icb_cmd_wmask(agu_icb_cmd_wmask_dut),
		.agu_icb_cmd_back2agu(agu_icb_cmd_back2agu_dut),
		.agu_icb_cmd_lock(agu_icb_cmd_lock_dut),
		.agu_icb_cmd_excl(agu_icb_cmd_excl_dut),
		.agu_icb_cmd_size(agu_icb_cmd_size_dut),
		.agu_icb_cmd_itag(agu_icb_cmd_itag_dut),
		.agu_icb_cmd_usign(agu_icb_cmd_usign_dut),
		.agu_icb_rsp_valid(agu_icb_rsp_valid),
		.agu_icb_rsp_ready(agu_icb_rsp_ready_dut),
		.agu_icb_rsp_err(agu_icb_rsp_err),
		.agu_icb_rsp_excl_ok(agu_icb_rsp_excl_ok),
		.agu_icb_rsp_rdata(agu_icb_rsp_rdata),
		.agu_req_alu_op1(agu_req_alu_op1_dut),
		.agu_req_alu_op2(agu_req_alu_op2_dut),
		.agu_req_alu_swap(agu_req_alu_swap_dut),
		.agu_req_alu_add(agu_req_alu_add_dut),
		.agu_req_alu_and(agu_req_alu_and_dut),
		.agu_req_alu_or(agu_req_alu_or_dut),
		.agu_req_alu_xor(agu_req_alu_xor_dut),
		.agu_req_alu_max(agu_req_alu_max_dut),
		.agu_req_alu_min(agu_req_alu_min_dut),
		.agu_req_alu_maxu(agu_req_alu_maxu_dut),
		.agu_req_alu_minu(agu_req_alu_minu_dut),
		.agu_req_alu_res(agu_req_alu_res),
		.agu_sbf_0_ena(agu_sbf_0_ena_dut),
		.agu_sbf_0_nxt(agu_sbf_0_nxt_dut),
		.agu_sbf_0_r(agu_sbf_0_r),
		.agu_sbf_1_ena(agu_sbf_1_ena_dut),
		.agu_sbf_1_nxt(agu_sbf_1_nxt_dut),
		.agu_sbf_1_r(agu_sbf_1_r),
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
		if (stats1.errors_agu_i_ready)
			$display("Hint: Output 'agu_i_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_i_ready, stats1.errortime_agu_i_ready);
		else
			$display("Hint: Output 'agu_i_ready' has no mismatches.");
		if (stats1.errors_agu_i_longpipe)
			$display("Hint: Output 'agu_i_longpipe' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_i_longpipe, stats1.errortime_agu_i_longpipe);
		else
			$display("Hint: Output 'agu_i_longpipe' has no mismatches.");
		if (stats1.errors_amo_wait)
			$display("Hint: Output 'amo_wait' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_amo_wait, stats1.errortime_amo_wait);
		else
			$display("Hint: Output 'amo_wait' has no mismatches.");
		if (stats1.errors_agu_o_valid)
			$display("Hint: Output 'agu_o_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_valid, stats1.errortime_agu_o_valid);
		else
			$display("Hint: Output 'agu_o_valid' has no mismatches.");
		if (stats1.errors_agu_o_wbck_wdat)
			$display("Hint: Output 'agu_o_wbck_wdat' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_wbck_wdat, stats1.errortime_agu_o_wbck_wdat);
		else
			$display("Hint: Output 'agu_o_wbck_wdat' has no mismatches.");
		if (stats1.errors_agu_o_wbck_err)
			$display("Hint: Output 'agu_o_wbck_err' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_wbck_err, stats1.errortime_agu_o_wbck_err);
		else
			$display("Hint: Output 'agu_o_wbck_err' has no mismatches.");
		if (stats1.errors_agu_o_cmt_misalgn)
			$display("Hint: Output 'agu_o_cmt_misalgn' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_cmt_misalgn, stats1.errortime_agu_o_cmt_misalgn);
		else
			$display("Hint: Output 'agu_o_cmt_misalgn' has no mismatches.");
		if (stats1.errors_agu_o_cmt_ld)
			$display("Hint: Output 'agu_o_cmt_ld' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_cmt_ld, stats1.errortime_agu_o_cmt_ld);
		else
			$display("Hint: Output 'agu_o_cmt_ld' has no mismatches.");
		if (stats1.errors_agu_o_cmt_stamo)
			$display("Hint: Output 'agu_o_cmt_stamo' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_cmt_stamo, stats1.errortime_agu_o_cmt_stamo);
		else
			$display("Hint: Output 'agu_o_cmt_stamo' has no mismatches.");
		if (stats1.errors_agu_o_cmt_buserr)
			$display("Hint: Output 'agu_o_cmt_buserr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_cmt_buserr, stats1.errortime_agu_o_cmt_buserr);
		else
			$display("Hint: Output 'agu_o_cmt_buserr' has no mismatches.");
		if (stats1.errors_agu_o_cmt_badaddr)
			$display("Hint: Output 'agu_o_cmt_badaddr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_o_cmt_badaddr, stats1.errortime_agu_o_cmt_badaddr);
		else
			$display("Hint: Output 'agu_o_cmt_badaddr' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_valid)
			$display("Hint: Output 'agu_icb_cmd_valid' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_valid, stats1.errortime_agu_icb_cmd_valid);
		else
			$display("Hint: Output 'agu_icb_cmd_valid' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_addr)
			$display("Hint: Output 'agu_icb_cmd_addr' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_addr, stats1.errortime_agu_icb_cmd_addr);
		else
			$display("Hint: Output 'agu_icb_cmd_addr' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_read)
			$display("Hint: Output 'agu_icb_cmd_read' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_read, stats1.errortime_agu_icb_cmd_read);
		else
			$display("Hint: Output 'agu_icb_cmd_read' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_wdata)
			$display("Hint: Output 'agu_icb_cmd_wdata' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_wdata, stats1.errortime_agu_icb_cmd_wdata);
		else
			$display("Hint: Output 'agu_icb_cmd_wdata' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_wmask)
			$display("Hint: Output 'agu_icb_cmd_wmask' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_wmask, stats1.errortime_agu_icb_cmd_wmask);
		else
			$display("Hint: Output 'agu_icb_cmd_wmask' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_back2agu)
			$display("Hint: Output 'agu_icb_cmd_back2agu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_back2agu, stats1.errortime_agu_icb_cmd_back2agu);
		else
			$display("Hint: Output 'agu_icb_cmd_back2agu' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_lock)
			$display("Hint: Output 'agu_icb_cmd_lock' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_lock, stats1.errortime_agu_icb_cmd_lock);
		else
			$display("Hint: Output 'agu_icb_cmd_lock' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_excl)
			$display("Hint: Output 'agu_icb_cmd_excl' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_excl, stats1.errortime_agu_icb_cmd_excl);
		else
			$display("Hint: Output 'agu_icb_cmd_excl' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_size)
			$display("Hint: Output 'agu_icb_cmd_size' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_size, stats1.errortime_agu_icb_cmd_size);
		else
			$display("Hint: Output 'agu_icb_cmd_size' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_itag)
			$display("Hint: Output 'agu_icb_cmd_itag' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_itag, stats1.errortime_agu_icb_cmd_itag);
		else
			$display("Hint: Output 'agu_icb_cmd_itag' has no mismatches.");
		if (stats1.errors_agu_icb_cmd_usign)
			$display("Hint: Output 'agu_icb_cmd_usign' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_cmd_usign, stats1.errortime_agu_icb_cmd_usign);
		else
			$display("Hint: Output 'agu_icb_cmd_usign' has no mismatches.");
		if (stats1.errors_agu_icb_rsp_ready)
			$display("Hint: Output 'agu_icb_rsp_ready' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_icb_rsp_ready, stats1.errortime_agu_icb_rsp_ready);
		else
			$display("Hint: Output 'agu_icb_rsp_ready' has no mismatches.");
		if (stats1.errors_agu_req_alu_op1)
			$display("Hint: Output 'agu_req_alu_op1' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_op1, stats1.errortime_agu_req_alu_op1);
		else
			$display("Hint: Output 'agu_req_alu_op1' has no mismatches.");
		if (stats1.errors_agu_req_alu_op2)
			$display("Hint: Output 'agu_req_alu_op2' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_op2, stats1.errortime_agu_req_alu_op2);
		else
			$display("Hint: Output 'agu_req_alu_op2' has no mismatches.");
		if (stats1.errors_agu_req_alu_swap)
			$display("Hint: Output 'agu_req_alu_swap' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_swap, stats1.errortime_agu_req_alu_swap);
		else
			$display("Hint: Output 'agu_req_alu_swap' has no mismatches.");
		if (stats1.errors_agu_req_alu_add)
			$display("Hint: Output 'agu_req_alu_add' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_add, stats1.errortime_agu_req_alu_add);
		else
			$display("Hint: Output 'agu_req_alu_add' has no mismatches.");
		if (stats1.errors_agu_req_alu_and)
			$display("Hint: Output 'agu_req_alu_and' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_and, stats1.errortime_agu_req_alu_and);
		else
			$display("Hint: Output 'agu_req_alu_and' has no mismatches.");
		if (stats1.errors_agu_req_alu_or)
			$display("Hint: Output 'agu_req_alu_or' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_or, stats1.errortime_agu_req_alu_or);
		else
			$display("Hint: Output 'agu_req_alu_or' has no mismatches.");
		if (stats1.errors_agu_req_alu_xor)
			$display("Hint: Output 'agu_req_alu_xor' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_xor, stats1.errortime_agu_req_alu_xor);
		else
			$display("Hint: Output 'agu_req_alu_xor' has no mismatches.");
		if (stats1.errors_agu_req_alu_max)
			$display("Hint: Output 'agu_req_alu_max' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_max, stats1.errortime_agu_req_alu_max);
		else
			$display("Hint: Output 'agu_req_alu_max' has no mismatches.");
		if (stats1.errors_agu_req_alu_min)
			$display("Hint: Output 'agu_req_alu_min' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_min, stats1.errortime_agu_req_alu_min);
		else
			$display("Hint: Output 'agu_req_alu_min' has no mismatches.");
		if (stats1.errors_agu_req_alu_maxu)
			$display("Hint: Output 'agu_req_alu_maxu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_maxu, stats1.errortime_agu_req_alu_maxu);
		else
			$display("Hint: Output 'agu_req_alu_maxu' has no mismatches.");
		if (stats1.errors_agu_req_alu_minu)
			$display("Hint: Output 'agu_req_alu_minu' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_req_alu_minu, stats1.errortime_agu_req_alu_minu);
		else
			$display("Hint: Output 'agu_req_alu_minu' has no mismatches.");
		if (stats1.errors_agu_sbf_0_ena)
			$display("Hint: Output 'agu_sbf_0_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_0_ena, stats1.errortime_agu_sbf_0_ena);
		else
			$display("Hint: Output 'agu_sbf_0_ena' has no mismatches.");
		if (stats1.errors_agu_sbf_0_nxt)
			$display("Hint: Output 'agu_sbf_0_nxt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_0_nxt, stats1.errortime_agu_sbf_0_nxt);
		else
			$display("Hint: Output 'agu_sbf_0_nxt' has no mismatches.");
		if (stats1.errors_agu_sbf_1_ena)
			$display("Hint: Output 'agu_sbf_1_ena' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_1_ena, stats1.errortime_agu_sbf_1_ena);
		else
			$display("Hint: Output 'agu_sbf_1_ena' has no mismatches.");
		if (stats1.errors_agu_sbf_1_nxt)
			$display("Hint: Output 'agu_sbf_1_nxt' has %0d mismatches. First mismatch occurred at time %0d.", 
					stats1.errors_agu_sbf_1_nxt, stats1.errortime_agu_sbf_1_nxt);
		else
			$display("Hint: Output 'agu_sbf_1_nxt' has no mismatches.");
   
        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    // 公式化信号对比
    assign tb_match =
		{ agu_i_ready_ref,agu_i_longpipe_ref,amo_wait_ref,agu_o_valid_ref,agu_o_wbck_wdat_ref,agu_o_wbck_err_ref,agu_o_cmt_misalgn_ref,agu_o_cmt_ld_ref,agu_o_cmt_stamo_ref,agu_o_cmt_buserr_ref,agu_o_cmt_badaddr_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_itag_ref,agu_icb_cmd_usign_ref,agu_icb_rsp_ready_ref,agu_req_alu_op1_ref,agu_req_alu_op2_ref,agu_req_alu_swap_ref,agu_req_alu_add_ref,agu_req_alu_and_ref,agu_req_alu_or_ref,agu_req_alu_xor_ref,agu_req_alu_max_ref,agu_req_alu_min_ref,agu_req_alu_maxu_ref,agu_req_alu_minu_ref,agu_sbf_0_ena_ref,agu_sbf_0_nxt_ref,agu_sbf_1_ena_ref,agu_sbf_1_nxt_ref} ===
			( { agu_i_ready_ref,agu_i_longpipe_ref,amo_wait_ref,agu_o_valid_ref,agu_o_wbck_wdat_ref,agu_o_wbck_err_ref,agu_o_cmt_misalgn_ref,agu_o_cmt_ld_ref,agu_o_cmt_stamo_ref,agu_o_cmt_buserr_ref,agu_o_cmt_badaddr_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_itag_ref,agu_icb_cmd_usign_ref,agu_icb_rsp_ready_ref,agu_req_alu_op1_ref,agu_req_alu_op2_ref,agu_req_alu_swap_ref,agu_req_alu_add_ref,agu_req_alu_and_ref,agu_req_alu_or_ref,agu_req_alu_xor_ref,agu_req_alu_max_ref,agu_req_alu_min_ref,agu_req_alu_maxu_ref,agu_req_alu_minu_ref,agu_sbf_0_ena_ref,agu_sbf_0_nxt_ref,agu_sbf_1_ena_ref,agu_sbf_1_nxt_ref} ^
			  { agu_i_ready_dut,agu_i_longpipe_dut,amo_wait_dut,agu_o_valid_dut,agu_o_wbck_wdat_dut,agu_o_wbck_err_dut,agu_o_cmt_misalgn_dut,agu_o_cmt_ld_dut,agu_o_cmt_stamo_dut,agu_o_cmt_buserr_dut,agu_o_cmt_badaddr_dut,agu_icb_cmd_valid_dut,agu_icb_cmd_addr_dut,agu_icb_cmd_read_dut,agu_icb_cmd_wdata_dut,agu_icb_cmd_wmask_dut,agu_icb_cmd_back2agu_dut,agu_icb_cmd_lock_dut,agu_icb_cmd_excl_dut,agu_icb_cmd_size_dut,agu_icb_cmd_itag_dut,agu_icb_cmd_usign_dut,agu_icb_rsp_ready_dut,agu_req_alu_op1_dut,agu_req_alu_op2_dut,agu_req_alu_swap_dut,agu_req_alu_add_dut,agu_req_alu_and_dut,agu_req_alu_or_dut,agu_req_alu_xor_dut,agu_req_alu_max_dut,agu_req_alu_min_dut,agu_req_alu_maxu_dut,agu_req_alu_minu_dut,agu_sbf_0_ena_dut,agu_sbf_0_nxt_dut,agu_sbf_1_ena_dut,agu_sbf_1_nxt_dut} ^
			  { agu_i_ready_ref,agu_i_longpipe_ref,amo_wait_ref,agu_o_valid_ref,agu_o_wbck_wdat_ref,agu_o_wbck_err_ref,agu_o_cmt_misalgn_ref,agu_o_cmt_ld_ref,agu_o_cmt_stamo_ref,agu_o_cmt_buserr_ref,agu_o_cmt_badaddr_ref,agu_icb_cmd_valid_ref,agu_icb_cmd_addr_ref,agu_icb_cmd_read_ref,agu_icb_cmd_wdata_ref,agu_icb_cmd_wmask_ref,agu_icb_cmd_back2agu_ref,agu_icb_cmd_lock_ref,agu_icb_cmd_excl_ref,agu_icb_cmd_size_ref,agu_icb_cmd_itag_ref,agu_icb_cmd_usign_ref,agu_icb_rsp_ready_ref,agu_req_alu_op1_ref,agu_req_alu_op2_ref,agu_req_alu_swap_ref,agu_req_alu_add_ref,agu_req_alu_and_ref,agu_req_alu_or_ref,agu_req_alu_xor_ref,agu_req_alu_max_ref,agu_req_alu_min_ref,agu_req_alu_maxu_ref,agu_req_alu_minu_ref,agu_sbf_0_ena_ref,agu_sbf_0_nxt_ref,agu_sbf_1_ena_ref,agu_sbf_1_nxt_ref} );

    // 错误统计
    // 公式化错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
		if (agu_i_ready_ref !== (agu_i_ready_ref ^ agu_i_ready_dut ^ agu_i_ready_ref)) begin
			if (stats1.errors_agu_i_ready == 0) stats1.errortime_agu_i_ready = $time;
			stats1.errors_agu_i_ready++;
		end
		if (agu_i_longpipe_ref !== (agu_i_longpipe_ref ^ agu_i_longpipe_dut ^ agu_i_longpipe_ref)) begin
			if (stats1.errors_agu_i_longpipe == 0) stats1.errortime_agu_i_longpipe = $time;
			stats1.errors_agu_i_longpipe++;
		end
		if (amo_wait_ref !== (amo_wait_ref ^ amo_wait_dut ^ amo_wait_ref)) begin
			if (stats1.errors_amo_wait == 0) stats1.errortime_amo_wait = $time;
			stats1.errors_amo_wait++;
		end
		if (agu_o_valid_ref !== (agu_o_valid_ref ^ agu_o_valid_dut ^ agu_o_valid_ref)) begin
			if (stats1.errors_agu_o_valid == 0) stats1.errortime_agu_o_valid = $time;
			stats1.errors_agu_o_valid++;
		end
		if (agu_o_wbck_wdat_ref !== (agu_o_wbck_wdat_ref ^ agu_o_wbck_wdat_dut ^ agu_o_wbck_wdat_ref)) begin
			if (stats1.errors_agu_o_wbck_wdat == 0) stats1.errortime_agu_o_wbck_wdat = $time;
			stats1.errors_agu_o_wbck_wdat++;
		end
		if (agu_o_wbck_err_ref !== (agu_o_wbck_err_ref ^ agu_o_wbck_err_dut ^ agu_o_wbck_err_ref)) begin
			if (stats1.errors_agu_o_wbck_err == 0) stats1.errortime_agu_o_wbck_err = $time;
			stats1.errors_agu_o_wbck_err++;
		end
		if (agu_o_cmt_misalgn_ref !== (agu_o_cmt_misalgn_ref ^ agu_o_cmt_misalgn_dut ^ agu_o_cmt_misalgn_ref)) begin
			if (stats1.errors_agu_o_cmt_misalgn == 0) stats1.errortime_agu_o_cmt_misalgn = $time;
			stats1.errors_agu_o_cmt_misalgn++;
		end
		if (agu_o_cmt_ld_ref !== (agu_o_cmt_ld_ref ^ agu_o_cmt_ld_dut ^ agu_o_cmt_ld_ref)) begin
			if (stats1.errors_agu_o_cmt_ld == 0) stats1.errortime_agu_o_cmt_ld = $time;
			stats1.errors_agu_o_cmt_ld++;
		end
		if (agu_o_cmt_stamo_ref !== (agu_o_cmt_stamo_ref ^ agu_o_cmt_stamo_dut ^ agu_o_cmt_stamo_ref)) begin
			if (stats1.errors_agu_o_cmt_stamo == 0) stats1.errortime_agu_o_cmt_stamo = $time;
			stats1.errors_agu_o_cmt_stamo++;
		end
		if (agu_o_cmt_buserr_ref !== (agu_o_cmt_buserr_ref ^ agu_o_cmt_buserr_dut ^ agu_o_cmt_buserr_ref)) begin
			if (stats1.errors_agu_o_cmt_buserr == 0) stats1.errortime_agu_o_cmt_buserr = $time;
			stats1.errors_agu_o_cmt_buserr++;
		end
		if (agu_o_cmt_badaddr_ref !== (agu_o_cmt_badaddr_ref ^ agu_o_cmt_badaddr_dut ^ agu_o_cmt_badaddr_ref)) begin
			if (stats1.errors_agu_o_cmt_badaddr == 0) stats1.errortime_agu_o_cmt_badaddr = $time;
			stats1.errors_agu_o_cmt_badaddr++;
		end
		if (agu_icb_cmd_valid_ref !== (agu_icb_cmd_valid_ref ^ agu_icb_cmd_valid_dut ^ agu_icb_cmd_valid_ref)) begin
			if (stats1.errors_agu_icb_cmd_valid == 0) stats1.errortime_agu_icb_cmd_valid = $time;
			stats1.errors_agu_icb_cmd_valid++;
		end
		if (agu_icb_cmd_addr_ref !== (agu_icb_cmd_addr_ref ^ agu_icb_cmd_addr_dut ^ agu_icb_cmd_addr_ref)) begin
			if (stats1.errors_agu_icb_cmd_addr == 0) stats1.errortime_agu_icb_cmd_addr = $time;
			stats1.errors_agu_icb_cmd_addr++;
		end
		if (agu_icb_cmd_read_ref !== (agu_icb_cmd_read_ref ^ agu_icb_cmd_read_dut ^ agu_icb_cmd_read_ref)) begin
			if (stats1.errors_agu_icb_cmd_read == 0) stats1.errortime_agu_icb_cmd_read = $time;
			stats1.errors_agu_icb_cmd_read++;
		end
		if (agu_icb_cmd_wdata_ref !== (agu_icb_cmd_wdata_ref ^ agu_icb_cmd_wdata_dut ^ agu_icb_cmd_wdata_ref)) begin
			if (stats1.errors_agu_icb_cmd_wdata == 0) stats1.errortime_agu_icb_cmd_wdata = $time;
			stats1.errors_agu_icb_cmd_wdata++;
		end
		if (agu_icb_cmd_wmask_ref !== (agu_icb_cmd_wmask_ref ^ agu_icb_cmd_wmask_dut ^ agu_icb_cmd_wmask_ref)) begin
			if (stats1.errors_agu_icb_cmd_wmask == 0) stats1.errortime_agu_icb_cmd_wmask = $time;
			stats1.errors_agu_icb_cmd_wmask++;
		end
		if (agu_icb_cmd_back2agu_ref !== (agu_icb_cmd_back2agu_ref ^ agu_icb_cmd_back2agu_dut ^ agu_icb_cmd_back2agu_ref)) begin
			if (stats1.errors_agu_icb_cmd_back2agu == 0) stats1.errortime_agu_icb_cmd_back2agu = $time;
			stats1.errors_agu_icb_cmd_back2agu++;
		end
		if (agu_icb_cmd_lock_ref !== (agu_icb_cmd_lock_ref ^ agu_icb_cmd_lock_dut ^ agu_icb_cmd_lock_ref)) begin
			if (stats1.errors_agu_icb_cmd_lock == 0) stats1.errortime_agu_icb_cmd_lock = $time;
			stats1.errors_agu_icb_cmd_lock++;
		end
		if (agu_icb_cmd_excl_ref !== (agu_icb_cmd_excl_ref ^ agu_icb_cmd_excl_dut ^ agu_icb_cmd_excl_ref)) begin
			if (stats1.errors_agu_icb_cmd_excl == 0) stats1.errortime_agu_icb_cmd_excl = $time;
			stats1.errors_agu_icb_cmd_excl++;
		end
		if (agu_icb_cmd_size_ref !== (agu_icb_cmd_size_ref ^ agu_icb_cmd_size_dut ^ agu_icb_cmd_size_ref)) begin
			if (stats1.errors_agu_icb_cmd_size == 0) stats1.errortime_agu_icb_cmd_size = $time;
			stats1.errors_agu_icb_cmd_size++;
		end
		if (agu_icb_cmd_itag_ref !== (agu_icb_cmd_itag_ref ^ agu_icb_cmd_itag_dut ^ agu_icb_cmd_itag_ref)) begin
			if (stats1.errors_agu_icb_cmd_itag == 0) stats1.errortime_agu_icb_cmd_itag = $time;
			stats1.errors_agu_icb_cmd_itag++;
		end
		if (agu_icb_cmd_usign_ref !== (agu_icb_cmd_usign_ref ^ agu_icb_cmd_usign_dut ^ agu_icb_cmd_usign_ref)) begin
			if (stats1.errors_agu_icb_cmd_usign == 0) stats1.errortime_agu_icb_cmd_usign = $time;
			stats1.errors_agu_icb_cmd_usign++;
		end
		if (agu_icb_rsp_ready_ref !== (agu_icb_rsp_ready_ref ^ agu_icb_rsp_ready_dut ^ agu_icb_rsp_ready_ref)) begin
			if (stats1.errors_agu_icb_rsp_ready == 0) stats1.errortime_agu_icb_rsp_ready = $time;
			stats1.errors_agu_icb_rsp_ready++;
		end
		if (agu_req_alu_op1_ref !== (agu_req_alu_op1_ref ^ agu_req_alu_op1_dut ^ agu_req_alu_op1_ref)) begin
			if (stats1.errors_agu_req_alu_op1 == 0) stats1.errortime_agu_req_alu_op1 = $time;
			stats1.errors_agu_req_alu_op1++;
		end
		if (agu_req_alu_op2_ref !== (agu_req_alu_op2_ref ^ agu_req_alu_op2_dut ^ agu_req_alu_op2_ref)) begin
			if (stats1.errors_agu_req_alu_op2 == 0) stats1.errortime_agu_req_alu_op2 = $time;
			stats1.errors_agu_req_alu_op2++;
		end
		if (agu_req_alu_swap_ref !== (agu_req_alu_swap_ref ^ agu_req_alu_swap_dut ^ agu_req_alu_swap_ref)) begin
			if (stats1.errors_agu_req_alu_swap == 0) stats1.errortime_agu_req_alu_swap = $time;
			stats1.errors_agu_req_alu_swap++;
		end
		if (agu_req_alu_add_ref !== (agu_req_alu_add_ref ^ agu_req_alu_add_dut ^ agu_req_alu_add_ref)) begin
			if (stats1.errors_agu_req_alu_add == 0) stats1.errortime_agu_req_alu_add = $time;
			stats1.errors_agu_req_alu_add++;
		end
		if (agu_req_alu_and_ref !== (agu_req_alu_and_ref ^ agu_req_alu_and_dut ^ agu_req_alu_and_ref)) begin
			if (stats1.errors_agu_req_alu_and == 0) stats1.errortime_agu_req_alu_and = $time;
			stats1.errors_agu_req_alu_and++;
		end
		if (agu_req_alu_or_ref !== (agu_req_alu_or_ref ^ agu_req_alu_or_dut ^ agu_req_alu_or_ref)) begin
			if (stats1.errors_agu_req_alu_or == 0) stats1.errortime_agu_req_alu_or = $time;
			stats1.errors_agu_req_alu_or++;
		end
		if (agu_req_alu_xor_ref !== (agu_req_alu_xor_ref ^ agu_req_alu_xor_dut ^ agu_req_alu_xor_ref)) begin
			if (stats1.errors_agu_req_alu_xor == 0) stats1.errortime_agu_req_alu_xor = $time;
			stats1.errors_agu_req_alu_xor++;
		end
		if (agu_req_alu_max_ref !== (agu_req_alu_max_ref ^ agu_req_alu_max_dut ^ agu_req_alu_max_ref)) begin
			if (stats1.errors_agu_req_alu_max == 0) stats1.errortime_agu_req_alu_max = $time;
			stats1.errors_agu_req_alu_max++;
		end
		if (agu_req_alu_min_ref !== (agu_req_alu_min_ref ^ agu_req_alu_min_dut ^ agu_req_alu_min_ref)) begin
			if (stats1.errors_agu_req_alu_min == 0) stats1.errortime_agu_req_alu_min = $time;
			stats1.errors_agu_req_alu_min++;
		end
		if (agu_req_alu_maxu_ref !== (agu_req_alu_maxu_ref ^ agu_req_alu_maxu_dut ^ agu_req_alu_maxu_ref)) begin
			if (stats1.errors_agu_req_alu_maxu == 0) stats1.errortime_agu_req_alu_maxu = $time;
			stats1.errors_agu_req_alu_maxu++;
		end
		if (agu_req_alu_minu_ref !== (agu_req_alu_minu_ref ^ agu_req_alu_minu_dut ^ agu_req_alu_minu_ref)) begin
			if (stats1.errors_agu_req_alu_minu == 0) stats1.errortime_agu_req_alu_minu = $time;
			stats1.errors_agu_req_alu_minu++;
		end
		if (agu_sbf_0_ena_ref !== (agu_sbf_0_ena_ref ^ agu_sbf_0_ena_dut ^ agu_sbf_0_ena_ref)) begin
			if (stats1.errors_agu_sbf_0_ena == 0) stats1.errortime_agu_sbf_0_ena = $time;
			stats1.errors_agu_sbf_0_ena++;
		end
		if (agu_sbf_0_nxt_ref !== (agu_sbf_0_nxt_ref ^ agu_sbf_0_nxt_dut ^ agu_sbf_0_nxt_ref)) begin
			if (stats1.errors_agu_sbf_0_nxt == 0) stats1.errortime_agu_sbf_0_nxt = $time;
			stats1.errors_agu_sbf_0_nxt++;
		end
		if (agu_sbf_1_ena_ref !== (agu_sbf_1_ena_ref ^ agu_sbf_1_ena_dut ^ agu_sbf_1_ena_ref)) begin
			if (stats1.errors_agu_sbf_1_ena == 0) stats1.errortime_agu_sbf_1_ena = $time;
			stats1.errors_agu_sbf_1_ena++;
		end
		if (agu_sbf_1_nxt_ref !== (agu_sbf_1_nxt_ref ^ agu_sbf_1_nxt_dut ^ agu_sbf_1_nxt_ref)) begin
			if (stats1.errors_agu_sbf_1_nxt == 0) stats1.errortime_agu_sbf_1_nxt = $time;
			stats1.errors_agu_sbf_1_nxt++;
		end
        
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule
