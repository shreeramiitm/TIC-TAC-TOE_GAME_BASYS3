`timescale 1ns / 1ps

module gameState(
    input Reset,
    input clk,
    input [17:0] Cells,
    output reg winState,
    output reg [8:0] Color
);

    // Converted from typedef enum
    localparam PLAY = 1'b0, WIN = 1'b1;
    reg PS, NS;

    always @(posedge clk) begin // Converted from always_ff
        if (Reset)
            PS <= PLAY;
        else
            PS <= NS;
    end

    always @* begin // Converted from always_comb
        case (PS)
            PLAY : begin
                winState = 0;
                // Horizontal
                if (Cells[1:0] == Cells[3:2] && Cells[3:2] == Cells[5:4] && Cells[1:0] != 0) begin
                    Color = 9'b000000111;
                    NS = WIN;
                end
                else if (Cells[7:6] == Cells[9:8] && Cells[9:8] == Cells[11:10] && Cells[7:6] != 0) begin
                    Color = 9'b000111000;
                    NS = WIN;
                end
                else if (Cells[13:12] == Cells[15:14] && Cells[15:14] == Cells[17:16] && Cells[13:12] != 0) begin
                    Color = 9'b111000000;
                    NS = WIN;
                end
                // Vertical
                else if (Cells[1:0] == Cells[7:6] && Cells[7:6] == Cells[13:12] && Cells[1:0] != 0) begin
                    Color = 9'b001001001;
                    NS = WIN;
                end
                else if (Cells[3:2] == Cells[9:8] && Cells[9:8] == Cells[15:14] && Cells[3:2] != 0) begin
                    Color = 9'b010010010;
                    NS = WIN;
                end
                else if (Cells[5:4] == Cells[11:10] && Cells[11:10] == Cells[17:16] && Cells[5:4] != 0) begin
                    Color = 9'b100100100;
                    NS = WIN;
                end
                // Diagonal
                else if (Cells[1:0] == Cells[9:8] && Cells[9:8] == Cells[17:16] && Cells[1:0] != 0) begin
                    Color = 9'b100010001;
                    NS = WIN;
                end
                else if (Cells[5:4] == Cells[9:8] && Cells[9:8] == Cells[13:12] && Cells[5:4] != 0) begin
                    Color = 9'b001010100;
                    NS = WIN;
                end
                else begin
                    Color = 0;
                    NS = PS;
                end
            end
            WIN : begin
                winState = 1;
                Color = Color; 
                NS = WIN;
            end
            default: begin
                Color = 0;
                winState = 0;
                NS = PLAY;
            end
        endcase
    end
endmodule