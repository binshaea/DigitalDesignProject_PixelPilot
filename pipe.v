`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2023 11:05:03 AM
// Design Name: 
// Module Name: pipe
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

module pipe #(parameter Initial_pipe_X = 500, Initial_pipe_Y = 400, PIPE_VEL = 10000)
              (input clk, input initalize,
//               input PIPE_VEL,
//               input  Initial_pipe_X,
//               input  Initial_pipe_Y,
               output  [10:0] pipe_x,
               output  [9:0] pipe_y);
               

//////Pipes
// Define initial values for pipe
//parameter initial_pipe_x = 500;
//parameter initial_pipe_y = 400;

//reg enable = 1;
reg [10:0] pipe_X = Initial_pipe_X;
reg [9:0] pipe_Y = Initial_pipe_Y;
// Velocity logic
reg [9:0] pipe_counter = 0;
reg [2:0] pipe_veloc = 0;

//        wire [10:0] pipe_x1;
//        wire [9:0] pipe_x2;
        
    always @(posedge clk) begin
        if (initalize)begin 
           pipe_X <= Initial_pipe_X;
           pipe_Y <= Initial_pipe_Y;
           pipe_veloc = 0;
           pipe_counter = 0;
        end 
        else if(pipe_counter < PIPE_VEL) begin
            pipe_counter <= pipe_counter + 1;
            if(pipe_counter % (PIPE_VEL) == 0) ///5000) == 0)// && counter < MAX_COUNTER_VALUE) 
                pipe_veloc <= pipe_counter / 100;

            // Update pipe_x and pipe_y based on velocity
            pipe_X <= pipe_X - 4 ; //pipe_veloc;
            pipe_Y <= pipe_Y - pipe_veloc ; // 2;
            end
       
        else  begin
           pipe_veloc <= 0;
           pipe_counter <= 0;
           pipe_X <= Initial_pipe_X;
           pipe_Y <= Initial_pipe_Y;
       end
  end
  
  assign pipe_x = pipe_X;
  assign pipe_y = pipe_Y;
endmodule