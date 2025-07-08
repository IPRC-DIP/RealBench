//`timescale 1 ps/1 ps
`include "sd_defines.v"

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_rd;
		int errortime_rd;
		int errors_data_out;
		int errortime_data_out;
		int errors_we;
		int errortime_we;
		int errors_DAT_oe_o;
		int errortime_DAT_oe_o;
		int errors_DAT_dat_o;
		int errortime_DAT_dat_o;
		int errors_busy_n;
		int errortime_busy_n;
		int errors_transm_complete;
		int errortime_transm_complete;
		int errors_crc_ok;
		int errortime_crc_ok;

		int clocks;
	} stats;
	
	stats stats1;
	
	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;

	
	reg sd_clk=0;
	initial forever
		#5 sd_clk = ~sd_clk;

	logic rst;
	logic [31:0] data_in;
	logic [`SD_BUS_W-1:0] DAT_dat_i;
	logic [1:0] start_dat;
	logic ack_transfer;

	logic rd_ref;
	logic [`SD_BUS_W-1:0] data_out_ref;
	logic we_ref;
	logic DAT_oe_o_ref;
	logic [`SD_BUS_W-1:0] DAT_dat_o_ref;
	logic busy_n_ref;
	logic transm_complete_ref;
	logic crc_ok_ref;

	logic rd_dut;
	logic [`SD_BUS_W-1:0] data_out_dut;
	logic we_dut;
	logic DAT_oe_o_dut;
	logic [`SD_BUS_W-1:0] DAT_dat_o_dut;
	logic busy_n_dut;
	logic transm_complete_dut;
	logic crc_ok_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0);
	end

	wire tb_match;
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.sd_clk,
		.* ,
		.rst,
		.data_in,
		.DAT_dat_i,
		.start_dat,
		.ack_transfer 
		);
	ref_sd_data_serial_host good1 (
		.sd_clk,
		.rst,
		.data_in,
		.rd(rd_ref),
		.data_out(data_out_ref),
		.we(we_ref),
		.DAT_oe_o(DAT_oe_o_ref),
		.DAT_dat_o(DAT_dat_o_ref),
		.DAT_dat_i,
		.start_dat,
		.ack_transfer,
		.busy_n(busy_n_ref),
		.transm_complete(transm_complete_ref),
		.crc_ok(crc_ok_ref)
		);
		
	sd_data_serial_host top_module1 (
		.sd_clk,
		.rst,
		.data_in,
		.rd(rd_dut),
		.data_out(data_out_dut),
		.we(we_dut),
		.DAT_oe_o(DAT_oe_o_dut),
		.DAT_dat_o(DAT_dat_o_dut),
		.DAT_dat_i,
		.start_dat,
		.ack_transfer,
		.busy_n(busy_n_dut),
		.transm_complete(transm_complete_dut),
		.crc_ok(crc_ok_dut)
		);


	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	


	final begin
		if (stats1.errors_rd) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "rd", stats1.errors_rd, stats1.errortime_rd);
		else $display("Hint: Output '%s' has no mismatches.", "rd");
		if (stats1.errors_data_out) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "data_out", stats1.errors_data_out, stats1.errortime_data_out);
		else $display("Hint: Output '%s' has no mismatches.", "data_out");
		if (stats1.errors_we) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "we", stats1.errors_we, stats1.errortime_we);
		else $display("Hint: Output '%s' has no mismatches.", "we");
		if (stats1.errors_DAT_oe_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "DAT_oe_o", stats1.errors_DAT_oe_o, stats1.errortime_DAT_oe_o);
		else $display("Hint: Output '%s' has no mismatches.", "DAT_oe_o");
		if (stats1.errors_DAT_dat_o) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "DAT_dat_o", stats1.errors_DAT_dat_o, stats1.errortime_DAT_dat_o);
		else $display("Hint: Output '%s' has no mismatches.", "DAT_dat_o");
		if (stats1.errors_busy_n) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "busy_n", stats1.errors_busy_n, stats1.errortime_busy_n);
		else $display("Hint: Output '%s' has no mismatches.", "busy_n");
		if (stats1.errors_transm_complete) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "transm_complete", stats1.errors_transm_complete, stats1.errortime_transm_complete);
		else $display("Hint: Output '%s' has no mismatches.", "transm_complete");
		if (stats1.errors_crc_ok) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "crc_ok", stats1.errors_crc_ok, stats1.errortime_crc_ok);
		else $display("Hint: Output '%s' has no mismatches.", "crc_ok");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match = ( { rd_ref } === ( { rd_ref } ^ { rd_dut } ^ { rd_ref } ) );
	assign tb_match = ( { data_out_ref } === ( { data_out_ref } ^ { data_out_dut } ^ { data_out_ref } ) );
	assign tb_match = ( { we_ref } === ( { we_ref } ^ { we_dut } ^ { we_ref } ) );
	assign tb_match = ( { DAT_oe_o_ref } === ( { DAT_oe_o_ref } ^ { DAT_oe_o_dut } ^ { DAT_oe_o_ref } ) );
	assign tb_match = ( { DAT_dat_o_ref } === ( { DAT_dat_o_ref } ^ { DAT_dat_o_dut } ^ { DAT_dat_o_ref } ) );
	assign tb_match = ( { busy_n_ref } === ( { busy_n_ref } ^ { busy_n_dut } ^ { busy_n_ref } ) );
	assign tb_match = ( { transm_complete_ref } === ( { transm_complete_ref } ^ { transm_complete_dut } ^ { transm_complete_ref } ) );
	assign tb_match = ( { crc_ok_ref } === ( { crc_ok_ref } ^ { crc_ok_dut } ^ { crc_ok_ref } ) );
	
	always @(posedge sd_clk, negedge sd_clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (rd_ref !== ( rd_ref ^ rd_dut ^ rd_ref ))
		begin if (stats1.errors_rd == 0) stats1.errortime_rd = $time;
			stats1.errors_rd = stats1.errors_rd+1'b1; end
		if (data_out_ref !== ( data_out_ref ^ data_out_dut ^ data_out_ref ))
		begin if (stats1.errors_data_out == 0) stats1.errortime_data_out = $time;
			stats1.errors_data_out = stats1.errors_data_out+1'b1; end
		if (we_ref !== ( we_ref ^ we_dut ^ we_ref ))
		begin if (stats1.errors_we == 0) stats1.errortime_we = $time;
			stats1.errors_we = stats1.errors_we+1'b1; end
		if (DAT_oe_o_ref !== ( DAT_oe_o_ref ^ DAT_oe_o_dut ^ DAT_oe_o_ref ))
		begin if (stats1.errors_DAT_oe_o == 0) stats1.errortime_DAT_oe_o = $time;
			stats1.errors_DAT_oe_o = stats1.errors_DAT_oe_o+1'b1; end
		if (DAT_dat_o_ref !== ( DAT_dat_o_ref ^ DAT_dat_o_dut ^ DAT_dat_o_ref ))
		begin if (stats1.errors_DAT_dat_o == 0) stats1.errortime_DAT_dat_o = $time;
			stats1.errors_DAT_dat_o = stats1.errors_DAT_dat_o+1'b1; end
		if (busy_n_ref !== ( busy_n_ref ^ busy_n_dut ^ busy_n_ref ))
		begin if (stats1.errors_busy_n == 0) stats1.errortime_busy_n = $time;
			stats1.errors_busy_n = stats1.errors_busy_n+1'b1; end
		if (transm_complete_ref !== ( transm_complete_ref ^ transm_complete_dut ^ transm_complete_ref ))
		begin if (stats1.errors_transm_complete == 0) stats1.errortime_transm_complete = $time;
			stats1.errors_transm_complete = stats1.errors_transm_complete+1'b1; end
		if (crc_ok_ref !== ( crc_ok_ref ^ crc_ok_dut ^ crc_ok_ref ))
		begin if (stats1.errors_crc_ok == 0) stats1.errortime_crc_ok = $time;
			stats1.errors_crc_ok = stats1.errors_crc_ok+1'b1; end

	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

