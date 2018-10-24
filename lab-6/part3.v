module part3(CLOCK_50, SW, KEY, LEDR);
	// Assigning inputs and outputs
	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [0:0] LEDR;
	
	// Wires and registers
	reg reset_cnt_main;
	wire [24:0] cnt_main;
	wire [2:0] S;
	wire reset, enable;
	wire E, ln, z, bit0, out;
	
	// Assignments
	assign S = SW[2:0];
	assign enable = KEY[1];
	assign reset = KEY[0];
	assign LEDR[0] = out;
	
	// Determining when to send reset signals
	always @(cnt_main)
		if (cnt_main == 25'b1011111010111100001000000) // 25 million
			reset_cnt_main <= 1'b1;
		else
			reset_cnt_main <= 1'b0;
	
	// Running counters
	counter_50 C0 (CLOCK_50, reset_cnt_main, cnt_main);
	
	// Tossing the salad together
	shiftReg(S, ln, reset_cnt_main, bit0, reset);
	morseLengthCounter(S, reset_cnt_main, reset, z);
	morseCode(KEY[1:0], z, bit0, reset_cnt_main, out, E, ln);
endmodule

module counter_50(clk, reset, Q);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [24:0] Q;
	
	// Logic
	always @(posedge clk)
		if (reset)
			Q <= 25'b0;
		else
			Q <= Q + 1;
endmodule

module shiftReg(s, ln, clk, bit0, reset);
	// Assigning inputs and outputs
	// E_a is equivalent 
	input ln, clk, reset;
	input [2:0] s;
	output bit0;
	
	// Parameters
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	parameter G = 3'b110;
	parameter H = 3'b111;
	
	// Wires and registers
	reg [0:3] d;
	wire [0:3] q;
	
	// Logic
	always @(s)
		case(s)
			A: d = 4'b0010;
			B: d = 4'b0001;
			C: d = 4'b0101;
			D: d = 4'b0001;
			E: d = 4'b0000;
			F: d = 4'b0100;
			G: d = 4'b0011;
			H: d = 4'b0000;
			default: d = 4'bxxxx;
		endcase
	
	// Multiplexers
	mux U0 (d[0], 1'b0, ln, clk, q[0], reset);
	mux U1 (d[1], q[0], ln, clk, q[1], reset);
	mux U2 (d[2], q[1], ln, clk, q[2], reset);
	mux U3 (d[3], q[2], ln, clk, q[3], reset);
	
	assign bit0 = q[3];
endmodule

module mux(d0, d1, s, clk, q, reset);
	// Assigning inputs and outputs
	input d0, d1, s, clk, reset;
	output reg q;
	
	// Wires
	wire d;
	
	// Assignments
	assign d = s ? d1 : d0;
	
	// Logic
	always @(posedge clk or negedge reset)
		if (~reset)
			q <= 1'b0;
		else
			q <= d;
endmodule

module morseLengthCounter(s, clk, reset, z);
	// Assigning inputs and outputs
	input [2:0] s;
	input clk, reset;
	output reg z;
	
	// Parameters
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	parameter G = 3'b110;
	parameter H = 3'b111;
	
	// Wires and registers
	reg [2:0] d, q;
	
	// Logic
	always @(s)
		case(s)
			A: d = 2;
			B: d = 4;
			C: d = 4;
			D: d = 3;
			E: d = 1;
			F: d = 4;
			G: d = 3;
			H: d = 4;
		endcase
	
	always @(posedge clk or negedge reset)
	begin
		z = (q == d);
		if (~reset)
			q <= 3'b0;
		else
			q <= q + 1;
	end
endmodule

module morseCode(k, z, bit0, half_counter, out, E, ln);
	// Assigning inputs and outputs
	input [1:0] k;
	input z, bit0, half_counter;
	output out, E, ln;
	
	// Wires and registers
	wire enable, reset;
	reg [2:0] y, Y;
	
	// Assignments
	assign enable = k[1];
	assign reset = k[0];
	
	// Parameters for FSM
	parameter idle  = 3'b000;
	parameter load = 3'b001;
	parameter dot1 = 3'b010;
	parameter dash1 = 3'b011;
	parameter dash2 = 3'b100;
	parameter dash3 = 3'b101;
	parameter blank = 3'b110;
	parameter done = 3'b111;
	
	// Logic
	always @(z, bit0, enable, y)
		case(y)
			idle: if (~enable) Y = load;
					else Y = idle;
			load: if (z) Y = done;
					else if (bit0 == 1'b0) Y = dot1;
					else Y = dash1;
			dot1: Y = blank;
			dash1: Y = dash2;
			dash2: Y = dash3;
			dash3: Y = blank;
			blank: if (z) Y = done;
					 else if (bit0 == 1'b0) Y = dot1;
					 else Y = done;
			done: Y = done;
		endcase
	
	always @(posedge half_counter or negedge reset)
		if (~reset)
			y <= idle;
		else
			y <= Y;
	
	assign E = (y == dot1 | y == idle | y == dash3);
	assign ln = ~(y == idle);
	assign out = (y == dot1 | y == dash1 | y == dash2 | y == dash3);
endmodule
