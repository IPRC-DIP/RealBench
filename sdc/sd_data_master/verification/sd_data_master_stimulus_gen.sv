`include "sd_defines.v"

module stimulus_gen (
	input clk,
	output logic rst,
	output [`RAM_MEM_WIDTH-1:0] dat_in_tx,
	output [`BD_WIDTH-1:0] free_tx_bd,
  	output logic ack_i_s_tx,
  	output [`RAM_MEM_WIDTH-1:0] dat_in_rx,
  	output [`BD_WIDTH-1:0] free_rx_bd,
  	output logic ack_i_s_rx,
  	output logic cmd_busy,
  	output logic we_ack,
  	output logic cmd_tsf_err,
  	output [4:0] card_status,
  	output logic tx_empt,
  	output logic tx_full,
  	output logic rx_full,
  	output logic busy_n     ,
  	output logic transm_complete ,
  	output logic crc_ok,
  	output logic Dat_Int_Status_rst,
  	output [1:0] transfer_type,
	output reg[511:0] wavedrom_title,
	output reg wavedrom_enable, 
	tb_match
);
	reg reset;
	assign rst = reset;


	task reset_test(input async = 0);
		bit arfail, srfail, datafail;
	
		@(posedge clk);
		@(posedge clk) reset = 0;
		repeat(3) @(posedge clk);
	
		@(negedge clk) begin datafail = !tb_match ; reset = 1; end
		@(posedge clk) arfail = !tb_match;
		@(posedge clk) begin
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
		repeat(3)@(posedge clk) reset = 1;
		repeat(3)@(posedge clk) reset = 0;
		dat_in_tx = $random;
		free_tx_bd = 0;
		ack_i_s_tx = 0;
		dat_in_rx = 0;
		free_rx_bd = 0;
		ack_i_s_rx = 0;   
		cmd_busy = 0;	 
		we_ack = 0;  
		cmd_tsf_err = 0;
		card_status = 0;  
		tx_empt = 0;
		tx_full = 0;
		rx_full = 0;  
		busy_n = 0;
		transm_complete = 0;
		crc_ok = 0;
		Dat_Int_Status_rst = 0;   
		transfer_type = 0;

		wavedrom_start("Asynchronous reset");
		reset_test(1);
		wavedrom_stop();

		//IDLE -> GET_RX_BD -> SEND_CMD -> RECIVE_CMD -> DATA_TRANSFER
		@(posedge clk) free_rx_bd = `BD_EMPTY - 1;

		repeat(10)@(posedge clk)	ack_i_s_rx = 1;

		repeat(10)@(posedge clk)	we_ack = 1;
		repeat(10)@(posedge clk) 	card_status = 5'b01001;
		repeat(10)@(posedge clk) 	rx_full = 1;
		repeat(10)@(posedge clk) 	crc_ok = 1; busy_n = 1;
		repeat(3)@(posedge clk) reset = 1;

		//IDLE -> GET_TX_BD -> SEND_CMD -> RECIVE_CMD -> SEND_CMD -> RECIVE_CMD ->SEND_CMD -> RECIVE_CMD
		// -> DATA_TRANSFER -> STOP -> STOP_SEND
		@(posedge clk) free_tx_bd = `BD_EMPTY - 1;
			ack_i_s_tx = 1;
		repeat(100) @(posedge clk);
		@(posedge clk) tx_full = 1;
		repeat(10) @(posedge clk);
		@(posedge clk) we_ack = 1; cmd_tsf_err = 1;
		@(posedge clk) we_ack = 0;
		@(posedge clk) cmd_tsf_err = 0;
		repeat(5) @(posedge clk);
		@(posedge clk) we_ack = 1;
 		@(posedge clk) we_ack = 0;
		repeat(10) @(posedge clk);
		@(posedge clk) we_ack = 1; transm_complete = 1;
		@(posedge clk) card_status = 5'b01001;
		@(posedge clk) tx_empt = 1; crc_ok = 0; busy_n = 1; we_ack = 0;
		repeat(10) @(posedge clk);
		@(posedge clk) cmd_busy = 0; 
		repeat(10) @(posedge clk) reset = 1;
		
		repeat(10000) @(posedge clk, negedge clk) begin
			dat_in_tx = $random;
			free_tx_bd =`BD_EMPTY-1;
			ack_i_s_tx = ($random%2);
			dat_in_rx = $random;
			free_rx_bd = $random;
			ack_i_s_rx = ($random%2);   
			cmd_busy = ($random%2);	 
			we_ack = ($random%2); 
			cmd_tsf_err = ($random%2);
			card_status = $random;
			tx_empt = ($random%2);
			tx_full = ($random%2);
			rx_full = ($random%2);  
			busy_n = ($random%2);
			transm_complete = ($random%2);
			crc_ok = ($random%2);
			Dat_Int_Status_rst = ($random%2);   
			transfer_type = $random;
			//reset = 1;
			reset = !($random & 31);
		end

		@(posedge clk);
		repeat(50000) @(posedge clk, negedge clk) begin
			dat_in_tx = $random;
			//free_tx_bd = $random;
			free_tx_bd =`BD_EMPTY;
			ack_i_s_tx = ($random%2);
			dat_in_rx = $random;
			//free_rx_bd = $random;
			free_rx_bd =`BD_EMPTY - 1;
			ack_i_s_rx = ($random%2);   
			cmd_busy = ($random%2);	 
			we_ack = ($random%2); 
			cmd_tsf_err = ($random%2);
			card_status = $random;
			tx_empt = ($random%2);
			tx_full = ($random%2);
			rx_full = ($random%2);  
			busy_n = ($random%2);
			transm_complete = ($random%2);
			crc_ok = ($random%2);
			Dat_Int_Status_rst = ($random%2);   
			transfer_type = $random;
			//reset = 1;
			reset = !($random & 31);
		end

		@(posedge clk);
		repeat(30000) @(posedge clk, negedge clk) begin
			dat_in_tx = $random;
			free_tx_bd = $random;
			ack_i_s_tx = ($random%2);
			dat_in_rx = $random;
			free_rx_bd = $random;
			ack_i_s_rx = ($random%2);   
			cmd_busy = ($random%2);	 
			we_ack = ($random%2); 
			cmd_tsf_err = ($random%2);
			card_status = $random;
			tx_empt = ($random%2);
			tx_full = ($random%2);
			rx_full = ($random%2);  
			busy_n = ($random%2);
			transm_complete = ($random%2);
			crc_ok = ($random%2);
			Dat_Int_Status_rst = ($random%2);   
			transfer_type = $random;
			//reset = 1;
			reset = !($random & 31);
		end

		$finish;
	end
	
endmodule