//`timescale 1 ps/1 ps

module tb();

	typedef struct packed {
		int errors;
		int errortime;
		int errors_CRC;
		int errortime_CRC;

		int clocks;
	} stats;
	
	stats stats1;


	wire[511:0] wavedrom_title;
	wire wavedrom_enable;
	int wavedrom_hide_after_time;
		

	
	reg CLK=0;
	initial forever
		#5 CLK = ~CLK;

	logic BITVAL;
	logic Enable;
	logic RST;
	logic [6:0] CRC_ref;
	logic [6:0] CRC_dut;

	initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(1, stim1.CLK, tb_mismatch ,CLK,BITVAL,Enable,RST,CRC_ref,CRC_dut);
	end


	wire tb_match;
	wire tb_mismatch = ~tb_match;
	
	stimulus_gen stim1 (
		.CLK,
		.* ,
		.BITVAL,
		.Enable,
		.RST);

	ref_sd_crc_7 good1 (
		.BITVAL,
		.Enable,
		.CLK,
		.RST,
		.CRC(CRC_ref) );
		
	sd_crc_7 top_module1 (
		.BITVAL,
		.Enable,
		.CLK,
		.RST,
		.CRC(CRC_dut) );


	bit strobe = 0;
	task wait_for_end_of_timestep;
		repeat(5) begin
			strobe <= !strobe;  // Try to delay until the very end of the time step.
			@(strobe);
		end
	endtask	



	final begin
		if (stats1.errors_CRC) $display("Hint: Output '%s' has %0d mismatches. First mismatch occurred at time %0d.", "CRC", stats1.errors_CRC, stats1.errortime_CRC);
		else $display("Hint: Output '%s' has no mismatches.", "CRC");

		$display("Hint: Total mismatched samples is %1d out of %1d samples\n", stats1.errors, stats1.clocks);
		$display("Simulation finished at %0d ps", $time);
		$display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
	end
	
	assign tb_match = ( { CRC_ref } === ( { CRC_ref } ^ { CRC_dut } ^ { CRC_ref } ) );
	always @(posedge CLK, negedge CLK) begin

		stats1.clocks++;
		if (!tb_match) begin
			if (stats1.errors == 0) stats1.errortime = $time;
			stats1.errors++;
		end
		if (CRC_ref !== ( CRC_ref ^ CRC_dut ^ CRC_ref ))
		begin if (stats1.errors_CRC == 0) stats1.errortime_CRC = $time;
			stats1.errors_CRC = stats1.errors_CRC+1'b1; end

	end

   initial begin
     #1000000
     $display("TIMEOUT");
     $finish();
   end

endmodule

