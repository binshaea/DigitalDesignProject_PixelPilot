`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2023 10:52:35 AM
// Design Name: 
// Module Name: goodie_collection
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


module goodie_collection( input clk, //game_start,
                          input[10:0] blkpos_x,
                          input [9:0] blkpos_y,
                          input play,
                          input game_start, //new
                          
                          input [10:0] goodie_pos_x1,
                          input [9:0] goodie_pos_y1,
                          input [10:0] goodie_pos_x2,
                          input [9:0] goodie_pos_y2,                          
                          input [10:0] goodie_pos_x3,
                          input [9:0] goodie_pos_y3,
                          input [10:0] goodie_pos_x4,
                          input [9:0] goodie_pos_y4,
                          input [10:0] goodie_pos_x5,
                          input [9:0] goodie_pos_y5,
                          input [10:0] goodie_pos_x6,
                          input [9:0] goodie_pos_y6,
                          input [10:0] goodie_pos_x7,
                          input [9:0] goodie_pos_y7,
                          input [10:0] goodie_pos_x8,
                          input [9:0] goodie_pos_y8,
                          input [10:0] goodie_pos_x9,
                          input [9:0] goodie_pos_y9,
                          //input [10:0] goodie_pos_x10,
                          //input [9:0] goodie_pos_y10,
                          
                          //output [3:0] max_score,
                          output [3:0] score,
                          
                          //output [8:0] collection_state,
                          //output sig_goodie_0
                          output reg sig_goodie_1,
                output reg sig_goodie_2,
                output reg sig_goodie_3,
                output reg sig_goodie_4,
                output reg sig_goodie_5,
                output reg sig_goodie_6,
                output reg sig_goodie_7,
                output reg sig_goodie_8,
                output reg sig_goodie_9
                          //output reg collision_detected
    );
  
   
    parameter maximum_score = 9;
/*module goodie_collection( input collision_detected,
                          output reg [3:0] score*/
// wire goodie_collision1, goodie_collision2, goodie_collision3, goodie_collision4, goodie_collision5, goodie_collision6, goodie_collision7; 
//wire goodie_collision8, goodie_collision9, goodie_collision10;                                                                                                     
        reg [3:0] game_score = 0;
        reg [8:0] goodie_state = 9'b0; // state 0 is not collected, state 1 is collected
                  reg sig0 = 1'b0; 
                                               
wire goodie_collision1, goodie_collision2, goodie_collision3, goodie_collision4, goodie_collision5;
wire goodie_collision6, goodie_collision7, goodie_collision8, goodie_collision9 ; //goodie_collision10;                      

collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d1(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x1), .pipe_y(goodie_pos_y1),.collision(goodie_collision1));  
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d2(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x2), .pipe_y(goodie_pos_y2),.collision(goodie_collision2));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d3(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x3), .pipe_y(goodie_pos_y3),.collision(goodie_collision3));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d4(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x4), .pipe_y(goodie_pos_y4),.collision(goodie_collision4));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d5(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x5), .pipe_y(goodie_pos_y5),.collision(goodie_collision5));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d6(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x6), .pipe_y(goodie_pos_y6),.collision(goodie_collision6));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d7(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x7), .pipe_y(goodie_pos_y7),.collision(goodie_collision7));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d8(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x8), .pipe_y(goodie_pos_y8),.collision(goodie_collision8));    
collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d9(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x9), .pipe_y(goodie_pos_y9),.collision(goodie_collision9));    
//collision_detector #(.OBSTACLE_WIDTH(20), .OBSTACLE_HEIGHT(20)) d10(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .pipe_x(goodie_pos_x10), .pipe_y(goodie_pos_y10),.collision(goodie_collision10));    
  
 //assign score = (goodie_collision1 || goodie_collision2 || goodie_collision3 || goodie_collision4 || goodie_collision5 || goodie_collision6 ||
  //                   goodie_collision7 || goodie_collision8)? (score+1):score;
  /* always @(posedge clk)
   begin
    if(game_start) 
        game_score <= 0;
    else if (play && game_score <= maximum_score) begin
           if (sig_goodie_1 || sig_goodie_2 || sig_goodie_3 || sig_goodie_4 || sig_goodie_5 || sig_goodie_6 ||
                sig_goodie_7 || sig_goodie_8)
                game_score <= game_score + 1;
           else
                game_score <= game_score;
    end
   end*/
   
    always @(posedge clk) 
    begin
        if(game_start) 
        begin
            game_score <= 0; 
            //goodie_state <= 9'b0;
            //sig0 <= 1'b0;
            sig_goodie_1 =0;
            sig_goodie_2= 0;
            sig_goodie_3=0;
            sig_goodie_4=0;
            sig_goodie_5=0;
            sig_goodie_6=0;
            sig_goodie_7=0;
            sig_goodie_8=0;
            sig_goodie_9=0;
        end
        else if (play)  
        begin
            if(goodie_collision1 && sig_goodie_1 == 0) 
            begin
                //goodie_state[0] <= 1'b1;
                sig_goodie_1 <= 1'b1;
                game_score <= game_score + 1;
            end
            else if(goodie_collision2 && sig_goodie_2 == 0) //sig_goodie_2 == 0) 
            begin
                sig_goodie_2 <= 1'b1; //goodie_state[1] <= 1'b1;
                game_score <= game_score + 1; 
            end
            else if(goodie_collision3 && sig_goodie_3 == 0) 
            begin
                sig_goodie_3 <= 1'b1;//goodie_state[2] <= 1'b1;
                game_score <= game_score + 1; 
            end
            else if(goodie_collision4 && sig_goodie_4 == 0) 
            begin
                sig_goodie_4 <= 1'b1; //goodie_state[3] <= 1'b1;
                game_score <= game_score + 1; 
             end
            else if(goodie_collision5 && sig_goodie_5 == 0) 
            begin
                sig_goodie_5 <= 1'b1; //goodie_state[4] <= 1'b1;
                game_score <= game_score + 1; 
           end
            else if(goodie_collision6 && sig_goodie_6 == 0) 
            begin
                sig_goodie_6 <= 1'b1;//goodie_state[5] <= 1'b1;
                game_score <= game_score + 1; 
         end
            else if(goodie_collision7 && sig_goodie_7 == 0) 
            begin
                sig_goodie_7 <= 1'b1;//goodie_state[6] <= 1'b1;
                game_score <= game_score + 1; 
        end
            else if(goodie_collision8 && sig_goodie_8 == 0) 
            begin
                sig_goodie_8 <= 1'b1;//goodie_state[7] <= 1'b1;
                game_score <= game_score + 1; 
         end
            else if(goodie_collision9 && sig_goodie_9 == 0) 
            begin
                sig_goodie_9 <= 1'b1;//goodie_state[8] <= 1'b1;
                game_score <= game_score + 1; 
         end
            /*else
            begin
                game_score <= game_score;  //added
                goodie_state <= goodie_state;
            end */
            end
        end

    
    assign score = game_score;
    assign collection_state = goodie_state;
    assign sig_goodie_0 = sig0;
    
endmodule