`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2023 09:50:24 AM
// Design Name: 
// Module Name: collision_detector
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


module collision_detector #(parameter OBSTACLE_WIDTH = 100, OBSTACLE_HEIGHT = 30 ) 
    (
        input [10:0] blkpos_x,
        input [9:0] blkpos_y,
        input [10:0] pipe_x,
        input [9:0] pipe_y,

      
        output collision    
    );
    
parameter PLAYER_WIDTH = 32; // just Example width of the player entity
parameter PLAYER_HEIGHT = 32; // just Example height of the player entity
//parameter OBSTACLE_WIDTH = 100; // just Example width of an obstacle entity
//parameter OBSTACLE_HEIGHT = 30; // just Example height of an obstacle entity


assign collision = ((blkpos_x>=pipe_x && blkpos_x <= pipe_x + OBSTACLE_WIDTH && blkpos_y + PLAYER_HEIGHT >= pipe_y && blkpos_y + PLAYER_HEIGHT <= pipe_y + OBSTACLE_HEIGHT) ||
    (blkpos_x + PLAYER_WIDTH >= pipe_x && blkpos_x + PLAYER_WIDTH <= pipe_x + OBSTACLE_WIDTH && blkpos_y + PLAYER_HEIGHT >= pipe_y &&  blkpos_y + PLAYER_HEIGHT <= pipe_y + OBSTACLE_HEIGHT )||
    (blkpos_x >= pipe_x && blkpos_x<= pipe_x+ OBSTACLE_WIDTH && blkpos_y >= pipe_y && blkpos_y <= pipe_y + OBSTACLE_HEIGHT )||
     (blkpos_x + PLAYER_WIDTH >= pipe_x &&  blkpos_x + PLAYER_WIDTH <= pipe_x + OBSTACLE_WIDTH && blkpos_y >= pipe_y && blkpos_y <= pipe_y + OBSTACLE_HEIGHT ));


endmodule
