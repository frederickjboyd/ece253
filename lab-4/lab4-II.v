module part2(SW, LEDR, HEX0, HEX1);
	// Assigning inputs and outputs
	input [3:0] SW;
	output [3:0] LEDR;
	output [0:6] HEX0;
	output [0:6] HEX1;
	
	// Adding pretty lights
	assign LEDR[3:0] = SW[3:0];
	
	// Wires
	wire z;
	wire [3:0] M0, A, V;
	
	assign V = SW[3:0];
	
	// Throwing everything together
	comparator C0 (V, z);
	circuitA A0 (V, A);
	mux_4bit_2to1 U0 (z, V, A, M0);
	disp_7seg H0 (M0, HEX0);
	dispTens H1 (z, HEX1);
endmodule

module comparator(V, z);
	// Assigning inputs and outputs
	input [3:0] V;
	output z;
	
	// Logic
	assign z = (V[3] & V[2]) | (V[3] & V[1]);
endmodule

module mux_4bit_2to1(s, V, A, M);
	// Assigning inputs and outputs
	input s;
	input [3:0] V, A;
	output [3:0] M;
	
	// Logic
	assign M = s ? A : V;
endmodule

module circuitA(V, A);
	// Assigning inputs and outputs
	input [3:0] V;
	output [3:0] A;
	
	// Logic
	assign A[3] = 1'b0;
	assign A[2] = V[3] & V[2] & V[1];
	assign A[1] = V[3] & V[2] & ~V[1];
	assign A[0] = (V[0] & V[3]) & (V[2] | V[1]);
endmodule

module disp_7seg(M, disp);
	// Assigning inputs and outputs
	input [3:0] M;
	output [0:6] disp;
	
	wire s0, s1, s2, s3;
	
	// Assigning wires for inputs and outputs
	assign s0 = M[0];
	assign s1 = M[1];
	assign s2 = M[2];
	assign s3 = M[3];
	
	// Logic
	assign disp[0] = (s0 & ~s1 & ~s2 & ~s3) | (~s0 & ~s1 & s2 & ~s3);
	assign disp[1] = s2 & (s0 ^ s1);
	assign disp[2] = ~s0 & s1 & ~s2 & ~s3;
	assign disp[3] = ~s3 & ((s0 & ~s1 & ~s2) | (~s0 & ~s1 & s2) | (s0 & s1 & s2));
	assign disp[4] = (s0 & ~s3) | (~s1 & s2 & ~s3) | (s0 & ~s1 & ~s2);
	assign disp[5] = ~s3 & ((s0 & ~s2) | (s0 & s1) | (s1 & ~s2));
	assign disp[6] = ~s3 & ((~s1 & ~s2) | (s0 & s1 & s2));
endmodule

module dispTens(z, disp);
	// Assigning inputs and outputs
	input z;
	output [0:6] disp;
	
	// Logic
	assign disp[0] = z;
	assign disp[1] = 1'b0;
	assign disp[2] = 1'b0;
	assign disp[3] = z;
	assign disp[4] = z;
	assign disp[5] = z;
	assign disp[6] = 1'b1;
endmodule
