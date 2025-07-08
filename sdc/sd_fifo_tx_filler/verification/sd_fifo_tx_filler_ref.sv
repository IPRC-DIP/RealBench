//用于管理数据的传输和填充fifo缓冲区。
//他通过wishbone总线读取数据，并将数据写入tx fifo
`include "sd_defines.v"

module ref_sd_fifo_tx_filler
( 
input clk,
input rst,
//WB Signals
output  [31:0]  m_wb_adr_o,//WB 地址输出，用于指定 Wishbone 总线上地址。

output  reg        m_wb_we_o,//WB 写使能信号，控制是否进行写操作
input   [31:0]  m_wb_dat_i,//

output    reg      m_wb_cyc_o,//WB 周期信号，表示开始一个新的总线周期
output   reg       m_wb_stb_o,//WB 选通信号，激活对总线的访问
input           m_wb_ack_i,//WB的ack信号，表示当前周期的写操作成功
output  reg	[2:0] m_wb_cti_o,//WB 周期类型，通常用于定义操作的特定类型
output	reg [1:0]	 m_wb_bte_o,//WB 总线类型扩展，用于定义总线突发传输模式

//Data Master Control signals
input en,//使能，高电平时启动fifo缓冲区填充
input [31:0] adr,//地址信号，指定要读取数据的地址


//Data Serial signals 
input sd_clk,//SD数据传输的时钟信号
output [31:0] dat_o, //输出数据
input rd,//读使能信号，用于控制从fifo读取数据
output empty,
output fe
//

);
reg reset_tx_fifo;//用于重置TX FIFO信号

reg [31:0] din;//要写入FIFO的数据
reg wr_tx;//写入FIFO的控制信号，高电平时向fifo写入数据
reg [8:0] we;//用于计数写入的数据字节
reg [8:0] offset;//偏移量
wire [5:0]mem_empt;//表示fifo的空状态


//fifo实例
sd_tx_fifo Tx_Fifo (
.d ( din ),
.wr  (  wr_tx ),
.wclk  (clk),
.q ( dat_o),
.rd (rd),
.full (fe),
.empty (empty),
.mem_empt (mem_empt),
.rclk (sd_clk),
.rst  (rst | reset_tx_fifo)
);

//地址计算，生成输出地址
assign  m_wb_adr_o = adr+offset;


reg first;//标记第一次操作，用于初始化

reg ackd;
reg delay;//用于管理和同步ack信号的状态

always @(posedge clk or posedge rst )begin
 if (rst) begin
	offset <=0;
	we <= 8'h1;
	m_wb_we_o <=0;
	m_wb_cyc_o <= 0;
	m_wb_stb_o <= 0;
	wr_tx<=0;
	ackd <=1;
	delay<=0;
	reset_tx_fifo<=1;

	first<=1;
	din<=0;
		m_wb_bte_o <= 2'b00;
		m_wb_cti_o <= 3'b000;

			
 end
 else if (en) begin //Start filling the TX buffer，启动填充操作
    reset_tx_fifo<=0;
    
	  if (m_wb_ack_i) begin//表示当前写操作成功	  
		  wr_tx <=1;
		  din <=m_wb_dat_i;	
		  					
		  m_wb_cyc_o <= 0;
		  m_wb_stb_o <= 0; 
		  delay<=~ delay;   
		end 
		else begin
			wr_tx <=0;
			
		end
	 
	  if (delay)begin
	     offset<=offset+`MEM_OFFSET;	
	     ackd<=~ackd;
	     delay<=~ delay;
	     wr_tx <=0; 
	  end
	  
		if ( !m_wb_ack_i & !fe & ackd  ) begin //If not full And no Ack  
		  m_wb_we_o <=0;
			m_wb_cyc_o <= 1;
			m_wb_stb_o <= 1; 
			ackd<=0;   
		end 
		
 
 end 
 else begin
   offset <=0;
   reset_tx_fifo<=1;
   m_wb_cyc_o <= 0;
   m_wb_stb_o <= 0; 
   m_wb_we_o <=0; 
		
		
 end 
end 
  
endmodule


