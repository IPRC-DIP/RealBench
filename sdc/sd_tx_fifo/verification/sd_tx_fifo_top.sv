
`include "sd_defines.v"
module sd_tx_fifo
  (
   input [32-1:0] d,//写入数据，宽度32位
   input wr,//输入写使能
   input wclk,//写时钟信号
   output [32-1:0] q,//读取输出的数据，宽度32位
   input rd,//读使能信号
   output full,//FIFO满信号
   output empty,//FIFO空信号
   output [5:0] mem_empt,//当前FIFO中的空余空间，6位
   input rclk,//读时钟信号
   input rst
   );
   
   reg [32-1:0] ram [0:`FIFO_TX_MEM_DEPTH-1]; //synthesis syn_ramstyle = "no_rw_check"
   //存储数据的RAM，大小由FIFO_TX_MEM_DEPTH定义
   reg [`FIFO_TX_MEM_ADR_SIZE-1:0] adr_i, adr_o;//分别用于写地址和读地址的寄存器
   wire ram_we;//最终的写使能信号，用于控制是否写入数据
   wire [32-1:0] ram_din;//进入RAM的数据
    

    //写操作   
   assign ram_we = wr & ~full;
   assign ram_din = d;
   
   always @ (posedge wclk)
     if (ram_we)
       ram[adr_i[`FIFO_TX_MEM_ADR_SIZE-2:0]] <= ram_din;
   

   //写地址管理
   always @ (posedge wclk or posedge rst)
     if (rst)
       adr_i <= `FIFO_TX_MEM_ADR_SIZE'h0;
     else
       if (ram_we)//如果可以写入，并且当前地址到达 FIFO_TX_MEM_DEPTH-1，则重置地址并翻转高位；否则，地址加 1
      	 if (adr_i == `FIFO_TX_MEM_DEPTH-1) begin
	        adr_i[`FIFO_TX_MEM_ADR_SIZE-2:0] <=0;	   
	        adr_i[`FIFO_TX_MEM_ADR_SIZE-1]<=~adr_i[`FIFO_TX_MEM_ADR_SIZE-1];
	    end  
	     else
	      adr_i <= adr_i + `FIFO_TX_MEM_ADR_SIZE'h1;
	   
	  //读操作
   always @ (posedge rclk or posedge rst)
     if (rst)
       adr_o <= `FIFO_TX_MEM_ADR_SIZE'h0;
     else
       if (!empty & rd) begin//FIFO不空切读使能信号有效，进行读地址更新
	
	 if (adr_o == `FIFO_TX_MEM_DEPTH-1) begin
	    adr_o[`FIFO_TX_MEM_ADR_SIZE-2:0] <=0;
	    adr_o[`FIFO_TX_MEM_ADR_SIZE-1] <=~adr_o[`FIFO_TX_MEM_ADR_SIZE-1];
	 end  
	 else
	   adr_o <= adr_o + `FIFO_TX_MEM_ADR_SIZE'h1;
	 end
//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------
	   
	 //状态信号和输出  
   assign full=  ( adr_i[`FIFO_TX_MEM_ADR_SIZE-2:0] == adr_o[`FIFO_TX_MEM_ADR_SIZE-2:0] ) &  (adr_i[`FIFO_TX_MEM_ADR_SIZE-1] ^ adr_o[`FIFO_TX_MEM_ADR_SIZE-1]) ;
   //当写地址和读地址相同且高位不同（表示循环回绕）时，FIFO 被视为满。
   assign empty = (adr_i == adr_o) ;
   //当写地址和读地址相同时，FIFO 被视为空
   assign mem_empt = ( adr_i-adr_o);
   //计算当前 FIFO 中的空余空间。
   assign q = ram[adr_o[`FIFO_TX_MEM_ADR_SIZE-2:0]];
   //根据读地址从 RAM 中读取数据。

// 验证写操作确实改变了写地址
   cover property (@(posedge wclk) ram_we |-> $past(adr_i) != adr_i);
   
   // 验证读操作确实改变了读地址
   cover property (@(posedge rclk) rd && !empty |-> $past(adr_o) != adr_o);
   
   // 验证FIFO能从非空变为空
   cover property (@(posedge rclk) !$past(empty) && empty);
   
   // 验证FIFO能从非满变为满
   cover property (@(posedge wclk) !$past(full) && full);
   
   // 验证数据能被正确写入后读出
   cover property (@(posedge wclk) ram_we && !full && (adr_i == 0));
   
   // 验证写指针能正确回环
   cover property (@(posedge wclk) 
     (adr_i == (`FIFO_TX_MEM_DEPTH-1)) && ram_we |=>(adr_i[`FIFO_TX_MEM_ADR_SIZE-2:0] == 0));
   
   // 验证读指针能正确回环
   cover property (@(posedge rclk) 
     (adr_o == (`FIFO_TX_MEM_DEPTH-1)) && rd && !empty |=>(adr_o[`FIFO_TX_MEM_ADR_SIZE-2:0] == 0));


endmodule


