`timescale 1ns / 1ps

module gameLogic(
    input wire clk,
    input wire [8:0] In,
    input wire Reset,
    output wire hsync, vsync,
    output wire [11:0] rgb,
    output wire winState
);

    reg [8:0] sqrSel;
    wire [17:0] Cells;
    
    // Initialized states for FPGA
    reg [8:0] prevIn = 0; 
    reg [8:0] myIn = 0;
    reg Turn = 0;
    
    wire [8:0] Color;

    // Converted from always_comb
    always @* begin
        if(!winState) begin
            if (In[6] && !Cells[16]) sqrSel = 9'b100000000;
            else if (In[7] && !Cells[14]) sqrSel = 9'b010000000;
            else if (In[8] && !Cells[12]) sqrSel = 9'b001000000;
            else if (In[3] && !Cells[10]) sqrSel = 9'b000100000;
            else if (In[4] && !Cells[8])  sqrSel = 9'b000010000;
            else if (In[5] && !Cells[6])  sqrSel = 9'b000001000;
            else if (In[0] && !Cells[4])  sqrSel = 9'b000000100;
            else if (In[1] && !Cells[2])  sqrSel = 9'b000000010;
            else if (In[2] && !Cells[0])  sqrSel = 9'b000000001;
            else sqrSel = 9'b000000000;
        end else begin
            sqrSel = 9'b000000000;
        end
    end

    always @ (negedge clk) begin
        if (prevIn != myIn && myIn != 0) 
            Turn <= ~Turn;
        prevIn <= myIn;
        myIn <= In;
    end

    // Win checking
    gameState state (
        .clk(clk), .Reset(Reset), .Cells(Cells), 
        .winState(winState), .Color(Color)
    );

    // Video generator
    videoElements VGA (
        .clk(clk), .reset(Reset), .hsync(hsync),
        .vsync(vsync), .rgb(rgb), .Cells(Cells), .Color(Color), .Turn(Turn)
    );

    // Board cells
    Cell cell1 (.clk(clk), .Sel(sqrSel[0]), .Turn(Turn), .Reset(Reset), .State(Cells[1:0]));
    Cell cell2 (.clk(clk), .Sel(sqrSel[1]), .Turn(Turn), .Reset(Reset), .State(Cells[3:2]));
    Cell cell3 (.clk(clk), .Sel(sqrSel[2]), .Turn(Turn), .Reset(Reset), .State(Cells[5:4]));
    Cell cell4 (.clk(clk), .Sel(sqrSel[3]), .Turn(Turn), .Reset(Reset), .State(Cells[7:6]));
    Cell cell5 (.clk(clk), .Sel(sqrSel[4]), .Turn(Turn), .Reset(Reset), .State(Cells[9:8]));
    Cell cell6 (.clk(clk), .Sel(sqrSel[5]), .Turn(Turn), .Reset(Reset), .State(Cells[11:10]));
    Cell cell7 (.clk(clk), .Sel(sqrSel[6]), .Turn(Turn), .Reset(Reset), .State(Cells[13:12]));
    Cell cell8 (.clk(clk), .Sel(sqrSel[7]), .Turn(Turn), .Reset(Reset), .State(Cells[15:14]));
    Cell cell9 (.clk(clk), .Sel(sqrSel[8]), .Turn(Turn), .Reset(Reset), .State(Cells[17:16]));

endmodule