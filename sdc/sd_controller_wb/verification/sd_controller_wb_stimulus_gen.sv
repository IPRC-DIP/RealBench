module stimulus_gen (
    input wire clk,
    // WISHBONE common
    output logic           wb_clk_i,     // WISHBONE clock
    output logic           wb_rst_i,     // WISHBONE reset
    output logic   [31:0]  wb_dat_i,     // WISHBONE data input

    // WISHBONE slave
    output logic   [7:0]  wb_adr_i,     // WISHBONE address input
    output logic    [3:0]  wb_sel_i,     // WISHBONE byte select input
    output logic           wb_we_i,      // WISHBONE write enable input
    output logic           wb_cyc_i,     // WISHBONE cycle input
    output logic           wb_stb_i,     // WISHBONE strobe input

    //Read enable Master side Rx_bd
    output logic write_req_s,
    output logic [15:0] cmd_set_s,
    output logic [31:0] cmd_arg_s,

    //Buss accessible registers    
    output logic [15:0] status_reg,
    output logic [31:0] cmd_resp_1,
    output logic [15:0]normal_int_status_reg, 
    output logic [15:0]error_int_status_reg,
    output logic [15:0] Bd_Status_reg,   
    output logic [7:0] Bd_isr_reg
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

logic [7:0] all_registers[] = {
    `argument, `command, `status, `resp1, `controller, `block,
    `power, `software, `timeout, `normal_isr, `error_isr, 
    `normal_iser, `error_iser, `capa, `clock_d, `bd_status, 
    `bd_isr, `bd_iser, `bd_rx, `bd_tx
};

// Clock period definition for the simulation
localparam CLK_PERIOD = 10; // 10 time units for the clock period

assign wb_clk_i = clk;

task test_reset();
    @(posedge clk);
    wb_rst_i = 1'b1;
    #(CLK_PERIOD/2);

    repeat(3) @(posedge clk);

    wb_rst_i = 1'b0;
    repeat(3) @(posedge clk);

    @(posedge clk);
    wb_rst_i = 1'b1;
    @(posedge clk);
    wb_rst_i = 1'b0;
    @(posedge clk);
endtask

task test_sequential_register_access();
    wb_stb_i = 1'b1;
    wb_cyc_i = 1'b1;
    
    wb_we_i = 1'b1;
    
    foreach(all_registers[i]) begin
        wb_sel_i = $urandom;
        wb_dat_i = $urandom;
        wb_adr_i = all_registers[i];
        #(CLK_PERIOD);
    end
    
    wb_we_i = 1'b0;
    
    foreach(all_registers[i]) begin
        wb_sel_i = $urandom;
        wb_adr_i = all_registers[i];
        #(CLK_PERIOD);
    end
    
    wb_stb_i = 1'b0;
    wb_cyc_i = 1'b0;
    #(CLK_PERIOD);
endtask

task test_sd_controller_operations();
    write_req_s = 1'b0;
    cmd_set_s = 16'h0000;
    cmd_arg_s = 32'h00000000;
    
    repeat(10) begin
        cmd_set_s = $urandom;
        cmd_arg_s = $urandom;
        
        wb_stb_i = 1'b1;
        wb_cyc_i = 1'b1;
        wb_we_i = 1'b1;
        wb_sel_i = 4'b1111;
        
        wb_adr_i = `argument;
        wb_dat_i = cmd_arg_s;
        #(CLK_PERIOD);
        
        wb_adr_i = `command;
        wb_dat_i = {16'h0000, cmd_set_s};
        #(CLK_PERIOD);
        
        wb_stb_i = 1'b0;
        wb_cyc_i = 1'b0;
        #(CLK_PERIOD * 5);
        
        write_req_s = 1'b1;
        #(CLK_PERIOD * 2);
        write_req_s = 1'b0;
        
        status_reg = $urandom;
        normal_int_status_reg = $urandom;
        error_int_status_reg = $urandom;
        cmd_resp_1 = $urandom;
        #(CLK_PERIOD * 3);
        
        wb_stb_i = 1'b1;
        wb_cyc_i = 1'b1;
        wb_we_i = 1'b0;
        
        wb_adr_i = `status;
        #(CLK_PERIOD);
        
        wb_adr_i = `resp1;
        #(CLK_PERIOD);
        
        wb_adr_i = `normal_isr;
        #(CLK_PERIOD);
        
        wb_adr_i = `error_isr;
        #(CLK_PERIOD);
        
        wb_stb_i = 1'b0;
        wb_cyc_i = 1'b0;
        #(CLK_PERIOD * 2);
    end
endtask

task test_boundary_conditions();
    wb_stb_i = 1'b1;
    wb_cyc_i = 1'b1;
    wb_we_i = 1'b1;
    wb_dat_i = $urandom;
    wb_adr_i = `argument;
    #(CLK_PERIOD/2);

    wb_cyc_i = 1'b0;
    #(CLK_PERIOD/2);
    wb_stb_i = 1'b0;
    #(CLK_PERIOD);

    wb_stb_i = 1'b1;
    wb_cyc_i = 1'b1;
    wb_adr_i = 8'hFF;
    #(CLK_PERIOD * 2);
    
    wb_adr_i = `argument;
    repeat(16) begin
        wb_sel_i = $urandom;
        wb_dat_i = $urandom;
        #(CLK_PERIOD);
    end
    
    wb_stb_i = 1'b0;
    wb_cyc_i = 1'b0;
    #(CLK_PERIOD);
endtask

task test_random_stimulus(int iterations);
    repeat(iterations) begin
        wb_rst_i = ($urandom % 20 == 0);
        wb_stb_i = $random;
        wb_cyc_i = $random;
        wb_we_i = $random;
        wb_sel_i = $urandom;
        wb_dat_i = $urandom;
        wb_adr_i = all_registers[$urandom % $size(all_registers)];
        
        write_req_s = $random;
        cmd_set_s = $urandom;
        cmd_arg_s = $urandom;

        if ($urandom % 10 == 0) begin
            status_reg = $urandom;
            cmd_resp_1 = $urandom;
            normal_int_status_reg = $urandom;
            error_int_status_reg = $urandom;
            Bd_Status_reg = $urandom;
            Bd_isr_reg = $urandom;
        end
        
        #(CLK_PERIOD);
    end
endtask

// Stimulus generation
initial begin
    wb_rst_i = 1'b0;
    wb_stb_i = 1'b0;
    wb_cyc_i = 1'b0;
    wb_we_i = 1'b0;
    wb_sel_i = 4'b0000;
    wb_dat_i = 32'h00000000;
    wb_adr_i = 8'h00;
    write_req_s = 1'b0;
    cmd_set_s = 16'h0000;
    cmd_arg_s = 32'h00000000;
    status_reg = 16'h0000;
    cmd_resp_1 = 32'h00000000;
    normal_int_status_reg = 16'h0000;
    error_int_status_reg = 16'h0000;
    Bd_Status_reg = 16'h0000;
    Bd_isr_reg = 8'h00;

    // reset
    wb_rst_i = 1'b1;
    #(CLK_PERIOD *3);
    wb_rst_i = 1'b0;
    #(CLK_PERIOD * 3);

    // select this slave
    wb_stb_i = 1'b1;
    wb_cyc_i = 1'b1;
    wb_sel_i = 4'b1111; 

    wb_we_i = 1'b1;
    wb_dat_i = $urandom;
    wb_adr_i = `argument;
    #(CLK_PERIOD);
    wb_adr_i = `command;
    #(CLK_PERIOD);
    wb_adr_i = `software;
    #(CLK_PERIOD);
    
    #(CLK_PERIOD * 5);
    
    test_reset();
    #(CLK_PERIOD * 5);
    
    test_sequential_register_access();
    #(CLK_PERIOD * 5);
    
    test_sd_controller_operations();
    #(CLK_PERIOD * 5);
    
    test_boundary_conditions();
    #(CLK_PERIOD * 5);

    test_random_stimulus(5000);

    #(CLK_PERIOD * 10);
    $finish;
end

endmodule