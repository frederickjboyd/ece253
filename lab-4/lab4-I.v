module part1(SW, LEDR, HEX0, HEX1);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0;
	output [0:6] HEX1;
	
	wire s0, s1, s2, s3, s4, s5, s6, s7;
	wire c0, c1;
	
	// Assigning wires for inputs and outputs
	assign s0 = SW[0];
	assign s1 = SW[1];
	assign s2 = SW[2];
	assign s3 = SW[3];
	assign s4 = SW[4];
	assign s5 = SW[5];
	assign s6 = SW[6];
	assign s7 = SW[7];
	
	// Adding pretty lights
	assign LEDR[9:0] = SW[9:0];
	
	// Logic - HEX0
	assign HEX0[0] = (s0 & ~s1 & ~s2 & ~s3) | (~s0 & ~s1 & s2 & ~s3);
	assign HEX0[1] = s2 & (s0 ^ s1);
	assign HEX0[2] = ~s0 & s1 & ~s2 & ~s3;
	assign HEX0[3] = ~s3 & ((s0 & ~s1 & ~s2) | (~s0 & ~s1 & s2) | (s0 & s1 & s2));
	assign HEX0[4] = (s0 & ~s3) | (~s1 & s2 & ~s3) | (s0 & ~s1 & ~s2);
	assign HEX0[5] = ~s3 & ((s0 & ~s2) | (s0 & s1) | (s1 & ~s2));
	assign HEX0[6] = ~s3 & ((~s1 & ~s2) | (s0 & s1 & s2));
	
	// Logic - HEX1
	assign HEX1[0] = (s0 & ~s1 & ~s2 & ~s3) | (~s0 & ~s1 & s2 & ~s3);
	assign HEX1[1] = s2 & (s0 ^ s1);
	assign HEX1[2] = ~s0 & s1 & ~s2 & ~s3;
	assign HEX1[3] = ~s3 & ((s0 & ~s1 & ~s2) | (~s0 & ~s1 & s2) | (s0 & s1 & s2));
	assign HEX1[4] = (s0 & ~s3) | (~s1 & s2 & ~s3) | (s0 & ~s1 & ~s2);
	assign HEX1[5] = ~s3 & ((s0 & ~s2) | (s0 & s1) | (s1 & ~s2));
	assign HEX1[6] = ~s3 & ((~s1 & ~s2) | (s0 & s1 & s2));
endmodule
