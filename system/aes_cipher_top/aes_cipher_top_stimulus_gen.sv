module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst,
    output logic ld,
    output logic [127:0] key,
    output logic [127:0] text_in,
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);
    // 核心测试向量：包含所有必要的边界条件和关键模式
    const logic [127:0] TEST_KEYS [6] = '{
        128'h000102030405060708090a0b0c0d0e0f,  // 标准测试向量
        128'hffffffffffffffffffffffffffffffff,    // 全1
        128'h00000000000000000000000000000000,   // 全0
        128'haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,   // 交替1010
        128'h5555555555555555555555555555555,    // 交替0101
        128'h0123456789abcdef0123456789abcdef    // 递增
    };
    
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
        {rst, ld, key, text_in, wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 记录核心加密过程
        wavedrom_start("Complete AES Encryption Process");
        @(negedge clk);
        key <= TEST_KEYS[0];
        text_in <= TEST_KEYS[1];
        {rst, ld} <= 2'b11;
        @(posedge clk);
        ld <= 0;
        repeat(15) @(posedge clk);
        wavedrom_stop();

        // 主要测试向量和边界条件测试
        for(int i=0; i<6; i++) begin
            @(negedge clk);
            key <= TEST_KEYS[i];
            text_in <= TEST_KEYS[(i+1)%6];  // 错位使用测试向量，增加组合
            rst <= 1'b1;
            ld <= 1'b1;
            @(posedge clk);
            ld <= 1'b0;
            // 每两轮进行一次复位打断
            if(i[0]) begin
                repeat(5) @(posedge clk);
                rst <= 1'b0;
                @(posedge clk);
                rst <= 1'b1;
            end
            repeat(15) @(posedge clk);
        end

        // 随机测试和位翻转
        repeat(8) begin
            @(negedge clk);
            key <= $random;
            text_in <= {~key[126:0], key[127]};  // 创建互补模式
            rst <= 1'b1;
            ld <= 1'b1;
            @(posedge clk);
            ld <= 1'b0;
            repeat(15) @(posedge clk);
        end

        // 最终复位测试
        reset_test(0);
        repeat(5) @(posedge clk);
        $finish;
    end
endmodule