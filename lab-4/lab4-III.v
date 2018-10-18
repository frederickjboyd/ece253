module part3(SW, LEDR);
	// Assigning inputs and outputs
	input [9:0] SW;
	output [9:0] LEDR;
	
	// Wires
	wire s0, s1, s2, s3, c_out; // Sum output
	wire c1, c2, c3; // Carry-overs
	wire [3:0] A, B; // Numbers to add
	wire c_in; // Carry-in
	
	// Assigning numbers to add
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign c_in = SW[8];
	
	// Assigning lights to display sum
	assign LEDR[0] = s0;
	assign LEDR[1] = s1;
	assign LEDR[2] = s2;
	assign LEDR[3] = s3;
	assign LEDR[4] = c_out;
	
	// Combining 4 fullAdders
	fullAdder A0 (A[0], B[0], c_in, s0, c1);
	fullAdder A1 (A[1], B[1], c1, s1, c2);
	fullAdder A2 (A[2], B[2], c2, s2, c3);
	fullAdder A3 (A[3], B[3], c3, s3, c_out);
endmodule

module fullAdder(a, b, ci, s, co);
	// Assigning inputs
	input a, b, ci;
	output s, co;
	
	// Logic
	assign s = a ^ b ^ ci;
	assign co = (a & b) | (a & ci) | (b & ci);
endmodule
