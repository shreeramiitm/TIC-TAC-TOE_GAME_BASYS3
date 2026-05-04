`timescale 1ns / 1ps

module Cell(
    input clk,
    input Sel,
    input Turn,
    input Reset,
    output reg [1:0] State
);

    // Converted from typedef enum
    localparam N = 2'd0, X = 2'd1, O = 2'd2;
    reg [1:0] PS, NS;

    always @(posedge clk) begin // Converted from always_ff
        if (Reset)
            PS <= N;
        else
            PS <= NS;
    end

    always @* begin // Converted from always_comb
        case (PS)
            N: begin
                State = 2'b00;
                if (Sel && ~Turn)
                    NS = X;
                else if (Sel && Turn)
                    NS = O;
                else
                    NS = PS;
            end
            X: begin
                State = 2'b01;
                NS = PS;
            end
            O: begin
                State = 2'b11;
                NS = PS;
            end
            default: begin
                NS = N;
                State = 2'b00;
            end
        endcase
    end
endmodule