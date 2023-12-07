`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 07:37:40 PM
// Design Name: 
// Module Name: drawcon
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


module drawcon( input Idel, play, win,lose,
                input [10:0] blkpos_x, 
                input [9:0] blkpos_y,
                
                input [11:0] blk_rgb,
                input [11:0]welcome_rgb,
                input [11:0]winning_rgb,
                input [11:0]player_bg_rgb,
                
                //collision detetctor
                input  [11:0] collide_rgb,     // Assuming 8-bit data
                input collision,
                //pipe1
                input [10:0] pipe_pos_x1,
                input [9:0] pipe_pos_y1,
                //pipe2
                input [10:0] pipe_pos_x2,
                input [9:0] pipe_pos_y2,
                 //pipe3
                input [10:0] pipe_pos_x3,
                input [9:0] pipe_pos_y3,                 
                //pipe4
                input [10:0] pipe_pos_x4,
                input [9:0] pipe_pos_y4,                 
                //pipe5
                input [10:0] pipe_pos_x5,
                input [9:0] pipe_pos_y5,
                //pipes another
                //pipe1
                input [10:0] pipe_pos_xa,
                input [9:0] pipe_pos_ya,
                //pipe2
                input [10:0] pipe_pos_xb,
                input [9:0] pipe_pos_yb,
                 //pipe3
                input [10:0] pipe_pos_xc,
                input [9:0] pipe_pos_yc,                 
                //pipe4
                input [10:0] pipe_pos_xd,
                input [9:0] pipe_pos_yd,                 
                //pipe5
                input [10:0] pipe_pos_xe,
                input [9:0] pipe_pos_ye,
                //goodie
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
                               // input [10:0] goodie_pos_x10,
                //input [9:0] goodie_pos_y10,
                
                //input [8:0] goodie_collection,
                //input sig_goodie_0,
                input sig_goodie_1,
                input sig_goodie_2,
                input sig_goodie_3,
                input sig_goodie_4,
                input sig_goodie_5,
                input sig_goodie_6,
                input sig_goodie_7,
                input sig_goodie_8,
                input sig_goodie_9,
                //vga
                input [10:0] draw_x, 
                input [9:0] draw_y, 
                output [3:0] r,
                 output  [3:0] g,
                  output  [3:0] b );


reg [3:0] bg_r; reg [3:0] bg_g; reg [3:0] bg_b;
 
 reg [3:0] r_reg;
 reg [3:0] g_reg;
 reg [3:0] b_reg;

reg [10:0] pipe_fx = 100;
reg [9:0] pipe_hf = 30;

reg [3:0] pipe_r = 4'b0101;
reg [3:0] pipe_g = 4'b0110; //1;
reg [3:0]  pipe_b = 4'b0000;

//reg [10:0] pipe_fx = 30;
//reg [9:0] pipe_hf = 100;
reg [3:0] gd_r = 4'b1011; //111;
reg [3:0] gd_g = 4'b0110; //100;
reg [3:0] gd_b = 4'b1001; //010;

//after collision
reg [3:0] c_gd_r = 4'b0000; //1011; //111;
reg [3:0] c_gd_g = 4'b0000; //0110; //100;
reg [3:0] c_gd_b = 4'b0000; //1001; //010;

reg [3:0] blk_r=4'b1101;//111;
 reg [3:0] blk_g=4'b1010;
  reg [3:0] blk_b=4'b1101;

    // Thorns color
    reg [3:0] player_b_r = 4'b1111; //1101;
    reg [3:0] player_b_g = 4'b1111; //0011;
    reg [3:0] player_b_b = 4'b1111; //1001;
    
    //reg [3:0] thorn_r1 = 4'b1111; //1001;
    //reg [3:0] thorn_g1 = 4'b1111; //0001;
    //reg [3:0] thorn_b1 = 4'b1111;//1011;


always @(*) 
begin 
        
              if ((draw_y >=0 && draw_y<10) || (draw_y>789 && draw_y<=799) || (draw_x>=0 && draw_x<10) || (draw_x>1269 && draw_x<=1279))
                begin 
                bg_r = 4'b0111; //000; //1111; 
                bg_g = 4'b0101; //1111; 
                bg_b = 4'b1001; //1111; 
                end 
               else
                begin 
                    bg_r = player_bg_rgb[11:8]; //4'b1011; //0000; // Background color here 
                    bg_g = player_bg_rgb[7:4]; //4'b0001; // Background color here 
                    bg_b = player_bg_rgb[3:0]; //4'b1001; // Background color here end
                   
                end
        

end



always @* begin
     if(Idel) begin 
//        r_reg = 4'b0000;  // Black color here 
//        g_reg = 4'b0000; // Black color here 
//        b_reg = 4'b0000; 
        r_reg = welcome_rgb[11:8];  // Black color here 
        g_reg = welcome_rgb[7:4]; // Black color here 
        b_reg = welcome_rgb[3:0];
        
        end 
        else
    if (lose) begin
            r_reg = collide_rgb[11:8];
            g_reg = collide_rgb[7:4];
            b_reg = collide_rgb[3:0];

     end
        else
    if (win) begin
            r_reg = winning_rgb[11:8]; //4'b1101; //winning_rgb[11:8];
            g_reg = winning_rgb[7:4]; //4'b1101; //winning_rgb[7:4];
            b_reg = winning_rgb[3:0]; //4'b1101; //winning_rgb[3:0];
     end
    else if (play) begin 
     if (draw_x >= blkpos_x && draw_x <= (blkpos_x + 32) && draw_y >= blkpos_y && draw_y <= (blkpos_y + 32)) 
        begin 
            r_reg= blk_r; //blk_rgb[11:8]; //blk_r; // Bright color here 
            g_reg= blk_g; //blk_rgb[7:4]; //blk_g; // Bright color here 
            b_reg= blk_b; //blk_rgb[3:0]; //blk_b; // Bright color here

//            r_reg= blk_rgb[11:8]; // Bright color here 
//            g_reg=blk_rgb[7:4]; // Bright color here 
//            b_reg=blk_rgb[3:0];
        end
      
     
     else begin
             if ((draw_x >= pipe_pos_x1 && draw_x <= (pipe_pos_x1 + pipe_fx)) && (draw_y >= pipe_pos_y1 && draw_y <= pipe_pos_y1 + pipe_hf)) begin
               // if ((draw_x >= pipe_pos_x1 && draw_x <= (pipe_pos_x1 + (pipe_fx/2))) && (draw_x >= (pipe_pos_x1 + (pipe_fx/2))) && 
                 //   (draw_x <= (pipe_pos_x1 + pipe_fx)) && (draw_y >= pipe_pos_y1 && draw_y <= pipe_pos_y1 + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
              else  if ((draw_x >= pipe_pos_x2 && draw_x <= (pipe_pos_x2 + pipe_fx)) && (draw_y >= pipe_pos_y2 && draw_y <= pipe_pos_y2 + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_x3 && draw_x <= (pipe_pos_x3 + pipe_fx)) && (draw_y >= pipe_pos_y3 && draw_y <= pipe_pos_y3 + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_x4 && draw_x <= (pipe_pos_x4 + pipe_fx)) && (draw_y >= pipe_pos_y4 && draw_y <= pipe_pos_y4 + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_x5 && draw_x <= (pipe_pos_x5 + pipe_fx)) && (draw_y >= pipe_pos_y5 && draw_y <= pipe_pos_y5 + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b; end
               ///////////////////////////////////////
               else  if ((draw_x >= pipe_pos_xa && draw_x <= (pipe_pos_xa + pipe_fx)) && (draw_y >= pipe_pos_ya && draw_y <= pipe_pos_ya + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_xb && draw_x <= (pipe_pos_xb + pipe_fx)) && (draw_y >= pipe_pos_yb && draw_y <= pipe_pos_yb + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_xc && draw_x <= (pipe_pos_xc + pipe_fx)) && (draw_y >= pipe_pos_yc && draw_y <= pipe_pos_yc + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_xd && draw_x <= (pipe_pos_xd + pipe_fx)) && (draw_y >= pipe_pos_yd && draw_y <= pipe_pos_yd + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b;
                end
               else  if ((draw_x >= pipe_pos_xe && draw_x <= (pipe_pos_xe + pipe_fx)) && (draw_y >= pipe_pos_ye && draw_y <= pipe_pos_ye + pipe_hf)) begin
                    r_reg = pipe_r ;
                    g_reg= pipe_g;
                    b_reg= pipe_b; end
                    ///////////////////////////////////////////////////
               else if (draw_x >= goodie_pos_x1 && draw_x <= (goodie_pos_x1 + 20) && draw_y >= goodie_pos_y1 && draw_y <= (goodie_pos_y1 + 20)) 
                begin 
                    r_reg= sig_goodie_1? c_gd_r : gd_r; // Bright color here 
                    g_reg= sig_goodie_1? c_gd_g : gd_g; // Bright color here 
                    b_reg= sig_goodie_1? c_gd_b : gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x2 && draw_x <= (goodie_pos_x2 + 20) && draw_y >= goodie_pos_y2 && draw_y <= (goodie_pos_y2 + 20)) 
                begin 
                    r_reg= sig_goodie_2? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_2? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_2? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x3 && draw_x <= (goodie_pos_x3 + 20) && draw_y >= goodie_pos_y3 && draw_y <= (goodie_pos_y3 + 20)) 
                begin 
                    r_reg= sig_goodie_3? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_3? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_3? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x4 && draw_x <= (goodie_pos_x4 + 20) && draw_y >= goodie_pos_y4 && draw_y <= (goodie_pos_y4 + 20)) 
                begin 
                    r_reg= sig_goodie_4? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_4? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_4? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x5 && draw_x <= (goodie_pos_x5 + 20) && draw_y >= goodie_pos_y5 && draw_y <= (goodie_pos_y5 + 20)) 
                begin 
                    r_reg= sig_goodie_5? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_5? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_5? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x6 && draw_x <= (goodie_pos_x6 + 20) && draw_y >= goodie_pos_y6 && draw_y <= (goodie_pos_y6 + 20)) 
                begin 
                    r_reg= sig_goodie_6? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_6? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_6? c_gd_b : gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x7 && draw_x <= (goodie_pos_x7 + 20) && draw_y >= goodie_pos_y7 && draw_y <= (goodie_pos_y7 + 20)) 
                begin 
                    r_reg= sig_goodie_7? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_7? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_7? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x8 && draw_x <= (goodie_pos_x8 + 20) && draw_y >= goodie_pos_y8 && draw_y <= (goodie_pos_y8 + 20)) 
                begin 
                    r_reg= sig_goodie_8? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_8? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_8? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                       else if (draw_x >= goodie_pos_x9 && draw_x <= (goodie_pos_x9 + 20) && draw_y >= goodie_pos_y9 && draw_y <= (goodie_pos_y9 + 20)) 
                begin 
                    r_reg= sig_goodie_9? c_gd_r: gd_r; // Bright color here 
                    g_reg= sig_goodie_9? c_gd_g: gd_g; // Bright color here 
                    b_reg= sig_goodie_9? c_gd_b: gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end
                  /*     else if (draw_x >= goodie_pos_x10 && draw_x <= (goodie_pos_x10 + 20) && draw_y >= goodie_pos_y10 && draw_y <= (goodie_pos_y10 + 20)) 
                begin 
                    r_reg= gd_r; // Bright color here 
                    g_reg= gd_g; // Bright color here 
                    b_reg= gd_b; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
                end*/
//                   else if (draw_x <= 0 && draw_x >= 400 && draw_y <= 0 && draw_y >= 757) 
//                  //else if (draw_x == blkpos_y1 && draw_y == blkpos_x1) // && draw_y <= (blkpos_y1 + 20)) 
//                begin 
//                    r_reg= 4'b1000; //000; // Bright color here 
//                    g_reg= 4'b1001; //011; // Bright color here 
//                    b_reg= 4'b1000; // Bright color here end else begin blk_r = 0; blk_g = 0; blk_b = 0; end end
//                end
                     else if (draw_x >= 435 && draw_x <= 450 && draw_y >= 10 && draw_y <= 790) begin
                            r_reg = player_b_r; 
                            g_reg = player_b_g; 
                            b_reg = player_b_b;
                            end
//                    else if (draw_x >= 15 && draw_x <= (40) && draw_y >= 15 && draw_y <= (75)) begin
//                 r_reg = thorn_r1; g_reg = thorn_g1; b_reg = thorn_b1;end
        ///////////////////////////////////
                else begin
                    r_reg= bg_r;  
                    g_reg=bg_g; 
                    b_reg=bg_b; 
                    
                end
        end 
      

   end

end

    assign {r, g, b} = {r_reg, g_reg, b_reg};

endmodule 