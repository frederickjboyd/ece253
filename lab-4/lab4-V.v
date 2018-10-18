module part5(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	// Assigning inputs and outputs
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX3, HEX5;
	
	// Wires
	wire [3:0] A, B;
	wire c_in;
	wire [4:0] sum;
	wire z;
	reg [3:0] z0, c1;
	wire [0:6] s0, s1;
	wire err;
	
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign c_in = SW[8];
	
	assign sum = A + B  + c_in;
	comparator C0 (sum, z);
	
	// LEDs
	assign LEDR[8:0] = SW[8:0];
	
	always @(z or z0 or c1)
	begin
		if (z == 1) begin
			z0 = 4'b1010;
			c1 = 4'b0001;
		end
		else begin
			z0 = 4'b0000;
			c1 = 4'b0000;
		end
	end
	
	assign s0 = sum - z0;
	assign s1 = c1;
	
	disp_7seg_old H0 (s0, HEX0);
	disp_7seg_old H1 (s1, HEX1);
	disp_7seg_old H5 (A, HEX5);
	disp_7seg_old H3 (B, HEX3);
	
	// Displaying error LED
	error ERR0 (sum, err);
	assign LEDR[9] = err;
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

module comparator(V, z);
	// Assigning inputs and outputs
	input [4:0] V;
	output z;
	
	// Logic
	assign z = V[4] | (V[3] & (V[2] | V[1]));
endmodule

module error(V, err);
	input [4:0] V;
	output err;
	
	wire err_temp;
	
	assign err_temp = ~V[4] | (V[4] & ~V[3] & ~V[2]);
	assign err = ~err_temp;
endmodule
