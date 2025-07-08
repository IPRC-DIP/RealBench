`include "sd_defines.v"
module stimulus_gen (
    input wire clk,
    // WISHBONE common
    output   logic        wb_clk_i,     // WISHBONE clock
    output   logic        wb_rst_i,     // WISHBONE reset
    output   logic   [31:0]  wb_dat_i,     // WISHBONE data input
    // WISHBONE error output
    output   logic       card_detect,
    // WISHBONE slave
    output   logic   [7:0]  wb_adr_i,     // WISHBONE address input
    output   logic   [3:0]  wb_sel_i,     // WISHBONE byte select input
    output   logic       wb_we_i,      // WISHBONE write enable input
    output   logic       wb_cyc_i,     // WISHBONE cycle input
    output   logic       wb_stb_i,     // WISHBONE strobe input

    // WISHBONE master
    output   logic   [31:0]  m_wb_dat_i,
    output   logic        m_wb_ack_i,

    // SD port
    output  logic [3:0] sd_dat_dat_i,   // Data in from SD card
    output  logic sd_cmd_dat_i         // Command in from SD card
    `ifdef SDC_CLK_SEP
        ,output logic sd_clk_i_pad
    `endif
);

// register adress
`define argument 8'h00
`define command 8'h04
`define status 8'h08
`define resp1 8'h0c
`define controller 8'h1c
`define block 8'h20
`define power 8'h24
`define software 8'h28
`define timeout 8'h2c  
`define normal_isr 8'h30   
`define error_isr 8'h34  
`define normal_iser 8'h38
`define error_iser 8'h3c
`define capa 8'h48
`define clock_d 8'h4c
`define bd_status 8'h50
`define bd_isr 8'h54 
`define bd_iser 8'h58 
`define bd_rx 8'h60  
`define bd_tx 8'h80  

// Clock period definition for the simulation
localparam CLK_PERIOD = 10; // 10 time units for the clock period

assign wb_clk_i = clk;

// Stimulus generation
initial begin

    // reset
    wb_rst_i = 1'b1;
    #(CLK_PERIOD*3);   
    wb_rst_i = 1'b0;
    #(CLK_PERIOD*3);          
    
    // select 
    wb_stb_i = 1'b1;
    wb_cyc_i = 1'b1;
    wb_sel_i = 4'b1000; // non-sense

    // wishbone slave
    repeat (20) @(negedge wb_clk_i) begin
        // change wb_adr_i
        wb_we_i = 1'b1;
        wb_dat_i = $random;
        wb_adr_i = `argument;
        #(CLK_PERIOD);
        wb_adr_i = `command;
        #(CLK_PERIOD);
        wb_adr_i = `software;
        #(CLK_PERIOD);
        wb_adr_i = `timeout;
        #(CLK_PERIOD);
        wb_adr_i = `normal_iser;
        #(CLK_PERIOD);
        wb_adr_i = `error_iser;
        #(CLK_PERIOD);
        wb_adr_i = `normal_isr;
        #(CLK_PERIOD);
        wb_adr_i = `error_isr;
        #(CLK_PERIOD);
        wb_adr_i = `clock_d;
        #(CLK_PERIOD);
        wb_adr_i = `bd_isr;
        #(CLK_PERIOD);
        wb_adr_i = `bd_iser;
        #(CLK_PERIOD);

        // bd_rx,bd_tx
        wb_adr_i = `bd_rx;
        #(CLK_PERIOD*4);
        wb_adr_i = `bd_tx;
        #(CLK_PERIOD*4);
        
        // output
        wb_cyc_i = 1'b1;
        wb_adr_i = `status;
        #(CLK_PERIOD);
        wb_adr_i = `resp1;
        #(CLK_PERIOD);
        wb_adr_i = `controller;
        #(CLK_PERIOD);
        wb_adr_i = `block;
        #(CLK_PERIOD);
        wb_adr_i = `power;
        #(CLK_PERIOD);
        wb_adr_i = `capa;
        #(CLK_PERIOD);
        wb_adr_i = `bd_status;
        #(CLK_PERIOD);
    end

    // wishbone master
    repeat (20) @(negedge wb_clk_i) begin
        m_wb_dat_i = $random;
        m_wb_ack_i = 1'b1;
        #(CLK_PERIOD*10); 
        m_wb_ack_i = 1'b0;
        #(CLK_PERIOD*10); 
    end
    
    repeat (1000) @(negedge wb_clk_i) begin
        sd_dat_dat_i = $random;
        sd_cmd_dat_i = $random;
        #(CLK_PERIOD*10); 
    end

    // Finish the simulation
    $finish;
end

endmodule