module stimulus_gen (
    input clk,
    output reg rst,
    output reg en,
    output reg [31:0] adr,
    output reg sd_clk,
    output reg [31:0] m_wb_dat_i,
    output reg m_wb_ack_i,
    output reg rd,
    output reg [511:0] wavedrom_title,
    output reg wavedrom_enable,
    input tb_match
);

    // 保留必要的reset_test task
    task reset_test(async=0);
        bit arfail, srfail, datafail;
    
        @(posedge clk);
        @(posedge clk) rst = 0;
        repeat(3) @(posedge clk);
    
        @(negedge clk) begin datafail = !tb_match; rst = 1; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst = 0;
        end
    endtask

    // 简化wavedrom相关task
    task wavedrom_start(input[511:0] title = "");
        wavedrom_title = title;
        wavedrom_enable = 1;
    endtask
    task wavedrom_stop; 
        wavedrom_enable = 0;
    endtask

    // 针对性测试offset和地址生成
    task test_offset_sequence;
        repeat(16) begin
            @(posedge clk);
            en = 1;
            m_wb_ack_i = 1;
            // 使用不同的基础地址
            adr = (32'h1000 * $random) & 32'hFFFF_FFF0;
            m_wb_dat_i = $random;
            
            // 确保数据传输完成
            repeat(4) @(posedge clk);
            m_wb_ack_i = 0;
            
            // 让offset有时间更新
            repeat(2) @(posedge clk);
        end
    endtask

    // 时钟生成
    reg [2:0] sd_clk_div;
    always @(posedge clk) begin
        sd_clk_div = sd_clk_div + 1;
        if(sd_clk_div == 3'b111) begin
            sd_clk = ~sd_clk;
        end
    end

    // 主测试序列
    initial begin
        // 初始化
        {rst, en, adr, sd_clk, m_wb_dat_i, m_wb_ack_i, rd, sd_clk_div} = 0;
        wavedrom_enable = 0;

        // 基本复位测试
        repeat(5) @(posedge clk);
        wavedrom_start("Reset test");
        reset_test(1);
        wavedrom_stop();

        // 地址偏移测试序列
        repeat(4) begin
            // offset测试序列
            wavedrom_start("Offset test");
            test_offset_sequence();
            wavedrom_stop();
            
            // FIFO操作
            repeat(8) begin
                @(posedge clk);
                en = 1;
                m_wb_ack_i = 1;
                m_wb_dat_i = $random;
                adr = $random;
                rd = $random % 2;
            end
        end

        // 随机测试序列
        repeat(2000) @(posedge clk) begin
            // 基本信号随机化
            rst = ($random % 100 < 2);  // 降低复位概率
            en = ($random % 100 < 95);  // 提高使能概率
            m_wb_dat_i = $random;
            
            case ($random % 4)
                0: begin // 连续传输
                    repeat(4) begin
                        @(posedge clk);
                        m_wb_ack_i = 1;
                        adr = $random & 32'hFFFF_FFF0;
                    end
                    @(posedge clk) m_wb_ack_i = 0;
                end
                
                1: begin // 读写交替
                    repeat(4) begin
                        @(posedge clk);
                        m_wb_ack_i = 1;
                        rd = !rd;
                        adr = adr + 4;
                    end
                end
                
                2: begin // offset变化测试
                    repeat(8) begin
                        @(posedge clk);
                        m_wb_ack_i = !m_wb_ack_i;
                        adr = (adr + 4) & 32'hFFFF_FFF0;
                    end
                end
                
                3: begin // FIFO边界测试
                    repeat(4) begin
                        @(posedge clk);
                        m_wb_ack_i = 1;
                        rd = 0;
                        @(posedge clk);
                        m_wb_ack_i = 0;
                        rd = 1;
                    end
                end
            endcase
        end

        // 结束序列
        repeat(10) @(posedge clk) begin
            rst = 1;
            en = 0;
            {rd, m_wb_ack_i} = 0;
        end

        #500 $finish;
    end

endmodule