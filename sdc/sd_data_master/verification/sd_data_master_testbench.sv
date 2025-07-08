//`timescale 1 ps/1 ps
`include "sd_defines.v"

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_re_s_tx;
		int errortime_re_s_tx;
		int errors_a_cmp_tx;
		int errortime_a_cmp_tx;
		int errors_re_s_rx;
		int errortime_re_s_rx;
		int errors_a_cmp_rx;
		int errortime_a_cmp_rx;
		int errors_we_req;
		int errortime_we_req;
		int errors_d_write;
		int errortime_d_write;
		int errors_d_read;
		int errortime_d_read;
		int errors_cmd_arg;
		int errortime_cmd_arg;
		int errors_cmd_set;
		int errortime_cmd_set;
		int errors_start_tx_fifo;
		int errortime_start_tx_fifo;
		int errors_start_rx_fifo;
		int errortime_start_rx_fifo;
		int errors_sys_adr;
		int errortime_sys_adr;
		int errors_ack_transfer;
		int errortime_ack_transfer;
		int errors_Dat_Int_Status;
		int errortime_Dat_Int_Status;
		int errors_CIDAT;
		int errortime_CIDAT;


		int clocks;
	} stats;
	
	stats stats1;
	
	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;

	
	reg clk=0;
	initial forever
		#5 clk = ~clk;


	logic rst;
	logic [`RAM_MEM_WIDTH-1:0] dat_in_tx;
	logic [`BD_WIDTH-1:0] free_tx_bd;
  	logic ack_i_s_tx;
  	logic [`RAM_MEM_WIDTH-1:0] dat_in_rx;
  	logic [`BD_WIDTH-1:0] free_rx_bd;
  	logic ack_i_s_rx;  
  	logic cmd_busy;	 
  	logic we_ack; 
  	logic cmd_tsf_err;
  	logic [4:0] card_status; 
  	logic tx_empt;
  	logic tx_full;
  	logic rx_full; 
  	logic busy_n;
  	logic transm_complete;
  	logic crc_ok;
  	logic Dat_Int_Status_rst;
  	logic [1:0] transfer_type;

	logic re_s_tx_ref;
	logic re_s_tx_dut;
	logic a_cmp_tx_ref;
	logic a_cmp_tx_dut;
	logic re_s_rx_ref;
	logic re_s_rx_dut;
	logic a_cmp_rx_ref;
	logic a_cmp_rx_dut;
	logic we_req_ref;
	logic we_req_dut;
	logic d_write_ref;
	logic d_write_dut;
	logic d_read_ref;
	logic d_read_dut;
	logic cmd_arg_ref;
	logic cmd_arg_dut;
	logic cmd_set_ref;
	logic cmd_set_dut;
	logic start_tx_fifo_ref;
	logic start_tx_fifo_dut;
	logic start_rx_fifo_ref;
	logic start_rx_fifo_dut;
	logic sys_adr_ref;
	logic sys_adr_dut;
	logic ack_transfer_ref;
	logic ack_transfer_dut;
	logic Dat_Int_Status_ref;
	logic Dat_Int_Status_dut;
	logic CIDAT_ref;
	logic CIDAT_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0);
	end

	wire tb_match;
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk,
		.* ,
		.rst,
		.dat_in_tx,
		.free_tx_bd,
		.ack_i_s_tx,
		.dat_in_rx,
		.free_rx_bd,
		.ack_i_s_rx,  
		.cmd_busy,	 
		.we_ack, 
		.cmd_tsf_err,
		.card_status, 
		.tx_empt,
		.tx_full,
		.rx_full, 
		.busy_n,
		.transm_complete,
		.crc_ok,
		.Dat_Int_Status_rst,
		.transfer_type
		);
	ref_sd_data_master good1 (
		.clk,
		.rst,
		.dat_in_tx,
		.free_tx_bd,
		.ack_i_s_tx,
		.re_s_tx(re_s_tx_ref),
		.a_cmp_tx(a_cmp_rx_ref),
		.dat_in_rx,
		.free_rx_bd,
		.ack_i_s_rx,
		.re_s_rx(re_s_rx_ref),
		.a_cmp_rx(a_cmp_rx_ref),
		.cmd_busy, 
		.we_req(we_req_ref),
		.we_ack,
		.d_write(d_write_ref),
		.d_read(d_read_ref),
		.cmd_arg(cmd_arg_ref),
		.cmd_set(cmd_set_ref),
		.cmd_tsf_err,
		.card_status,
		.start_tx_fifo(start_tx_fifo_ref),
		.start_rx_fifo(start_rx_fifo_ref),
		.sys_adr(sys_adr_ref),
		.tx_empt,
		.tx_full,
		.rx_full,
		.busy_n,
		.transm_complete ,
		.crc_ok,
		.ack_transfer(ack_transfer_ref), 
		.Dat_Int_Status(Dat_Int_Status_ref),
		.Dat_Int_Status_rst,
		.CIDAT(CIDAT_ref),
		.transfer_type
    	);
		
	sd_data_master top_module1 (
		.clk,
		.rst,
		.dat_in_tx,
		.free_tx_bd,
		.ack_i_s_tx,
		.re_s_tx(re_s_tx_dut),
		.a_cmp_tx(a_cmp_rx_dut),
		.dat_in_rx,
		.free_rx_bd,
		.ack_i_s_rx,
		.re_s_rx(re_s_rx_dut),
		.a_cmp_rx(a_cmp_rx_dut),
		.cmd_busy, 
		.we_req(we_req_dut),
		.we_ack,
		.d_write(d_write_dut),
		.d_read(d_read_dut),
		.cmd_arg(cmd_arg_dut),
		.cmd_set(cmd_set_dut),
		.cmd_tsf_err,
		.card_status,
		.start_tx_fifo(start_tx_fifo_dut),
		.start_rx_fifo(start_rx_fifo_dut),
		.sys_adr(sys_adr_dut),
		.tx_empt,
		.tx_full,
		.rx_full,
		.busy_n,
		.transm_complete ,
		.crc_ok,
		.ack_transfer(ack_transfer_dut), 
		.Dat_Int_Status(Dat_Int_Status_dut),
		.Dat_Int_Status_rst,
		.CIDAT(CIDAT_dut),
		.transfer_type
		 );

	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	


	final begin
		if (stats1.errors_re_s_tx) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "re_s_tx", stats1.errors_re_s_tx, stats1.errortime_re_s_tx);
		else $display("Hint: Output '%s' has no mismatches.", "re_s_tx");
		if (stats1.errors_a_cmp_tx) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "a_cmp_tx", stats1.errors_a_cmp_tx, stats1.errortime_a_cmp_tx);
		else $display("Hint: Output '%s' has no mismatches.", "a_cmp_tx");
		if (stats1.errors_re_s_rx) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "re_s_rx", stats1.errors_re_s_rx, stats1.errortime_re_s_rx);
		else $display("Hint: Output '%s' has no mismatches.", "re_s_rx");
		if (stats1.errors_a_cmp_rx) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "a_cmp_rx", stats1.errors_a_cmp_rx, stats1.errortime_a_cmp_rx);
		else $display("Hint: Output '%s' has no mismatches.", "a_cmp_rx");
		if (stats1.errors_we_req) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "we_req", stats1.errors_we_req, stats1.errortime_we_req);
		else $display("Hint: Output '%s' has no mismatches.", "we_req");
		if (stats1.errors_d_write) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "d_write", stats1.errors_d_write, stats1.errortime_d_write);
		else $display("Hint: Output '%s' has no mismatches.", "d_write");
		if (stats1.errors_d_read) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "d_read", stats1.errors_d_read, stats1.errortime_d_read);
		else $display("Hint: Output '%s' has no mismatches.", "d_read");
		if (stats1.errors_cmd_arg) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_arg", stats1.errors_cmd_arg, stats1.errortime_cmd_arg);
		else $display("Hint: Output '%s' has no mismatches.", "cmd_arg");
		if (stats1.errors_cmd_set) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "cmd_set", stats1.errors_cmd_set, stats1.errortime_cmd_set);
		else $display("Hint: Output '%s' has no mismatches.", "cmd_set");
		if (stats1.errors_start_tx_fifo) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "start_tx_fifo", stats1.errors_start_tx_fifo, stats1.errortime_start_tx_fifo);
		else $display("Hint: Output '%s' has no mismatches.", "start_tx_fifo");
		if (stats1.errors_start_rx_fifo) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "start_rx_fifo", stats1.errors_start_rx_fifo, stats1.errortime_start_rx_fifo);
		else $display("Hint: Output '%s' has no mismatches.", "start_rx_fifo");
		if (stats1.errors_sys_adr) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "sys_adr", stats1.errors_sys_adr, stats1.errortime_sys_adr);
		else $display("Hint: Output '%s' has no mismatches.", "sys_adr");
		if (stats1.errors_ack_transfer) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "ack_transfer", stats1.errors_ack_transfer, stats1.errortime_ack_transfer);
		else $display("Hint: Output '%s' has no mismatches.", "ack_transfer");
		if (stats1.errors_Dat_Int_Status) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "Dat_Int_Status", stats1.errors_Dat_Int_Status, stats1.errortime_Dat_Int_Status);
		else $display("Hint: Output '%s' has no mismatches.", "Dat_Int_Status");
		if (stats1.errors_CIDAT) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "CIDAT", stats1.errors_CIDAT, stats1.errortime_CIDAT);
		else $display("Hint: Output '%s' has no mismatches.", "CIDAT");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match = ( { re_s_tx_ref } === ( { re_s_tx_ref } ^ { re_s_tx_dut } ^ { re_s_tx_ref } ) ) ^ ( { a_cmp_tx_ref } === ( { a_cmp_tx_ref } ^ { a_cmp_tx_dut } ^ { a_cmp_tx_ref } ) ) ^ ( { re_s_rx_ref } === ( { re_s_rx_ref } ^ { re_s_rx_dut } ^ { re_s_rx_ref } ) ) ^ ( { a_cmp_rx_ref } === ( { a_cmp_rx_ref } ^ { a_cmp_rx_dut } ^ { a_cmp_rx_ref } ) ) ^ ( { we_req_ref } === ( { we_req_ref } ^ { we_req_dut } ^ { we_req_ref } ) ) ^ ( { d_write_ref } === ( { d_write_ref } ^ { d_write_dut } ^ { d_write_ref } ) ) ^ ( { d_read_ref } === ( { d_read_ref } ^ { d_read_dut } ^ { d_read_ref } ) ) ^ ( { cmd_arg_ref } === ( { cmd_arg_ref } ^ { cmd_arg_dut } ^ { cmd_arg_ref } ) ) ^ ( { cmd_set_ref } === ( { cmd_set_ref } ^ { cmd_set_dut } ^ { cmd_set_ref } ) ) ^ ( { start_tx_fifo_ref } === ( { start_tx_fifo_ref } ^ { start_tx_fifo_dut } ^ { start_tx_fifo_ref } ) ) ^ ( { start_rx_fifo_ref } === ( { start_rx_fifo_ref } ^ { start_rx_fifo_dut } ^ { start_rx_fifo_ref } ) ) ^ ( { sys_adr_ref } === ( { sys_adr_ref } ^ { sys_adr_dut } ^ { sys_adr_ref } ) ) ^ ( { ack_transfer_ref } === ( { ack_transfer_ref } ^ { ack_transfer_dut } ^ { ack_transfer_ref } ) ) ^ ( { Dat_Int_Status_ref } === ( { Dat_Int_Status_ref } ^ { Dat_Int_Status_dut } ^ { Dat_Int_Status_ref } ) ) ^ ( { CIDAT_ref } === ( { CIDAT_ref } ^ { CIDAT_dut } ^ { CIDAT_ref } ) );
	
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end

		if (re_s_tx_ref !== ( re_s_tx_ref ^ re_s_tx_dut ^ re_s_tx_ref ))
		begin if (stats1.errors_re_s_tx == 0) stats1.errortime_re_s_tx = $time;
			stats1.errors_re_s_tx = stats1.errors_re_s_tx+1'b1; end
		if (a_cmp_tx_ref !== ( a_cmp_tx_ref ^ a_cmp_tx_dut ^ a_cmp_tx_ref ))
		begin if (stats1.errors_a_cmp_tx == 0) stats1.errortime_a_cmp_tx = $time;
			stats1.errors_a_cmp_tx = stats1.errors_a_cmp_tx+1'b1; end
		if (re_s_rx_ref !== ( re_s_rx_ref ^ re_s_rx_dut ^ re_s_rx_ref ))
		begin if (stats1.errors_re_s_rx == 0) stats1.errortime_re_s_rx = $time;
			stats1.errors_re_s_rx = stats1.errors_re_s_rx+1'b1; end
		if (a_cmp_rx_ref !== ( a_cmp_rx_ref ^ a_cmp_rx_dut ^ a_cmp_rx_ref ))
		begin if (stats1.errors_a_cmp_rx == 0) stats1.errortime_a_cmp_rx = $time;
			stats1.errors_a_cmp_rx = stats1.errors_a_cmp_rx+1'b1; end
		if (we_req_ref !== ( we_req_ref ^ we_req_dut ^ we_req_ref ))
		begin if (stats1.errors_we_req == 0) stats1.errortime_we_req = $time;
			stats1.errors_we_req = stats1.errors_we_req+1'b1; end
		if (d_write_ref !== ( d_write_ref ^ d_write_dut ^ d_write_ref ))
		begin if (stats1.errors_d_write == 0) stats1.errortime_d_write = $time;
			stats1.errors_d_write = stats1.errors_d_write+1'b1; end
		if (d_read_ref !== ( d_read_ref ^ d_read_dut ^ d_read_ref ))
		begin if (stats1.errors_d_read == 0) stats1.errortime_d_read = $time;
			stats1.errors_d_read = stats1.errors_d_read+1'b1; end
		if (cmd_arg_ref !== ( cmd_arg_ref ^ cmd_arg_dut ^ cmd_arg_ref ))
		begin if (stats1.errors_cmd_arg == 0) stats1.errortime_cmd_arg = $time;
			stats1.errors_cmd_arg = stats1.errors_cmd_arg+1'b1; end
		if (cmd_set_ref !== ( cmd_set_ref ^ cmd_set_dut ^ cmd_set_ref ))
		begin if (stats1.errors_cmd_set == 0) stats1.errortime_cmd_set = $time;
			stats1.errors_cmd_set = stats1.errors_cmd_set+1'b1; end
		if (start_tx_fifo_ref !== ( start_tx_fifo_ref ^ start_tx_fifo_dut ^ start_tx_fifo_ref ))
		begin if (stats1.errors_start_tx_fifo == 0) stats1.errortime_start_tx_fifo = $time;
			stats1.errors_start_tx_fifo = stats1.errors_start_tx_fifo+1'b1; end
		if (start_rx_fifo_ref !== ( start_rx_fifo_ref ^ start_rx_fifo_dut ^ start_rx_fifo_ref ))
		begin if (stats1.errors_start_rx_fifo == 0) stats1.errortime_start_rx_fifo = $time;
			stats1.errors_start_rx_fifo = stats1.errors_start_rx_fifo+1'b1; end
		if (sys_adr_ref !== ( sys_adr_ref ^ sys_adr_dut ^ sys_adr_ref ))
		begin if (stats1.errors_sys_adr == 0) stats1.errortime_sys_adr = $time;
			stats1.errors_sys_adr = stats1.errors_sys_adr+1'b1; end
		if (ack_transfer_ref !== ( ack_transfer_ref ^ ack_transfer_dut ^ ack_transfer_ref ))
		begin if (stats1.errors_ack_transfer == 0) stats1.errortime_ack_transfer = $time;
			stats1.errors_ack_transfer = stats1.errors_ack_transfer+1'b1; end
		if (Dat_Int_Status_ref !== ( Dat_Int_Status_ref ^ Dat_Int_Status_dut ^ Dat_Int_Status_ref ))
		begin if (stats1.errors_Dat_Int_Status == 0) stats1.errortime_Dat_Int_Status = $time;
			stats1.errors_Dat_Int_Status = stats1.errors_Dat_Int_Status+1'b1; end
		if (CIDAT_ref !== ( CIDAT_ref ^ CIDAT_dut ^ CIDAT_ref ))
		begin if (stats1.errors_CIDAT == 0) stats1.errortime_CIDAT = $time;
			stats1.errors_CIDAT = stats1.errors_CIDAT+1'b1; end
	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

