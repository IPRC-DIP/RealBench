module stimulus_gen (
    input clk,
    output logic kld  // key load signal
);
    initial begin
        kld = 1'b0;
        @(negedge clk);

        // 测试1：完整的单轮运行（确保所有case都被触发）
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(200) @(posedge clk);  // 让计数器运行完整个序列0-9

        // 测试2：中断序列并重新开始
        repeat(10) begin
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            repeat(5) @(posedge clk);  // 运行一半后重置
        end

        // 测试3：完整序列重复
        repeat(10) begin
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            repeat(10) @(posedge clk);  // 完整运行0-9
        end

        // 测试4：快速重置
        repeat(5) begin
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            @(posedge clk);  // 只运行一个周期就重置
        end

        // 最后一次完整运行
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(15) @(posedge clk);  // 确保运行超过完整序列长度

        $finish;
    end
endmodule