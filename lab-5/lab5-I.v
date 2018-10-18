module part1(SW, KEY, LEDR);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	// Assigning pretty lights
	assign LEDR[0] = SW[0];
	assign LEDR[1] = KEY[0];
	
	// Wires
	wire d, clk, q0, q1, q2;
	
	assign d = SW[0];
	assign clk = KEY[0];
	assign LEDR[9] = q0;
	assign LEDR[8] = q1;
	assign LEDR[7] = q2;
	
	// Storage elements
	gated_d_latch S0 (d, clk, q0);
	positive_d_flip_flop S1 (d, clk, q1);
	negative_d_flip_flop S2 (d, clk, q2);
endmodule

module gated_d_latch(d, clk, q);
	// Assigning inputs and outputs
	input d, clk;
	output reg q;
	
	// Wires
	wire r, s, q_bar;
	
	// Logic
	always @(d, clk)
		begin
			if (clk == 1'b1)
				q = d;
		end
endmodule

module positive_d_flip_flop(d, clk, q);
	// Assigning inputs and outputs
	input d, clk;
	output reg q;
	
	// Logic
	always @(posedge clk)
		q = d;
endmodule

module negative_d_flip_flop(d, clk, q);
	// Assigning inputs and outputs
	input d, clk;
	output reg q;
	
	// Logic
	always @(negedge clk)
		q = d;
endmodule
