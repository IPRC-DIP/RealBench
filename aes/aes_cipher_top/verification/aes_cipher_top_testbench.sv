//`timescale 1 ps/1 ps

module tb();
    // 定义统计结构体
    typedef struct packed {
        int errors;           // 总错误数
        int errortime;        // 第一次错误发生时间
        int errors_text;      // text_out错误数
        int errortime_text;   // text_out第一次错误时间
        int errors_done;      // done信号错误数
        int errortime_done;   // done信号第一次错误时间
        int clocks;           // 总时钟周期数
    } stats;
    
    stats stats1;
    
    // 时钟生成
    reg clk = 0;
    initial forever #5 clk = ~clk;
    
    // 信号定义
    logic rst, ld;
    logic [127:0] key;
    logic [127:0] text_in;
    logic done_ref, done_dut;
    logic [127:0] text_out_ref;
    logic [127:0] text_out_dut;
    logic [511:0] wavedrom_title;
    logic wavedrom_enable;
    
    wire tb_match_text = (text_out_ref === (text_out_ref ^ text_out_dut ^ text_out_ref));
    wire tb_match_done = (done_ref === done_dut);
    wire tb_match = tb_match_text & tb_match_done;
    
    // 实例化stimulus generator
    stimulus_gen stim1 (
        .clk(clk),
        .tb_match(tb_match),
        .rst(rst),
        .ld(ld),
        .key(key),
        .text_in(text_in),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );
    
    // 实例化参考模块
    ref_aes_cipher_top good1 (
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .done(done_ref),
        .key(key),
        .text_in(text_in),
        .text_out(text_out_ref)
    );
    
    // 实例化被测模块
    aes_cipher_top top_module1 (
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .done(done_dut),
        .key(key),
        .text_in(text_in),
        .text_out(text_out_dut)
    );
    
    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0);
    end
    
    // 错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
        
        if (!tb_match_text) begin
            if (stats1.errors_text == 0) stats1.errortime_text = $time;
            stats1.errors_text++;
        end
        
        if (!tb_match_done) begin
            if (stats1.errors_done == 0) stats1.errortime_done = $time;
            stats1.errors_done++;
        end
    end
    
    // 最终统计信息输出
    final begin
        $display("\nTest Results:");
        if (stats1.errors_text) 
            $display("Hint: Output text_out has %0d mismatches. First at time %0d", 
                    stats1.errors_text, stats1.errortime_text);
        else 
            $display("Hint: Output 'text_out' has no mismatches.");
        if (stats1.errors_done) 
            $display("Hint: Output done signal has %0d mismatches. First at time %0d", 
                    stats1.errors_done, stats1.errortime_done);
        else 
            $display("Hint: Output 'done' has no mismatches.");
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