module part2(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [3:0] x;
	wire [3:0] y;
	wire [3:0] M;
	wire s;
	
	assign s = SW[9];
	assign x = SW[3:0];
	assign y = SW[7:4];
	assign M = s ? y : x;
	//assign LEDR[3] = M[3];
	//assign LEDR[2] = M[2];
	//assign LEDR[1] = M[1];
	//assign LEDR[0] = M[0];
	assign LEDR[3:0] = M;
	assign LEDR[9] = s;
endmodule
