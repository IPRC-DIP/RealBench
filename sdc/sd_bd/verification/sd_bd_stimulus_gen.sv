module stimulus_gen (
    input clk,
    input tb_match,
    output reg rst,
    output reg we_m,
    output reg [`RAM_MEM_WIDTH-1:0] dat_in_m,
    output reg re_s,
    output reg a_cmp,
    output reg [511:0] wavedrom_title,
    output reg wavedrom_enable
);

    // 保持原有的任务
    task wavedrom_start(input[511:0] title = "");
        wavedrom_title = title;
        wavedrom_enable = 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable = 0;
    endtask

    // 保持原有的reset_test
    task reset_test(input async=0);
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
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        {rst, we_m, re_s, a_cmp, dat_in_m} = 0;
        wavedrom_enable = 0;

        // 1. 复位测试
        repeat(5) @(posedge clk);
        wavedrom_start("Reset test");
        reset_test(1);
        
        // 复位后立即读写操作
        @(posedge clk);
        re_s = 1;
        @(posedge clk);
        re_s = 0;
        @(posedge clk);
        we_m = 1;
        dat_in_m = $random;
        @(posedge clk);
        we_m = 0;
        wavedrom_stop();

        // 2. 交替读写测试
        wavedrom_start("Write-Read test");
        repeat(32) begin
            // 先写入
            repeat(2) begin
                we_m = 1;
                dat_in_m = $random;
                repeat(2) @(posedge clk);
                we_m = 0;
                @(posedge clk);
            end
            
            // 然后读出
            repeat(2) begin
                re_s = 1;
                repeat(2) @(posedge clk);
                re_s = 0;
                @(posedge clk);
            end

            // 发送完成信号
            if($random % 2) begin
                a_cmp = 1;
                @(posedge clk);
                a_cmp = 0;
                repeat(2) @(posedge clk);
            end
        end
        wavedrom_stop();

        // 3. 边界测试
        wavedrom_start("Edge test");
        repeat(20) begin
            // 连续写入
            repeat(8) begin
                we_m = 1;
                dat_in_m = $random;
                @(posedge clk);
                we_m = 0;
                @(posedge clk);
            end
            
            // 连续读出
            repeat(8) begin
                re_s = 1;
                @(posedge clk);
                re_s = 0;
                @(posedge clk);
            end
            
            // 多个完成信号
            repeat(4) begin
                a_cmp = 1;
                @(posedge clk);
                a_cmp = 0;
                @(posedge clk);
            end
            
            // 复位测试
            reset_test(1);
        end
        wavedrom_stop();

        // 4. 随机测试
        repeat(1000) @(posedge clk) begin
            // 随机生成操作组合
            if($random % 2) we_m = 1;
            else we_m = 0;
            
            if($random % 2) re_s = 1;
            else re_s = 0;
            
            if($random % 2) a_cmp = 1;
            else a_cmp = 0;
            
            dat_in_m = $random;
            
            // 每隔一段时间插入复位
            if($random % 50 == 0) begin
                reset_test(1);
            end
            
            // 随机延迟
            repeat($random % 3) @(posedge clk);
        end

        // 5. 快速切换测试
        wavedrom_start("Fast switch test");
        repeat(50) begin
            we_m = 1;
            re_s = 1;
            dat_in_m = $random;
            @(posedge clk);
            we_m = 0;
            re_s = 0;
            @(posedge clk);
            a_cmp = 1;
            @(posedge clk);
            a_cmp = 0;
            @(posedge clk);
        end
        wavedrom_stop();

        // 最终清理
        repeat(10) @(posedge clk);
        reset_test(1);

        #100 $finish;
    end

endmodule