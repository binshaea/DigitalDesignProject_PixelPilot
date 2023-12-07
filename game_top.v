`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 11:35:28 AM
// Design Name: 
// Module Name: game_top
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
 module game_top ( input clk, 
                    input reset, // which is basically the center button 
                    input btn_up, 
                    input btn_down, 
                    input btn_left, 
                    input btn_right, 
                    input start,
                    output hsync,
                    output vsync,
                    output [3:0] pix_r,
                    output [3:0] pix_g,
                    output [3:0] pix_b,
                    output coll,    //collision display for obstacles
                    output [7:0] an, //for scoreboard display
                    output score_board_a,
                    output score_board_b,
                    output score_board_c,
                    output score_board_d,
                    output score_board_e,
                    output score_board_f,
                    output score_board_g
                     );
 

//Parameters

parameter screen_width = 1279; parameter screen_height = 799;
parameter welcome_width = 200 ; parameter welcome_height = 133 ;
parameter gameover_image_width = 360; parameter gameover_image_height = 360;
parameter win_image_width = 300; parameter win_image_height = 168;
parameter player_bg_image_width = 200; //368; 
parameter player_bg_image_height = 113; //207;

//wire declaration

wire [3:0] game_score;
wire pixclk; reg slower_clk = 0; reg [20:0] slow_clk_counter=0;
wire [3:0] red ; wire [3:0] blue ; wire [3:0] green ; wire [10:0] curr_x; wire [9:0] curr_y;
wire collision; 

//Interconnecting wires for dracon, goodies, pipes, fsm

wire [8:0] c_state_goodie;
wire sig0;
wire collision1;

//Pipe wire Declarations

wire [10:0] pipe_x1; wire [9:0] pipe_y1;
wire [10:0] pipe_x2; wire [9:0] pipe_y2;
wire [10:0] pipe_x3; wire [9:0] pipe_y3;
wire [10:0] pipe_x4; wire [9:0] pipe_y4;
wire [10:0] pipe_x5; wire [9:0] pipe_y5;
wire [10:0] pipe_xa; wire [9:0] pipe_ya;
wire [10:0] pipe_xb; wire [9:0] pipe_yb;
wire [10:0] pipe_xc; wire [9:0] pipe_yc;
wire [10:0] pipe_xd; wire [9:0] pipe_yd;
wire [10:0] pipe_xe; wire [9:0] pipe_ye;

//Goodie wire declarations

wire [10:0] goodie_x1; wire [9:0] goodie_y1;
wire [10:0] goodie_x2; wire [9:0] goodie_y2;
wire [10:0] goodie_x3; wire [9:0] goodie_y3;
wire [10:0] goodie_x4; wire [9:0] goodie_y4;
wire [10:0] goodie_x5; wire [9:0] goodie_y5;
wire [10:0] goodie_x6; wire [9:0] goodie_y6;
wire [10:0] goodie_x7; wire [9:0] goodie_y7;
wire [10:0] goodie_x8; wire [9:0] goodie_y8;
wire [10:0] goodie_x9; wire [9:0] goodie_y9;
//wire [10:0] goodie_x10; wire [9:0] goodie_y10;

//Spirits Declarations

//generating welcome screen 
wire [14:0] welcome_addra;
wire [11:0] welcome_douta;
wire [10:0] X;
wire [9:0] Y;

//generating spirit for gameover screen
wire [16:0] gameover_addra;     // Assuming 17bit address
wire [11:0] gameover_douta;     // Assuming 12-bit data
wire [10:0] X_1;
wire [9:0] Y_1;

//generating spirit for win screen display
wire [16:0] win_addra;
wire [11:0] win_douta;
wire [10:0] X_2;
wire [9:0] Y_2;

//generating spirit for player_bg screen display
wire [16:0] player_bg_addra;
wire [11:0] player_bg_douta;
wire [10:0] X_4;
wire [9:0] Y_4;

//reg declarations
reg Idel,play,win,lose;
reg [10:0] blkpos_x=200; reg [9:0] blkpos_y=210;
parameter max_score = 8; 
reg initalize=0;

//Combinational statments

assign coll = collision;

 //Spirits Generation part -------- 

//Gameover Screen

assign X_1 = curr_x*(gameover_image_width-1)/screen_width;
assign Y_1 = curr_y*(gameover_image_height-1)/screen_height;     
//assign addra = Y*image_width + X;  //USE this formula if .coe file is flattened as row by row
assign gameover_addra = X_1* gameover_image_height + Y_1;  //USE this formula if .coe file is flattened as column by column

gameover_display gameover(.clka(pixclk),.addra(gameover_addra),.douta(gameover_douta));  //.ena(collision)


//Welcome Screen

assign X = curr_x*(welcome_width-1)/screen_width;
assign Y = curr_y*(welcome_height-1)/screen_height;
assign welcome_addra = X* welcome_height + Y;  //USE this formula if .coe file is flattened as column by column

welcome_display your_instance_name (.clka(pixclk), .addra(welcome_addra), .douta(welcome_douta)  );

//Winning Screen
assign X_2 = curr_x*(win_image_width-1)/screen_width;
assign Y_2 = curr_y*(win_image_height-1)/screen_height;
          
//assign addra = Y*image_width + X;  //USE this formula if .coe file is flattened as row by row
assign win_addra = X_2* win_image_height + Y_2;  //USE this formula if .coe file is flattened as column by column

win_display winning(.clka(pixclk),.addra(win_addra),.douta(win_douta));  //.ena(collision)

//Player Background Screen
assign X_4 = curr_x*(player_bg_image_width-1)/screen_width;
assign Y_4 = curr_y*(player_bg_image_height-1)/screen_height;
          
//assign addra = Y*image_width + X;  //USE this formula if .coe file is flattened as row by row
assign player_bg_addra = X_4* win_image_height + Y_4;  //USE this formula if .coe file is flattened as column by column

player_background player_bg(.clka(pixclk),.addra(player_bg_addra),.douta(player_bg_douta));  //.ena(collision)

//Clock generation
always @(posedge pixclk) 
begin 
    slow_clk_counter <= slow_clk_counter + 1;
    if (slow_clk_counter==21'd834600) 
    begin
        slow_clk_counter<=0;
        slower_clk <= ~slower_clk;
    end
end

//Clock generation
//wire pixclk; 
reg scoreboard_clk = 0; reg [1:0] scoreboard_clk_counter=0;

always @(posedge slower_clk) 
begin 
    scoreboard_clk_counter <= scoreboard_clk_counter + 1;
    if (scoreboard_clk_counter==2'b10) //1669200) //834600) 
    begin
        scoreboard_clk_counter<=0;
        scoreboard_clk <= ~scoreboard_clk;
    end
end
/////////////////////////////////////////////////////////


//generating spirit of main chatacter
wire [10:0] character_addra;
wire [11:0] character_douta;
parameter character_width = 47; parameter character_height = 32;
//  //normilisation 
wire [10:0] X_5;
wire [9:0] Y_5;
assign X_5 = blkpos_x*(character_width-1)/screen_width;
assign Y_5 = blkpos_y*(character_height-1)/screen_height;
          
assign character_addra = X_5* character_height + Y_5;  //USE this formula if .coe file is flattened as column by column
player_block char(.clka(slower_clk),.addra(character_addra),.douta(character_douta));


wire sig_goodie_1, sig_goodie_2, sig_goodie_3, sig_goodie_4, sig_goodie_5, sig_goodie_6, sig_goodie_7, sig_goodie_8, sig_goodie_9;
//DRAWCON MODULE
drawcon draw1( .Idel(Idel),.play(play),.win(win),.lose(lose),
              .pipe_pos_x1(pipe_x1), .pipe_pos_y1(pipe_y1), 
              .pipe_pos_x2(pipe_x2), .pipe_pos_y2(pipe_y2), 
              .pipe_pos_x3(pipe_x3), .pipe_pos_y3(pipe_y3),
              .pipe_pos_x4(pipe_x4), .pipe_pos_y4(pipe_y4), 
              .pipe_pos_x5(pipe_x5), .pipe_pos_y5(pipe_y5),              
              .pipe_pos_xa(pipe_xa), .pipe_pos_ya(pipe_ya),
              .pipe_pos_xb(pipe_xb), .pipe_pos_yb(pipe_yb),
              .pipe_pos_xc(pipe_xc), .pipe_pos_yc(pipe_yc),
              .pipe_pos_xd(pipe_xd), .pipe_pos_yd(pipe_yd),
              .pipe_pos_xe(pipe_xe), .pipe_pos_ye(pipe_ye),
              
              .welcome_rgb(welcome_douta), //welcome screen
              .collide_rgb(gameover_douta), //game_over screen
              .winning_rgb(win_douta), //Winning screen
              .player_bg_rgb(player_bg_douta), //player background screen
              .collision(collision), //pipe collision
    
              .goodie_pos_x1(goodie_x1), .goodie_pos_y1(goodie_y1), 
              .goodie_pos_x2(goodie_x2), .goodie_pos_y2(goodie_y2), 
              .goodie_pos_x3(goodie_x3), .goodie_pos_y3(goodie_y3), 
              .goodie_pos_x4(goodie_x4), .goodie_pos_y4(goodie_y4), 
              .goodie_pos_x5(goodie_x5), .goodie_pos_y5(goodie_y5), 
              .goodie_pos_x6(goodie_x6), .goodie_pos_y6(goodie_y6), 
              .goodie_pos_x7(goodie_x7), .goodie_pos_y7(goodie_y7), 
              .goodie_pos_x8(goodie_x8), .goodie_pos_y8(goodie_y8), 
              .goodie_pos_x9(goodie_x9), .goodie_pos_y9(goodie_y9), 
              //.goodie_pos_x10(goodie_x10), .goodie_pos_y10(goodie_y10), 
                
              //.goodie_collection(c_state_goodie), //goodie collision
              //.sig_goodie_0(sig0),
              .sig_goodie_1(sig_goodie_1), .sig_goodie_2(sig_goodie_2), .sig_goodie_3(sig_goodie_3), .sig_goodie_4(sig_goodie_4),
              .sig_goodie_8(sig_goodie_8), .sig_goodie_7(sig_goodie_7), .sig_goodie_6(sig_goodie_6), .sig_goodie_5(sig_goodie_5),
              .sig_goodie_9(sig_goodie_9),
              
              .blkpos_x(blkpos_x), .blkpos_y(blkpos_y), 
              .blk_rgb(character_douta),
              .draw_x(curr_x), .draw_y(curr_y), 
              .r(red), .g(green), .b(blue));

//VGA MODULE
vga_out vgaout(.clk(pixclk),.blue(blue),.green(green),.red(red), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), 
               .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));


//PIPE COLLISION MODULES
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30) ) collide1 (
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_x1),
        .pipe_y(pipe_y1),
        .collision(collision1)
    ); 
wire collisiona;
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collidea (
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_xa),
        .pipe_y(pipe_ya),
        .collision(collisiona)
    );  
wire collision2;
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collide2(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_x2),
        .pipe_y(pipe_y2),
        .collision(collision2)
    );  
wire collisionb;
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collideb(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_xb),
        .pipe_y(pipe_yb),
        .collision(collisionb)
    );
wire collisoin3;    
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collide3(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_x3),
        .pipe_y(pipe_y3),
        .collision(collision3)
    );  
wire collisoinc;    
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collidec(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_xc),
        .pipe_y(pipe_yc),
        .collision(collisionc)
    );  
wire collision4;  
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collide4(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_x4),
        .pipe_y(pipe_y4),
        .collision(collision4)
    );  
wire collisoind;    
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collided(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_xd),
        .pipe_y(pipe_yd),
        .collision(collisiond)
    );  
wire collision5;    
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collide5(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_x5),
        .pipe_y(pipe_y5),
        .collision(collision5)
    );  
wire collisoine;    
collision_detector #( .OBSTACLE_WIDTH(100), .OBSTACLE_HEIGHT(30)) collidee(
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .pipe_x(pipe_xe),
        .pipe_y(pipe_ye),
        .collision(collisione)
    );  
 
 ///COLLISION DECTECTION LOGIC
reg coll_detected=0;
always @* begin
    
    if(coll_detected == 0 && (collision1 || collision2 || collision3 || collision4 || 
        collision5 || collisiona || collisionb || collisionc || collisiond || collisione))begin
        coll_detected = 1;
        //if (~(collision1 || collision2 || collision3 || collision4 || collision5 || collisiona || collisionb || collisionc || collisiond || collisione))
          //   coll_detected = 1;
        end
end

assign collision = coll_detected;  

////Score board and goodie collection LOGIC

//assign collision = collision1 || collision2 || collision3 || collision4 || collision5 || collisiona || collisionb|| collisionc || collisiond || collisione;
   wire [3:0] dig0, dig2, dig3, dig4, dig5, dig6, dig7;
   //wire score_board_a, score_board_b, score_board_c, score_board_d, score_board_e, score_board_f, score_board_g; // score_board_an;
  // wire rst;
   
   //SCOREBOARD
    score_board s1 (.clk(scoreboard_clk), .rst(reset), .play(play),                                                                                   
                       .dig0(game_score), .dig1(game_score), .dig2(game_score), .dig3(game_score),                       
                       .dig4(game_score), .dig5(game_score), .dig6(game_score), .dig7(game_score),                                                                      
                       .a(score_board_a), .b(score_board_b), .c(score_board_c), .d(score_board_d), .e(score_board_e), .f(score_board_f),        
                       .g(score_board_g), .an(an)); 
    
  /*  wire [10:0] goodie_x;
    wire [9:0] goodie_y;
    wire goodie_collision;
    
  goodie_collision_detection #(OBSTACLE_WIDTH(100), OBSTACLE_HEIGHT(30) ) gd1 (
        .blkpos_x(blkpos_x),
        .blkpos_y(blkpos_y),
        .goodie_x(goodie_x),
        .goodie_y(goodie_y),
        .goodie_collision(goodie_collision) 
    );   */              
  //GOOODIE COLLECTION               
 goodie_collection gc1( 
                          .clk(slower_clk), //game_start,
                          .play(play),
                          .blkpos_x(blkpos_x),
                          .blkpos_y(blkpos_y),
                          .game_start(reset),
                          .goodie_pos_x1(goodie_x1), .goodie_pos_y1(goodie_y1),
                          .goodie_pos_x2(goodie_x2), .goodie_pos_y2(goodie_y2),
                          .goodie_pos_x3(goodie_x3), .goodie_pos_y3(goodie_y3),
                          .goodie_pos_x4(goodie_x4), .goodie_pos_y4(goodie_y4),
                          .goodie_pos_x5(goodie_x5), .goodie_pos_y5(goodie_y5),
                          .goodie_pos_x6(goodie_x6), .goodie_pos_y6(goodie_y6),
                          .goodie_pos_x7(goodie_x7), .goodie_pos_y7(goodie_y7),
                          .goodie_pos_x8(goodie_x8), .goodie_pos_y8(goodie_y8),
                          .goodie_pos_x9(goodie_x9), .goodie_pos_y9(goodie_y9),
                         // .goodie_pos_x10(goodie_x10), .goodie_pos_y10(goodie_y10),
                          //.collection_state(c_state_goodie), .sig_goodie_0(sig0), 
                          .sig_goodie_1(sig_goodie_1), .sig_goodie_2(sig_goodie_2), .sig_goodie_3(sig_goodie_3), .sig_goodie_4(sig_goodie_4),
                            .sig_goodie_8(sig_goodie_8), .sig_goodie_7(sig_goodie_7), .sig_goodie_6(sig_goodie_6), .sig_goodie_5(sig_goodie_5),
                             .sig_goodie_9(sig_goodie_9), .score(game_score));
                     
//GOODIE GENERATION    
goodie #( .Initial_Goodie_X(350), .Initial_Goodie_Y(200), .Goodie_Vel(1000)) goodie_inst_a(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x1),
.goodie_y(goodie_y1));

goodie #( .Initial_Goodie_X(450), .Initial_Goodie_Y(300), .Goodie_Vel(1000)) goodie_inst1(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x2),
.goodie_y(goodie_y2));

goodie #( .Initial_Goodie_X(550), .Initial_Goodie_Y(400), .Goodie_Vel(1000)) goodie_inst2(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x3),
.goodie_y(goodie_y3));

goodie #( .Initial_Goodie_X(650), .Initial_Goodie_Y(380), .Goodie_Vel(1000)) goodie_inst3(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x4),
.goodie_y(goodie_y4));

goodie #( .Initial_Goodie_X(750), .Initial_Goodie_Y(560), .Goodie_Vel(1000)) goodie_inst4(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x5),
.goodie_y(goodie_y5));

goodie #( .Initial_Goodie_X(850), .Initial_Goodie_Y(490), .Goodie_Vel(1000)) goodie_inst5(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x6),
.goodie_y(goodie_y6));

goodie #( .Initial_Goodie_X(950), .Initial_Goodie_Y(637), .Goodie_Vel(1000)) goodie_inst6(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x7),
.goodie_y(goodie_y7));

goodie #( .Initial_Goodie_X(1050), .Initial_Goodie_Y(555), .Goodie_Vel(1000)) goodie_inst7(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x8),
.goodie_y(goodie_y8));

goodie #( .Initial_Goodie_X(1150), .Initial_Goodie_Y(710), .Goodie_Vel(1000)) goodie_inst8(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x9),
.goodie_y(goodie_y9));

goodie #( .Initial_Goodie_X(1200), .Initial_Goodie_Y(598), .Goodie_Vel(1000)) goodie_inst9(
.clk(slower_clk),
.initialize(initalize),
.goodie_x(goodie_x10),
.goodie_y(goodie_y10));
/////////////////////////////////////////////////////////

//PIPE GENERATION     
 pipe #(.Initial_pipe_X(400), .Initial_pipe_Y(200), .PIPE_VEL(1000)) pipe_inst1(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_x1),
    .pipe_y(pipe_y1)
  );
  
 pipe #(.Initial_pipe_X(450), .Initial_pipe_Y(300), .PIPE_VEL(20000)) pipe_inst2(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_x2),
    .pipe_y(pipe_y2)
  );  

 pipe #(.Initial_pipe_X(500), .Initial_pipe_Y(400), .PIPE_VEL(3000)) pipe_inst3(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_x3),
    .pipe_y(pipe_y3)
  );  
  
 pipe #(.Initial_pipe_X(650), .Initial_pipe_Y(520), .PIPE_VEL(4000)) pipe_inst4(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_x4),
    .pipe_y(pipe_y4)
  );  

 pipe #(.Initial_pipe_X(800), .Initial_pipe_Y(620), .PIPE_VEL(5000)) pipe_inst5(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_x5),
    .pipe_y(pipe_y5)
  ); 
  //pipes another
   pipe #(.Initial_pipe_X(950), .Initial_pipe_Y(750), .PIPE_VEL(6000)) pipe_insta(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_xa),
    .pipe_y(pipe_ya)
  );
  
 pipe #(.Initial_pipe_X(1100), .Initial_pipe_Y(630), .PIPE_VEL(7000)) pipe_instb(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_xb),
    .pipe_y(pipe_yb)
  );  

 pipe #(.Initial_pipe_X(1280), .Initial_pipe_Y(510), .PIPE_VEL(8000)) pipe_instc(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_xc),
    .pipe_y(pipe_yc)
  );  
  
 pipe #(.Initial_pipe_X(1200), .Initial_pipe_Y(450), .PIPE_VEL(9000)) pipe_instd(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_xd),
    .pipe_y(pipe_yd)
  );  

 pipe #(.Initial_pipe_X(1280), .Initial_pipe_Y(320), .PIPE_VEL(10000)) pipe_inste(
    .clk(slower_clk),
    .initalize(initalize),
    .pipe_x(pipe_xe),
    .pipe_y(pipe_ye)
  ); 

//83.46MHZ CLOCK INSTANTIATION
clk_wiz_0 inst
  (
  // Clock out ports  
  .clk_out1(pixclk),
 // Clock in ports
  .clk_in1(clk)
  );

//PLAYER GENERATION 
always @(posedge slower_clk)
begin
    if(initalize)begin
        blkpos_x <= 100; 
        blkpos_y <= 110; 
    end 
    else 
    begin
        if      (btn_up && (blkpos_y-4 >= 10))      blkpos_y <= blkpos_y - 4; 
        else if (btn_down && (blkpos_y+4 <= 757))   blkpos_y <= blkpos_y + 4; 
        else if (btn_left && (blkpos_x-4 >= 10))    blkpos_x <= blkpos_x - 4; 
        else if (btn_right && (blkpos_x+4 <= 400))  blkpos_x <= blkpos_x + 4; 
    end   
end 

//FSM LOGIC

//State Encoding
parameter STATE_1 = 2'b00, // Idel Starting the game state 
          STATE_2 = 2'b01, // Playing the game
          STATE_3 = 2'b10, // Collision state "Game over"
          STATE_4 = 2'b11; // Winning state
             
//State reg declaration
reg [3:0] CurrentState;
reg [3:0] NextState;

always@(posedge slower_clk) begin
    if(reset)begin 
        CurrentState <= STATE_1;//STATE_Initial;
        end
    else 
        CurrentState <= NextState;
end

always@(*) begin
    case(CurrentState)

        STATE_1: begin //Idel State
            if (start) begin
                NextState = STATE_2;
                {play, win, Idel, lose} = 4'b1000;
            end
            else if (reset) begin 
                //reinitialize everything
                initalize = 1;
                //Keep in current state
                NextState = CurrentState;
                {play, win, Idel, lose} = 4'b0010;
            end
           /* else if (~reset) begin
                initalize = 0;
                NextState = CurrentState;
                {play, win, Idel, lose} = 4'b0010;
            end*/
            else begin 
                NextState = CurrentState;
                {play, win, Idel, lose} = 4'b0010;
            end
        end
        STATE_2: begin //Play state
            if(collision) 
            begin
                NextState = STATE_3;
                {play, win, Idel, lose} = 4'b0001;
            end
            else if(game_score == 9 ) //max_score)
            begin 
                NextState = STATE_4;
                {play, win, Idel, lose} = 4'b0100;
            end
            else 
              if (~start || (~ start && reset)) begin
                initalize = 1;
                NextState = STATE_1;
                {play, win, Idel, lose} = 4'b0010;
            end
            else if (reset) begin
                //reinitialize everything
                initalize = 1;
                //keep in current state (restart the game) 
                NextState = STATE_1;
                {play, win, Idel, lose} = 4'b0010;
            end 
             else if (~reset && start && game_score < 9)begin 
                initalize = 0;
                NextState = CurrentState;    
                {play, win, Idel, lose} = 4'b1000; 
              end
             else begin    
                NextState = CurrentState;    
                {play, win, Idel, lose} = 4'b1000;     
            end
            
        end
        STATE_3: begin
           // coll_detected = 1;
            if (reset && start) begin 
                //reinitialize everything
                initalize = 1;
//                coll_detected = 0;
                //keep in current state (restart the game) 
                NextState = STATE_2;
                {play, win, Idel, lose} = 4'b1000;
            end
            else if (~start || (~ start && reset)) begin
                initalize = 1;
//                coll_detected = 0;
                NextState = STATE_1;
                {play, win, Idel, lose} = 4'b0010;
            end
             if (reset) begin 
                initalize = 1; 
                NextState = STATE_1;    
                {play, win, Idel, lose} = 4'b0010;   
            end 
            else 
              begin    
                NextState = CurrentState;    
                {play, win, Idel, lose} = 4'b0001;     
            end
        end 
        STATE_4: begin
             if (reset) begin 
                //reinitialize everything
                initalize = 1;
                //keep in current state (restart the game) 
                NextState = STATE_1;
                {play, win, Idel, lose} = 4'b0010;
            end
             else if ( ~start || (~ start && reset)) begin
                initalize = 1;
                NextState = STATE_1;
                {play, win, Idel, lose} = 4'b0010;
            end
            else  if (~reset) begin 
                initalize = 0; 
                NextState = CurrentState;    
                {play, win, Idel, lose} = 4'b0100;   
            end 
            else
              begin    
                NextState = CurrentState;    
                {play, win, Idel, lose} = 4'b0100;     
            end
        end
        default:  NextState = CurrentState;
endcase

end
//Make sure the collision works with one pipe ----DONE
//Generalise it to all the pipes ----DONE
//handle the logic of the score
//Populate the states in the FSM S3 and S4  --- DONE
//Make sure to have a full reset to the game not only the block -- need to apply some initialization to the velocity also
//Gameover RAM thing -- Done Alhamdullah 
//Generalise the ROM memory blocks to also the main character of the game and goodie points -- keep in mind the max memory area that ROM can handel in total (use small images)

endmodule