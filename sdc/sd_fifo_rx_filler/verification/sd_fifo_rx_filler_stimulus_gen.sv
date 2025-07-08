module stimulus_gen (
    input clk,
    output reg rst,
    output reg en,
    output reg [31:0] adr,
    output reg sd_clk,
    output reg [`SD_BUS_W-1:0] dat_i,
    output reg wr,
    output reg m_wb_ack_i,
    output reg [511:0] wavedrom_title,
    output reg wavedrom_enable,
    input tb_match
);
    
    initial sd_clk = 0;
    always #10 sd_clk = ~sd_clk;

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title = title;
        wavedrom_enable = 1;
    endtask

    task wavedrom_stop;
        #1 wavedrom_enable = 0;
    endtask

    task reset_test(input async = 0);
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
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", async ? "asynchronous" : "synchronous");
    endtask

    task test_main;
        integer i;
        begin
            en = 1;
            
            // 阶段1: 让offset累积，测试adr组合
            for(i=0; i<512; i=i+1) begin  // 覆盖所有9位offset值
                // 交替使用固定和随机地址
                adr = (i % 2) ? 32'hFFFF_FFF0 : $random;
                
                // 写入并传输以更新offset
                @(posedge sd_clk);
                wr = 1;
                dat_i = $random;
                @(posedge sd_clk);
                wr = 0;
                
                @(posedge clk);
                m_wb_ack_i = 1;
                @(posedge clk);
                m_wb_ack_i = 0;
                
                // 适度的使能切换
                if(i % 64 == 63) begin
                    en = 0;
                    @(posedge clk);
                    en = 1;
                end
                
                // 最小化的复位操作
                if(i % 256 == 255) begin
                    rst = 1;
                    @(posedge clk);
                    rst = 0;
                end
            end
            
            // 阶段2: 密集的数据传输
            repeat(128) begin
                @(posedge sd_clk);
                wr = 1;
                dat_i = $random;
                @(posedge sd_clk);
                wr = 0;
            end
        end
    endtask

    initial begin
        // 初始化
        rst = 0;
        en = 0;
        adr = 0;
        wr = 0;
        dat_i = 0;
        m_wb_ack_i = 0;

        // 1. 基础复位测试
        repeat(10) begin
            wavedrom_start("Reset Test");
            reset_test(1);
            wavedrom_stop();
            repeat(5) @(posedge clk);
        end

        // 2. 主要测试序列
        repeat(8) begin
            wavedrom_start("Main Test");
            test_main();
            wavedrom_stop();
            
            // 每轮之间的复位
            rst = 1;
            @(posedge clk);
            rst = 0;
            repeat(5) @(posedge clk);
        end

        // 3. 随机测试
        repeat(1000) @(posedge clk) begin
            // 地址和数据操作
            if($random % 2 == 0) begin
                adr = $random;
                @(posedge sd_clk);
                wr = 1;
                dat_i = $random;
                @(posedge sd_clk);
                wr = 0;
            end
            
            // 总线控制
            if($random % 3 == 0) begin
                m_wb_ack_i = 1;
                @(posedge clk);
                m_wb_ack_i = 0;
            end
            
            // 最小化控制信号切换
            if($random % 32 == 0) en = !en;
            if($random % 64 == 0) begin
                rst = 1;
                @(posedge clk);
                rst = 0;
            end
        end

        #100 $finish;
    end

endmodule