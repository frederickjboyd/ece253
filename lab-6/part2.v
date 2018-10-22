module part2(SW, KEY, LEDR);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	
	// Wires and registers
	wire w, z, reset, clk;
	reg [3:0] y_Q, y_D; // y_Q is current state, y_D is next state
	
	// Setting parameters
	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter C = 4'b0010;
	parameter D = 4'b0011;
	parameter E = 4'b0100;
	parameter F = 4'b0101;
	parameter G = 4'b0110;
	parameter H = 4'b0111;
	parameter I = 4'b1000;
	
	// Assignments
	assign reset = SW[0];
	assign w = SW[1];
	assign clk = KEY[0];
	assign LEDR[3:0] = y_Q;
	assign LEDR[9] = z;
	assign z = (y_Q == E) | (y_Q == I);
	
	// Logic
	always @(w, y_Q)
		case (y_Q)
			A: if (~w) y_D <= B; else y_D <= F;
			B: if (~w) y_D <= C; else y_D <= F;
			C: if (~w) y_D <= D; else y_D <= F;
			D: if (~w) y_D <= E; else y_D <= F;
			E: if (~w) y_D <= E; else y_D <= F;
			F: if (~w) y_D <= B; else y_D <= G;
			G: if (~w) y_D <= B; else y_D <= H;
			H: if (~w) y_D <= B; else y_D <= I;
			I: if (~w) y_D <= B; else y_D <= I;
			default: y_D <= 4'dx;
		endcase
	
	always @(posedge clk or negedge reset)
		if (~reset)
			y_Q <= A;
		else
			y_Q <= y_D;
endmodule
