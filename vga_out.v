`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 08:01:38 AM
// Design Name: 
// Module Name: vga_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_out(
    input clk,
    input [3:0] blue, green, red,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output  hsync,
    output  vsync,
    output  [10:0] curr_x, [9:0] curr_y
);

    reg [10:0] hcount = 11'd0;
    reg [9:0] vcount = 10'd0;
    reg [10:0] xcurr = 11'd0;
    reg [9:0] ycurr = 10'd0;
  
 /*   reg [3:0] pix_red;
    reg [3:0] pix_green;
    reg [3:0] pix_blue;*/


    always @(posedge clk) begin
           
            
            hcount <= hcount + 1;
            if (hcount == 1679) begin
                hcount <= 0;
                vcount <= vcount + 1;
                
                if (vcount == 827)
                    vcount <= 0;
                    
            end

    end

   
    
    //implementation for visible pixel counter
    
   
    always @(posedge clk) begin
        if (((hcount >= 336) && (hcount <= 1615)) && ((vcount >= 27) && (vcount <= 826))) begin
            xcurr <= hcount- 336 ;
            ycurr <= vcount- 27 ;
            if (xcurr == 1279)
                xcurr <= 0;             
            if (ycurr == 799)

                ycurr <= 0;
                    
        end 
 
    end
    
    
     // Use assign statements to set hsync and vsync
    assign hsync = (hcount >= 0) && (hcount <= 135) ? 1'b0 : 1'b1;
    assign vsync = (vcount >= 0) && (vcount <= 2) ? 1'b1 : 1'b0;
    
 /*   always @ (posedge clk)
    begin
        if ((hcount >=336 && hcount <=1615) && (vcount >=27 && vcount <=826))
            begin
                pix_red <= red;
                pix_green <= green;
                pix_blue <= blue;
            end
            else
            begin
                pix_red <= 0;
                pix_green <= 0;
                pix_blue <= 0;
            end    
      end*/
    
    // Use assign statements to set pixel values based on the visible region
    assign pix_r = ((hcount >= 336) && (hcount <= 1615)) && ((vcount >= 27) && (vcount <= 826)) ? red : 4'b0000;
    assign pix_g = ((hcount >= 336) && (hcount <= 1615)) && ((vcount >= 27) && (vcount <= 826)) ? green : 4'b0000;
    assign pix_b = ((hcount >= 336) && (hcount <= 1615)) && ((vcount >= 27) && (vcount <= 826)) ? blue : 4'b0000;
    
   
     assign curr_x = xcurr;
     assign curr_y = ycurr;
     


endmodule