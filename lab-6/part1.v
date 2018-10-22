module part1(SW, KEY, LEDR);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	
	// Wires and registers
	wire w, z, reset, clk;
	wire [8:0] state, state_next;
	
	// Setting parameters
	parameter A = 9'b000000001;
	parameter B = 9'b000000010;
	parameter C = 9'b000000100;
	parameter D = 9'b000001000;
	parameter E = 9'b000010000;
	parameter F = 9'b000100000;
	parameter G = 9'b001000000;
	parameter H = 9'b010000000;
	parameter I = 9'b100000000;
	
	// Assignments
	assign reset = SW[0];
	assign w = SW[1];
	assign clk = KEY[0];
	assign LEDR[8:0] = state;
	assign LEDR[9] = z;
	assign z = (state == E) | (state == I);
	
	// Logic
	assign state_next[0] = 1'b0;
	assign state_next[1] = ~w & (state[0] | state[5] | state[6] | state[7] | state[8]);
	assign state_next[2] = ~w & state[1];
	assign state_next[3] = ~w & state[2];
	assign state_next[4] = ~w & (state[3] | state[4]);
	assign state_next[5] = w & (state[0] | state[1] | state[2] | state[3] | state[4]);
	assign state_next[6] = w & state[5];
	assign state_next[7] = w & state[6];
	assign state_next[8] = w & (state[7] | state[8]);
	
	// Instantiating flip-flops
	positive_d_flip_flop F0 (state_next[0], clk, reset, 1'b1, state[0]);
	positive_d_flip_flop F1 (state_next[1], clk, reset, 1'b0, state[1]);
	positive_d_flip_flop F2 (state_next[2], clk, reset, 1'b0, state[2]);
	positive_d_flip_flop F3 (state_next[3], clk, reset, 1'b0, state[3]);
	positive_d_flip_flop F4 (state_next[4], clk, reset, 1'b0, state[4]);
	positive_d_flip_flop F5 (state_next[5], clk, reset, 1'b0, state[5]);
	positive_d_flip_flop F6 (state_next[6], clk, reset, 1'b0, state[6]);
	positive_d_flip_flop F7 (state_next[7], clk, reset, 1'b0, state[7]);
	positive_d_flip_flop F8 (state_next[8], clk, reset, 1'b0, state[8]);
endmodule

module positive_d_flip_flop(d, clk, reset, reset_val, q);
	// Assigning inputs and outputs
	input d, clk, reset, reset_val;
	output reg q;
	
	// Logic
	always @(posedge clk or negedge reset)
		if (~reset)
			q <= reset_val;
		else
			q <= d;
endmodule
