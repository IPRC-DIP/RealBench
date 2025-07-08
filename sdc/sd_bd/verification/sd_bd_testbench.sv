//`timescale 1 ps/1 ps

module tb_sd_bd();
    // 统计结构体定义
    typedef struct packed {
        int errors;
        int errortime;
        int errors_free_bd;
        int errortime_free_bd;
        int errors_ack_o_s;
        int errortime_ack_o_s;
        int errors_dat_out_s;
        int errortime_dat_out_s;
        int clocks;
    } stats;
   
    stats stats1;
   
    // 时钟和信号定义
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 接口信号
    logic rst;
    logic we_m;
    logic [`RAM_MEM_WIDTH-1:0] dat_in_m;
    logic [`BD_WIDTH-1:0] free_bd_ref, free_bd_dut;
    logic re_s;
    logic ack_o_s_ref, ack_o_s_dut;
    logic a_cmp;
    logic [`RAM_MEM_WIDTH-1:0] dat_out_s_ref, dat_out_s_dut;
    
    // 比较信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;
   
     // wavedrom signals
    wire [511:0] wavedrom_title;
    wire wavedrom_enable;
   
    // 实例化stimulus generator
    stimulus_gen stim1 (
        .clk(clk),
        .tb_match(tb_match),
        .rst(rst),
        .we_m(we_m),
        .dat_in_m(dat_in_m),
        .re_s(re_s),
        .a_cmp(a_cmp),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );


    // 实例化参考模型
    ref_sd_bd good1 (
        .clk(clk),
        .rst(rst),
        .we_m(we_m),
        .dat_in_m(dat_in_m),
        .free_bd(free_bd_ref),
        .re_s(re_s),
        .ack_o_s(ack_o_s_ref),
        .a_cmp(a_cmp),
        .dat_out_s(dat_out_s_ref)
    );
       
    // 实例化待测模块
    sd_bd top_module1 (
        .clk(clk),
        .rst(rst),
        .we_m(we_m),
        .dat_in_m(dat_in_m),
        .free_bd(free_bd_dut),
        .re_s(re_s),
        .ack_o_s(ack_o_s_dut),
        .a_cmp(a_cmp),
        .dat_out_s(dat_out_s_dut)
    );

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 仿真结束时输出统计信息
    final begin
        if (stats1.errors_free_bd) 
            $display("Hint: Output 'free_bd' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_free_bd, stats1.errortime_free_bd);
        else 
            $display("Hint: Output 'free_bd' has no mismatches.");
            
        if (stats1.errors_ack_o_s) 
            $display("Hint: Output 'ack_o_s' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_ack_o_s, stats1.errortime_ack_o_s);
        else 
            $display("Hint: Output 'ack_o_s' has no mismatches.");
            
        if (stats1.errors_dat_out_s) 
            $display("Hint: Output 'dat_out_s' has %0d mismatches. First mismatch occurred at time %0d.", 
                    stats1.errors_dat_out_s, stats1.errortime_dat_out_s);
        else 
            $display("Hint: Output 'dat_out_s' has no mismatches.");

        $display("Hint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
    end
   
    // 信号比对
    assign tb_match = ( { free_bd_ref, ack_o_s_ref, dat_out_s_ref } === 
                       ( { free_bd_ref, ack_o_s_ref, dat_out_s_ref } ^ 
                         { free_bd_dut, ack_o_s_dut, dat_out_s_dut } ^ 
                         { free_bd_ref, ack_o_s_ref, dat_out_s_ref } ) );

    // 错误统计
    always @(posedge clk) begin
        stats1.clocks++;
        
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end
        
        if (free_bd_ref !== (free_bd_ref ^ free_bd_dut ^ free_bd_ref)) begin
            if (stats1.errors_free_bd == 0) stats1.errortime_free_bd = $time;
            stats1.errors_free_bd++;
        end
        
        if (ack_o_s_ref !== (ack_o_s_ref ^ ack_o_s_dut ^ ack_o_s_ref)) begin
            if (stats1.errors_ack_o_s == 0) stats1.errortime_ack_o_s = $time;
            stats1.errors_ack_o_s++;
        end
        
        if (dat_out_s_ref !== (dat_out_s_ref ^ dat_out_s_dut ^ dat_out_s_ref)) begin
            if (stats1.errors_dat_out_s == 0) stats1.errortime_dat_out_s = $time;
            stats1.errors_dat_out_s++;
        end
    end

    // 超时控制
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule