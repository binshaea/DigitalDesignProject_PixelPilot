`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 11:36:23 AM
// Design Name: 
// Module Name: game_top_tb
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


module game_top_tb();

  // Inputs
  reg clk;
  reg up;
  reg down;
  reg left;
  reg right;
  reg reset;

  // Outputs
wire hsync;
wire vsync;
wire [3:0] pix_r;
wire [3:0] pix_g;
wire [3:0] pix_b;
wire start;
wire coll;

  // Instantiate the module to be tested
  game_top dut (
    .clk(clk),
    .btn_up(up),
    .btn_down(down),
    .btn_left(left),
    .btn_right(right),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .pix_r(pix_r),
    .pix_g(pix_g),
    .pix_b(pix_b),
    .start(start),
    .coll(coll)
 
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Test scenario
  initial begin
    // Initialize inputs
    clk = 0;
    up = 0;
    down = 0;
    left = 0;
    right = 0;
    reset = 0;




    #16666680 up = 1;
    #30666680 up = 1;
    #30666680 up = 0;
    #30666680 left = 1;
    #30666680 left = 0;
    #30666680 right = 1;
    #30666680 right = 0;
    #30666680 reset = 1;
    #30666680 reset = 0;
    #30666680 down = 1;
    #30666680 down = 0;
    // Wait for a few clock cycles
    /*#20

    // Simulate sprite movement
    up = 1;
    #20 up = 0;
    left = 1;
    #20 left = 0;
    down = 1;
    #20 down = 0;
    right = 1;
    #20 right = 0;
    center = 1;
    #30 center = 0;

    // Scenario 1: Normal sprite movement
    reset = 1;
    #10 reset = 0;
    #20 up = 1;
    #20 up = 0;
    #20 left = 1;
    #20 left = 0;
    #20 down = 1;
    #20 down = 0;
    #20 right = 1;
    #20 right = 0;
    
     // Scenario 2: Sprite reaches screen bounds
    reset = 1;
    #10 reset = 0;
    #20 up = 1;
    #40 down = 1;
    #40 left = 1;
    #40 right = 1;
    #40 up = 0;
    #40 down = 0;
    #40 left = 0;
    #40 right = 0;
    
    // Scenario 3: Continuous sprite movement
    reset = 1;
    #10 reset = 0;
    #20 up = 1;
    #40 down = 1;
    #40 left = 1;
    #40 right = 1;
    #40 up = 0;
    #40 down = 0;
    #40 left = 0;
    #40 right = 0;
    // Wait for simulation to finish
    #5000;

    $finish;*/
  end

endmodule

