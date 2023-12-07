`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Elham Binshaflout
// 
// Create Date: 10/27/2023 08:02:17 AM
// Design Name: 
// Module Name: vga_out_tb
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


module vga_out_tb();

wire hsync, vsync;
wire [3:0] pix_r, pix_g, pix_b;

wire [10:0] curr_x;
wire [9:0] curr_y;

reg [3:0] red=2; reg [3:0] green=5; reg [3:0] blue = 6;
reg clk;

vga_out uut (.clk(clk),.red(red),.green(green),.blue(blue),.pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b),
 .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));



   initial begin
      clk = 0;
      
      #10 clk = 1'b1;

      // Monitor VGA signals and counters
      monitor();

      // Finish the simulation
      #5000000 $finish ;
   end


  // Monitor VGA signals and counters
task monitor;
begin
    $display("Time   HSYNC  VSYNC  PIX_R  PIX_G  PIX_B    CURR_X  CURR_Y");
    $display("------------------------------------------------------------");
    while (1) begin
        #10;
        $display("%0t  %b   %b   %b   %b   %b  %h   %h", $time, hsync, vsync, pix_r, pix_g, pix_b, curr_x, curr_y);
    end
end
endtask


   // Clock generation (50 MHz)
   always begin
      #2.5 clk = ~clk;
   end

endmodule