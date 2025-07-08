module stimulus_gen (
	input CLK_PAD_IO,

	output logic RST_PAD_I, New_CMD, 
    output logic data_write, data_read, 
    output logic ERR_INT_RST, NORMAL_INT_RST, 
    output logic req_in, ack_in, card_detect,

    output [31:0] ARG_REG,
    output [13:0] CMD_SET_REG,
    output [15:0] TIMEOUT_REG,
    output [39:0] cmd_in,
    output [7:0] serial_status,

	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	tb_match
);
	reg reset;
	assign RST_PAD_I = reset;


	task reset_test(async=0);
		bit arfail, srfail, datafail;
	
		@(posedge CLK_PAD_IO);
		@(posedge CLK_PAD_IO) reset = 0;
		repeat(3) @(posedge CLK_PAD_IO);
	
		@(negedge CLK_PAD_IO) begin datafail = !tb_match ; reset = 1; end
		@(posedge CLK_PAD_IO) arfail = !tb_match;
		@(posedge CLK_PAD_IO) begin
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

// Add two ports to module stimulus_gen:
//    output [511:0] wavedrom_title
//    output reg wavedrom_enable

	task wavedrom_start(input[511:0] title = "");
	endtask
	
	task wavedrom_stop;
		#1;
	endtask	



	initial begin
		repeat(3)@(posedge CLK_PAD_IO) reset = 0;
		repeat(3)@(posedge CLK_PAD_IO) reset = 1;
		New_CMD = 0;
		data_write = 0;
		data_read = 0;
		ERR_INT_RST = 0;
		NORMAL_INT_RST = 0;
		req_in = 0;
		ack_in = 0;
		card_detect = 0;
		cmd_in = 0;
		serial_status = 0;
		ARG_REG = 0;
		CMD_SET_REG = 0;
		TIMEOUT_REG = 0;

		repeat(3)@(posedge CLK_PAD_IO) reset = 0;

		wavedrom_start("Asynchronous reset");
		reset_test(1);
		wavedrom_stop();


		repeat(10)@(posedge CLK_PAD_IO) reset = 1;
		repeat(10)@(posedge CLK_PAD_IO) reset = 0;
		repeat(10)@(posedge CLK_PAD_IO) TIMEOUT_REG = 15'h10;
		repeat(10)@(posedge CLK_PAD_IO) New_CMD = 1;
		repeat(10)@(posedge CLK_PAD_IO) ack_in = 1;
		repeat(10)@(posedge CLK_PAD_IO) ack_in = 0;
		repeat(10)@(posedge CLK_PAD_IO) ack_in = 1;
		repeat(10)@(posedge CLK_PAD_IO) ERR_INT_RST= 1;
		repeat(10)@(posedge CLK_PAD_IO) NORMAL_INT_RST=1;


        @(posedge CLK_PAD_IO);
		repeat(5000) @(posedge CLK_PAD_IO, negedge CLK_PAD_IO) begin
			New_CMD = ($random%2);
            data_write = ($random%2);
            data_read = ($random%2);
            ERR_INT_RST = ($random%2);
            NORMAL_INT_RST = ($random%2);
            req_in = ($random%2);
            ack_in = ($random%2);
            card_detect = ($random%2);

            ARG_REG = $random;
            CMD_SET_REG = $random;
            TIMEOUT_REG = $random;
            cmd_in = {$random, $random[7:0]};
            serial_status = $random;
			reset = !($random & 31);
		end
		
		#1 $finish;
	end
	
endmodule