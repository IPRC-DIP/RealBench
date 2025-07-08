module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst,
    output logic kld,
    output logic ld,
    output logic [127:0] key,
    output logic [127:0] text_in,
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);
    // AES test vectors 
    const logic [127:0] TEST_KEYS [4] = '{
        128'h000102030405060708090a0b0c0d0e0f,
        128'h2b7e151628aed2a6abf7158809cf4f3c,
        128'hffffffffffffffffffffffffffffffff,
        128'h00000000000000000000000000000000
    };
    
    const logic [127:0] TEST_CIPHER [4] = '{
        128'h69c4e0d86a7b0430d8cdb78070b4c55a,
        128'h3925841d02dc09fbdc118597196a0b32,
        128'ha112ffc72f68417b9c924f17fc976336,
        128'hdaec3055df058e1c39e814ea76f6747e
    };

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title = title;
        wavedrom_enable = 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable = 0;
    endtask

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
        rst = 1'b1;
        kld = 1'b0;
        ld = 1'b0;
        key = 'x;
        text_in = 'x;
        wavedrom_enable = 0;
        
        // 复位测试
        reset_test();
        @(posedge clk);
        rst = 1'b1;
        repeat(2) @(posedge clk);

        // 测试1：基本密钥加载和解密流程
        // 先进行密钥加载
        @(negedge clk);
        key = TEST_KEYS[0];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        // 等待密钥扩展完成
        repeat(12) @(posedge clk);
        
        // 解密流程
        @(negedge clk);
        text_in = TEST_CIPHER[0];
        ld = 1'b1;
        @(posedge clk);
        ld = 1'b0;
        repeat(11) @(posedge clk); // 等待完整的解密过程

        // 测试2：密钥加载中断测试
        // 开始新的密钥加载但中途打断
        @(negedge clk);
        key = TEST_KEYS[1];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(5) @(posedge clk);
        // 在密钥扩展过程中重新加载
        @(negedge clk);
        key = TEST_KEYS[2];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(12) @(posedge clk);

        // 测试3：解密过程中断测试
        @(negedge clk);
        text_in = TEST_CIPHER[2];
        ld = 1'b1;
        @(posedge clk);
        ld = 1'b0;
        repeat(5) @(posedge clk);
        // 在解密过程中加载新数据
        @(negedge clk);
        text_in = TEST_CIPHER[3];
        ld = 1'b1;
        @(posedge clk);
        ld = 1'b0;
        repeat(11) @(posedge clk);

        // 测试4：快速切换测试
        repeat(4) begin
            // 快速切换密钥加载
            @(negedge clk);
            key = TEST_KEYS[3];
            kld = 1'b1;
            @(posedge clk);
            kld = 1'b0;
            @(posedge clk);
            // 紧接着进行数据加载
            @(negedge clk);
            text_in = TEST_CIPHER[3];
            ld = 1'b1;
            @(posedge clk);
            ld = 1'b0;
            repeat(2) @(posedge clk);
        end

        // 测试5：等待done信号测试
        @(negedge clk);
        key = TEST_KEYS[0];
        kld = 1'b1;
        @(posedge clk);
        kld = 1'b0;
        repeat(12) @(posedge clk);
        
        @(negedge clk);
        text_in = TEST_CIPHER[0];
        ld = 1'b1;
        @(posedge clk);
        ld = 1'b0;
        // 等待完整解密过程及done信号
        repeat(15) @(posedge clk);

        // 完成测试
        repeat(5) @(posedge clk);
        $finish;
    end
endmodule