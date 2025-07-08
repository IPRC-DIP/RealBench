module tb();
    // 定义统计结构体
    typedef struct packed {
        int errors;         // 总错误数
        int errortime;      // 第一次错误发生时间
        int errors_out;     // out信号错误数
        int errortime_out;  // out信号第一次错误时间
        int clocks;         // 总时钟周期数
    } stats;
    
    stats stats1;
    
    // 时钟生成
    reg clk = 0;
    initial forever #5 clk = ~clk;
    
    // 信号定义
    logic kld;             // 输入
    logic [31:0] out_ref;  // 参考模块输出
    logic [31:0] out_dut;  // 被测模块输出
    wire tb_match;         // 输出匹配标志
    wire tb_mismatch = ~tb_match;
    
    
    // 实例化stimulus generator
    stimulus_gen stim1 (
        .clk(clk),
        .kld(kld)
    );
    
    // 实例化参考模块
    ref_aes_rcon good1 (
        .clk(clk),
        .kld(kld),
        .out(out_ref)
    );
    
    // 实例化被测模块
    aes_rcon top_module1 (
        .clk(clk),
        .kld(kld),
        .out(out_dut)
    );
    
    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0);
    end
    
    // 最终统计信息输出
    final begin
        if (stats1.errors_out) 
            $display("Hint: Output 'out' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_out, stats1.errortime_out);
        else 
            $display("Hint: Output 'out' has no mismatches.");
            
        $display("\nHint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
        $display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
    end
    
    // 输出匹配检查
    assign tb_match = (out_ref === (out_ref ^ out_dut ^ out_ref));
    
    // 错误统计
    always @(posedge clk, negedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
        
        if (out_ref !== (out_ref ^ out_dut ^ out_ref)) begin
            if (stats1.errors_out == 0) stats1.errortime_out = $time;
            stats1.errors_out = stats1.errors_out + 1'b1;
        end
    end
    
    // 超时保护
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end
    
endmodule