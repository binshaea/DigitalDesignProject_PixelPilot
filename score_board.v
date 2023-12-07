`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/20/2023 12:37:05 PM
// Design Name:
// Module Name: multidigit
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
module score_board (
 input clk, // Clock input (assumes a 60Hz clock)
 input rst, // Reset input (active low)
 input play,
 input [3:0] dig0, // 4-bit input for digit 0
 input [3:0] dig1, // 4-bit input for digit 1
 input [3:0] dig2, // 4-bit input for digit 2
 input [3:0] dig3, // 4-bit input for digit 3
 input [3:0] dig4, // 4-bit input for digit 4
 input [3:0] dig5, // 4-bit input for digit 5
 input [3:0] dig6, // 4-bit input for digit 6
 input [3:0] dig7, // 4-bit input for digit 7
 output a, // Segment a
 output b, // Segment b
 output c, // Segment c
 output d, // Segment d
 output e, // Segment e
 output f, // Segment f
 output g, // Segment g
 //output reg
 output reg [7:0] an // Anodes for each digit (active low)
);
reg [2:0] counter = 3'b0; // Counter for cycling through digits
reg [3:0] num; // Temporary variable to store the digit value
// Seven-segment module instantiation
seven_segment sevseg (
 .num(num), // Use the temporary variable for sevenseg
 .a(a),
 .b(b),
 .c(c),
 .d(d),
 .e(e),
 .f(f),
 .g(g)
);
always @(posedge clk) begin
 if (rst ) begin
 counter <= 0;
 an <= 0;
 end
 else if (play)
 counter <= counter + 1;
end

always @(dig1) begin
 // State machine to cycle through the digits
//if (play) begin 
  //  counter <= counter + 1; 
     case (counter)
     3'b000: begin
     an <= 8'b11111110; // Enable digit 0 (active low)
     num <= dig0; // Store dig0 in the temporary variable
     end
     3'b001: begin
     an <= 8'b11111101; // Enable digit 1 (active low)
     num <= dig1; // Store dig1 in the temporary variable
     end
     3'b010: begin
     an <= 8'b11111011; // Enable digit 2 (active low)
     num <= dig2; // Store dig2 in the temporary variable
     end
     3'b011: begin
     an <= 8'b11110111; // Enable digit 3 (active low)
     num <= dig3; // Store dig3 in the temporary variable
     end
     3'b100: begin
     an <= 8'b11101111; // Enable digit 4 (active low)
     num <= dig4; // Store dig4 in the temporary variable
     end
     3'b101: begin
     an <= 8'b11011111; // Enable digit 5 (active low)
     num <= dig5; // Store dig5 in the temporary variable
     end
     3'b110: begin
     an <= 8'b10111111; // Enable digit 6 (active low)
     num <= dig6; // Store dig6 in the temporary variable
     end
     3'b111: begin
     an <= 8'b01111111; // Enable digit 7 (active low)
     num <= dig7; // Store dig7 in the temporary variable
     end
      default: begin
     an <= 8'b00000000; //1111111; // Enable digit 7 (active low)
     num <= dig7; // Store dig7 in the temporary variable
     end
     endcase
    end
//end
endmodule