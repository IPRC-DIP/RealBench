module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    // 输出待测模块的输入
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title <= title;
        wavedrom_enable <= 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable <= 0;
    endtask

    task reset_test(input async=0);
        bit arfail, srfail, datafail;
   
        @(posedge clk);
        @(posedge clk) rst <= 0;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst <= 1; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst <= 0;
        end
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 测试任务1
        wavedrom_start("Task1");
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 测试任务2
        wavedrom_start("Task2");
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 随机测试
        for(int i = 0; i < 100; i++)begin
            wavedrom_start("Random Test");
            repeat(2) @(posedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule