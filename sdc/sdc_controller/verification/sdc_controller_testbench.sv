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

		int errors_m_wb_adr_o;
		int errortime_m_wb_adr_o;

		int errors_m_wb_sel_o;
		int errortime_m_wb_sel_o;

		int errors_m_wb_we_o;
		int errortime_m_wb_we_o;

		int errors_m_wb_dat_o;
		int errortime_m_wb_dat_o;

		int errors_m_wb_cyc_o;
		int errortime_m_wb_cyc_o;

		int errors_m_wb_stb_o;
		int errortime_m_wb_stb_o;

		int errors_m_wb_cti_o;
		int errortime_m_wb_cti_o;

		int errors_m_wb_bte_o;
		int errortime_m_wb_bte_o;

		int errors_sd_dat_out_o;
		int errortime_sd_dat_out_o;

		int errors_sd_dat_oe_o;
		int errortime_sd_dat_oe_o;

		int errors_sd_cmd_out_o;
		int errortime_sd_cmd_out_o;

		int errors_sd_cmd_oe_o;
		int errortime_sd_cmd_oe_o;

		int errors_sd_clk_o_pad;
		int errortime_sd_clk_o_pad;

		`ifdef SDC_IRQ_ENABLE
		int errors_int_a;
		int errortime_int_a;
		int errors_int_b;
		int errortime_int_b;
		int errors_int_c;
		int errortime_int_c;
		`endif
		int clocks;
	} stats;
	
	stats stats1;
	

	
	reg clk=0;
	initial forever
		#5 clk = ~clk;

	// Input Signals
	// WISHBONE common
	logic        wb_clk_i;     // WISHBONE clock
	logic        wb_rst_i;     // WISHBONE reset
	logic   [31:0]  wb_dat_i;     // WISHBONE data input
	// WISHBONE error output
	logic       card_detect;
	// WISHBONE slave
	logic   [7:0]  wb_adr_i;     // WISHBONE address input
	logic   [3:0]  wb_sel_i;     // WISHBONE byte select input
	logic       wb_we_i;      // WISHBONE write enable input
	logic       wb_cyc_i;     // WISHBONE cycle input
	logic       wb_stb_i;     // WISHBONE strobe input
	// WISHBONE master
	logic   [31:0]  m_wb_dat_i;
	logic        m_wb_ack_i;
	// SD port
	logic [3:0] sd_dat_dat_i;   // Data in from SD card
	logic sd_cmd_dat_i;         // Command in from SD card
	`ifdef SDC_CLK_SEP
   	logic sd_clk_i_pad;
  	`endif

	// Output Signals
	// wishbone
	logic [31:0] wb_dat_o_ref;
	logic wb_ack_o_ref;
	// wishbone master
	logic  [31:0]  m_wb_adr_o_ref;
	logic  [3:0]   m_wb_sel_o_ref;
	logic          m_wb_we_o_ref;
	logic  [31:0]  m_wb_dat_o_ref;
	logic          m_wb_cyc_o_ref;
	logic          m_wb_stb_o_ref;
	logic  [2:0]   m_wb_cti_o_ref;
	logic	[1:0]	m_wb_bte_o_ref;
	//SD port
	logic  [3:0] sd_dat_out_o_ref; //Data out to SDcard
	logic  sd_dat_oe_o_ref; //SD Card tristate Data Output enable (Connects on the SoC TopLevel)
	logic  sd_cmd_out_o_ref; //Command out to SDcard
	logic  sd_cmd_oe_o_ref; //SD Card tristate CMD Output enable (Connects on the SoC TopLevel)
	logic sd_clk_o_pad_ref;
	// IRQ
	`ifdef SDC_IRQ_ENABLE
	logic int_a_ref, int_b_ref, int_c_ref ; 
	`endif

	// Output Signals
	// wishbone
	logic [31:0] wb_dat_o_dut;
	logic wb_ack_o_dut;
	// wishbone master
	logic  [31:0]  m_wb_adr_o_dut;
	logic  [3:0]   m_wb_sel_o_dut;
	logic          m_wb_we_o_dut;
	logic  [31:0]  m_wb_dat_o_dut;
	logic          m_wb_cyc_o_dut;
	logic          m_wb_stb_o_dut;
	logic  [2:0]   m_wb_cti_o_dut;
	logic	[1:0]	m_wb_bte_o_dut;
	//SD port
	logic  [3:0] sd_dat_out_o_dut; //Data out to SDcard
	logic  sd_dat_oe_o_dut; //SD Card tristate Data Output enable (Connects on the SoC TopLevel)
	logic  sd_cmd_out_o_dut; //Command out to SDcard
	logic  sd_cmd_oe_o_dut; //SD Card tristate CMD Output enable (Connects on the SoC TopLevel)
	logic sd_clk_o_pad_dut;
	// IRQ
	`ifdef SDC_IRQ_ENABLE
	logic int_a_dut, int_b_dut, int_c_dut ; 
	`endif

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
	`ifdef SDC_IRQ_ENABLE
	wire tb_match16;
	wire tb_match17;
	wire tb_match18;
	`endif

	
	stimulus_gen stim1 (
        .clk(clk),
        .wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),
        .wb_dat_i(wb_dat_i),
        .card_detect(card_detect),
        .wb_adr_i(wb_adr_i),
        .wb_sel_i(wb_sel_i),
        .wb_we_i(wb_we_i),
        .wb_cyc_i(wb_cyc_i),
        .wb_stb_i(wb_stb_i),
        .m_wb_dat_i(m_wb_dat_i),
        .m_wb_ack_i(m_wb_ack_i),
        .sd_dat_dat_i(sd_dat_dat_i),
        .sd_cmd_dat_i(sd_cmd_dat_i)
        `ifdef SDC_CLK_SEP
        	,.sd_clk_i_pad(sd_clk_i_pad)
        `endif
    );
	ref_sdc_controller good1 (
		.wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),
        .wb_dat_i(wb_dat_i),
        .card_detect(card_detect),
        .wb_adr_i(wb_adr_i),
        .wb_sel_i(wb_sel_i),
        .wb_we_i(wb_we_i),
        .wb_cyc_i(wb_cyc_i),
        .wb_stb_i(wb_stb_i),
        .m_wb_dat_i(m_wb_dat_i),
        .m_wb_ack_i(m_wb_ack_i),
        .sd_dat_dat_i(sd_dat_dat_i),
        .sd_cmd_dat_i(sd_cmd_dat_i),
        `ifdef SDC_CLK_SEP
        	.sd_clk_i_pad(sd_clk_i_pad),
        `endif
		.wb_dat_o(wb_dat_o_ref),
		.wb_ack_o(wb_ack_o_ref),
		.m_wb_adr_o(m_wb_adr_o_ref),
		.m_wb_sel_o(m_wb_sel_o_ref),
		.m_wb_we_o(m_wb_we_o_ref),

		.m_wb_dat_o(m_wb_dat_o_ref),
		.m_wb_cyc_o(m_wb_cyc_o_ref),
		.m_wb_stb_o(m_wb_stb_o_ref),
		.m_wb_cti_o(m_wb_cti_o_ref),
		.m_wb_bte_o(m_wb_bte_o_ref),
		// SD port
		.sd_dat_out_o(sd_dat_out_o_ref),
		.sd_dat_oe_o(sd_dat_oe_o_ref),

		.sd_cmd_out_o(sd_cmd_out_o_ref),
		.sd_cmd_oe_o(sd_cmd_oe_o_ref),
		.sd_clk_o_pad(sd_clk_o_pad_ref)
		// IRQ
		`ifdef SDC_IRQ_ENABLE
			,.int_a(int_a_ref),
			.int_b(int_b_ref),
			.int_c(int_c_ref)
		`endif

		);
		
	sdc_controller top_module1 (
		.wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),
        .wb_dat_i(wb_dat_i),
        .card_detect(card_detect),
        .wb_adr_i(wb_adr_i),
        .wb_sel_i(wb_sel_i),
        .wb_we_i(wb_we_i),
        .wb_cyc_i(wb_cyc_i),
        .wb_stb_i(wb_stb_i),
        .m_wb_dat_i(m_wb_dat_i),
        .m_wb_ack_i(m_wb_ack_i),
        .sd_dat_dat_i(sd_dat_dat_i),
        .sd_cmd_dat_i(sd_cmd_dat_i),
        `ifdef SDC_CLK_SEP
        	.sd_clk_i_pad(sd_clk_i_pad),
        `endif
		.wb_dat_o(wb_dat_o_dut),
		.wb_ack_o(wb_ack_o_dut),
		.m_wb_adr_o(m_wb_adr_o_dut),
		.m_wb_sel_o(m_wb_sel_o_dut),
		.m_wb_we_o(m_wb_we_o_dut),

		.m_wb_dat_o(m_wb_dat_o_dut),
		.m_wb_cyc_o(m_wb_cyc_o_dut),
		.m_wb_stb_o(m_wb_stb_o_dut),
		.m_wb_cti_o(m_wb_cti_o_dut),
		.m_wb_bte_o(m_wb_bte_o_dut),
		// SD port
		.sd_dat_out_o(sd_dat_out_o_dut),
		.sd_dat_oe_o(sd_dat_oe_o_dut),

		.sd_cmd_out_o(sd_cmd_out_o_dut),
		.sd_cmd_oe_o(sd_cmd_oe_o_dut),
		.sd_clk_o_pad(sd_clk_o_pad_dut)
		// IRQ
		`ifdef SDC_IRQ_ENABLE
			,.int_a(int_a_dut),
			.int_b(int_b_dut),
			.int_c(int_c_dut)
		`endif
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

		if (stats1.errors_m_wb_adr_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_adr_o", stats1.errors_m_wb_adr_o, stats1.errortime_m_wb_adr_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_adr_o");

		if (stats1.errors_m_wb_sel_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_sel_o", stats1.errors_m_wb_sel_o, stats1.errortime_m_wb_sel_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_sel_o");

		if (stats1.errors_m_wb_we_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_we_o", stats1.errors_m_wb_we_o, stats1.errortime_m_wb_we_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_we_o");

		if (stats1.errors_m_wb_dat_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_dat_o", stats1.errors_m_wb_dat_o, stats1.errortime_m_wb_dat_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_dat_o");

		if (stats1.errors_m_wb_cyc_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_cyc_o", stats1.errors_m_wb_cyc_o, stats1.errortime_m_wb_cyc_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_cyc_o");

		if (stats1.errors_m_wb_stb_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_stb_o", stats1.errors_m_wb_stb_o, stats1.errortime_m_wb_stb_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_stb_o");

		if (stats1.errors_m_wb_cti_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_cti_o", stats1.errors_m_wb_cti_o, stats1.errortime_m_wb_cti_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_cti_o");

		if (stats1.errors_m_wb_bte_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "m_wb_bte_o", stats1.errors_m_wb_bte_o, stats1.errortime_m_wb_bte_o);
			else $display("Hint: Output '%s' has no mismatches.", "m_wb_bte_o");

		if (stats1.errors_sd_dat_out_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sd_dat_out_o", stats1.errors_sd_dat_out_o, stats1.errortime_sd_dat_out_o);
			else $display("Hint: Output '%s' has no mismatches.", "sd_dat_out_o");

		if (stats1.errors_sd_dat_oe_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sd_dat_oe_o", stats1.errors_sd_dat_oe_o, stats1.errortime_sd_dat_oe_o);
			else $display("Hint: Output '%s' has no mismatches.", "sd_dat_oe_o");

		if (stats1.errors_sd_cmd_out_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sd_cmd_out_o", stats1.errors_sd_cmd_out_o, stats1.errortime_sd_cmd_out_o);
			else $display("Hint: Output '%s' has no mismatches.", "sd_cmd_out_o");

		if (stats1.errors_sd_cmd_oe_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sd_cmd_oe_o", stats1.errors_sd_cmd_oe_o, stats1.errortime_sd_cmd_oe_o);
			else $display("Hint: Output '%s' has no mismatches.", "sd_cmd_oe_o");

		if (stats1.errors_sd_clk_o_pad) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sd_clk_o_pad", stats1.errors_sd_clk_o_pad, stats1.errortime_sd_clk_o_pad);
			else $display("Hint: Output '%s' has no mismatches.", "sd_clk_o_pad");
		
		`ifdef SDC_IRQ_ENABLE
		if (stats1.errors_int_a) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "int_a", stats1.errors_int_a, stats1.errortime_int_a);
			else $display("Hint: Output '%s' has no mismatches.", "int_a");
		if (stats1.errors_int_b) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "int_b", stats1.errors_int_b, stats1.errortime_int_b);
			else $display("Hint: Output '%s' has no mismatches.", "int_b");
		if (stats1.errors_int_c) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "int_c", stats1.errors_int_c, stats1.errortime_int_c);
			else $display("Hint: Output '%s' has no mismatches.", "int_c");
		`endif

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match1 = ( { wb_dat_o_ref } === ( { wb_dat_o_ref } ^ { wb_dat_o_dut } ^ { wb_dat_o_ref } ) );
	assign tb_match2 = ( { wb_ack_o_ref } === ( { wb_ack_o_ref } ^ { wb_ack_o_dut } ^ { wb_ack_o_ref } ) );
	assign tb_match3 = ( { m_wb_adr_o_ref } === ( { m_wb_adr_o_ref } ^ { m_wb_adr_o_dut } ^ { m_wb_adr_o_ref } ) );
	assign tb_match4 = ( { m_wb_sel_o_ref } === ( { m_wb_sel_o_ref } ^ { m_wb_sel_o_dut } ^ { m_wb_sel_o_ref } ) );
	assign tb_match5 = ( { m_wb_we_o_ref } === ( { m_wb_we_o_ref } ^ { m_wb_we_o_dut } ^ { m_wb_we_o_ref } ) );
	assign tb_match6 = ( { m_wb_dat_o_ref } === ( { m_wb_dat_o_ref } ^ { m_wb_dat_o_dut } ^ { m_wb_dat_o_ref } ) );
	assign tb_match7 = ( { m_wb_cyc_o_ref } === ( { m_wb_cyc_o_ref } ^ { m_wb_cyc_o_dut } ^ { m_wb_cyc_o_ref } ) );
	assign tb_match8 = ( { m_wb_stb_o_ref } === ( { m_wb_stb_o_ref } ^ { m_wb_stb_o_dut } ^ { m_wb_stb_o_ref } ) );
	assign tb_match9 = ( { m_wb_cti_o_ref } === ( { m_wb_cti_o_ref } ^ { m_wb_cti_o_dut } ^ { m_wb_cti_o_ref } ) );
	assign tb_match10 = ( { m_wb_bte_o_ref } === ( { m_wb_bte_o_ref } ^ { m_wb_bte_o_dut } ^ { m_wb_bte_o_ref } ) );
	assign tb_match11 = ( { sd_dat_out_o_ref } === ( { sd_dat_out_o_ref } ^ { sd_dat_out_o_dut } ^ { sd_dat_out_o_ref } ) );
	assign tb_match12 = ( { sd_dat_oe_o_ref } === ( { sd_dat_oe_o_ref } ^ { sd_dat_oe_o_dut } ^ { sd_dat_oe_o_ref } ) );
	assign tb_match13 = ( { sd_cmd_out_o_ref } === ( { sd_cmd_out_o_ref } ^ { sd_cmd_out_o_dut } ^ { sd_cmd_out_o_ref } ) );
	assign tb_match14 = ( { sd_cmd_oe_o_ref } === ( { sd_cmd_oe_o_ref } ^ { sd_cmd_oe_o_dut } ^ { sd_cmd_oe_o_ref } ) );
	assign tb_match15 = ( { sd_clk_o_pad_ref } === ( { sd_clk_o_pad_ref } ^ { sd_clk_o_pad_dut } ^ { sd_clk_o_pad_ref } ) );
	`ifdef SDC_IRQ_ENABLE
		assign tb_match16 = ( { sd_cmd_out_o_ref } === ( { sd_cmd_out_o_ref } ^ { sd_cmd_out_o_dut } ^ { sd_cmd_out_o_ref } ) );
		assign tb_match17 = ( { sd_cmd_oe_o_ref } === ( { sd_cmd_oe_o_ref } ^ { sd_cmd_oe_o_dut } ^ { sd_cmd_oe_o_ref } ) );
		assign tb_match18 = ( { sd_clk_o_pad_ref } === ( { sd_clk_o_pad_ref } ^ { sd_clk_o_pad_dut } ^ { sd_clk_o_pad_ref } ) );
	`endif

	`ifdef SDC_IRQ_ENABLE
		assign tb_match = tb_match1 && tb_match2 && tb_match3 && tb_match4 && tb_match5 && tb_match6 && tb_match7 && tb_match8 && tb_match9 && tb_match10 && tb_match11 && tb_match12 && tb_match13 && tb_match14 && tb_match15 && tb_match16 && tb_match17 && tb_match18;
	`else
		assign tb_match = tb_match1 && tb_match2 && tb_match3 && tb_match4 && tb_match5 && tb_match6 && tb_match7 && tb_match8 && tb_match9 && tb_match10 && tb_match11 && tb_match12 && tb_match13 && tb_match14 && tb_match15;
	`endif

	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		
		if (wb_dat_o_ref !== ( wb_dat_o_ref ^ wb_dat_o_dut ^ wb_dat_o_ref ))
			begin if (stats1.errors_wb_dat_o == 0) stats1.errortime_wb_dat_o = $time;
		stats1.errors_wb_dat_o = stats1.errors_wb_dat_o + 1'b1; end

		if (wb_ack_o_ref !== ( wb_ack_o_ref ^ wb_ack_o_dut ^ wb_ack_o_ref ))
			begin if (stats1.errors_wb_ack_o == 0) stats1.errortime_wb_ack_o = $time;
				stats1.errors_wb_ack_o = stats1.errors_wb_ack_o + 1'b1; end

		if (m_wb_adr_o_ref !== ( m_wb_adr_o_ref ^ m_wb_adr_o_dut ^ m_wb_adr_o_ref ))
			begin if (stats1.errors_m_wb_adr_o == 0) stats1.errortime_m_wb_adr_o = $time;
				stats1.errors_m_wb_adr_o = stats1.errors_m_wb_adr_o + 1'b1; end

		if (m_wb_sel_o_ref !== ( m_wb_sel_o_ref ^ m_wb_sel_o_dut ^ m_wb_sel_o_ref ))
			begin if (stats1.errors_m_wb_sel_o == 0) stats1.errortime_m_wb_sel_o = $time;
				stats1.errors_m_wb_sel_o = stats1.errors_m_wb_sel_o + 1'b1; end

		if (m_wb_we_o_ref !== ( m_wb_we_o_ref ^ m_wb_we_o_dut ^ m_wb_we_o_ref ))
			begin if (stats1.errors_m_wb_we_o == 0) stats1.errortime_m_wb_we_o = $time;
				stats1.errors_m_wb_we_o = stats1.errors_m_wb_we_o + 1'b1; end

		if (m_wb_dat_o_ref !== ( m_wb_dat_o_ref ^ m_wb_dat_o_dut ^ m_wb_dat_o_ref ))
			begin if (stats1.errors_m_wb_dat_o == 0) stats1.errortime_m_wb_dat_o = $time;
				stats1.errors_m_wb_dat_o = stats1.errors_m_wb_dat_o + 1'b1; end

		if (m_wb_cyc_o_ref !== ( m_wb_cyc_o_ref ^ m_wb_cyc_o_dut ^ m_wb_cyc_o_ref ))
			begin if (stats1.errors_m_wb_cyc_o == 0) stats1.errortime_m_wb_cyc_o = $time;
				stats1.errors_m_wb_cyc_o = stats1.errors_m_wb_cyc_o + 1'b1; end

		if (m_wb_stb_o_ref !== ( m_wb_stb_o_ref ^ m_wb_stb_o_dut ^ m_wb_stb_o_ref ))
			begin if (stats1.errors_m_wb_stb_o == 0) stats1.errortime_m_wb_stb_o = $time;
				stats1.errors_m_wb_stb_o = stats1.errors_m_wb_stb_o + 1'b1; end

		if (m_wb_cti_o_ref !== ( m_wb_cti_o_ref ^ m_wb_cti_o_dut ^ m_wb_cti_o_ref ))
			begin if (stats1.errors_m_wb_cti_o == 0) stats1.errortime_m_wb_cti_o = $time;
				stats1.errors_m_wb_cti_o = stats1.errors_m_wb_cti_o + 1'b1; end

		if (m_wb_bte_o_ref !== ( m_wb_bte_o_ref ^ m_wb_bte_o_dut ^ m_wb_bte_o_ref ))
			begin if (stats1.errors_m_wb_bte_o == 0) stats1.errortime_m_wb_bte_o = $time;
				stats1.errors_m_wb_bte_o = stats1.errors_m_wb_bte_o + 1'b1; end

		if (sd_dat_out_o_ref !== ( sd_dat_out_o_ref ^ sd_dat_out_o_dut ^ sd_dat_out_o_ref ))
			begin if (stats1.errors_sd_dat_out_o == 0) stats1.errortime_sd_dat_out_o = $time;
				stats1.errors_sd_dat_out_o = stats1.errors_sd_dat_out_o + 1'b1; end

		if (sd_dat_oe_o_ref !== ( sd_dat_oe_o_ref ^ sd_dat_oe_o_dut ^ sd_dat_oe_o_ref ))
			begin if (stats1.errors_sd_dat_oe_o == 0) stats1.errortime_sd_dat_oe_o = $time;
				stats1.errors_sd_dat_oe_o = stats1.errors_sd_dat_oe_o + 1'b1; end

		if (sd_cmd_out_o_ref !== ( sd_cmd_out_o_ref ^ sd_cmd_out_o_dut ^ sd_cmd_out_o_ref ))
			begin if (stats1.errors_sd_cmd_out_o == 0) stats1.errortime_sd_cmd_out_o = $time;
				stats1.errors_sd_cmd_out_o = stats1.errors_sd_cmd_out_o + 1'b1; end

		if (sd_cmd_oe_o_ref !== ( sd_cmd_oe_o_ref ^ sd_cmd_oe_o_dut ^ sd_cmd_oe_o_ref ))
			begin if (stats1.errors_sd_cmd_oe_o == 0) stats1.errortime_sd_cmd_oe_o = $time;
				stats1.errors_sd_cmd_oe_o = stats1.errors_sd_cmd_oe_o + 1'b1; end

		if (sd_clk_o_pad_ref !== ( sd_clk_o_pad_ref ^ sd_clk_o_pad_dut ^ sd_clk_o_pad_ref ))
			begin if (stats1.errors_sd_clk_o_pad == 0) stats1.errortime_sd_clk_o_pad = $time;
				stats1.errors_sd_clk_o_pad = stats1.errors_sd_clk_o_pad + 1'b1; end

		`ifdef SDC_IRQ_ENABLE
			if (int_a_ref !== ( int_a_ref ^ int_a_dut ^ int_a_ref ))
				begin if (stats1.errors_int_a == 0) stats1.errortime_int_a = $time;
					stats1.errors_int_a = stats1.errors_int_a + 1'b1; end

			if (int_b_ref !== ( int_b_ref ^ int_b_dut ^ int_b_ref ))
				begin if (stats1.errors_int_b == 0) stats1.errortime_int_b = $time;
					stats1.errors_int_b = stats1.errors_int_b + 1'b1; end

			if (int_c_ref !== ( int_c_ref ^ int_c_dut ^ int_c_ref ))
				begin if (stats1.errors_int_c == 0) stats1.errortime_int_c = $time;
					stats1.errors_int_c = stats1.errors_int_c + 1'b1; end
		`endif
	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

