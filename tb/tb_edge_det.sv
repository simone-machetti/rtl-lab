// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */

`timescale 1 ns/1 ps

module tb_edge_det ();

    logic clk;
    logic rst_n;
    logic a;
    logic rising_edge;
    logic falling_edge;

    edge_det edge_det_i (
        .clk_i         (clk),
        .rst_ni        (rst_n),
        .a_i           (a),
        .rising_edge_o (rising_edge),
        .falling_edge_o(falling_edge)
    );

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    initial begin
        $dumpfile("activity.vcd");
        $dumpvars(0, tb_edge_detector.edge_detector_i);
        rst_n = 0;
        #10;
        rst_n = 1;
        a = 1;
        #10;
        a = 0;
        #10;
        $finish();
        $dumpoff;
    end

endmodule
