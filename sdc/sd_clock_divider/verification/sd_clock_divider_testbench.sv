//`timescale 1 ps/1 ps

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_SD_CLK;
		int errortime_SD_CLK;

		int clocks;
	} stats;
	
	stats stats1;
	

	
	reg clk=0;
	initial forever
		#5 clk = ~clk;

	logic [7:0] DIVIDER;
	logic RST;
	logic SD_CLK_ref;
	logic SD_CLK_dut;




	wire tb_match;
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.clk(clk),
		.DIVIDER(DIVIDER),
        .RST(RST));
	ref_sd_clock_divider good1 (
		.CLK(clk),
        .DIVIDER(DIVIDER),
		.RST(RST),
        .SD_CLK(SD_CLK_ref) );
		
	sd_clock_divider top_module1 (
		.CLK(clk),
        .DIVIDER(DIVIDER),
		.RST(RST),
        .SD_CLK(SD_CLK_dut) );

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0);
	end

	final begin
		if (stats1.errors_SD_CLK) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "SD_CLK", stats1.errors_SD_CLK, stats1.errortime_SD_CLK);
		else $display("Hint: Output '%s' has no mismatches.", "SD_CLK");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match = ( { SD_CLK_ref } === ( { SD_CLK_ref } ^ { SD_CLK_dut } ^ { SD_CLK_ref } ) );
	always @(posedge clk, negedge clk) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (SD_CLK_ref !== ( SD_CLK_ref ^ SD_CLK_dut ^ SD_CLK_ref ))
		begin if (stats1.errors_SD_CLK == 0) stats1.errortime_SD_CLK = $time;
			stats1.errors_SD_CLK = stats1.errors_SD_CLK+1'b1; end

	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

