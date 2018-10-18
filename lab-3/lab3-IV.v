module part4(SW, LEDR, HEX0);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0;
	
	wire c0, c1;

	// Assigning c0, c1 to switches
	assign c0 = SW[0];
	assign c1 = SW[1];

	// Adding pretty lights
	assign LEDR[0] = c0;
	assign LEDR[1] = c1;
	
	// Assigning output values
	assign HEX0[0] = ~c0 | c1;
	assign HEX0[1] = c0;
	assign HEX0[2] = c0;
	assign HEX0[3] = c1;
	assign HEX0[4] = c1;
	assign HEX0[5] = ~c0 | c1;
	assign HEX0[6] = c1;
endmodule
