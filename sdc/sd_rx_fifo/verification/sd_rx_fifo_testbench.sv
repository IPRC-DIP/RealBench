//`timescale 1 ps/1 ps

module tb_sd_rx_fifo();
    // 统计结构体定义
    typedef struct packed {
        int errors;
        int errortime;
        int errors_q;
        int errortime_q;
        int errors_full;
        int errortime_full;
        int errors_empty;
        int errortime_empty;
        int errors_mem_empt;
        int errortime_mem_empt;
        int clocks;
    } stats;
   
    stats stats1;
   
    // 时钟和信号定义
    reg wclk = 0;
    reg rclk = 0;
    initial forever #5 wclk = ~wclk;
    initial forever #8 rclk = ~rclk;  // 不同频率测试异步性

    // 接口信号
    logic rst;
    logic [3:0] d;
    logic wr;
    logic [31:0] q_ref, q_dut;
    logic rd;
    logic full_ref, full_dut;
    logic empty_ref, empty_dut;
    logic [1:0] mem_empt_ref, mem_empt_dut;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   

    // 波形相关信号
    wire[511:0] wavedrom_title;
    wire wavedrom_enable;


    // 实例化stimulus generator
    stimulus_gen stim1 (
        .wclk(wclk),              // 写时钟
        .rclk(rclk),              // 读时钟
        .tb_match(tb_match),
        .d(d),
        .wr(wr),
        .rd(rd),
        .rst(rst),
        .wavedrom_title(),
        .wavedrom_enable(wavedrom_enable)
    );

    // 实例化参考模型
    ref_sd_rx_fifo good1 (
        .wclk(wclk),
        .rclk(rclk),
        .rst(rst),
        .d(d),
        .wr(wr),
        .q(q_ref),
        .rd(rd),
        .full(full_ref),
        .empty(empty_ref),
        .mem_empt(mem_empt_ref)
    );
       
    // 实例化待测模块
    sd_rx_fifo top_module1 (
        .wclk(wclk),
        .rclk(rclk),
        .rst(rst),
        .d(d),
        .wr(wr),
        .q(q_dut),
        .rd(rd),
        .full(full_dut),
        .empty(empty_dut),
        .mem_empt(mem_empt_dut)
    );

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    final begin
        if (stats1.errors_q) 
            $display("Hint: Output 'q' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_q, stats1.errortime_q);
        else 
            $display("Hint: Output 'q' has no mismatches.");
            
        if (stats1.errors_full) 
            $display("Hint: Output 'full' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_full, stats1.errortime_full);
        else 
            $display("Hint: Output 'full' has no mismatches.");
            
        if (stats1.errors_empty) 
            $display("Hint: Output 'empty' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_empty, stats1.errortime_empty);
        else 
            $display("Hint: Output 'empty' has no mismatches.");
            
        if (stats1.errors_mem_empt) 
            $display("Hint: Output 'mem_empt' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_mem_empt, stats1.errortime_mem_empt);
        else 
            $display("Hint: Output 'mem_empt' has no mismatches.");

        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    assign tb_match = ( { q_ref, full_ref, empty_ref, mem_empt_ref } === 
                       ( { q_ref, full_ref, empty_ref, mem_empt_ref } ^ 
                         { q_dut, full_dut, empty_dut, mem_empt_dut } ^ 
                         { q_ref, full_ref, empty_ref, mem_empt_ref } ) );

    // 错误统计
    always @(posedge wclk, posedge rclk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
        
        if (q_ref !== (q_ref ^ q_dut ^ q_ref)) begin
            if (stats1.errors_q == 0) stats1.errortime_q = $time;
            stats1.errors_q++;
        end
        
        if (full_ref !== (full_ref ^ full_dut ^ full_ref)) begin
            if (stats1.errors_full == 0) stats1.errortime_full = $time;
            stats1.errors_full++;
        end
        
        if (empty_ref !== (empty_ref ^ empty_dut ^ empty_ref)) begin
            if (stats1.errors_empty == 0) stats1.errortime_empty = $time;
            stats1.errors_empty++;
        end
        
        // if (mem_empt_ref !== (mem_empt_ref ^ mem_empt_dut ^ mem_empt_ref)) begin
        if (mem_empt_ref !== mem_empt_dut) begin
            if (stats1.errors_mem_empt == 0) stats1.errortime_mem_empt = $time;
            stats1.errors_mem_empt++;
        end
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule