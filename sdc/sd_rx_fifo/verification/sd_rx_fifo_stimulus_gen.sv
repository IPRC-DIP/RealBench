module stimulus_gen (
    input wclk,
    input rclk,
    input tb_match,
    output reg [3:0] d,
    output reg wr,
    output reg rd,
    output reg rst,
    output reg [511:0] wavedrom_title,
    output reg wavedrom_enable
);

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title = title;
        wavedrom_enable = 1;
    endtask
    
    task wavedrom_stop;
        wavedrom_enable = 0;
    endtask

    task reset_test(async=0);
        bit arfail, srfail, datafail;
    
        @(posedge wclk);
        @(posedge wclk) rst = 0;
        repeat(3) @(posedge wclk);
    
        @(negedge wclk) begin datafail = !tb_match; rst = 1; end
        @(posedge wclk) arfail = !tb_match;
        @(posedge wclk) begin
            srfail = !tb_match;
            rst = 0;
        end
    endtask

    // 新增：测试FIFO写满和地址回环
    task test_fifo_full_and_wrap;
        // 先清空FIFO
        rst = 1;
        @(posedge wclk);
        rst = 0;
        
        // 连续写入直到FIFO满
        repeat(64) begin  // 写入超过FIFO深度的数据
            @(posedge wclk);
            wr = 1;
            d = $random;
            @(posedge wclk);
        end
        wr = 0;
        
        // 等待一段时间
        repeat(4) @(posedge wclk);
        
        // 读出一些数据后继续写入，测试地址回环
        fork
            begin
                repeat(32) @(posedge rclk) begin
                    rd = 1;
                end
                @(posedge rclk) rd = 0;
            end
            begin
                repeat(8) @(posedge wclk);
                repeat(32) @(posedge wclk) begin
                    wr = 1;
                    d = $random;
                end
                @(posedge wclk) wr = 0;
            end
        join
    endtask

    // 新增：测试读地址回环
    task test_read_wrap;
        // 先填充数据
        rst = 1;
        @(posedge wclk);
        rst = 0;
        
        repeat(32) @(posedge wclk) begin
            wr = 1;
            d = $random;
        end
        @(posedge wclk) wr = 0;
        
        // 连续读出超过FIFO深度的数据
        repeat(64) @(posedge rclk) begin
            rd = 1;
        end
        @(posedge rclk) rd = 0;
    endtask

    initial begin
        // 初始化
        {rst, wr, rd, d} = 0;
        wavedrom_enable = 0;

        // 基本复位测试
        repeat(5) @(posedge wclk);
        wavedrom_start("Reset test");
        reset_test(1);
        wavedrom_stop();

        // 测试FIFO满状态和地址回环
        wavedrom_start("FIFO full and wrap test");
        repeat(4) begin  // 多次测试以确保覆盖
            test_fifo_full_and_wrap();
            // 间隔等待
            repeat(10) @(posedge wclk);
        end
        wavedrom_stop();

        // 测试读地址回环
        wavedrom_start("Read wrap test");
        repeat(4) begin
            test_read_wrap();
            // 间隔等待
            repeat(10) @(posedge wclk);
        end
        wavedrom_stop();

        // 随机测试，重点测试边界条件
        wavedrom_start("Random corner cases");
        repeat(2000) @(posedge wclk) begin
            case ($random % 4)
                0: begin // 写满测试
                    repeat(16) @(posedge wclk) begin
                        wr = 1;
                        d = $random;
                    end
                    @(posedge wclk) wr = 0;
                end
                
                1: begin // 读空测试
                    @(posedge rclk);
                    repeat(16) @(posedge rclk) begin
                        rd = 1;
                    end
                    @(posedge rclk) rd = 0;
                end
                
                2: begin // 交替读写
                    fork
                        begin
                            repeat(8) @(posedge wclk) begin
                                wr = 1;
                                d = $random;
                                @(posedge wclk);
                                wr = 0;
                                @(posedge wclk);
                            end
                        end
                        begin
                            repeat(8) @(posedge rclk) begin
                                rd = 1;
                                @(posedge rclk);
                                rd = 0;
                                @(posedge rclk);
                            end
                        end
                    join
                end
                
                3: begin // 快速切换读写
                    repeat(8) begin
                        @(posedge wclk);
                        wr = 1;
                        d = $random;
                        @(posedge wclk);
                        wr = 0;
                        @(posedge rclk);
                        rd = 1;
                        @(posedge rclk);
                        rd = 0;
                    end
                end
            endcase

            // 随机插入复位
            if ($random % 50 == 0) begin
                rst = 1;
                @(posedge wclk);
                rst = 0;
            end
        end
        wavedrom_stop();

        // 结束序列
        repeat(10) @(posedge wclk) begin
            rst = 1;
            {wr, rd} = 0;
        end

        #500 $finish;
    end

endmodule