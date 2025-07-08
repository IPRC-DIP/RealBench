module stimulus_gen (
	input CLK,
	output logic BITVAL, Enable, RST,
	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	input tb_match
);
	reg reset;
	assign RST = reset;

//	检测reset
	task reset_test(input async=0);
		bit arfail, srfail, datafail;
	
		@(posedge CLK);
		@(posedge CLK) reset = 0;
		repeat(3) @(posedge CLK);
	
		@(negedge CLK) begin datafail = !tb_match ; reset = 1; end
		@(posedge CLK) arfail = !tb_match;
		@(posedge CLK) begin
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
		reset = 1'b1;
		wavedrom_start("Asynchronous reset");
		reset_test(1);

		repeat(3) @(posedge CLK);
		{Enable,BITVAL} = 2'b11;
		repeat(3) @(posedge CLK);
		{Enable,BITVAL} = 2'b10;
		repeat(3) @(posedge CLK);
		{Enable,BITVAL} = 2'b01;
		repeat(3) @(posedge CLK);
		{Enable,BITVAL} = 2'b00;
		wavedrom_stop();

		@(posedge CLK);

		repeat(1000) @(posedge CLK, negedge CLK) begin
			{Enable, BITVAL} = $random & $random;
			reset = !($random & 31);
		end
		
		$finish;
	end
	
endmodule