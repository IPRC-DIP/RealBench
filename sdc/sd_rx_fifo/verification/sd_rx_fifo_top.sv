`include "sd_defines.v"

module sd_rx_fifo (
   input [4-1:0] d,
   input wr,
   input wclk,
   output [32-1:0] q,
   input rd,
   output full,
   output empty,
   output [1:0] mem_empt,
   input rclk,
   input rst
);

   reg [32-1:0] ram [0:`FIFO_RX_MEM_DEPTH-1]; //synthesis syn_ramstyle = "no_rw_check"
   reg [`FIFO_RX_MEM_ADR_SIZE-1:0] adr_i, adr_o;
   wire ram_we;
   wire [32-1:0] ram_din;
   reg [8-1:0] we;
   reg [4*(8)-1:0] tmp;
   reg ft;

   // 基础功能验证点
   cover property (@(posedge wclk) wr && !full);  // 验证写操作在非满状态下能执行
   cover property (@(posedge rclk) rd && !empty); // 验证读操作在非空状态下能执行
   
   // FIFO状态转换验证
   cover property (@(posedge wclk) !full && (adr_i + 1'b1 == adr_o)); // 即将满的状态
   cover property (@(posedge rclk) !empty && (adr_i == adr_o + 1'b1)); // 即将空的状态
   
   // 写使能移位验证
   cover property (@(posedge wclk) wr && we == 8'h01); // 验证写使能最后一位
   cover property (@(posedge wclk) wr && we == 8'h80); // 验证写使能第一位
   
   // 数据写入完整性验证
   cover property (@(posedge wclk) ram_we && ft); // 验证完整的数据包写入
   
   // 地址回环验证
   cover property (@(posedge wclk) ram_we && adr_i == (`FIFO_RX_MEM_DEPTH-1)); // 写地址回环
   cover property (@(posedge rclk) rd && !empty && adr_o == (`FIFO_RX_MEM_DEPTH-1)); // 读地址回环

   // Original logic starts here
   always @ (posedge wclk or posedge rst)
     if (rst)
       we <= 8'h1;
     else
       if (wr)
         we <= {we[8-2:0],we[8-1]};

   always @ (posedge wclk or posedge rst)
     if (rst) begin
       tmp <= {4*(8-1){1'b0}};
       ft <= 0;
     end
     else begin
       `ifdef BIG_ENDIAN
         if (wr & we[7]) begin
           tmp[4*1-1:4*0] <= d;
           ft <= 1;
         end
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
           ft <= 1;
         end
       `endif
     end

   assign ram_we = wr & we[0] & ft;
   assign ram_din = tmp;

   always @ (posedge wclk)
     if (ram_we)
       ram[adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0]] <= ram_din;

   always @ (posedge wclk or posedge rst)
     if (rst)
       adr_i <= `FIFO_RX_MEM_ADR_SIZE'h0;
     else
       if (ram_we)
         if (adr_i == `FIFO_RX_MEM_DEPTH-1) begin
           adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0] <= 0;
           adr_i[`FIFO_RX_MEM_ADR_SIZE-1] <= ~adr_i[`FIFO_RX_MEM_ADR_SIZE-1];
         end
         else
           adr_i <= adr_i + `FIFO_RX_MEM_ADR_SIZE'h1;

   always @ (posedge rclk or posedge rst)
     if (rst)
       adr_o <= `FIFO_RX_MEM_ADR_SIZE'h0;
     else
       if (!empty & rd)
         if (adr_o == `FIFO_RX_MEM_DEPTH-1) begin
           adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0] <= 0;
           adr_o[`FIFO_RX_MEM_ADR_SIZE-1] <= ~adr_o[`FIFO_RX_MEM_ADR_SIZE-1];
         end
         else
           adr_o <= adr_o + `FIFO_RX_MEM_ADR_SIZE'h1;

   assign full = (adr_i[`FIFO_RX_MEM_ADR_SIZE-2:0] == adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0]) & 
                 (adr_i[`FIFO_RX_MEM_ADR_SIZE-1] ^ adr_o[`FIFO_RX_MEM_ADR_SIZE-1]);
   assign empty = (adr_i == adr_o);
   assign mem_empt = (adr_i - adr_o);
   assign q = ram[adr_o[`FIFO_RX_MEM_ADR_SIZE-2:0]];

endmodule
