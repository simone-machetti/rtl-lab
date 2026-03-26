// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

`timescale 1 ns/1 ps

module booth_r4 #(
    parameter int WIDTH_A = 4,
    parameter int WIDTH_B = 8,

    localparam int PP_SIZE  = (WIDTH_A + 1) / 2,
    localparam int PP_WIDTH = WIDTH_B + 2
)(
    input  logic [ WIDTH_A-1:0] a_i,
    input  logic [ WIDTH_B-1:0] b_i,
    output logic [PP_WIDTH-1:0] pp_o [0:PP_SIZE-1]
);

    logic [WIDTH_A:0] mult_ext;

    assign mult_ext = {a_i, 1'b0};

    genvar i;
    generate

        for (i = 0; i < PP_SIZE; i++) begin : ben_booth

            logic [2:0] sel;

            assign sel = mult_ext[2*i +: 3];

            booth_r4_cell #(
                .IN_WIDTH(WIDTH_B)
            ) booth_r4_cell_i (
                .mult_i(b_i),
                .sel_i (sel),
                .pp_o  (pp_o[i])
            );
        end

    endgenerate

endmodule
