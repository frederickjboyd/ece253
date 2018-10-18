module part5(SW, LEDR, HEX0, HEX1, HEX2);
	// Assigning inputs and outputs
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0;
	output [0:6] HEX1;
	output [0:6] HEX2;
	
	// Wires to connect output of multiplexers to 7-segment decoder
	wire [1:0] M0;
	wire [1:0] M1;
	wire [1:0] M2;
	
	// Assigning pretty lights
	assign LEDR[9:0] = SW[9:0];
	
	// Logic
	// Multiplexers
	mux_2bit_3to1 U0 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M0);
	mux_2bit_3to1 U1 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M1);
	mux_2bit_3to1 U2 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M2);
	// 7-segment decoders
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
endmodule

module mux_2bit_3to1(S, U, V, W, M);
	// Assigning inputs and outputs
	input [1:0] S, U, V, W;
	output [1:0] M;
	
	// Logic
	assign M = (S[1] ? W : (S[0] ? V : U));
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

//	assign display[0] = C[1] | ~C[0];
//	assign display[1] = C[0];
//	assign display[2] = C[0];
//	assign display[3] = C[1];
//	assign display[4] = C[1];
//	assign display[5] = C[1] | ~C[0];
//	assign display[6] = C[1];
endmodule
