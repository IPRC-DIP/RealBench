`include "sd_defines.v"

module stimulus_gen (
	input sd_clk,
	output logic rst,
	output [31:0] data_in ,
	output [`SD_BUS_W-1:0] DAT_dat_i,
	output [1:0] start_dat,
	output logic ack_transfer,

	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	tb_match
);
	reg reset;
	assign rst = reset;


	task reset_test(input async = 0);
		bit arfail, srfail, datafail;
	
		@(posedge sd_clk);
		@(posedge sd_clk) reset = 0;
		repeat(3) @(posedge sd_clk);
	
		@(negedge sd_clk) begin datafail = !tb_match ; reset = 1; end
		@(posedge sd_clk) arfail = !tb_match;
		@(posedge sd_clk) begin
			srfail = !tb_match;
			reset = 0;
		end
		if (srfail)
			$display("Hint: Your reset doesn't seem to be working.");
		else if (arfail && (async || !datafail))
			$display("Hint: Your reset should be %0s, but doesn't appear to be.", async ? "asynchronous" : "synchronous");
		// Don't warn about synchronous reset if the half-cycle before is already wrong. It's more likely
		// a functionality error than the reset being implemented asynchronously.
	
	endtask

	task wavedrom_start(input[511:0] title = "");
	endtask

	task wavedrom_stop;
		#1;
	endtask	


	initial begin
		repeat(3)@(posedge sd_clk) reset = 0;
		repeat(3)@(posedge sd_clk) reset = 1;
		reset = 0;
		data_in = 0;
		DAT_dat_i = 0;
		start_dat = 0;
		ack_transfer = 0;

		repeat(3)@(posedge sd_clk) reset = 0;

		wavedrom_start("Asynchronous reset");
		reset_test(1);
		wavedrom_stop();

		// IDLE -> WRITE_DAT -> WRITE_CRC -> WRITE_BUSY -> IDLE
		@(posedge sd_clk) data_in = 31'h1010;
			start_dat = 2'b01;
			ack_transfer = 1;

		repeat(1000) @(posedge sd_clk);
		repeat(1000) @(posedge sd_clk) DAT_dat_i[0] = ~DAT_dat_i[0];
		repeat(10) @(posedge sd_clk) reset = 1;
		repeat(10) @(posedge sd_clk) reset = 0;

		// IDLE -> WRITE_DAT -> WRITE_CRC -> WRITE_BUSY -> IDLE
		@(posedge sd_clk) data_in = 31'h1010;
			start_dat = 2'b01;
			ack_transfer = 1;

		repeat(2000) @(posedge sd_clk);
		repeat(10) @(posedge sd_clk) reset = 1;
		repeat(10) @(posedge sd_clk) reset = 0;
		
		// IDLE -> READ_WAIT -> READ_DAT -> IDLE
		@(posedge sd_clk) data_in = 31'h1010;
			start_dat = 2'b10;
			ack_transfer = 1;
			DAT_dat_i[0] = 0;
		repeat(10) @(posedge sd_clk);
		repeat(10) @(posedge sd_clk) reset = 1;
		repeat(10) @(posedge sd_clk) reset = 0;

		// IDLE -> READ_WAIT -> READ_DAT -> IDLE
		@(posedge sd_clk) data_in = 31'h1010;
			start_dat = 2'b10;
			ack_transfer = 0;
			DAT_dat_i = 0;
		repeat(1000) @(posedge sd_clk);
		repeat(500)@(posedge sd_clk) DAT_dat_i = DAT_dat_i + 1;
		repeat(10) @(posedge sd_clk) start_dat = 2'b11;
		repeat(10) @(posedge sd_clk) reset = 1;
		repeat(10) @(posedge sd_clk) reset = 0;

		// IDLE -> WRITE_DAT -> IDLE
		@(posedge sd_clk) data_in = 31'h1010;
			start_dat = 2'b01;
			ack_transfer = 1;

		repeat(1000) @(posedge sd_clk);
		repeat(10) @(posedge sd_clk) start_dat = 2'b11;
		repeat(10) @(posedge sd_clk) reset = 1;
		repeat(10) @(posedge sd_clk) reset = 0;

		//random
		repeat(2000) @(posedge sd_clk, negedge sd_clk) begin
			ack_transfer = ($random%2);

            data_in = $random;
            DAT_dat_i = $random;
            start_dat = $random;
			reset = !($random & 31);
		end
		#1
		$finish;
	end
	
endmodule