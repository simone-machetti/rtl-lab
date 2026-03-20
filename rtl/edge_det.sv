// -----------------------------------------------------------------------------
// Author: Simone Machetti
// -----------------------------------------------------------------------------

`timescale 1 ns/1 ps

module edge_det (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic a_i,
    output logic rising_edge_o,
    output logic falling_edge_o
);

    logic a;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            a <= 1'b0;
        end else begin
            a <= a_i;
        end
    end

    assign rising_edge_o  = ~a & a_i;
    assign falling_edge_o = a & ~a_i;

endmodule
