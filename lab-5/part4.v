module part4 (SW, KEY, HEX3, HEX2, HEX1, HEX0);
	// Assigning inputs and outputs
	input [1:0] SW;
	input [0:0] KEY;
	output [0:6] HEX3, HEX2, HEX1, HEX0;
	
	// Wires and regs
	wire enable, clk, clear; 
	reg [15:0] Q;
	
	// Logic
	assign clk = KEY[0];
	assign enable = SW[1];
	assign clear = SW[0];
	always @(posedge clk or negedge clear)
		if (~clear) // resetting the T_FF when the KEY0 is pressed
			Q <= 16'b0;
		else if (enable) // flipping when adding counter
			Q <= Q + 1;
	
	// Display bits on HEX
	dispHex D1 (Q[3:0], HEX0);
	dispHex D2 (Q[7:4], HEX1);
	dispHex D3 (Q[11:8], HEX2);
	dispHex D4 (Q[15:12], HEX3);
endmodule

//module part4(SW, KEY, HEX0, HEX1, HEX2, HEX3);
//	// Assigning inputs and outputs
//	input [9:0] SW;
//	input [0:0] KEY;
//	output [0:6] HEX0, HEX1, HEX2, HEX3;
//	
//	// Wires
//	wire clk, enable, clear;
//	wire [15:0] Q;
//	
//	// Assignments
//	assign clk = KEY[0];
//	assign enable = SW[1];
//	assign clear = SW[0];
//	
//	// Logic
//	counter c0 (clk, clear, Q);
//	
//	// Display output
//	dispHex H0 (Q[3:0], HEX0);
//	dispHex H1 (Q[7:4], HEX1);
//	dispHex H2 (Q[11:8], HEX2);
//	dispHex H3 (Q[15:12], HEX3);
//endmodule
//
//module counter(clk, clear, Q);
//	// Assigning inputs and outputs
//	input clk, clear;
//	output reg [15:0] Q;
//	
//	// Logic
//	always @(posedge clk or negedge clear)
//		if (clear)
//			Q <= 16'b0;
//		else
//			Q <= Q + 1;
//endmodule

module dispHex(s, disp);
	// Assigning inputs and outputs
	input [3:0] s;
	output [0:6] disp;
	
	// Logic
	assign disp[0]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]);
	assign disp[1]=(~s[3]& s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign disp[2]=(~s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign disp[3]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]& s[1]& s[0]);
	assign disp[4]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[0]);
	assign disp[5]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]);
	assign disp[6]=(~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | (~s[3]&~s[2]&~s[1]);
endmodule
