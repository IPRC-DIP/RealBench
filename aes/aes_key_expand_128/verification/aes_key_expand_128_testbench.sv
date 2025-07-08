//`timescale 1 ps/1 ps

module tb();
    // 定义统计结构体
    typedef struct packed {
        int errors;         // 总错误数
        int errortime;      // 第一次错误发生时间
        int errors_w0;      // wo_0错误数
        int errortime_w0;   // wo_0第一次错误时间
        int errors_w1;      // wo_1错误数
        int errortime_w1;   // wo_1第一次错误时间
        int errors_w2;      // wo_2错误数
        int errortime_w2;   // wo_2第一次错误时间
        int errors_w3;      // wo_3错误数
        int errortime_w3;   // wo_3第一次错误时间
        int clocks;         // 总时钟周期数
    } stats;
    
    stats stats1;
    
    // 时钟生成
    reg clk = 0;
    initial forever #5 clk = ~clk;
    
    // 信号定义
    logic kld;
    logic [127:0] key;
    logic [31:0] wo_0_ref, wo_1_ref, wo_2_ref, wo_3_ref;
    logic [31:0] wo_0_dut, wo_1_dut, wo_2_dut, wo_3_dut;
    
    wire tb_match_w0, tb_match_w1, tb_match_w2, tb_match_w3;
    // wire tb_match = tb_match_w0 & tb_match_w1 & tb_match_w2 & tb_match_w3;
    // wire tb_mismatch = ~tb_match;
    reg tb_mismatch;

    // 实例化stimulus generator
    stimulus_gen stim1 (
        .clk(clk),
        .kld(kld),
        .key(key)
    );
    
    // 实例化参考模块
    ref_aes_key_expand_128 good1 (
        .clk(clk),
        .kld(kld),
        .key(key),
        .wo_0(wo_0_ref),
        .wo_1(wo_1_ref),
        .wo_2(wo_2_ref),
        .wo_3(wo_3_ref)
    );
    
    // 实例化被测模块
    aes_key_expand_128 top_module1 (
        .clk(clk),
        .kld(kld),
        .key(key),
        .wo_0(wo_0_dut),
        .wo_1(wo_1_dut),
        .wo_2(wo_2_dut),
        .wo_3(wo_3_dut)
    );
    
    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0);
    end
    
    // 输出匹配检查
    assign tb_match_w0 = wo_0_dut === wo_0_ref;
    assign tb_match_w1 = wo_1_dut === wo_1_ref;
    assign tb_match_w2 = wo_2_dut === wo_2_ref;
    assign tb_match_w3 = wo_3_dut === wo_3_ref;
    always @(*) begin
        tb_mismatch = ~(wo_0_dut === wo_0_ref & wo_1_dut === wo_1_ref & wo_2_dut === wo_2_ref & wo_3_dut === wo_3_ref);
    end

    // 错误统计
    always @(posedge clk, negedge clk) begin
        stats1.clocks++;
        
        if (tb_mismatch) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
        
        if (!tb_match_w0) begin
            if (stats1.errors_w0 == 0) stats1.errortime_w0 = $time;
            stats1.errors_w0++;
        end
        
        if (!tb_match_w1) begin
            if (stats1.errors_w1 == 0) stats1.errortime_w1 = $time;
            stats1.errors_w1++;
        end
        
        if (!tb_match_w2) begin
            if (stats1.errors_w2 == 0) stats1.errortime_w2 = $time;
            stats1.errors_w2++;
        end
        
        if (!tb_match_w3) begin
            if (stats1.errors_w3 == 0) stats1.errortime_w3 = $time;
            stats1.errors_w3++;
        end
    end
    
    // 最终统计信息输出
    final begin
        $display("\nTest Results:");
        if (stats1.errors) 
            $display("total has %0d mismatches. First at time %0d", 
                    stats1.errors, stats1.errortime);
        else 
            $display("Hint: Output total has no mismatches.");
        if (stats1.errors_w0) 
            $display("wo_0 has %0d mismatches. First at time %0d", 
                    stats1.errors_w0, stats1.errortime_w0);
        else 
            $display("Hint: Output 'wo_0' has no mismatches.");
        if (stats1.errors_w1) 
            $display("wo_1 has %0d mismatches. First at time %0d", 
                    stats1.errors_w1, stats1.errortime_w1);
        else 
            $display("Hint: Output 'wo_1' has no mismatches.");
        if (stats1.errors_w2) 
            $display("wo_2 has %0d mismatches. First at time %0d", 
                    stats1.errors_w2, stats1.errortime_w2);
        else 
            $display("Hint: Output 'wo_2' has no mismatches.");
        if (stats1.errors_w3) 
            $display("wo_3 has %0d mismatches. First at time %0d", 
                    stats1.errors_w3, stats1.errortime_w3);
        else 
            $display("Hint: Output 'wo_3' has no mismatches.");
            
        $display("\nHint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
    
    // 超时保护
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end
    
endmodule