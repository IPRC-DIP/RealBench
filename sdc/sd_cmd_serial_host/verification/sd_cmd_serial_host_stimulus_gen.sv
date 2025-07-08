module stimulus_gen (
	input SD_CLK_IN,

	output logic RST_IN,
    output [15:0] SETTING_IN,
    output [39:0] CMD_IN,
    output logic REQ_IN,
    output logic ACK_IN,
    output logic cmd_dat_i,
    
	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable,
	input tb_match
);
	reg reset;
	assign RST_IN = reset;


	task reset_test(input async=0);
		bit arfail, srfail, datafail;
	
		@(posedge SD_CLK_IN);
		@(posedge SD_CLK_IN) reset = 0;
		repeat(3) @(posedge SD_CLK_IN);
	
		@(negedge SD_CLK_IN) begin datafail = !tb_match ; reset = 1; end
		@(posedge SD_CLK_IN) arfail = !tb_match;
		@(posedge SD_CLK_IN) begin
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
		repeat(3)@(posedge SD_CLK_IN) reset = 1;
		repeat(3)@(posedge SD_CLK_IN) reset = 0;

        wavedrom_start("Asynchronous reset");
		reset_test(1);
		wavedrom_stop();

		repeat(2)@(posedge SD_CLK_IN) reset = 0;
        REQ_IN =1;

        repeat(50)@(posedge SD_CLK_IN) 
        SETTING_IN [6:0] =1;//IDLE->WRITE_WR->WRITE_WR->DLY_WR
        repeat(10)@(posedge SD_CLK_IN) ACK_IN=1;
        @(posedge SD_CLK_IN) ACK_IN=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [11]=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [11]=1;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [12]=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [12]=1;
        repeat(10)@(posedge SD_CLK_IN) ACK_IN=1;
        repeat(10)@(posedge SD_CLK_IN) ACK_IN=0;

        repeat(10)@(posedge SD_CLK_IN) 
        cmd_dat_i = 1;//DLY_WR->DLY_WR
        
        repeat(5)@(posedge SD_CLK_IN) 
        cmd_dat_i = 0;//DLY_WR->READ_WR
        SETTING_IN [6:0] =127;

        repeat(2)@(posedge SD_CLK_IN) 
        ACK_IN = 1;
        
        repeat(2)@(posedge SD_CLK_IN) 
        ACK_IN = 0;
        SETTING_IN [6:0] =127;

        repeat(20)@(posedge SD_CLK_IN) 
        cmd_dat_i = 0;
        
        repeat(40)@(posedge SD_CLK_IN) 
        SETTING_IN [14:13] = 2'b00;

        repeat(33)@(posedge SD_CLK_IN) 
        SETTING_IN [14:13] = 2'b01;

        repeat(33)@(posedge SD_CLK_IN) 
        SETTING_IN [14:13] = 2'b10;

        repeat(33)@(posedge SD_CLK_IN) 
        SETTING_IN [14:13] = 2'b11;
        
        repeat(1)@(posedge SD_CLK_IN) SETTING_IN [12]=0;SETTING_IN [11]=1;
        repeat(1)@(posedge SD_CLK_IN) SETTING_IN [12]=1;SETTING_IN [11]=1;

        repeat(10)@(posedge SD_CLK_IN) 
        cmd_dat_i= $random % 2;
        SETTING_IN [7] =1;
        repeat(10)@(posedge SD_CLK_IN) 
        SETTING_IN [7] =0;

  

        repeat(20)@(posedge SD_CLK_IN) 
        ACK_IN = 1; //DLY_READ->ACK_WR;

        repeat(2)@(posedge SD_CLK_IN) reset = 0;
        REQ_IN =1;

        repeat(10)@(posedge SD_CLK_IN) 
        SETTING_IN [6:0] =0;//IDLE->WRITE_WO->WRITE_WO->DLY_WO
        ACK_IN=1;
        repeat(10)@(posedge SD_CLK_IN) 
        SETTING_IN [6:0] =0;
        ACK_IN=0;

        @(posedge SD_CLK_IN) ACK_IN=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [11]=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [11]=1;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [12]=0;
        repeat(10)@(posedge SD_CLK_IN) SETTING_IN [12]=1;
        repeat(10)@(posedge SD_CLK_IN) ACK_IN=1;
        repeat(10)@(posedge SD_CLK_IN) ACK_IN=0;

        repeat(100)@(posedge SD_CLK_IN) 
        SETTING_IN [10:8] = 1;//DLY_WO->ACK_WO->IDLE;

  



		@(posedge SD_CLK_IN) reset = 1;
        REQ_IN =1;


        @(posedge SD_CLK_IN) reset = 0;

		repeat(100000) @(posedge SD_CLK_IN, negedge SD_CLK_IN) begin
            SETTING_IN = $random;
            if ($random % 2) 
                SETTING_IN[6:0] = $random % 127 + 1;//WRITE_WR
            else 
                SETTING_IN[6:0] = 0;//WRITE_WO
            
            if ($random % 2) 
                SETTING_IN [10:8] = $random % 7 + 1;//DLY
            else 
                SETTING_IN [10:8] = 0;//DLY

            SETTING_IN [11] = $random % 2;//block_write
            SETTING_IN[12] = $random % 2;//block_read
            
            SETTING_IN [14:13] = ($random % 4);//DLY


            CMD_IN = {$random, $random[7:0]};
            REQ_IN = ($random %2);
            ACK_IN = ($random %2);
            cmd_dat_i = ($random %2);
			reset = !($random & 31);
		end
		
		#1 $finish;
	end
	
endmodule