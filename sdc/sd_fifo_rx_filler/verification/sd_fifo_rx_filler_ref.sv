`include "sd_defines.v"

module ref_sd_fifo_rx_filler
( 
input clk,
input rst,
//WB Signals
output  [31:0]  m_wb_adr_o,//wishbone接口的地址输出

output  reg        m_wb_we_o,//写使能信号

output reg [31:0]  m_wb_dat_o,//wishbone接口的地址输出
output    reg      m_wb_cyc_o,
output   reg       m_wb_stb_o,//wishbone接口控制信号
input           m_wb_ack_i,//表示从设备已经成功接收了主设备的请求
output  reg	[2:0] m_wb_cti_o,
output	reg [1:0]	 m_wb_bte_o,//传输类型和突发类信号

//Data Master Control signals
input en,//使能信号，用于控制FIFO的填充
input [31:0] adr,//地址信号，用于写入数据的地址

//Data Serial signals 
input sd_clk,//SD数据时钟信号
input [`SD_BUS_W-1:0] dat_i, //输入数据
input wr,//写使能信号
output full,//指示FIFO已满的状态
output empty//

);
 wire [31:0] dat_o;
reg rd;
reg reset_rx_fifo;
sd_rx_fifo Rx_Fifo (//用于接收输入数据
.d ( dat_i ),
.wr  (  wr ),
.wclk  (sd_clk),
.q ( dat_o),
.rd (rd),
.full (full),
.empty (empty),
.mem_empt (),
.rclk (clk),
.rst  (rst | reset_rx_fifo)
);

//reg [31:0] tmp_dat;
reg [8:0] offset;//用于地址偏移
assign  m_wb_adr_o = adr+offset;//地址输出：由基地址adr和偏移地址计算得出的地址
//assign  m_wb_dat_o = dat_o;

reg wb_free;
always @(posedge clk or posedge rst )begin

 if (rst) begin
  offset<=0;
  m_wb_we_o <=0;
	m_wb_cyc_o <= 0;
	m_wb_stb_o <= 0;
	wb_free<=1;
	m_wb_dat_o<=0;
	rd<=0;
	reset_rx_fifo<=1;
	m_wb_bte_o <= 2'b00;
		m_wb_cti_o <= 3'b000;

 end
 else if (en)  begin//Start filling the RX buffer，开始填充RX FIFO
    rd<=0;
    reset_rx_fifo<=0;
  if (!empty & wb_free) begin
    rd<=1;
    
    m_wb_dat_o<=#1 dat_o;
    m_wb_we_o <=#1 1;
		m_wb_cyc_o <=#1 1;
		m_wb_stb_o <=#1 1; 
    wb_free<=0;   
  end

 //当前没有空闲且接收到ack信号，表示写入完成
 //重置相关控制信号并更新offset 
  if(  !wb_free & m_wb_ack_i) begin
    m_wb_we_o <=0;
		m_wb_cyc_o <= 0;
		m_wb_stb_o <= 0;
		offset<=offset+`MEM_OFFSET;
		wb_free<=1;
	end	 
end
else begin//如果en为假，重置相关信号并清空FIFO
   reset_rx_fifo<=1;
    rd<=0;
   offset<=0;
    	m_wb_cyc_o <= 0;
			m_wb_stb_o <= 0; 
			m_wb_we_o <=0; 
			wb_free<=1;
  end

end  
endmodule


