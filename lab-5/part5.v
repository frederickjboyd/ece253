module part5(CLOCK_50, HEX0);
	// Assigning inputs and outputs
	input CLOCK_50;
	output [0:6] HEX0;
	
	// Wires
	reg reset_cnt_main, reset_cnt_smol;
	wire [25:0] cnt_main;
	wire [3:0] cnt_smol;
	
	// Determining when to send reset signals
	always @(CLOCK_50)
		if (cnt_main == 26'b10111110101111000010000000)
			reset_cnt_main <= 1'b1;
		else
			reset_cnt_main <= 1'b0;
	always @(CLOCK_50)
		if (cnt_smol == 4'b1010)
			reset_cnt_smol <= 1'b1;
		else
			reset_cnt_smol <= 1'b0;
	
	// Running counters
	counter_50 C0 (CLOCK_50, reset_cnt_main, cnt_main);
	counter_9  C1 (reset_cnt_main, reset_cnt_smol, cnt_smol);
	
	// Display outputs
	hexDisp H0 (cnt_smol, HEX0);
endmodule

module counter_50(clk, reset, Q);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [25:0] Q;
	
	// Logic
	always @(posedge clk or posedge reset)
		if (reset)
			Q <= 26'b0;
		else
			Q <= Q + 1;
endmodule

module counter_9(clk, reset, S);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [3:0] S;
	
	// Logic
	always @(posedge clk or posedge reset)
		if (reset)
			S <= 4'b0;
		else
			S <= S + 1;
endmodule

module hexDisp(M, disp);
	// Assigning inputs and outputs
	input [3:0] M;
	output [0:6] disp;
	
	// Wires
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
