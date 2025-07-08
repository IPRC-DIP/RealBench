`include "sd_defines.v"

module sd_fifo_rx_filler
( 
    input clk,
    input rst,
    //WB Signals
    output  [31:0]  m_wb_adr_o,
    output  reg     m_wb_we_o,
    output reg [31:0] m_wb_dat_o,
    output reg      m_wb_cyc_o,
    output reg      m_wb_stb_o,
    input           m_wb_ack_i,
    output reg [2:0] m_wb_cti_o,
    output reg [1:0] m_wb_bte_o,

    //Data Master Control signals
    input en,
    input [31:0] adr,

    //Data Serial signals 
    input sd_clk,
    input [`SD_BUS_W-1:0] dat_i,
    input wr,
    output full,
    output empty
);

    // 内部信号定义与原模块相同
    wire [31:0] dat_o;
    reg rd;
    reg reset_rx_fifo;
    reg [8:0] offset;
    reg wb_free;

    // 实例化原始FIFO
    sd_rx_fifo Rx_Fifo (
        .d(dat_i),
        .wr(wr),
        .wclk(sd_clk),
        .q(dat_o),
        .rd(rd),
        .full(full),
        .empty(empty),
        .mem_empt(),
        .rclk(clk),
        .rst(rst | reset_rx_fifo)
    );

    // 地址计算逻辑
    assign m_wb_adr_o = adr + offset;

    // 主要状态机逻辑保持不变
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            offset <= 0;
            m_wb_we_o <= 0;
            m_wb_cyc_o <= 0;
            m_wb_stb_o <= 0;
            wb_free <= 1;
            m_wb_dat_o <= 0;
            rd <= 0;
            reset_rx_fifo <= 1;
            m_wb_bte_o <= 2'b00;
            m_wb_cti_o <= 3'b000;
        end
        else if (en) begin
            rd <= 0;
            reset_rx_fifo <= 0;
            
            if (!empty & wb_free) begin
                rd <= 1;
                m_wb_dat_o <= #1 dat_o;
                m_wb_we_o <= #1 1;
                m_wb_cyc_o <= #1 1;
                m_wb_stb_o <= #1 1; 
                wb_free <= 0;   
            end

            if (!wb_free & m_wb_ack_i) begin
                m_wb_we_o <= 0;
                m_wb_cyc_o <= 0;
                m_wb_stb_o <= 0;
                offset <= offset + `MEM_OFFSET;
                wb_free <= 1;
            end 
        end
        else begin
            reset_rx_fifo <= 1;
            rd <= 0;
            offset <= 0;
            m_wb_cyc_o <= 0;
            m_wb_stb_o <= 0; 
            m_wb_we_o <= 0; 
            wb_free <= 1;
        end
    end

    // 添加覆盖点以验证关键功能
    
    // 1. 验证FIFO读操作的触发
    cover property (@(posedge clk) en && !empty && wb_free |=> rd);
    
    // 2. 验证FIFO读后数据被正确传输到wishbone总线
    cover property (@(posedge clk) rd |=> m_wb_dat_o == $past(dat_o));
    
    // 3. 验证地址偏移更新
    cover property (@(posedge clk) !wb_free && m_wb_ack_i |=> 
        offset == $past(offset) + `MEM_OFFSET);
    

    
    // 5. 验证使能切换后FIFO被正确重置
    cover property (@(posedge clk) $fell(en) |=> reset_rx_fifo);
    
    // 6. 验证复位后的状态
    cover property (@(posedge clk) rst |=> 
        (offset == 0 && wb_free && !m_wb_we_o && !m_wb_cyc_o && !m_wb_stb_o));
    
    // 7. 验证wishbone总线信号同步性
    cover property (@(posedge clk) 
        (m_wb_cyc_o && m_wb_stb_o && m_wb_we_o));
    

    
endmodule