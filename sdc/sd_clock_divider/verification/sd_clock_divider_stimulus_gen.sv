module stimulus_gen (
    input wire clk,
    output logic [7:0] DIVIDER,
    output logic RST
);

    // Clock period definition for the simulation
    localparam CLK_PERIOD = 10; // 10 time units for the clock period

    // Stimulus generation
    initial begin
        // Initial values
        DIVIDER = 8'd0;
        RST = 1'b1; // Start with reset asserted

        // Wait for a few clock cycles with reset asserted
        #(CLK_PERIOD * 3);

        // Deassert reset
        RST = 1'b0;

        // Wait for a few clock cycles before changing DIVIDER
        #(CLK_PERIOD * 5);

        // Test various divider values
        repeat (5) begin
            DIVIDER = $urandom_range(1, 255); // Random divider value
            #(CLK_PERIOD * 1000); // Wait for some cycles to see the effect
        end

        // Test reset functionality
        RST = 1'b1;
        #(CLK_PERIOD * 3);
        RST = 1'b0;

        // Randomly change divider and reset
        repeat (20) begin
            DIVIDER = $urandom_range(1, 255);
            RST = $urandom_range(0, 1);
            #(CLK_PERIOD * $urandom_range(1, 10));
        end

        // Finish the simulation
        $finish;
    end

endmodule
