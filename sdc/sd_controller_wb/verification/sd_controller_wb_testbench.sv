//`timescale 1 ps/1 ps
`include "sd_defines.v"
module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_wb_dat_o;
		int errortime_wb_dat_o;
		int errors_wb_ack_o;
		int errortime_wb_ack_o;
		int errors_we_m_tx_bd;
		int errortime_we_m_tx_bd;
		int errors_new_cmd;
		int errortime_new_cmd;
		int errors_we_ack;
		int errortime_we_ack;
		int errors_int_ack;
		int errortime_int_ack;
		int errors_cmd_int_busy;
		int errortime_cmd_int_busy;
		int errors_we_m_rx_bd;
		int errortime_we_m_rx_bd;
		int errors_int_busy;
		int errortime_int_busy;
		int errors_argument_reg;
		int errortime_argument_reg;
		int errors_cmd_setting_reg;
		int errortime_cmd_setting_reg;
		int errors_software_reset_reg;
		int errortime_software_reset_reg;
		int errors_time_out_reg;
		int errortime_time_out_reg;
		int errors_normal_int_signal_enable_reg;
		int errortime_normal_int_signal_enable_reg;
		int errors_error_int_signal_enable_reg;
		int errortime_error_int_signal_enable_reg;
		int errors_clock_divider;
		int errortime_clock_divider;
		int errors_Bd_isr_enable_reg;
		int errortime_Bd_isr_enable_reg;
		int errors_Bd_isr_reset;
		int errortime_Bd_isr_reset;
		int errors_normal_isr_reset;
		int errortime_normal_isr_reset;
		int errors_error_isr_reset;
		int errortime_error_isr_reset;
		int errors_dat_in_m_rx_bd;
		int errortime_dat_in_m_rx_bd;
		int errors_dat_in_m_tx_bd;
		int errortime_dat_in_m_tx_bd;

		int clocks;
	} stats;
	
	stats stats1;
	

	
	reg clk=0;
	initial forever
		#5 clk = ~clk;
	
	// Input Signals
	// wishbone 
	logic wb_clk_i;
	logic wb_rst_i;
	logic [31:0] wb_dat_i;
	logic [7:0] wb_adr_i;
	logic [3:0] wb_sel_i;
	logic wb_we_i;
	logic wb_cyc_i;
	logic wb_stb_i;
	// other
	logic write_req_s;			// write_request_slave
	logic [15:0] cmd_set_s;		
	logic [31:0] cmd_arg_s;
	// registers
	logic [15:0] status_reg;
	logic [31:0] cmd_resp_1;
	logic [15:0] normal_int_status_reg; 
	logic [15:0] error_int_status_reg;
	logic [15:0] Bd_Status_reg;   
	logic [7:0]  Bd_isr_reg;

	// Output Signals (ref)
	// wishbone
	logic [31:0] wb_dat_o_ref;
	logic wb_ack_o_ref;
	// other
	logic we_m_tx_bd_ref;
	logic new_cmd_ref;
	logic we_ack_ref;
	logic int_ack_ref; //Internal Delayed Ack;
	logic cmd_int_busy_ref;
	logic we_m_rx_bd_ref; //Write enable Master side Rx_bd
	logic int_busy_ref;
	// Bus accessible registers
	logic [31:0] argument_reg_ref;
	logic [15:0] cmd_setting_reg_ref;
	logic [7:0] software_reset_reg_ref; 
	logic [15:0] time_out_reg_ref;   
	logic [15:0]normal_int_signal_enable_reg_ref;
	logic [15:0]error_int_signal_enable_reg_ref;
	logic [7:0] clock_divider_ref;
	logic [7:0] Bd_isr_enable_reg_ref;
	// Register Control
	logic Bd_isr_reset_ref;
	logic normal_isr_reset_ref;
	logic error_isr_reset_ref;
	// data buffer register
	logic [`RAM_MEM_WIDTH-1:0] dat_in_m_rx_bd_ref; //Data in to Rx_bd from Master
	logic [`RAM_MEM_WIDTH-1:0] dat_in_m_tx_bd_ref;

	// Output Signals (dut)
	// wishbone
	logic [31:0] wb_dat_o_dut;
	logic wb_ack_o_dut;
	// other
	logic we_m_tx_bd_dut;
	logic new_cmd_dut;
	logic we_ack_dut;
	logic int_ack_dut; //Internal Delayed Ack;
	logic cmd_int_busy_dut;
	logic we_m_rx_bd_dut; //Write enable Master side Rx_bd
	logic int_busy_dut;
	// Bus accessible registers
	logic [31:0] argument_reg_dut;
	logic [15:0] cmd_setting_reg_dut;
	logic [7:0] software_reset_reg_dut; 
	logic [15:0] time_out_reg_dut;   
	logic [15:0]normal_int_signal_enable_reg_dut;
	logic [15:0]error_int_signal_enable_reg_dut;
	logic [7:0] clock_divider_dut;
	logic [7:0] Bd_isr_enable_reg_dut;
	// Register Control
	logic Bd_isr_reset_dut;
	logic normal_isr_reset_dut;
	logic error_isr_reset_dut;
	// data buffer register
	logic [`RAM_MEM_WIDTH-1:0] dat_in_m_rx_bd_dut; //Data in to Rx_bd from Master
	logic [`RAM_MEM_WIDTH-1:0] dat_in_m_tx_bd_dut;
	

	

	wire tb_match;
	wire tb_mismatch = ~tb_match;
	wire tb_match1;
	wire tb_match2;
	wire tb_match3;
	wire tb_match4;
	wire tb_match5;
	wire tb_match6;
	wire tb_match7;
	wire tb_match8;
	wire tb_match9;
	wire tb_match10;
	wire tb_match11;
	wire tb_match12;
	wire tb_match13;
	wire tb_match14;
	wire tb_match15;
	wire tb_match16;
	wire tb_match17;
	wire tb_match18;
	wire tb_match19;
	wire tb_match20;
	wire tb_match21;
	wire tb_match22;
	
	stimulus_gen stim1 (
		.clk(clk),
		.wb_clk_i(wb_clk_i),
		.wb_rst_i(wb_rst_i),
		.wb_dat_i(wb_dat_i),
		.wb_adr_i(wb_adr_i),
		.wb_sel_i(wb_sel_i),
		.wb_we_i(wb_we_i),
		.wb_cyc_i(wb_cyc_i),
		.wb_stb_i(wb_stb_i),
		.write_req_s(write_req_s),
		.cmd_set_s(cmd_set_s),
		.cmd_arg_s(cmd_arg_s),
		.status_reg(status_reg),
		.cmd_resp_1(cmd_resp_1),
		.normal_int_status_reg(normal_int_status_reg),
		.error_int_status_reg(error_int_status_reg),
		.Bd_Status_reg(Bd_Status_reg),
		.Bd_isr_reg(Bd_isr_reg)
		);
	ref_sd_controller_wb good1 (
		// input
		.wb_clk_i(wb_clk_i),
		.wb_rst_i(wb_rst_i),
		.wb_dat_i(wb_dat_i),
		.wb_adr_i(wb_adr_i),
		.wb_sel_i(wb_sel_i),
		.wb_we_i(wb_we_i),
		.wb_cyc_i(wb_cyc_i),
		.wb_stb_i(wb_stb_i),
		.write_req_s(write_req_s),
		.cmd_set_s(cmd_set_s),
		.cmd_arg_s(cmd_arg_s),
		.status_reg(status_reg),
		.cmd_resp_1(cmd_resp_1),
		.normal_int_status_reg(normal_int_status_reg),
		.error_int_status_reg(error_int_status_reg),
		.Bd_Status_reg(Bd_Status_reg),
		.Bd_isr_reg(Bd_isr_reg),
		// output
		.wb_dat_o(wb_dat_o_ref),
		.wb_ack_o(wb_ack_o_ref),
		.we_m_tx_bd(we_m_tx_bd_ref),
		.new_cmd(new_cmd_ref),
		.we_ack(we_ack_ref),
		.int_ack(int_ack_ref),
		.cmd_int_busy(cmd_int_busy_ref),
		.we_m_rx_bd(we_m_rx_bd_ref),
		.int_busy(int_busy_ref),
		//Buss accessible registers    
		.argument_reg(argument_reg_ref),
		.cmd_setting_reg(cmd_setting_reg_ref),
		.software_reset_reg(software_reset_reg_ref),
		.time_out_reg(time_out_reg_ref),
		.normal_int_signal_enable_reg(normal_int_signal_enable_reg_ref),
		.error_int_signal_enable_reg(error_int_signal_enable_reg_ref),
		.clock_divider(clock_divider_ref),
		.Bd_isr_enable_reg(Bd_isr_enable_reg_ref),
		//Register Controll
		.Bd_isr_reset(Bd_isr_reset_ref),
		.normal_isr_reset(normal_isr_reset_ref),
		.error_isr_reset(error_isr_reset_ref),
		.dat_in_m_rx_bd(dat_in_m_rx_bd_ref), //Data in to Rx_bd from Master
		.dat_in_m_tx_bd(dat_in_m_tx_bd_ref)
		);
		
	sd_controller_wb top_module1 (
		// input 
		.wb_clk_i(wb_clk_i),
		.wb_rst_i(wb_rst_i),
		.wb_dat_i(wb_dat_i),
		.wb_adr_i(wb_adr_i),
		.wb_sel_i(wb_sel_i),
		.wb_we_i(wb_we_i),
		.wb_cyc_i(wb_cyc_i),
		.wb_stb_i(wb_stb_i),
		.write_req_s(write_req_s),
		.cmd_set_s(cmd_set_s),
		.cmd_arg_s(cmd_arg_s),
		.status_reg(status_reg),
		.cmd_resp_1(cmd_resp_1),
		.normal_int_status_reg(normal_int_status_reg),
		.error_int_status_reg(error_int_status_reg),
		.Bd_Status_reg(Bd_Status_reg),
		.Bd_isr_reg(Bd_isr_reg),
		// output
		.wb_dat_o(wb_dat_o_dut),
		.wb_ack_o(wb_ack_o_dut),
		.we_m_tx_bd(we_m_tx_bd_dut),
		.new_cmd(new_cmd_dut),
		.we_ack(we_ack_dut),
		.int_ack(int_ack_dut),
		.cmd_int_busy(cmd_int_busy_dut),
		.we_m_rx_bd(we_m_rx_bd_dut),
		.int_busy(int_busy_dut),
		//Buss accessible registers    
		.argument_reg(argument_reg_dut),
		.cmd_setting_reg(cmd_setting_reg_dut),
		.software_reset_reg(software_reset_reg_dut),
		.time_out_reg(time_out_reg_dut),
		.normal_int_signal_enable_reg(normal_int_signal_enable_reg_dut),
		.error_int_signal_enable_reg(error_int_signal_enable_reg_dut),
		.clock_divider(clock_divider_dut),
		.Bd_isr_enable_reg(Bd_isr_enable_reg_dut),
		//Register Controll
		.Bd_isr_reset(Bd_isr_reset_dut),
		.normal_isr_reset(normal_isr_reset_dut),
		.error_isr_reset(error_isr_reset_dut),
		.dat_in_m_rx_bd(dat_in_m_rx_bd_dut), //Data in to Rx_bd from Master
		.dat_in_m_tx_bd(dat_in_m_tx_bd_dut)
		);

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0);
	end

	final begin
		if (stats1.errors_wb_dat_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "wb_dat_o", stats1.errors_wb_dat_o, stats1.errortime_wb_dat_o);
		else $display("Hint: Output '%s' has no mismatches.", "wb_dat_o");
		if (stats1.errors_wb_ack_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "wb_ack_o", stats1.errors_wb_ack_o, stats1.errortime_wb_ack_o);
		else $display("Hint: Output '%s' has no mismatches.", "wb_ack_o");
		if (stats1.errors_we_m_tx_bd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "we_m_tx_bd", stats1.errors_we_m_tx_bd, stats1.errortime_we_m_tx_bd);
		else $display("Hint: Output '%s' has no mismatches.", "we_m_tx_bd");
		if (stats1.errors_new_cmd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "new_cmd", stats1.errors_new_cmd, stats1.errortime_new_cmd);
		else $display("Hint: Output '%s' has no mismatches.", "new_cmd");
		if (stats1.errors_we_ack) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "we_ack", stats1.errors_we_ack, stats1.errortime_we_ack);
		else $display("Hint: Output '%s' has no mismatches.", "we_ack");
		if (stats1.errors_int_ack) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "int_ack", stats1.errors_int_ack, stats1.errortime_int_ack);
		else $display("Hint: Output '%s' has no mismatches.", "int_ack");
		if (stats1.errors_cmd_int_busy) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_int_busy", stats1.errors_cmd_int_busy, stats1.errortime_cmd_int_busy);
		else $display("Hint: Output '%s' has no mismatches.", "cmd_int_busy");
		if (stats1.errors_we_m_rx_bd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "we_m_rx_bd", stats1.errors_we_m_rx_bd, stats1.errortime_we_m_rx_bd);
		else $display("Hint: Output '%s' has no mismatches.", "we_m_rx_bd");
		if (stats1.errors_int_busy) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "int_busy", stats1.errors_int_busy, stats1.errortime_int_busy);
		else $display("Hint: Output '%s' has no mismatches.", "int_busy");
		if (stats1.errors_argument_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "argument_reg", stats1.errors_argument_reg, stats1.errortime_argument_reg);
		else $display("Hint: Output '%s' has no mismatches.", "argument_reg");
		if (stats1.errors_cmd_setting_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_setting_reg", stats1.errors_cmd_setting_reg, stats1.errortime_cmd_setting_reg);
		else $display("Hint: Output '%s' has no mismatches.", "cmd_setting_reg");
		if (stats1.errors_software_reset_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "software_reset_reg", stats1.errors_software_reset_reg, stats1.errortime_software_reset_reg);
		else $display("Hint: Output '%s' has no mismatches.", "software_reset_reg");
		if (stats1.errors_time_out_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "time_out_reg", stats1.errors_time_out_reg, stats1.errortime_time_out_reg);
		else $display("Hint: Output '%s' has no mismatches.", "time_out_reg");
		if (stats1.errors_normal_int_signal_enable_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "normal_int_signal_enable_reg", stats1.errors_normal_int_signal_enable_reg, stats1.errortime_normal_int_signal_enable_reg);
		else $display("Hint: Output '%s' has no mismatches.", "normal_int_signal_enable_reg");
		if (stats1.errors_error_int_signal_enable_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "error_int_signal_enable_reg", stats1.errors_error_int_signal_enable_reg, stats1.errortime_error_int_signal_enable_reg);
		else $display("Hint: Output '%s' has no mismatches.", "error_int_signal_enable_reg");
		if (stats1.errors_clock_divider) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "clock_divider", stats1.errors_clock_divider, stats1.errortime_clock_divider);
		else $display("Hint: Output '%s' has no mismatches.", "clock_divider");
		if (stats1.errors_Bd_isr_enable_reg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "Bd_isr_enable_reg", stats1.errors_Bd_isr_enable_reg, stats1.errortime_Bd_isr_enable_reg);
		else $display("Hint: Output '%s' has no mismatches.", "Bd_isr_enable_reg");
		if (stats1.errors_Bd_isr_reset) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "Bd_isr_reset", stats1.errors_Bd_isr_reset, stats1.errortime_Bd_isr_reset);
		else $display("Hint: Output '%s' has no mismatches.", "Bd_isr_reset");
		if (stats1.errors_normal_isr_reset) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "normal_isr_reset", stats1.errors_normal_isr_reset, stats1.errortime_normal_isr_reset);
		else $display("Hint: Output '%s' has no mismatches.", "normal_isr_reset");
		if (stats1.errors_error_isr_reset) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "error_isr_reset", stats1.errors_error_isr_reset, stats1.errortime_error_isr_reset);
		else $display("Hint: Output '%s' has no mismatches.", "error_isr_reset");
		if (stats1.errors_dat_in_m_rx_bd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "dat_in_m_rx_bd", stats1.errors_dat_in_m_rx_bd, stats1.errortime_dat_in_m_rx_bd);
		else $display("Hint: Output '%s' has no mismatches.", "dat_in_m_rx_bd");
		if (stats1.errors_dat_in_m_tx_bd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "dat_in_m_tx_bd", stats1.errors_dat_in_m_tx_bd, stats1.errortime_dat_in_m_tx_bd);
		else $display("Hint: Output '%s' has no mismatches.", "dat_in_m_tx_bd");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match1 = ( { wb_dat_o_ref } === ( { wb_dat_o_ref } ^ { wb_dat_o_dut } ^ { wb_dat_o_ref } ) );
	assign tb_match2 = ( { wb_ack_o_ref } === ( { wb_ack_o_ref } ^ { wb_ack_o_dut } ^ { wb_ack_o_ref } ) );
	assign tb_match3 = ( { we_m_tx_bd_ref } === ( { we_m_tx_bd_ref } ^ { we_m_tx_bd_dut } ^ { we_m_tx_bd_ref } ) );
	assign tb_match4 = ( { new_cmd_ref } === ( { new_cmd_ref } ^ { new_cmd_dut } ^ { new_cmd_ref } ) );
	assign tb_match5 = ( { we_ack_ref } === ( { we_ack_ref } ^ { we_ack_dut } ^ { we_ack_ref } ) );
	assign tb_match6 = ( { int_ack_ref } === ( { int_ack_ref } ^ { int_ack_dut } ^ { int_ack_ref } ) );
	assign tb_match7 = ( { cmd_int_busy_ref } === ( { cmd_int_busy_ref } ^ { cmd_int_busy_dut } ^ { cmd_int_busy_ref } ) );
	assign tb_match8 = ( { we_m_rx_bd_ref } === ( { we_m_rx_bd_ref } ^ { we_m_rx_bd_dut } ^ { we_m_rx_bd_ref } ) );
	assign tb_match9 = ( { int_busy_ref } === ( { int_busy_ref } ^ { int_busy_dut } ^ { int_busy_ref } ) );
	assign tb_match10 = ( { argument_reg_ref } === ( { argument_reg_ref } ^ { argument_reg_dut } ^ { argument_reg_ref } ) );
	assign tb_match11 = ( { cmd_setting_reg_ref } === ( { cmd_setting_reg_ref } ^ { cmd_setting_reg_dut } ^ { cmd_setting_reg_ref } ) );
	assign tb_match12 = ( { software_reset_reg_ref } === ( { software_reset_reg_ref } ^ { software_reset_reg_dut } ^ { software_reset_reg_ref } ) );
	assign tb_match13 = ( { time_out_reg_ref } === ( { time_out_reg_ref } ^ { time_out_reg_dut } ^ { time_out_reg_ref } ) );
	assign tb_match14 = ( { normal_int_signal_enable_reg_ref } === ( { normal_int_signal_enable_reg_ref } ^ { normal_int_signal_enable_reg_dut } ^ { normal_int_signal_enable_reg_ref } ) );
	assign tb_match15 = ( { error_int_signal_enable_reg_ref } === ( { error_int_signal_enable_reg_ref } ^ { error_int_signal_enable_reg_dut } ^ { error_int_signal_enable_reg_ref } ) );
	assign tb_match16 = ( { clock_divider_ref } === ( { clock_divider_ref } ^ { clock_divider_dut } ^ { clock_divider_ref } ) );
	assign tb_match17 = ( { Bd_isr_enable_reg_ref } === ( { Bd_isr_enable_reg_ref } ^ { Bd_isr_enable_reg_dut } ^ { Bd_isr_enable_reg_ref } ) );
	assign tb_match18 = ( { Bd_isr_reset_ref } === ( { Bd_isr_reset_ref } ^ { Bd_isr_reset_dut } ^ { Bd_isr_reset_ref } ) );
	assign tb_match19 = ( { normal_isr_reset_ref } === ( { normal_isr_reset_ref } ^ { normal_isr_reset_dut } ^ { normal_isr_reset_ref } ) );
	assign tb_match20 = ( { error_isr_reset_ref } === ( { error_isr_reset_ref } ^ { error_isr_reset_dut } ^ { error_isr_reset_ref } ) );
	assign tb_match21 = ( { dat_in_m_rx_bd_ref } === ( { dat_in_m_rx_bd_ref } ^ { dat_in_m_rx_bd_dut } ^ { dat_in_m_rx_bd_ref } ) );
	assign tb_match22 = ( { dat_in_m_tx_bd_ref } === ( { dat_in_m_tx_bd_ref } ^ { dat_in_m_tx_bd_dut } ^ { dat_in_m_tx_bd_ref } ) );

	assign tb_match = tb_match1 && tb_match2 && tb_match3 && tb_match4 && tb_match5 && tb_match6 && tb_match7 && tb_match8 && tb_match9 && tb_match10 && tb_match11 && tb_match12 && tb_match13 && tb_match14 && tb_match15 && tb_match16 && tb_match17 && tb_match18 && tb_match19 && tb_match20 && tb_match21 && tb_match22;

	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end

	if (wb_dat_o_ref !== ( wb_dat_o_ref ^ wb_dat_o_dut ^ wb_dat_o_ref ))
		begin if (stats1.errors_wb_dat_o == 0) stats1.errortime_wb_dat_o = $time;
		stats1.errors_wb_dat_o = stats1.errors_wb_dat_o+1'b1; end

	if (wb_ack_o_ref !== ( wb_ack_o_ref ^ wb_ack_o_dut ^ wb_ack_o_ref ))
		begin if (stats1.errors_wb_ack_o == 0) stats1.errortime_wb_ack_o = $time;
			stats1.errors_wb_ack_o = stats1.errors_wb_ack_o+1'b1; end

	if (we_m_tx_bd_ref !== ( we_m_tx_bd_ref ^ we_m_tx_bd_dut ^ we_m_tx_bd_ref ))
		begin if (stats1.errors_we_m_tx_bd == 0) stats1.errortime_we_m_tx_bd = $time;
			stats1.errors_we_m_tx_bd = stats1.errors_we_m_tx_bd+1'b1; end

	if (new_cmd_ref !== ( new_cmd_ref ^ new_cmd_dut ^ new_cmd_ref ))
		begin if (stats1.errors_new_cmd == 0) stats1.errortime_new_cmd = $time;
			stats1.errors_new_cmd = stats1.errors_new_cmd+1'b1; end

	if (we_ack_ref !== ( we_ack_ref ^ we_ack_dut ^ we_ack_ref ))
		begin if (stats1.errors_we_ack == 0) stats1.errortime_we_ack = $time;
			stats1.errors_we_ack = stats1.errors_we_ack+1'b1; end

	if (int_ack_ref !== ( int_ack_ref ^ int_ack_dut ^ int_ack_ref ))
		begin if (stats1.errors_int_ack == 0) stats1.errortime_int_ack = $time;
			stats1.errors_int_ack = stats1.errors_int_ack+1'b1; end

	if (cmd_int_busy_ref !== ( cmd_int_busy_ref ^ cmd_int_busy_dut ^ cmd_int_busy_ref ))
		begin if (stats1.errors_cmd_int_busy == 0) stats1.errortime_cmd_int_busy = $time;
			stats1.errors_cmd_int_busy = stats1.errors_cmd_int_busy+1'b1; end

	if (we_m_rx_bd_ref !== ( we_m_rx_bd_ref ^ we_m_rx_bd_dut ^ we_m_rx_bd_ref ))
		begin if (stats1.errors_we_m_rx_bd == 0) stats1.errortime_we_m_rx_bd = $time;
			stats1.errors_we_m_rx_bd = stats1.errors_we_m_rx_bd+1'b1; end

	if (int_busy_ref !== ( int_busy_ref ^ int_busy_dut ^ int_busy_ref ))
		begin if (stats1.errors_int_busy == 0) stats1.errortime_int_busy = $time;
			stats1.errors_int_busy = stats1.errors_int_busy+1'b1; end

	if (argument_reg_ref !== ( argument_reg_ref ^ argument_reg_dut ^ argument_reg_ref ))
		begin if (stats1.errors_argument_reg == 0) stats1.errortime_argument_reg = $time;
			stats1.errors_argument_reg = stats1.errors_argument_reg+1'b1; end

	if (cmd_setting_reg_ref !== ( cmd_setting_reg_ref ^ cmd_setting_reg_dut ^ cmd_setting_reg_ref ))
		begin if (stats1.errors_cmd_setting_reg == 0) stats1.errortime_cmd_setting_reg = $time;
			stats1.errors_cmd_setting_reg = stats1.errors_cmd_setting_reg+1'b1; end

	if (software_reset_reg_ref !== ( software_reset_reg_ref ^ software_reset_reg_dut ^ software_reset_reg_ref ))
		begin if (stats1.errors_software_reset_reg == 0) stats1.errortime_software_reset_reg = $time;
			stats1.errors_software_reset_reg = stats1.errors_software_reset_reg+1'b1; end

	if (time_out_reg_ref !== ( time_out_reg_ref ^ time_out_reg_dut ^ time_out_reg_ref ))
		begin if (stats1.errors_time_out_reg == 0) stats1.errortime_time_out_reg = $time;
			stats1.errors_time_out_reg = stats1.errors_time_out_reg+1'b1; end

	if (normal_int_signal_enable_reg_ref !== ( normal_int_signal_enable_reg_ref ^ normal_int_signal_enable_reg_dut ^ normal_int_signal_enable_reg_ref ))
		begin if (stats1.errors_normal_int_signal_enable_reg == 0) stats1.errortime_normal_int_signal_enable_reg = $time;
			stats1.errors_normal_int_signal_enable_reg = stats1.errors_normal_int_signal_enable_reg+1'b1; end

	if (error_int_signal_enable_reg_ref !== ( error_int_signal_enable_reg_ref ^ error_int_signal_enable_reg_dut ^ error_int_signal_enable_reg_ref ))
	begin if (stats1.errors_error_int_signal_enable_reg == 0) stats1.errortime_error_int_signal_enable_reg = $time;
		stats1.errors_error_int_signal_enable_reg = stats1.errors_error_int_signal_enable_reg+1'b1; end

	if (clock_divider_ref !== ( clock_divider_ref ^ clock_divider_dut ^ clock_divider_ref ))
		begin if (stats1.errors_clock_divider == 0) stats1.errortime_clock_divider = $time;
			stats1.errors_clock_divider = stats1.errors_clock_divider+1'b1; end

	if (Bd_isr_enable_reg_ref !== ( Bd_isr_enable_reg_ref ^ Bd_isr_enable_reg_dut ^ Bd_isr_enable_reg_ref ))
		begin if (stats1.errors_Bd_isr_enable_reg == 0) stats1.errortime_Bd_isr_enable_reg = $time;
			stats1.errors_Bd_isr_enable_reg = stats1.errors_Bd_isr_enable_reg+1'b1; end

	if (Bd_isr_reset_ref !== ( Bd_isr_reset_ref ^ Bd_isr_reset_dut ^ Bd_isr_reset_ref ))
		begin if (stats1.errors_Bd_isr_reset == 0) stats1.errortime_Bd_isr_reset = $time;
			stats1.errors_Bd_isr_reset = stats1.errors_Bd_isr_reset+1'b1; end

	if (normal_isr_reset_ref !== ( normal_isr_reset_ref ^ normal_isr_reset_dut ^ normal_isr_reset_ref ))
		begin if (stats1.errors_normal_isr_reset == 0) stats1.errortime_normal_isr_reset = $time;
			stats1.errors_normal_isr_reset = stats1.errors_normal_isr_reset+1'b1; end

	if (error_isr_reset_ref !== ( error_isr_reset_ref ^ error_isr_reset_dut ^ error_isr_reset_ref ))
		begin if (stats1.errors_error_isr_reset == 0) stats1.errortime_error_isr_reset = $time;
			stats1.errors_error_isr_reset = stats1.errors_error_isr_reset+1'b1; end

	if (dat_in_m_rx_bd_ref !== ( dat_in_m_rx_bd_ref ^ dat_in_m_rx_bd_dut ^ dat_in_m_rx_bd_ref ))
		begin if (stats1.errors_dat_in_m_rx_bd == 0) stats1.errortime_dat_in_m_rx_bd = $time;
			stats1.errors_dat_in_m_rx_bd = stats1.errors_dat_in_m_rx_bd+1'b1; end

	if (dat_in_m_tx_bd_ref !== ( dat_in_m_tx_bd_ref ^ dat_in_m_tx_bd_dut ^ dat_in_m_tx_bd_ref ))
		begin if (stats1.errors_dat_in_m_tx_bd == 0) stats1.errortime_dat_in_m_tx_bd = $time;
			stats1.errors_dat_in_m_tx_bd = stats1.errors_dat_in_m_tx_bd+1'b1; end
	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

