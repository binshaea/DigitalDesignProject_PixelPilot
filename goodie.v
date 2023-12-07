`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2023 03:29:35 PM
// Design Name: 
// Module Name: goodie
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

module goodie #(parameter Initial_Goodie_X = 500, Initial_Goodie_Y = 400, Goodie_Vel = 10000)
              (input clk, 
               input initialize,
               output [10:0] goodie_x,
               output [9:0] goodie_y);
               
reg [10:0] goodie_X = Initial_Goodie_X;
reg [9:0] goodie_Y = Initial_Goodie_Y;
// Velocity logic
reg [9:0] g_counter = 0;
reg [2:0] g_veloc = 0;

        
    always @(posedge clk) begin
        if (initialize) begin 
           goodie_X <= Initial_Goodie_X;
           goodie_Y <= Initial_Goodie_Y;
           g_veloc = 0;
           g_counter = 0;
        end 
        else if(g_counter < Goodie_Vel) begin
            g_counter <= g_counter + 1;
            if(g_counter % (Goodie_Vel) == 0)// && counter < MAX_COUNTER_VALUE) 
                g_veloc <= g_counter / 100;
            
            else 
                g_veloc <= g_veloc;
            // Update pipe_x and pipe_y based on velocity
            goodie_X <= goodie_X - 5 ; //pipe_veloc;
            goodie_Y <= goodie_Y - g_veloc ; // 2;
            end
        else begin
            g_veloc <= 0;
           g_counter <= 0;
           goodie_X <= Initial_Goodie_X;
           goodie_Y <= Initial_Goodie_Y;
       end
  end
  
  assign goodie_x = goodie_X;
  assign goodie_y = goodie_Y;
  
  endmodule