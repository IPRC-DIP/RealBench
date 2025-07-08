// testbench.sv
//`timescale 1 ps/1 ps

module tb_sd_fifo_tx_filler();
    // 统计结构定义
    typedef struct packed {
        int errors;
        int errortime;
        int errors_m_wb_adr_o;
        int errortime_m_wb_adr_o;
        int errors_m_wb_we_o;
        int errortime_m_wb_we_o;
        int errors_m_wb_cyc_o;
        int errortime_m_wb_cyc_o;
        int errors_m_wb_stb_o;
        int errortime_m_wb_stb_o;
        int errors_m_wb_cti_o;
        int errortime_m_wb_cti_o;
        int errors_m_wb_bte_o;
        int errortime_m_wb_bte_o;
        int errors_dat_o;
        int errortime_dat_o;
        int errors_empty;
        int errortime_empty;
        int errors_fe;
        int errortime_fe;
        int clocks;
    } stats;
   
    stats stats1;

    // 波形相关信号
    wire[511:0] wavedrom_title;
    wire wavedrom_enable;

    // 时钟生成
    reg clk = 0;
    reg sd_clk = 0;
    initial forever #5 clk = ~clk;
    initial forever #10 sd_clk = ~sd_clk;

    // 基本信号定义
    logic rst;
    logic en;
    logic [31:0] adr;
    logic [31:0] m_wb_dat_i;
    logic m_wb_ack_i;
    logic rd;
    
    // 输出信号对比用信号定义
    logic [31:0] m_wb_adr_o_ref, m_wb_adr_o_dut;
    logic m_wb_we_o_ref, m_wb_we_o_dut;
    logic m_wb_cyc_o_ref, m_wb_cyc_o_dut;
    logic m_wb_stb_o_ref, m_wb_stb_o_dut;
    logic [2:0] m_wb_cti_o_ref, m_wb_cti_o_dut;
    logic [1:0] m_wb_bte_o_ref, m_wb_bte_o_dut;
    logic [31:0] dat_o_ref, dat_o_dut;
    logic empty_ref, empty_dut;
    logic fe_ref, fe_dut;

    // 比较结果信号
    wire tb_match;
    wire tb_mismatch = ~tb_match;

    // 激励生成器例化
    stimulus_gen stim1 (
        .*,  // 自动连接同名信号
        .tb_match(tb_match),
        .wavedrom_title(wavedrom_title),
        .wavedrom_enable(wavedrom_enable)
    );

    // 参考模型例化
    ref_sd_fifo_tx_filler ref_model (
        .clk(clk),
        .rst(rst),
        .m_wb_adr_o(m_wb_adr_o_ref),
        .m_wb_we_o(m_wb_we_o_ref),
        .m_wb_dat_i(m_wb_dat_i),
        .m_wb_cyc_o(m_wb_cyc_o_ref),
        .m_wb_stb_o(m_wb_stb_o_ref),
        .m_wb_ack_i(m_wb_ack_i),
        .m_wb_cti_o(m_wb_cti_o_ref),
        .m_wb_bte_o(m_wb_bte_o_ref),
        .en(en),
        .adr(adr),
        .sd_clk(sd_clk),
        .dat_o(dat_o_ref),
        .rd(rd),
        .empty(empty_ref),
        .fe(fe_ref)
    );

    // 待测模块例化
    sd_fifo_tx_filler dut (
        .clk(clk),
        .rst(rst),
        .m_wb_adr_o(m_wb_adr_o_dut),
        .m_wb_we_o(m_wb_we_o_dut),
        .m_wb_dat_i(m_wb_dat_i),
        .m_wb_cyc_o(m_wb_cyc_o_dut),
        .m_wb_stb_o(m_wb_stb_o_dut),
        .m_wb_ack_i(m_wb_ack_i),
        .m_wb_cti_o(m_wb_cti_o_dut),
        .m_wb_bte_o(m_wb_bte_o_dut),
        .en(en),
        .adr(adr),
        .sd_clk(sd_clk),
        .dat_o(dat_o_dut),
        .rd(rd),
        .empty(empty_dut),
        .fe(fe_dut)
    );

    // 波形记录
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // 信号对比逻辑
    assign tb_match = (
        m_wb_adr_o_ref === m_wb_adr_o_dut &&
        m_wb_we_o_ref === m_wb_we_o_dut &&
        m_wb_cyc_o_ref === m_wb_cyc_o_dut &&
        m_wb_stb_o_ref === m_wb_stb_o_dut &&
        m_wb_cti_o_ref === m_wb_cti_o_dut &&
        m_wb_bte_o_ref === m_wb_bte_o_dut &&
        dat_o_ref === dat_o_dut &&
        empty_ref === empty_dut &&
        fe_ref === fe_dut
    );

    // 输出监控和统计
    always @(posedge clk) begin
        stats1.clocks++;
        if (!tb_match) begin
            if (stats1.errors == 0) stats1.errortime = $time;
            stats1.errors++;
        end

        // 检查每个输出信号
        `define CHECK_SIGNAL(signal, ref, dut) \
        if (ref !== dut) begin \
            if (stats1.errors_``signal == 0) stats1.errortime_``signal = $time; \
            stats1.errors_``signal++; \
        end

        `CHECK_SIGNAL(m_wb_adr_o, m_wb_adr_o_ref, m_wb_adr_o_dut)
        `CHECK_SIGNAL(m_wb_we_o, m_wb_we_o_ref, m_wb_we_o_dut)
        `CHECK_SIGNAL(m_wb_cyc_o, m_wb_cyc_o_ref, m_wb_cyc_o_dut)
        `CHECK_SIGNAL(m_wb_stb_o, m_wb_stb_o_ref, m_wb_stb_o_dut)
        `CHECK_SIGNAL(m_wb_cti_o, m_wb_cti_o_ref, m_wb_cti_o_dut)
        `CHECK_SIGNAL(m_wb_bte_o, m_wb_bte_o_ref, m_wb_bte_o_dut)
        `CHECK_SIGNAL(dat_o, dat_o_ref, dat_o_dut)
        `CHECK_SIGNAL(empty, empty_ref, empty_dut)
        `CHECK_SIGNAL(fe, fe_ref, fe_dut)
    end

    // 最终报告
    final begin
        $display("\n=== Test Results ===");
        if (stats1.errors == 0)
            $display("All tests passed successfully!");
        else begin
            $display("Errors detected:");
            
            `define REPORT_SIGNAL(signal) \
            if (stats1.errors_``signal) \
                $display("Hint: Output %s: %0d errors, first at time %0d", \
                    `"signal`", stats1.errors_``signal, stats1.errortime_``signal); \
            else \
                $display("Hint: Output `'signal`' has no mismatches.");

            `REPORT_SIGNAL(m_wb_adr_o)
            `REPORT_SIGNAL(m_wb_we_o)
            `REPORT_SIGNAL(m_wb_cyc_o)
            `REPORT_SIGNAL(m_wb_stb_o)
            `REPORT_SIGNAL(m_wb_cti_o)
            `REPORT_SIGNAL(m_wb_bte_o)
            `REPORT_SIGNAL(dat_o)
            `REPORT_SIGNAL(empty)
            `REPORT_SIGNAL(fe)
        end
        
        $display("\nHint: Total mismatched samples is %1d out of %1d samples\n", 
                stats1.errors, stats1.clocks);
        $display("Simulation finished at %0d ps\n", $time);
    end

    // 超时保护
    initial begin
        #1000000;
        $display("TIMEOUT");
        $finish;
    end

endmodule