// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

`timescale 1 ns/1 ps

module tb_cpr_tree ();

    localparam int PP_SIZE  = 64;
    localparam int PP_WIDTH = 50;
    localparam int ACC_SIZE = 3;

    localparam int ACC_WIDTH = 48;
    localparam int EXT_NUM   = 15;
    localparam int OUT_WIDTH = ACC_WIDTH;

    logic [OUT_WIDTH-1:0] expected;

    logic [ACC_WIDTH-1:0] acc       [0:ACC_SIZE-1];
    logic                 is_signed [ 0:EXT_NUM-1];
    logic                 is_shift  [ 0:EXT_NUM-1];
    logic [ PP_WIDTH-1:0] pp        [ 0:PP_SIZE-1];
    logic [OUT_WIDTH-1:0] out;

    cpr_tree #(
        .PP_SIZE (PP_SIZE),
        .PP_WIDTH(PP_WIDTH),
        .ACC_SIZE(ACC_SIZE)
    ) cpr_tree_i (
        .acc_i      (acc),
        .is_signed_i(is_signed),
        .is_shift_i (is_shift),
        .pp_i       (pp),
        .out_o      (out)
    );

    initial begin

        $dumpfile("activity.vcd");
        $dumpvars(0, tb_cpr_tree.cpr_tree_i);

        for (int k = 0; k < EXT_NUM; k ++) begin
            is_signed[k] = 1'b1;
            is_shift[k]  = 1'b0;
        end

        for (int j = 0; j < 1000; j++) begin

            expected = '0;

            for (int i = 0; i < ACC_SIZE; i++) begin
                acc[i]   = OUT_WIDTH'($urandom_range(0, (1 << ACC_WIDTH) - 1));
                expected = OUT_WIDTH'($signed(expected) + $signed(acc[i]));
            end

            for (int i = 0; i < PP_SIZE; i++) begin
                pp[i]    = PP_WIDTH'($urandom_range(0, (1 << PP_WIDTH) - 1));
                expected = OUT_WIDTH'($signed(expected) + $signed(pp[i]));
            end

            #5;

            if (out != expected) begin
                $display("Error!");
                $dumpoff;
                $finish();
            end
        end

        $dumpoff;
        $finish();
    end

endmodule
