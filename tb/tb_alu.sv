// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

/* verilator lint_off UNUSEDSIGNAL */

`timescale 1 ns/1 ps

module tb_alu ();

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] op;
    logic [7:0] alu;

    alu alu_i (
        .a_i  (a),
        .b_i  (b),
        .op_i (op),
        .alu_o(alu)
    );

    initial begin
        $dumpfile("activity.vcd");
        $dumpvars(0, tb_alu.alu_i);
        a  = 8'($urandom_range(32'd0, 32'd255));
        b  = 8'($urandom_range(32'd0, 32'd255));
        op = 3'b000;
        #5;
        op = 3'b001;
        #5;
        op = 3'b010;
        #5;
        op = 3'b011;
        #5;
        op = 3'b100;
        #5;
        op = 3'b101;
        #5;
        op = 3'b110;
        #5;
        op = 3'b111;
        #5;
        $dumpoff;
        $finish();
    end

endmodule
