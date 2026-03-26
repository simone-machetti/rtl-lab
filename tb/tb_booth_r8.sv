// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

`timescale 1 ns/1 ps

module tb_booth_r8 ();

    localparam int WIDTH_A   = 8;
    localparam int WIDTH_B   = 8;
    localparam int PP_SIZE   = (WIDTH_A + 2) / 3;
    localparam int PP_WIDTH  = WIDTH_B + 3;
    localparam int OUT_WIDTH = WIDTH_A + WIDTH_B;

    logic [  WIDTH_A-1:0] a;
    logic [  WIDTH_B-1:0] b;
    logic [ PP_WIDTH-1:0] pp [0:PP_SIZE-1];
    logic [OUT_WIDTH-1:0] res;
    logic [OUT_WIDTH-1:0] exp;

    booth_r8 #(
        .WIDTH_A(WIDTH_A),
        .WIDTH_B(WIDTH_B)
    ) booth_r8_i (
        .a_i (a),
        .b_i (b),
        .pp_o(pp)
    );

    initial begin
        $dumpfile("activity.vcd");
        $dumpvars(0, tb_booth_r8.booth_r8_i);

        for (int j = 0; j < 1000; j++) begin
            a = WIDTH_A'($urandom_range(0, (1<<WIDTH_A)-1));
            b = WIDTH_B'($urandom_range(0, (1<<WIDTH_B)-1));

            #5;

            res = OUT_WIDTH'($signed(pp[0]));
            for (int i = 1; i < PP_SIZE; i++) begin
                res = OUT_WIDTH'(res + (OUT_WIDTH'($signed(pp[i])) << (3*i)));
            end

            exp = OUT_WIDTH'($signed(a) * $signed(b));

            if (res != exp) begin
                $display("Error!");
                $dumpoff;
                $finish();
            end
        end

        $dumpoff;
        $finish();
    end

endmodule
