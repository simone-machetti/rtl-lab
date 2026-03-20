// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */

`timescale 1 ns/1 ps

module tb_mux ();

    logic [7:0] a_i;
    logic [7:0] b_i;
    logic       sel_i;
    logic [7:0] y_o;

    mux mux_i (
        .a_i  (a_i),
        .b_i  (b_i),
        .sel_i(sel_i),
        .y_o  (y_o)
    );

    initial begin
        $dumpfile("activity.vcd");
        $dumpvars(0, tb_mux.mux_i);
        for (int i = 0; i < 10; i++) begin
            a_i   = 8'($urandom_range(0, 32'd255));
            b_i   = 8'($urandom_range(0, 32'd255));
            sel_i = 1'($random % 2);
            #5;
        end
        $dumpoff;
        $finish();
    end

endmodule
