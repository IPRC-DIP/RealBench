module stimulus_gen (
    input clk,
    input tb_match,
    // 输出待测模块的输入
	output logic [5-1:0] read_src1_idx,
	output logic [5-1:0] read_src2_idx,
	output logic wbck_dest_wen,
	output logic [5-1:0] wbck_dest_idx,
	output logic [32-1:0] wbck_dest_dat,
	output logic test_mode,
    output logic rst_n,
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
        bit arfail, srfail;

        // 复位信号拉高
        rst_n = 1;
        if (async == 1)begin
            // 异步复位测试
            @(negedge clk);
            rst_n = 0;
            #1;
            arfail = !tb_match;
            rst_n = 1;
            if (arfail)
                $display("Error: Asynchronous reset failed. Ensure your design resets immediately when rst_n is asserted.");
            else
                $display("Info: Asynchronous reset succeed.");
        end
        else begin
            // 同步复位测试
            @(negedge clk); rst_n = 0;
            @(negedge clk); srfail = !tb_match;
            @(negedge clk); rst_n = 1;
            if (srfail)
                $display("Error: Synchronous reset failed. Check if your design resets on the clock edge.");
            else 
                $display("Info: Synchronous reset succeed.");
        end
    endtask

    // test_plan
    // ---------------------------------reset----------------------------------
    // async reset ok
    // sync reset ok
    // ---------------------------------io-------------------------------------
    // read_src1_dat
    // read_src2_dat
    // x1_r
    task base_all_low();
        read_src1_idx = 0;
        read_src2_idx = 0;
        wbck_dest_wen = 0;
        wbck_dest_idx = 0;
        wbck_dest_dat = 0;
        test_mode = 0;
    endtask
    initial begin
        // 初始化
        // int seed = 12345;
        // $random(seed);
        {
            read_src1_idx,
            read_src2_idx,
            wbck_dest_wen,
            wbck_dest_idx,
            wbck_dest_dat,
            test_mode,
            rst_n, wavedrom_enable
        } <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(negedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(negedge clk);
        
        // 测试任务1-写入，读取
        wavedrom_start("Task1");
        @(negedge clk);
        base_all_low();
        wbck_dest_wen = 1'b1;
        wbck_dest_idx = 5'd0;
        wbck_dest_dat = {32{1'b1}};
        repeat(31) begin
            @(negedge clk);
            wbck_dest_idx = wbck_dest_idx + 5'd1;
        end

        @(negedge clk);
        base_all_low();
        read_src1_idx = 5'd0;
        read_src2_idx = 5'd31;
        repeat(31) begin
            @(negedge clk);
            read_src1_idx = read_src1_idx + 5'd1;
            read_src2_idx = read_src2_idx - 5'd1;
        end
        wavedrom_stop();

        // 测试任务3-写入同时读取
        wavedrom_start("Task2");
        @(negedge clk);
        base_all_low();
        read_src1_idx = 5'd0;
        read_src2_idx = 5'd31;
        wbck_dest_wen = 1'b1;
        wbck_dest_idx = 5'd0;
        wbck_dest_dat = wbck_dest_idx;
        repeat(31) begin
            @(negedge clk);
            wbck_dest_idx = wbck_dest_idx + 5'd1;
            wbck_dest_dat = wbck_dest_idx;
            read_src1_idx = read_src1_idx + 5'd1;
            read_src2_idx = read_src2_idx - 5'd1;
        end
        wavedrom_stop();

        // 随机测试
        wavedrom_start("Test3");
        repeat(100)begin
            @(negedge clk);
            base_all_low(); 
            read_src1_idx = $random & 5'h1F;
            read_src2_idx = $random & 5'h1F;
            wbck_dest_idx = $random & 5'h1F;
            wbck_dest_wen = $random & 1'b1;
            wbck_dest_dat = $random;
        end
        wavedrom_stop();
        
        // test_mode 随机测试
        wavedrom_start("Test4");
        repeat(500)begin
            @(negedge clk);
            base_all_low(); 
            test_mode = $random & 1'b1;
            read_src1_idx = $random & 5'h1F;
            read_src2_idx = $random & 5'h1F;
            wbck_dest_idx = $random & 5'h1F;
            wbck_dest_wen = $random & 1'b1;
            wbck_dest_dat = $random;
        end
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule