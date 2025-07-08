module stimulus_gen (
    input clk,
    output logic kld,                // key load signal
    output logic [127:0] key        // input key
);
    // 一些典型的测试密钥
    const logic [127:0] TEST_KEYS [4] = '{
        128'h000102030405060708090a0b0c0d0e0f,  // AES标准文档中的例子
        128'h2b7e151628aed2a6abf7158809cf4f3c,  // NIST测试向量
        128'hffffffffffffffffffffffffffffffff,    // 全1
        128'h00000000000000000000000000000000    // 全0
    };
    
    initial begin
        // 初始化
        kld = 1'bx;
        key = 'x;
        @(negedge clk);
        
        // 第一轮：基本功能测试，测试所有预定义的密钥
        for(int i=0; i<4; i++) begin
            // 加载新密钥
            key = TEST_KEYS[i];
            kld = 1'b1;
            @(posedge clk);
            
            // 生成扩展密钥
            kld = 1'b0;
            repeat(12) @(posedge clk);  // 等待足够的时间让密钥完全扩展
        end
        
        // 第二轮：中途重载测试
        key = TEST_KEYS[0];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(5) @(posedge clk);
        
        // 中途重新加载另一个密钥
        key = TEST_KEYS[1];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(12) @(posedge clk);
        
        // 第三轮：快速切换测试
        repeat(4) begin
            key = TEST_KEYS[2];
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            @(posedge clk);
            
            key = TEST_KEYS[3];
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            @(posedge clk);
        end
        
        // 完成测试
        @(posedge clk);
        $finish;
    end
endmodule