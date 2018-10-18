module part4(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	// Assigning inputs and outputs
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX3, HEX5;
	
	// Wires
	wire s0, s1, s2, s3, c_out; // Sum output
	wire c1, c2, c3; // Carry-overs
	wire [3:0] A, B, c_in; // Numbers to add
	wire z; // sum > 9?
	wire [3:0] M0, X; // Multiplexer output, circuit "A"
	wire [4:0] V; // Sum binary output
	wire err; // Error out if sum > 19
	
	// Assigning numbers to add
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign c_in = SW[8];
	
	// Assigning lights to display sum
	assign LEDR[0] = V[0];
	assign LEDR[1] = V[1];
	assign LEDR[2] = V[2];
	assign LEDR[3] = V[3];
	assign LEDR[4] = V[4];
	
	// Combining 4 fullAdders
	fullAdder A0 (A[0], B[0], c_in, V[0], c1);
	fullAdder A1 (A[1], B[1], c1, V[1], c2);
	fullAdder A2 (A[2], B[2], c2, V[2], c3);
	fullAdder A3 (A[3], B[3], c3, V[3], V[4]);
	
	// Displaying answer
	comparator C0 (V, z);
	circuitA E0 (V, X);
	mux_5bit_2to1 U0 (z, V, X, M0);
	disp_7seg H0 (M0, HEX0);
	dispTens H1 (z, HEX1);
	disp_7seg_old H3 (B, HEX3);
	disp_7seg_old H5 (A, HEX5);
	
	// Displaying error LED
	error ERR0 (V, err);
	assign LEDR[9] = err;
endmodule

module comparator(V, z);
	// Assigning inputs and outputs
	input [4:0] V;
	output z;
	
	// Logic
	assign z = V[4] | (V[3] & (V[2] | V[1]));
	
//	assign z = (V[3] & V[2]) | (V[3] & V[1]);
endmodule

module error(V, err);
	input [4:0] V;
	output err;
	
	wire err_temp;
	
	assign err_temp = ~V[4] | (V[4] & ~V[3] & ~V[2]);
	assign err = ~err_temp;
endmodule

module mux_5bit_2to1(s, V, A, M);
	// Assigning inputs and outputs
	input s;
	input [4:0] V, A;
	output [4:0] M;
	
	// Logic
	assign M = s ? A : V;
endmodule

module circuitA(V, A);
	// Assigning inputs and outputs
	input [4:0] V;
	output [4:0] A;
	
	// Logic
	assign A[4] = 1'b0;
	assign A[3] = V[4] & V[1];
	assign A[2] = (V[4] & ~V[1]) | (V[3] & V[2] & V[1]);
	assign A[1] = (V[4] & ~V[1]) | (V[3] & V[2] & ~V[1]);
	assign A[0] = (V[4] & V[0]) | ((V[0] & V[3]) & (V[2] | V[1]));
	
//	assign A[3] = 1'b0;
//	assign A[2] = V[3] & V[2] & V[1];
//	assign A[1] = V[3] & V[2] & ~V[1];
//	assign A[0] = (V[0] & V[3]) & (V[2] | V[1]);
endmodule

module disp_7seg_old(M, disp);
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

module disp_7seg(M, disp);
	// Assigning inputs and outputs
	input [4:0] M;
	output [0:6] disp;
	
	wire s0, s1, s2, s3, s4;
	
	// Assigning wires for inputs and outputs
	assign s0 = M[0];
	assign s1 = M[1];
	assign s2 = M[2];
	assign s3 = M[3];
	assign s4 = M[4];
	
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

module fullAdder(a, b, ci, s, co);
	// Assigning inputs
	input a, b, ci;
	output s, co;
	
	// Logic
	assign s = a ^ b ^ ci;
	assign co = (a & b) | (a & ci) | (b & ci);
endmodule
