module part6(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0;
	output [0:6] HEX1;
	output [0:6] HEX2;
	output [0:6] HEX3;
	output [0:6] HEX4;
	output [0:6] HEX5;
	
	wire [1:0] M0, M1, M2, M3, M4, M5;
	
//	mux_2bit_6to1 U0 (SW[9:7], 3, 3, 3, SW[5:4], SW[3:2], SW[1:0], M0);
//	mux_2bit_6to1 U1 (SW[9:7], SW[1:0], 3, 3, 3, SW[5:4], SW[3:2], M1);
//	mux_2bit_6to1 U2 (SW[9:7], SW[3:2], SW[1:0], 3, 3, 3, SW[5:4], M2);
//	mux_2bit_6to1 U3 (SW[9:7], SW[5:4], SW[3:2], SW[1:0], 3, 3, 3, M3);
//	mux_2bit_6to1 U4 (SW[9:7], 3, SW[5:4], SW[3:2], SW[1:0], 3, 3, M4);
//	mux_2bit_6to1 U5 (SW[9:7], 3, 3, SW[5:4], SW[3:2], SW[1:0], 3, M5);
	mux_2bit_6to1 U0 (SW[9:7], SW[1:0], 3, 3, 3, SW[5:4], SW[3:2], M0);
	mux_2bit_6to1 U1 (SW[9:7], SW[3:2], SW[1:0], 3, 3, 3, SW[5:4], M1);
	mux_2bit_6to1 U2 (SW[9:7], SW[5:4], SW[3:2], SW[1:0], 3, 3, 3, M2);
	mux_2bit_6to1 U3 (SW[9:7], 3, SW[5:4], SW[3:2], SW[1:0], 3, 3, M3);
	mux_2bit_6to1 U4 (SW[9:7], 3, 3, SW[5:4], SW[3:2], SW[1:0], 3, M4);
	mux_2bit_6to1 U5 (SW[9:7], 3, 3, 3, SW[5:4], SW[3:2], SW[1:0], M5);
	// 7-segment decoders
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
	char_7seg H3 (M3, HEX3);
	char_7seg H4 (M4, HEX4);
	char_7seg H5 (M5, HEX5);
endmodule

//module mux_2bit_3to1(S, U, V, W, M);
//	// Assigning inputs and outputs
//	input [1:0] S, U, V, W;
//	output [1:0] M;
//	
//	// Logic
//	assign M = (S[1] ? W : (S[0] ? V : U));
//endmodule

module mux_2bit_6to1(S, A, B, C, D, E, F, M);
	// Assigning inputs and outputs
	input [1:0] A, B, C, D, E, F;
	input [2:0] S;
	output [1:0] M;
	
	// Logic
	assign M = S[2] ? (S[0] ? F : E) : (S[1] ? (S[0] ? D : C) : (S[0] ? B : A));
//	assign M = ~S[2] ? 0 : (S[0] ? F : E);
//	assign M = ~S[1] ? 0 : (S[0] ? D : C);
//	assign M = (S[2] | S[1]) ? 0 : (S[0] ? B : A);
endmodule

module char_7seg(C, display);
	// Assigning inputs and outputs
	input [1:0] C;
	output [0:6] display;
	
	assign display[0] = C[0] | ~C[1];
	assign display[1] = C[1];
	assign display[2] = C[1];
	assign display[3] = C[0];
	assign display[4] = C[0];
	assign display[5] = C[0] | ~C[1];
	assign display[6] = C[0];
endmodule
