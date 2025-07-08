module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    // 输出待测模块的输入
	output logic alu_wbck_i_valid,
	output logic [32-1:0] alu_wbck_i_wdat,
	output logic [5-1:0] alu_wbck_i_rdidx,
	output logic longp_wbck_i_valid,
	output logic [32-1:0] longp_wbck_i_wdat,
	output logic [5-1:0] longp_wbck_i_flags,
	output logic [5-1:0] longp_wbck_i_rdidx,
	output logic longp_wbck_i_rdfpu,
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
        @(posedge clk) rst_n <= 0;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst_n <= 1; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst_n <= 0;
        end
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        int seed = 12345;
        {
            rst_n,
            alu_wbck_i_valid,
            alu_wbck_i_wdat,
            alu_wbck_i_rdidx,
            longp_wbck_i_valid,
            longp_wbck_i_wdat,
            longp_wbck_i_flags,
            longp_wbck_i_rdidx,
            longp_wbck_i_rdfpu,
            wavedrom_enable
        } <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 测试任务1-只进行alu写回
        wavedrom_start("Task1");
        repeat(2000) begin
            @(posedge clk);
            alu_wbck_i_valid = $random(seed) & 1'b1;
            alu_wbck_i_wdat = $random(seed);
            alu_wbck_i_rdidx = $random(seed) & 5'h1F;
            end
        @(posedge clk);
        alu_wbck_i_valid = 1'b0;
        wavedrom_stop();

        // 测试任务2-只进行长流水线写回
        wavedrom_start("Task2");
        repeat(2000) begin
            @(posedge clk);
            longp_wbck_i_valid = $random(seed) & 1'b1;
            longp_wbck_i_wdat = $random(seed);
            longp_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_flags = $random(seed) & 5'h1F;
            longp_wbck_i_rdfpu = $random(seed) & 1'h1;
        end
        @(posedge clk);
        longp_wbck_i_valid = 1'b0;
        wavedrom_stop();

        // 测试任务3-alu与长流水线同时写回
        wavedrom_start("Task3");
        alu_wbck_i_valid = 1'b1;
        longp_wbck_i_valid = 1'b1;
        repeat(2000) begin
            @(posedge clk);
            alu_wbck_i_wdat = $random(seed);
            alu_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_wdat = $random(seed);
            longp_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_flags = $random(seed) & 5'h1F;
            longp_wbck_i_rdfpu = $random(seed) & 1'h1;
        end
        @(posedge clk);
        alu_wbck_i_valid = 1'b0;
        longp_wbck_i_valid = 1'b0;
        wavedrom_stop();

        // 随机测试
        wavedrom_start("Random Test");
        repeat(5000) begin
            @(posedge clk);
            alu_wbck_i_valid = $random(seed) & 1'h1;
            alu_wbck_i_wdat = $random(seed);
            alu_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_valid = $random(seed) & 1'h1;
            longp_wbck_i_wdat = $random(seed);
            longp_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_flags = $random(seed) & 5'h1F;
            longp_wbck_i_rdfpu = $random(seed) & 1'h1;
        end
        wavedrom_stop();

        // 复位随机测试
        wavedrom_start("Random Test");
        repeat(5000) begin
            @(posedge clk);
            rst_n = $random(seed) & 1'h1;
            alu_wbck_i_valid = $random(seed) & 1'h1;
            alu_wbck_i_wdat = $random(seed);
            alu_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_valid = $random(seed) & 1'h1;
            longp_wbck_i_wdat = $random(seed);
            longp_wbck_i_rdidx = $random(seed) & 5'h1F;
            longp_wbck_i_flags = $random(seed) & 5'h1F;
            longp_wbck_i_rdfpu = $random(seed) & 1'h1;
        end
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule