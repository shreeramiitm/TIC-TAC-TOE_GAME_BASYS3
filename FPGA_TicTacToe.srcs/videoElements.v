`timescale 1ns / 1ps

module videoElements(
    input clk, reset,
    input [17:0] Cells,
    input [8:0] Color,
    input Turn,
    output hsync, vsync,
    output [11:0] rgb
);

    // Constants for screen boundaries and drawing
    localparam hRes = 640;
    localparam vRes = 480;
    localparam hBorder = 100;
    localparam vBorder = 20;
    localparam hLinePos1 = vBorder + 147;
    localparam hLinePos2 = (vRes - 20) - 147;
    localparam vLinePos1 = hBorder + 147;
    localparam vLinePos2 = (hRes - 100) - 147;
    localparam sqBorder = 40;
    localparam lineWeight = 2;

    // Register to hold the color for the current pixel
    reg [11:0] current_color;

    // Internal wires
    wire [9:0] hPos, vPos;
    wire p_tick;
    wire video_on;

    // instantiate vga_sync
    vga_sync vga_sync_unit (
        .clk(clk), .reset(reset), .hsync(hsync),
        .vsync(vsync), .video_on(video_on), .p_tick(p_tick),
        .x(hPos), .y(vPos)
    );

    // Draw elements on screen
    always @(posedge p_tick) begin
        current_color = 12'h000; // Default Background is Black

        // Draw Horizontal grid lines (White)
        if (hPos > hBorder && hPos < (hRes - hBorder) &&
           ((vPos > hLinePos1 - lineWeight && vPos < hLinePos1 + lineWeight) ||
            (vPos > hLinePos2 - lineWeight && vPos < hLinePos2 + lineWeight)))
            current_color = 12'hFFF;
            
        // Draw Vertical grid lines (White)
        else if (vPos > vBorder && vPos < (vRes - vBorder) &&
                ((hPos > vLinePos1 - lineWeight && hPos < vLinePos1 + lineWeight) ||
                 (hPos > vLinePos2 - lineWeight && hPos < vLinePos2 + lineWeight)))
            current_color = 12'hFFF;
            
        // Cell 1 (Top Right)
        else if (hPos > hBorder + sqBorder && hPos < vLinePos1 - sqBorder &&
                 vPos > vBorder + sqBorder && vPos < hLinePos1 - sqBorder && Cells[0]) begin
            if (Color[0]) current_color = 12'hF00;               // Win: Red
            else if (Cells[1] == 1'b0) current_color = 12'h0FF;  // Player 1: Cyan
            else current_color = 12'hFF0;                        // Player 2: Yellow
        end
        
        // Cell 2 (Top Middle)
        else if (hPos > vLinePos1 + sqBorder && hPos < vLinePos2 - sqBorder &&
                 vPos > vBorder + sqBorder && vPos < hLinePos1 - sqBorder && Cells[2]) begin
            if (Color[1]) current_color = 12'hF00;
            else if (Cells[3] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 3 (Top Left)
        else if (hPos > vLinePos2 + sqBorder && hPos < (hRes - hBorder) - sqBorder &&
                 vPos > vBorder + sqBorder && vPos < hLinePos1 - sqBorder && Cells[4]) begin
            if (Color[2]) current_color = 12'hF00;
            else if (Cells[5] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 4 (Middle Right)
        else if (hPos > hBorder + sqBorder && hPos < vLinePos1 - sqBorder &&
                 vPos > hLinePos1 + sqBorder && vPos < hLinePos2 - sqBorder && Cells[6]) begin
            if (Color[3]) current_color = 12'hF00;
            else if (Cells[7] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 5 (Center)
        else if (hPos > vLinePos1 + sqBorder && hPos < vLinePos2 - sqBorder &&
                 vPos > hLinePos1 + sqBorder && vPos < hLinePos2 - sqBorder && Cells[8]) begin
            if (Color[4]) current_color = 12'hF00;
            else if (Cells[9] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 6 (Middle Left)
        else if (hPos > vLinePos2 + sqBorder && hPos < (hRes - hBorder) - sqBorder &&
                 vPos > hLinePos1 + sqBorder && vPos < hLinePos2 - sqBorder && Cells[10]) begin
            if (Color[5]) current_color = 12'hF00;
            else if (Cells[11] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 7 (Bottom Right)
        else if (hPos > hBorder + sqBorder && hPos < vLinePos1 - sqBorder &&
                 vPos > hLinePos2 + sqBorder && vPos < (vRes - vBorder) - sqBorder && Cells[12]) begin
            if (Color[6]) current_color = 12'hF00;
            else if (Cells[13] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 8 (Bottom Middle)
        else if (hPos > vLinePos1 + sqBorder && hPos < vLinePos2 - sqBorder &&
                 vPos > hLinePos2 + sqBorder && vPos < (vRes - vBorder) - sqBorder && Cells[14]) begin
            if (Color[7]) current_color = 12'hF00;
            else if (Cells[15] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
        
        // Cell 9 (Bottom Left)
        else if (hPos > vLinePos2 + sqBorder && hPos < (hRes - hBorder) - sqBorder &&
                 vPos > hLinePos2 + sqBorder && vPos < (vRes - vBorder) - sqBorder && Cells[16]) begin
            if (Color[8]) current_color = 12'hF00;
            else if (Cells[17] == 1'b0) current_color = 12'h0FF;
            else current_color = 12'hFF0;
        end
    end

    // Finally, output the color to the VGA port only if we are in the active video region
    assign rgb = video_on ? current_color : 12'h000;
    
endmodule