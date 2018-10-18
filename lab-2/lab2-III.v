module part3(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [1:0] U;
	wire [1:0] V;
	wire [1:0] W;
	wire [1:0] M;
	wire s0;
	wire s1;
	
	// Assigning switches
	assign U = SW[1:0];
	assign V = SW[3:2];
	assign W = SW[5:4];
	assign s0 = SW[8];
	assign s1 = SW[9];
	
	// Logic
	assign M = s1 ? W : (s0 ? V : U);
	
	// Output LEDs
	assign LEDR[8] = s0;
	assign LEDR[9] = s1;
	assign LEDR[0] = M[0];
	assign LEDR[1] = M[1];
endmodule
