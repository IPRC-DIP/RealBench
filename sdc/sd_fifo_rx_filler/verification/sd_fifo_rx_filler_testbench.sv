//`timescale 1 ps/1 ps

module tb_sd_fifo_rx_filler();
    // 统计信息结构体定义
    typedef struct packed {
        int errors;                  // 总错误数
        int errortime;              // 首次错误时间
        int errors_m_wb_adr;        // 地址输出错误数
        int errortime_m_wb_adr;     // 地址首次错误时间
        int errors_m_wb_we;         // 写使能错误数
        int errortime_m_wb_we;      // 写使能首次错误时间
        int errors_m_wb_dat;        // 数据输出错误数
        int errortime_m_wb_dat;     // 数据输出首次错误时间
        int errors_m_wb_cyc;        // 总线周期错误数
        int errortime_m_wb_cyc;     // 总线周期首次错误时间
        int errors_m_wb_stb;        // 选通信号错误数
        int errortime_m_wb_stb;     // 选通信号首次错误时间
        int errors_m_wb_cti;        // 周期类型错误数
        int errortime_m_wb_cti;     // 周期类型首次错误时间
        int errors_m_wb_bte;        // 突发类型错误数
        int errortime_m_wb_bte;     // 突发类型首次错误时间
        int clocks;                 // 总时钟周期数
    } stats;

    stats stats1;

    // 时钟生成
    reg clk = 0;
    initial forever #5 clk = ~clk;

    // 所有信号定义
    logic rst;
    logic en;
    logic [31:0] adr;
    logic sd_clk;
    logic [`SD_BUS_W-1:0] dat_i;
    logic wr;
    logic m_wb_ack_i;

    // Reference输出信号
    logic [31:0] m_wb_adr_ref;
    logic m_wb_we_ref;
    logic [31:0] m_wb_dat_ref;
    logic m_wb_cyc_ref;
    logic m_wb_stb_ref;
    logic [2:0] m_wb_cti_ref;
    logic [1:0] m_wb_bte_ref;
    logic full_ref;
    logic empty_ref;

    // DUT输出信号
    logic [31:0] m_wb_adr_dut;
    logic m_wb_we_dut;
    logic [31:0] m_wb_dat_dut;
    logic m_wb_cyc_dut;
    logic m_wb_stb_dut;
    logic [2:0] m_wb_cti_dut;
    logic [1:0] m_wb_bte_dut;
    logic full_dut;
    logic empty_dut;

    // 波形导出相关信号
    wire[511:0] wavedrom_title;
    wire wavedrom_enable;

    // 验证信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;

    // 波形导出
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);  // 导出所有信号
    end

    // 实例化stimulus generator
    stimulus_gen stim1 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .adr(adr),
        .sd_clk(sd_clk),
        .dat_i(dat_i),
        .wr(wr),
        .m_wb_ack_i(m_wb_ack_i),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable),
        .tb_match(tb_match)
    );

    // 实例化reference model
    ref_sd_fifo_rx_filler good1 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .adr(adr),
        .m_wb_adr_o(m_wb_adr_ref),
        .m_wb_we_o(m_wb_we_ref),
        .m_wb_dat_o(m_wb_dat_ref),
        .m_wb_cyc_o(m_wb_cyc_ref),
        .m_wb_stb_o(m_wb_stb_ref),
        .m_wb_ack_i(m_wb_ack_i),
        .m_wb_cti_o(m_wb_cti_ref),
        .m_wb_bte_o(m_wb_bte_ref),
        .sd_clk(sd_clk),
        .dat_i(dat_i),
        .wr(wr),
        .full(full_ref),
        .empty(empty_ref)
    );

    // 实例化DUT
    sd_fifo_rx_filler top_module1 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .adr(adr),
        .m_wb_adr_o(m_wb_adr_dut),
        .m_wb_we_o(m_wb_we_dut),
        .m_wb_dat_o(m_wb_dat_dut),
        .m_wb_cyc_o(m_wb_cyc_dut),
        .m_wb_stb_o(m_wb_stb_dut),
        .m_wb_ack_i(m_wb_ack_i),
        .m_wb_cti_o(m_wb_cti_dut),
        .m_wb_bte_o(m_wb_bte_dut),
        .sd_clk(sd_clk),
        .dat_i(dat_i),
        .wr(wr),
        .full(full_dut),
        .empty(empty_dut)
        
    );

    // 验证: 比较reference和DUT输出?
    /*
    assign tb_match = (
        {m_wb_adr_ref, m_wb_we_ref, m_wb_dat_ref, m_wb_cyc_ref, 
         m_wb_stb_ref, m_wb_cti_ref, m_wb_bte_ref, full_ref} === 
        ({m_wb_adr_ref, m_wb_we_ref, m_wb_dat_ref, m_wb_cyc_ref, 
          m_wb_stb_ref, m_wb_cti_ref, m_wb_bte_ref, full_ref} ^ 
         {m_wb_adr_dut, m_wb_we_dut, m_wb_dat_dut, m_wb_cyc_dut, 
          m_wb_stb_dut, m_wb_cti_dut, m_wb_bte_dut, full_dut} ^ 
         {m_wb_adr_ref, m_wb_we_ref, m_wb_dat_ref, m_wb_cyc_ref, 
          m_wb_stb_ref, m_wb_cti_ref, m_wb_bte_ref, full_ref})
    );*/
    assign tb_match = m_wb_adr_ref === m_wb_adr_dut & m_wb_we_ref === m_wb_we_dut & m_wb_dat_ref === m_wb_dat_dut & m_wb_cyc_ref === m_wb_cyc_dut & m_wb_stb_ref === m_wb_stb_dut & m_wb_cti_ref === m_wb_cti_dut & m_wb_bte_ref === m_wb_bte_dut & full_ref ===full_dut;


    // 错误统计
    always @(posedge clk, negedge clk) begin
        stats1.clocks++;
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end

        // 检查每个输出信号
        if (m_wb_adr_ref !== (m_wb_adr_ref ^ m_wb_adr_dut ^ m_wb_adr_ref)) begin
            if (stats1.errors_m_wb_adr == 0) stats1.errortime_m_wb_adr = $time;
            stats1.errors_m_wb_adr++;
        end

        if (m_wb_we_ref !== (m_wb_we_ref ^ m_wb_we_dut ^ m_wb_we_ref)) begin
            if (stats1.errors_m_wb_we == 0) stats1.errortime_m_wb_we = $time;
            stats1.errors_m_wb_we++;
        end

        if (m_wb_dat_ref !== (m_wb_dat_ref ^ m_wb_dat_dut ^ m_wb_dat_ref)) begin
            if (stats1.errors_m_wb_dat == 0) stats1.errortime_m_wb_dat = $time;
            stats1.errors_m_wb_dat++;
        end

        if (m_wb_cyc_ref !== (m_wb_cyc_ref ^ m_wb_cyc_dut ^ m_wb_cyc_ref)) begin
            if (stats1.errors_m_wb_cyc == 0) stats1.errortime_m_wb_cyc = $time;
            stats1.errors_m_wb_cyc++;
        end

        if (m_wb_stb_ref !== (m_wb_stb_ref ^ m_wb_stb_dut ^ m_wb_stb_ref)) begin
            if (stats1.errors_m_wb_stb == 0) stats1.errortime_m_wb_stb = $time;
            stats1.errors_m_wb_stb++;
        end

        if (m_wb_cti_ref !== (m_wb_cti_ref ^ m_wb_cti_dut ^ m_wb_cti_ref)) begin
            if (stats1.errors_m_wb_cti == 0) stats1.errortime_m_wb_cti = $time;
            stats1.errors_m_wb_cti++;
        end

        if (m_wb_bte_ref !== (m_wb_bte_ref ^ m_wb_bte_dut ^ m_wb_bte_ref)) begin
            if (stats1.errors_m_wb_bte == 0) stats1.errortime_m_wb_bte = $time;
            stats1.errors_m_wb_bte++;
        end
    end

    // 最终结果输出
    final begin
        $display("\n----- Simulation Results -----");
        
        // 输出每个信号的错误统计
        if (stats1.errors) 
            $display("Hint: Output total has %0d mismatches. First mismatch at time %0d.", 
                    stats1.errors, stats1.errortime);
        else 
            $display("Hint: Output total has no mismatches.");

        if (stats1.errors_m_wb_adr) 
            $display("Hint: Output 'm_wb_adr_o' has %0d mismatches. First mismatch at time %0d.", 
                    stats1.errors_m_wb_adr, stats1.errortime_m_wb_adr);
        else 
            $display("Hint: Output 'm_wb_adr_o' has no mismatches.");

        if (stats1.errors_m_wb_we) 
            $display("Hint: Output 'm_wb_we_o' has %0d mismatches. First mismatch at time %0d.", 
                    stats1.errors_m_wb_we, stats1.errortime_m_wb_we);
        else 
            $display("Hint: Output 'm_wb_we_o' has no mismatches.");

        if (stats1.errors_m_wb_dat) 
            $display("Hint: Output 'm_wb_dat_o' has %0d mismatches. First mismatch at time %0d.", 
                    stats1.errors_m_wb_dat, stats1.errortime_m_wb_dat);
        else 
            $display("Hint: Output 'm_wb_dat_o' has no mismatches.");

        // ... 其他信号的错误统计输出

        $display("\nHint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps", $time);
        $display("Mismatches: %1d in %1d samples", stats1.errors, stats1.clocks);
    end

    // 超时保护
    initial begin
        #1000000
        $display("TIMEOUT");
        $finish();
    end

endmodule