//`timescale 1 ps/1 ps

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_CMD_OUT;
		int errortime_CMD_OUT;
        int errors_ACK_OUT;
		int errortime_ACK_OUT;
        int errors_REQ_OUT;
		int errortime_REQ_OUT;
        int errors_STATUS;
		int errortime_STATUS;
        int errors_cmd_oe_o;
		int errortime_cmd_oe_o;
        int errors_cmd_out_o;
		int errortime_cmd_out_o;
        int errors_st_dat_t;
		int errortime_st_dat_t;


		int clocks;
	} stats;
	
	stats stats1;


	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
		

	
	reg SD_CLK_IN=0;
	initial forever
		#5 SD_CLK_IN = ~SD_CLK_IN;


	logic RST_IN,REQ_IN,ACK_IN,cmd_dat_i;
    logic [15:0] SETTING_IN; 
    logic [39:0] CMD_IN;
   
   
	logic CMD_OUT_ref;
	logic CMD_OUT_dut;
    logic ACK_OUT_ref;
    logic ACK_OUT_dut;
    logic REQ_OUT_ref;
    logic REQ_OUT_dut;
    logic [7:0] STATUS_ref;
    logic [7:0] STATUS_dut;
    logic cmd_oe_o_ref;
    logic cmd_oe_o_dut;
    logic cmd_out_o_ref;
    logic cmd_out_o_dut;
    logic st_dat_t_ref;
    logic st_dat_t_dut;

   


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





	stimulus_gen stim1 (
		.SD_CLK_IN,
		.* ,
		.RST_IN,
		.SETTING_IN,
		.CMD_IN,
        .REQ_IN,
        .ACK_IN,
        .cmd_dat_i);

	ref_sd_cmd_serial_host good1 (
		.SD_CLK_IN,
		.RST_IN,
		.SETTING_IN,
		.CMD_IN,
        .REQ_IN,
        .ACK_IN,
        .cmd_dat_i,
        .CMD_OUT(CMD_OUT_ref),
        .ACK_OUT(ACK_OUT_ref),
        .REQ_OUT(REQ_OUT_ref),
        .STATUS(STATUS_ref),
        .cmd_oe_o(cmd_oe_o_ref),
        .cmd_out_o(cmd_out_o_ref),
        .st_dat_t(st_dat_t_ref));
		
	sd_cmd_serial_host top_module1 (
		.SD_CLK_IN,
		.RST_IN,
		.SETTING_IN,
		.CMD_IN,
        .REQ_IN,
        .ACK_IN,
        .cmd_dat_i,
        .CMD_OUT(CMD_OUT_dut),
        .ACK_OUT(ACK_OUT_dut),
        .REQ_OUT(REQ_OUT_dut),
        .STATUS(STATUS_dut),
        .cmd_oe_o(cmd_oe_o_dut),
        .cmd_out_o(cmd_out_o_dut),
        .st_dat_t(st_dat_t_dut));


	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	



	final begin
        if (stats1.errors_CMD_OUT) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "CMD_OUT", stats1.errors_CMD_OUT, stats1.errortime_CMD_OUT);
        else $display("Hint: Output '%s' has no mismatches.", "CMD_OUT");
        
        if (stats1.errors_ACK_OUT) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "ACK_OUT", stats1.errors_ACK_OUT, stats1.errortime_ACK_OUT);
        else $display("Hint: Output '%s' has no mismatches.", "ACK_OUT");
        
        if (stats1.errors_REQ_OUT) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "REQ_OUT", stats1.errors_REQ_OUT, stats1.errortime_REQ_OUT);
        else $display("Hint: Output '%s' has no mismatches.", "REQ_OUT");
        
        if (stats1.errors_STATUS) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "STATUS", stats1.errors_STATUS, stats1.errortime_STATUS);
        else $display("Hint: Output '%s' has no mismatches.", "STATUS");
        
        if (stats1.errors_cmd_oe_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_oe_o", stats1.errors_cmd_oe_o, stats1.errortime_cmd_oe_o);
        else $display("Hint: Output '%s' has no mismatches.", "cmd_oe_o");
        
        if (stats1.errors_cmd_out_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_out_o", stats1.errors_cmd_out_o, stats1.errortime_cmd_out_o);
        else $display("Hint: Output '%s' has no mismatches.", "cmd_out_o");
        
        if (stats1.errors_st_dat_t) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "st_dat_t", stats1.errors_st_dat_t, stats1.errortime_st_dat_t);
        else $display("Hint: Output '%s' has no mismatches.", "st_dat_t");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
    assign tb_match1 = ( { CMD_OUT_ref } === ( { CMD_OUT_ref } ^ { CMD_OUT_dut } ^ { CMD_OUT_ref } ) );
    assign tb_match2 = ( { ACK_OUT_ref } === ( { ACK_OUT_ref } ^ { ACK_OUT_dut } ^ { ACK_OUT_ref } ) );
    assign tb_match3 = ( { REQ_OUT_ref } === ( { REQ_OUT_ref } ^ { REQ_OUT_dut } ^ { REQ_OUT_ref } ) );
    assign tb_match4 = ( { STATUS_ref } === ( { STATUS_ref } ^ { STATUS_dut } ^ { STATUS_ref } ) );
    assign tb_match5 = ( { cmd_oe_o_ref } === ( { cmd_oe_o_ref } ^ { cmd_oe_o_dut } ^ { cmd_oe_o_ref } ) );
    assign tb_match6 = ( { cmd_out_o_ref } === ( { cmd_out_o_ref } ^ { cmd_out_o_dut } ^ { cmd_out_o_ref } ) );
    assign tb_match7 = ( { st_dat_t_ref } === ( { st_dat_t_ref } ^ { st_dat_t_dut } ^ { st_dat_t_ref } ) );
    assign tb_match = tb_match1 && tb_match2 && tb_match3 && tb_match4 && tb_match5 && tb_match6 && tb_match7;
    
	always @(posedge SD_CLK_IN, negedge SD_CLK_IN) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end


        if (CMD_OUT_ref !== ( CMD_OUT_ref ^ CMD_OUT_dut ^ CMD_OUT_ref ))
        begin 
            if (stats1.errors_CMD_OUT == 0) stats1.errortime_CMD_OUT = $time;
            stats1.errors_CMD_OUT = stats1.errors_CMD_OUT + 1'b1; 
        end
        
        if (ACK_OUT_ref !== ( ACK_OUT_ref ^ ACK_OUT_dut ^ ACK_OUT_ref ))
        begin 
            if (stats1.errors_ACK_OUT == 0) stats1.errortime_ACK_OUT = $time;
            stats1.errors_ACK_OUT = stats1.errors_ACK_OUT + 1'b1; 
        end

        if (REQ_OUT_ref !== ( REQ_OUT_ref ^ REQ_OUT_dut ^ REQ_OUT_ref ))
        begin 
            if (stats1.errors_REQ_OUT == 0) stats1.errortime_REQ_OUT = $time;
            stats1.errors_REQ_OUT = stats1.errors_REQ_OUT + 1'b1; 
        end

        if (STATUS_ref !== ( STATUS_ref ^ STATUS_dut ^ STATUS_ref ))
        begin 
            if (stats1.errors_STATUS == 0) stats1.errortime_STATUS = $time;
            stats1.errors_STATUS = stats1.errors_STATUS + 1'b1; 
        end

        if (cmd_oe_o_ref !== ( cmd_oe_o_ref ^ cmd_oe_o_dut ^ cmd_oe_o_ref ))
        begin 
            if (stats1.errors_cmd_oe_o == 0) stats1.errortime_cmd_oe_o = $time;
            stats1.errors_cmd_oe_o = stats1.errors_cmd_oe_o + 1'b1; 
        end

        if (cmd_out_o_ref !== ( cmd_out_o_ref ^ cmd_out_o_dut ^ cmd_out_o_ref ))
        begin 
            if (stats1.errors_cmd_out_o == 0) stats1.errortime_cmd_out_o = $time;
            stats1.errors_cmd_out_o = stats1.errors_cmd_out_o + 1'b1; 
        end

        if (st_dat_t_ref !== ( st_dat_t_ref ^ st_dat_t_dut ^ st_dat_t_ref ))
        begin 
            if (stats1.errors_st_dat_t == 0) stats1.errortime_st_dat_t = $time;
            stats1.errors_st_dat_t = stats1.errors_st_dat_t + 1'b1; 
        end

	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

