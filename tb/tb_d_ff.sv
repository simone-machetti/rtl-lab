// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */

`timescale 1 ns/1 ps

module tb_d_ff ();

    logic clk;
    logic rst_n;
    logic d;
    logic q_norst;
    logic q_syncrst;
    logic q_asyncrst;

    d_ff d_ff_i (
        .clk_i       (clk),
        .rst_ni      (rst_n),
        .d_i         (d),
        .q_norst_o   (q_norst),
        .q_syncrst_o (q_syncrst),
        .q_asyncrst_o(q_asyncrst)
    );

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    initial begin
        $dumpfile("activity.vcd");
        $dumpvars(0, tb_d_ff.d_ff_i);
        rst_n = 1'b0;
        #10;
        rst_n = 1'b1;
        #10;
        for (int i = 0; i < 10; i++) begin
            d = 1'($random % 2);
            #10;
        end
        $dumpoff;
        $finish();
    end

endmodule
