`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/20/2023 12:37:05 PM
// Design Name:
// Module Name: sevenseg
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
module seven_segment (
 input [3:0] num, // 4-bit input
 output reg a, // Segment a
 output reg b, // Segment b
 output reg c, // Segment c
 output reg d, // Segment d
 output reg e, // Segment e
 output reg f, // Segment f
 output reg g // Segment g
);
// Define 7-segment patterns for numbers 0-9 and hex letters A-F
always @ (num) begin
 case (num)
 4'b0000: {a, b, c, d, e, f, g} = 7'b0000001; // 0 : Active Low
 4'b0001: {a, b, c, d, e, f, g} = 7'b1001111; // 1 : Active Low
 4'b0010: {a, b, c, d, e, f, g} = 7'b0010010; // 2 : Active Low
 4'b0011: {a, b, c, d, e, f, g} = 7'b0000110; // 3 : Active Low
 4'b0100: {a, b, c, d, e, f, g} = 7'b1001100; // 4 : Active Low
 4'b0101: {a, b, c, d, e, f, g} = 7'b0100100; // 5 : Active Low
 4'b0110: {a, b, c, d, e, f, g} = 7'b0100000; // 6 : Active Low
 4'b0111: {a, b, c, d, e, f, g} = 7'b0001111; // 7 : Active Low
 4'b1000: {a, b, c, d, e, f, g} = 7'b0000000; // 8 : Active Low
 4'b1001: {a, b, c, d, e, f, g} = 7'b0000100; // 9 : Active Low
 /*4'b1010: {a, b, c, d, e, f, g} = 7'b0001000; // A : Active Low
 4'b1011: {a, b, c, d, e, f, g} = 7'b1100000; // b : Lowercase b is displayed because 8 and uppercase B activates the same patterns. AL
 4'b1100: {a, b, c, d, e, f, g} = 7'b0110001; // C : Active Low
 4'b1101: {a, b, c, d, e, f, g} = 7'b1000010; // D : Lowercase d is displayed because 0 and uppercase D activates the same patterns. AL
 4'b1110: {a, b, c, d, e, f, g} = 7'b0110000; // E : Active Low
 4'b1111: {a, b, c, d, e, f, g} = 7'b0111000; // F : Active Low*/
 default: {a, b, c, d, e, f, g} = 7'b1111111; // Display nothing for other inputs
 endcase
end
endmodule