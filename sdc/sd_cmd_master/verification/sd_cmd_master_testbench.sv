//`timescale 1 ps/1 ps

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_STATUS_REG;
		int errortime_STATUS_REG;
		int errors_RESP_1_REG;
		int errortime_RESP_1_REG;
        int errors_ERR_INT_REG;
		int errortime_ERR_INT_REG;
        int errors_NORMAL_INT_REG;
		int errortime_NORMAL_INT_REG;
        int errors_settings;
		int errortime_settings;
        int errors_go_idle_o;
		int errortime_go_idle_o;
        int errors_cmd_out;
		int errortime_cmd_out;
        int errors_req_out;
		int errortime_req_out;
        int errors_ack_out;
		int errortime_ack_out;

		int clocks;
	} stats;
	
	stats stats1;


	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
		

	
	reg CLK_PAD_IO=0;
	initial forever
		#5 CLK_PAD_IO = ~CLK_PAD_IO;

	logic RST_PAD_I,New_CMD,data_write,data_read;
    logic ERR_INT_RST,NORMAL_INT_RST,req_in,ack_in,card_detect;
    logic [31:0] ARG_REG;
    logic [13:0] CMD_SET_REG;
    logic [15:0] TIMEOUT_REG;
    logic [39:0] cmd_in;
    logic [7:0] serial_status;

	logic go_idle_o_ref;
	logic go_idle_o_dut;
    logic req_out_ref;
    logic req_out_dut;
    logic ack_out_ref;
    logic ack_out_dut;
    logic [15:0] STATUS_REG_ref;
    logic [15:0] STATUS_REG_dut;
    logic [31:0] RESP_1_REG_ref;    
    logic [31:0] RESP_1_REG_dut;
    logic [4:0] ERR_INT_REG_ref;
    logic [4:0] ERR_INT_REG_dut;
    logic [15:0] NORMAL_INT_REG_ref;
    logic [15:0] NORMAL_INT_REG_dut;
    logic [15:0] settings_ref;
    logic [15:0] settings_dut;
    logic [39:0] cmd_out_ref;
    logic [39:0] cmd_out_dut;


	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0);
	end


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

	stimulus_gen stim1 (
		.CLK_PAD_IO,
		.* ,
		.RST_PAD_I,
		.New_CMD,
		.data_write,
        .data_read,
        .ERR_INT_RST,
        .NORMAL_INT_RST,
        .req_in,
        .ack_in,
        .card_detect,
        .ARG_REG,
        .CMD_SET_REG,
        .TIMEOUT_REG,
        .cmd_in,
        .serial_status
        );

	ref_sd_cmd_master good1 (
		.CLK_PAD_IO,
		.RST_PAD_I,
		.New_CMD,
		.data_write,
        .data_read,
        .ARG_REG,
        .CMD_SET_REG,
        .TIMEOUT_REG,
        .STATUS_REG(STATUS_REG_ref),
        .RESP_1_REG(RESP_1_REG_ref),
        .ERR_INT_REG(ERR_INT_REG_ref),
        .NORMAL_INT_REG(NORMAL_INT_REG_ref),
        .ERR_INT_RST,
        .NORMAL_INT_RST,
        .settings(settings_ref),
        .go_idle_o(go_idle_o_ref),
        .cmd_out(cmd_out_ref),
        .req_out(req_out_ref),
        .ack_out(ack_out_ref),
        .req_in,
        .ack_in,
        .cmd_in,
        .serial_status,
        .card_detect);
		
	sd_cmd_master top_module1 (
		.CLK_PAD_IO,
		.RST_PAD_I,
		.New_CMD,
		.data_write,
        .data_read,
        .ARG_REG,
        .CMD_SET_REG,
        .TIMEOUT_REG,
        .STATUS_REG(STATUS_REG_dut),
        .RESP_1_REG(RESP_1_REG_dut),
        .ERR_INT_REG(ERR_INT_REG_dut),
        .NORMAL_INT_REG(NORMAL_INT_REG_dut),
        .ERR_INT_RST,
        .NORMAL_INT_RST,
        .settings(settings_dut),
        .go_idle_o(go_idle_o_dut),
        .cmd_out(cmd_out_dut),
        .req_out(req_out_dut),
        .ack_out(ack_out_dut),
        .req_in,
        .ack_in,
        .cmd_in,
        .serial_status,
        .card_detect);


	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	



	final begin
		if (stats1.errors_STATUS_REG) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "STATUS_REG", stats1.errors_STATUS_REG, stats1.errortime_STATUS_REG);
		else $display("Hint: Output '%s' has no mismatches.", "STATUS_REG");
		if (stats1.errors_RESP_1_REG) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "RESP_1_REG", stats1.errors_RESP_1_REG, stats1.errortime_RESP_1_REG);
		else $display("Hint: Output '%s' has no mismatches.", "RESP_1_REG");
		if (stats1.errors_ERR_INT_REG) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "ERR_INT_REG", stats1.errors_ERR_INT_REG, stats1.errortime_ERR_INT_REG);
		else $display("Hint: Output '%s' has no mismatches.", "ERR_INT_REG");
		if (stats1.errors_NORMAL_INT_REG) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "NORMAL_INT_REG", stats1.errors_NORMAL_INT_REG, stats1.errortime_NORMAL_INT_REG);
		else $display("Hint: Output '%s' has no mismatches.", "NORMAL_INT_REG");
		if (stats1.errors_settings) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "errors_settings", stats1.errors_settings, stats1.errortime_settings);
		else $display("Hint: Output '%s' has no mismatches.", "errors_settings");
		if (stats1.errors_go_idle_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "errors_go_idle_o", stats1.errors_go_idle_o, stats1.errortime_go_idle_o);
		else $display("Hint: Output '%s' has no mismatches.", "errors_go_idle_o");
		if (stats1.errors_cmd_out) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "errors_cmd_out", stats1.errors_cmd_out, stats1.errortime_cmd_out);
		else $display("Hint: Output '%s' has no mismatches.", "errors_cmd_out");
		if (stats1.errors_req_out) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "errors_req_out", stats1.errors_req_out, stats1.errortime_req_out);
		else $display("Hint: Output '%s' has no mismatches.", "errors_req_out");
		if (stats1.errors_ack_out) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "ack_out", stats1.errors_ack_out, stats1.errortime_ack_out);
		else $display("Hint: Output '%s' has no mismatches.", "ack_out");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match1 = ( { STATUS_REG_ref } === ( { STATUS_REG_ref } ^ { STATUS_REG_dut } ^ { STATUS_REG_ref } ) );
	assign tb_match2 = ( { RESP_1_REG_ref } === ( { RESP_1_REG_ref } ^ { RESP_1_REG_dut } ^ { RESP_1_REG_ref } ) );
	assign tb_match3 = ( { ERR_INT_REG_ref } === ( { ERR_INT_REG_ref } ^ { ERR_INT_REG_dut } ^ { ERR_INT_REG_ref } ) );
	assign tb_match4 = ( { NORMAL_INT_REG_ref } === ( { NORMAL_INT_REG_ref } ^ { NORMAL_INT_REG_dut } ^ { NORMAL_INT_REG_ref } ) );
	assign tb_match5 = ( { settings_ref } === ( { settings_ref } ^ { settings_dut } ^ { settings_ref } ) );
	assign tb_match6 = ( { go_idle_o_ref } === ( { go_idle_o_ref } ^ { go_idle_o_dut } ^ { go_idle_o_ref } ) );
	assign tb_match7 = ( { cmd_out_ref } === ( { cmd_out_ref } ^ { cmd_out_dut } ^ { cmd_out_ref } ) );
	assign tb_match8 = ( { req_out_ref } === ( { req_out_ref } ^ { req_out_dut } ^ { req_out_ref } ) );
	assign tb_match9 = ( { ack_out_ref } === ( { ack_out_ref } ^ { ack_out_dut } ^ { ack_out_ref } ) );
	assign tb_match = tb_match1 && tb_match2 && tb_match3 && tb_match4 && tb_match5 && tb_match6 && tb_match7 && tb_match8 && tb_match9;

	always @(posedge CLK_PAD_IO, negedge CLK_PAD_IO) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		

		if (STATUS_REG_ref !== ( STATUS_REG_ref ^ STATUS_REG_dut ^ STATUS_REG_ref ))
		begin if (stats1.errors_STATUS_REG == 0) stats1.errortime_STATUS_REG = $time;
			stats1.errors_STATUS_REG = stats1.errors_STATUS_REG+1'b1; end
		
        if (RESP_1_REG_ref !== ( RESP_1_REG_ref ^ RESP_1_REG_dut ^ RESP_1_REG_ref ))
		begin if (stats1.errors_RESP_1_REG == 0) stats1.errortime_RESP_1_REG = $time;
			stats1.errors_RESP_1_REG = stats1.errors_RESP_1_REG+1'b1; end

		if (ERR_INT_REG_ref !== ( ERR_INT_REG_ref ^ ERR_INT_REG_dut ^ ERR_INT_REG_ref ))
		begin if (stats1.errors_ERR_INT_REG == 0) stats1.errortime_ERR_INT_REG = $time;
			stats1.errors_ERR_INT_REG = stats1.errors_ERR_INT_REG+1'b1; end

		if (NORMAL_INT_REG_ref !== ( NORMAL_INT_REG_ref ^ NORMAL_INT_REG_dut ^ NORMAL_INT_REG_ref ))
		begin if (stats1.errors_NORMAL_INT_REG == 0) stats1.errortime_NORMAL_INT_REG = $time;
			stats1.errors_NORMAL_INT_REG = stats1.errors_NORMAL_INT_REG+1'b1; end

		if (settings_ref !== ( settings_ref ^ settings_dut ^ settings_ref ))
		begin if (stats1.errors_settings == 0) stats1.errortime_settings = $time;
			stats1.errors_settings = stats1.errors_settings+1'b1; end

		if (go_idle_o_ref !== ( go_idle_o_ref ^ go_idle_o_dut ^ go_idle_o_ref ))
		begin if (stats1.errors_go_idle_o == 0) stats1.errortime_go_idle_o = $time;
			stats1.errors_go_idle_o = stats1.errors_go_idle_o+1'b1; end
		
        if (cmd_out_ref !== ( cmd_out_ref ^ cmd_out_dut ^ cmd_out_ref ))
		begin if (stats1.errors_cmd_out == 0) stats1.errortime_cmd_out = $time;
			stats1.errors_cmd_out = stats1.errors_cmd_out+1'b1; end

		if (req_out_ref !== ( req_out_ref ^ req_out_dut ^ req_out_ref ))
		begin if (stats1.errors_req_out == 0) stats1.errortime_req_out = $time;
			stats1.errors_req_out = stats1.errors_req_out+1'b1; end
            
		if (ack_out_ref !== ( ack_out_ref ^ ack_out_dut ^ ack_out_ref ))
		begin if (stats1.errors_ack_out == 0) stats1.errortime_ack_out = $time;
			stats1.errors_ack_out = stats1.errors_ack_out+1'b1; end


	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

