module part2(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [1:0] KEY;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	// Wires and registers
	wire clk, reset;
	reg [8:0] sum;
	reg [7:0] A, B;
	reg b_active;
	
	// Logic
	assign reset = KEY[0];
	assign clk = KEY[1];
	always @(negedge reset, posedge clk)
		if (~reset)
			begin
				A <= 0;
				B <= 0;
				sum <= 0;
				b_active <= 0;
			end
		else
			begin
				if (b_active)
					begin
						B = SW[7:0];
					end
				else
					begin
						A = SW[7:0];
						b_active = 1;
					end
				sum = A + B;
			end
	
	// Displaying outputs
	dispHex H0 (A[3:0], HEX0);
	dispHex H1 (A[7:4], HEX1);
	dispHex H2 (B[3:0], HEX2);
	dispHex H3 (B[7:4], HEX3);
	dispHex H4 (sum[3:0], HEX4);
	dispHex H5 (sum[7:4], HEX5);
	assign LEDR[0] = sum[8];
endmodule

module dispHex(num, disp);
	// Assigning inputs and outputs
	input [3:0]num;
	output [0:6]disp;
	
	// Logic
	assign disp[0] = ~num[3]&~num[2]&~num[1] | num[3]&num[2]&~num[1]&~num[0] | ~num[3]&num[2]&num[1]&num[0];
	assign disp[1] = num[3]&num[2]&~num[1]&~num[0] | ~num[3]&num[2]&~num[1]&num[0] | num[3]&num[1]&num[0] | num[2]&num[1]&~num[0];
	assign disp[2] = ~num[3]&~num[2]&num[1]&~num[0] | num[3]&num[2]&~num[1]&~num[0] | num[3]&num[2]&num[1];
	assign disp[3] = ~num[3]&num[2]&~num[1]&~num[0] | ~num[2]&~num[1]&num[0] | num[2]&num[1]&num[0] | num[3]&~num[2]&num[1]&~num[0];
	assign disp[4] = ~num[3]&num[0] | ~num[3]&num[2]&~num[1] | ~num[2]&~num[1]&num[0];
	assign disp[5] = num[3]&num[2]&~num[1]&num[0] | ~num[3]&~num[2]&num[0] | ~num[3]&num[1]&num[0] | ~num[3]&~num[2]&num[1];
	assign disp[6] = ~num[3]&num[2]&~num[1]&~num[0] | ~num[3]&~num[2]&~num[1]&num[0] | num[3]&num[2]&~num[1]&num[0] | num[3]&~num[2]&num[1]&num[0];
endmodule
