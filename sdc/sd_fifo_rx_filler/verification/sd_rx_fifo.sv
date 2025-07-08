`include "sd_defines.v"

module sd_rx_fifo
  (
   input [4-1:0] d,//4位宽的数据输入端口
   input wr,//写使能信号
   input wclk,//写时钟信号
   output [32-1:0] q,//32位宽的数据输出端口
   input rd,//读使能信号
   output full,//表示FIFO是否满
   output empty,//表示FIFO是否空
   output [1:0] mem_empt,//表示内存的剩余空间
   input rclk,//读时钟信号
   input rst
   );
   reg [32-1:0] ram [0:`FIFO_RX_MEM_DEPTH-1]; //synthesis syn_ramstyle = "no_rw_check
   //一个二维数组，表示FIFO存储空间
   reg [`FIFO_RX_MEM_ADR_SIZE-1:0] adr_i, adr_o;//写地址和读地址寄存器
   wire ram_we;//写使能信号
   wire [32-1:0] ram_din;//写入ram的数据
   reg [8-1:0] we;//8位的写使能信号，用于指示哪些字节可以写入
   reg [4*(8)-1:0] tmp;//临时存储的寄存器，32位
   reg ft;//表示是否已写入数据的标志位

   //写使能逻辑
   always @ (posedge wclk or posedge rst)
     if (rst)
       we <= 8'h1;//表示第一个字节可以写入
     else
       if (wr)
	 we <= {we[8-2:0],we[8-1]};//进行移位，使得下一位字节可以写入

   //数据写入逻辑
   always @ (posedge wclk or posedge rst)
     if (rst) begin
       tmp <= {4*(8-1){1'b0}};
         ft<=0; 
   end    
     else//根据大端或小端格式，将输入数据写入tmp
       begin
	 `ifdef BIG_ENDIAN
	   
     //ft 只在 (wr & we[7]) == 1 时设为 1，是为了确保只有在完整数据写入完成时，
     //标志位才会被更新，以此保证数据的一致性和完整性。
     //其他情况下（如 (wr & we[6])）并未写入整个数据块，因此不应设置为 1
	  if (wr & we[7]) begin
	    tmp[4*1-1:4*0] <= d;	 
	    ft<=1; end 
	  if (wr & we[6])
	    tmp[4*2-1:4*1] <= d; 
	  if (wr & we[5])
	    tmp[4*3-1:4*2] <= d;	  
	  if (wr & we[4])
	    tmp[4*4-1:4*3] <= d;	  
	  if (wr & we[3])
	    tmp[4*5-1:4*4] <= d;	  
	  if (wr & we[2])
	    tmp[4*6-1:4*5] <= d;	  
	  if (wr & we[1]) 
	    tmp[4*7-1:4*6] <= d;	 
 	  if (wr & we[0]) 
	    tmp[4*8-1:4*7] <= d;	 
	 `endif 
	 `ifdef LITTLE_ENDIAN 
	  if (wr & we[0])
	   tmp[4*1-1:4*0] <= d;	 
	  if (wr & we[1])
	    tmp[4*2-1:4*1] <= d;   
	  if (wr & we[2])
	    tmp[4*3-1:4*2] <= d;   
	  if (wr & we[3])
	   tmp[4*4-1:4*3] <= d;	     
	  if (wr & we[4])
	   tmp[4*5-1:4*4] <= d; 
	  if (wr & we[5])
	   tmp[4*6-1:4*5] <= d;	 
	  if (wr & we[6]) 
	   tmp[4*7-1:4*6] <= d;	  	  
	  if (wr & we[7]) begin
	   tmp[4*8-1:4*7] <= d;
	       ft<=1; 
     end
      `endif 
  end

    //ram写入操作 
   assign ram_we = wr & we[0] &ft;//表示在写使能、最小字节使能和数据标志均为真时有效
   assign ram_din = tmp;
   always @ (posedge wclk)
     if (ram_we)
       ram[adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0]] <= ram_din;


  //写地址递增逻辑
   always @ (posedge wclk or posedge rst)
     if (rst)
       adr_i <= `FIFO_RX_MEM_ADR_SIZE'h0;
     else
       if (ram_we)
	 if (adr_i == `FIFO_RX_MEM_DEPTH-1) begin
	   adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0] <=0;	   
	   adr_i[`FIFO_RX_MEM_ADR_SIZE-1]<=~adr_i[`FIFO_RX_MEM_ADR_SIZE-1];
	 end  
	 else
	   adr_i <= adr_i + `FIFO_RX_MEM_ADR_SIZE'h1;
	   

  //读地址逻辑
   always @ (posedge rclk or posedge rst)
     if (rst)
       adr_o <= `FIFO_RX_MEM_ADR_SIZE'h0;
     else
       if (!empty & rd)
	
	 if (adr_o == `FIFO_RX_MEM_DEPTH-1) begin
	    adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0] <=0;
	    adr_o[`FIFO_RX_MEM_ADR_SIZE-1] <=~adr_o[`FIFO_RX_MEM_ADR_SIZE-1];
	 end  
	 else
	   adr_o <= adr_o + `FIFO_RX_MEM_ADR_SIZE'h1;
	 
//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------
	//FIFO状态信号   
  //如果低位相同且高位不同，说明fifo已满
   assign full =  (adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0] == adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0] ) & (adr_i[`FIFO_RX_MEM_ADR_SIZE-1] ^ adr_o[`FIFO_RX_MEM_ADR_SIZE-1]) ;
   assign empty = (adr_i == adr_o) ;
   
   assign mem_empt = ( adr_i-adr_o);
   assign q = ram[adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0]];
endmodule

