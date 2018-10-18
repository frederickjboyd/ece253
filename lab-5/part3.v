module part3(SW, KEY, HEX0, HEX1);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [0:0] KEY;
	output [0:6] HEX0, HEX1;
	
	// Wires
	wire clk, enable, clear;
	wire [7:0] Q;
	
	// Assignments
	assign clk = KEY[0];
	assign enable = SW[1];
	assign clear = SW[0];
	
	// Logic
	flip_flop T0 (enable, clk, clear, Q[0]);
	flip_flop T1 ((enable & Q[0]), clk, clear, Q[1]);
	flip_flop T2 ((enable & Q[0] & Q[1]), clk, clear, Q[2]);
	flip_flop T3 ((enable & Q[0] & Q[1] & Q[2]), clk, clear, Q[3]);
	flip_flop T4 ((enable & Q[0] & Q[1] & Q[2] & Q[3]), clk, clear, Q[4]);
	flip_flop T5 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4]), clk, clear, Q[5]);
	flip_flop T6 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5]), clk, clear, Q[6]);
	flip_flop T7 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6]), clk, clear, Q[7]);
	
	dispHex H0 (Q[3:0], HEX0);
	dispHex H1 (Q[7:4], HEX1);
endmodule

module flip_flop(t, clk, clear, q);
	// Assigning inputs and outputs
	input t, clk, clear;
	output reg q;
	
	// Wires
	
	always @(posedge clk or negedge clear)
		if (~clear)
			q <= 1'b0;
		else if (t)
			q <= ~q;
endmodule

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
