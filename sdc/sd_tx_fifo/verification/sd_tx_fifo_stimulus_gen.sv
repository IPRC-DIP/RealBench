module stimulus_gen (
    input wclk,
    input rclk,
    input tb_match,
    // DUT输入信号
    output reg [31:0] d,       // 32位数据输入
    output reg wr,
    output reg rd,
    output reg rst,
    // 波形显示信号
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

    task reset_test(input async=0);
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
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    // 新增：写指针回环测试
    task test_write_wrap;
        repeat(2) begin
            // 连续写直到回环
            repeat(`FIFO_TX_MEM_DEPTH + 2) begin
                @(posedge wclk);
                wr = 1;
                d = $random;
                @(posedge wclk);
                wr = 0;
                @(posedge wclk);
            end
            
            // 等待一些时钟周期
            repeat(10) @(posedge wclk);
        end
    endtask

    // 新增：读指针回环测试
    task test_read_wrap;
        // 先写入足够的数据
        repeat(`FIFO_TX_MEM_DEPTH) begin
            @(posedge wclk);
            wr = 1;
            d = $random;
            @(posedge wclk);
            wr = 0;
        end
        
        // 连续读直到回环
        repeat(`FIFO_TX_MEM_DEPTH + 2) begin
            @(posedge rclk);
            rd = 1;
            @(posedge rclk);
            rd = 0;
            @(posedge rclk);
        end
    endtask

    initial begin
        // 初始化
        rst = 1'b1;
        wr = 0;
        rd = 0;
        d = 32'h0;
        wavedrom_enable = 0;

        // 复位测试
        repeat(10) @(posedge wclk);
        wavedrom_start("Reset test");
        reset_test(1);
        wavedrom_stop();

        // 基本写读测试
        wavedrom_start("Basic write/read test");
        // 写入一些数据
        repeat(8) begin
            @(posedge wclk);
            wr = 1;
            d = $random;
            @(posedge wclk);
            wr = 0;
        end
        // 读出数据
        repeat(8) begin
            @(posedge rclk);
            rd = 1;
            @(posedge rclk);
            rd = 0;
        end
        wavedrom_stop();

        // 写指针回环测试
        wavedrom_start("Write pointer wrap test");
        test_write_wrap();
        wavedrom_stop();

        // 读指针回环测试
        wavedrom_start("Read pointer wrap test");
        test_read_wrap();
        wavedrom_stop();

        // 满状态测试
        wavedrom_start("Full state test");
        rst = 0;
        repeat(`FIFO_TX_MEM_DEPTH + 4) begin
            @(posedge wclk);
            wr = 1;
            d = $random;
        end
        wr = 0;
        wavedrom_stop();

        // 空状态测试
        wavedrom_start("Empty state test");
        repeat(`FIFO_TX_MEM_DEPTH + 4) begin
            @(posedge rclk);
            rd = 1;
        end
        rd = 0;
        wavedrom_stop();

        // 交替读写测试
        wavedrom_start("Alternate read/write test");
        repeat(50) begin
            fork
                begin
                    @(posedge wclk);
                    wr = 1;
                    d = $random;
                    @(posedge wclk);
                    wr = 0;
                end
                begin
                    @(posedge rclk);
                    rd = 1;
                    @(posedge rclk);
                    rd = 0;
                end
            join
        end
        wavedrom_stop();

        // 随机测试
        wavedrom_start("Random operations test");
        repeat(1000) begin
            case ($random % 4)
                0: begin // 连续写
                    repeat(4) begin
                        @(posedge wclk);
                        wr = 1;
                        d = $random;
                        @(posedge wclk);
                        wr = 0;
                    end
                end
                
                1: begin // 连续读
                    repeat(4) begin
                        @(posedge rclk);
                        rd = 1;
                        @(posedge rclk);
                        rd = 0;
                    end
                end
                
                2: begin // 交替读写
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
                
                3: begin // 复位
                    if ($random % 20 == 0) begin
                        rst = 1;
                        @(posedge wclk);
                        rst = 0;
                    end
                end
            endcase
        end
        wavedrom_stop();

        // 结束测试
        repeat(10) @(posedge wclk);
        rst = 1;
        {wr, rd} = 0;
        
        #500 $finish;
    end

endmodule