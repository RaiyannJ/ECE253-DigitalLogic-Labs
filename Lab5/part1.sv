module part1 (Clock, Enable, Reset, CounterValue);

	input logic Clock, Enable, Reset;
	output logic [7:0] CounterValue;
	logic w1, w2, w3, w4, w5, w6, w7;
	
	T_flip_flop u0(.clk(Clock), .reset_b(Reset), .t(Enable), .q(CounterValue[0]));
	assign w1 = Enable&CounterValue[0];
	T_flip_flop u1(.clk(Clock), .reset_b(Reset), .t(w1), .q(CounterValue[1]));
	assign w2 = w1&CounterValue[1];
	T_flip_flop u2(.clk(Clock), .reset_b(Reset), .t(w2), .q(CounterValue[2]));
	assign w3 = w2&CounterValue[2];
	T_flip_flop u3(.clk(Clock), .reset_b(Reset), .t(w3), .q(CounterValue[3]));
	assign w4 = w3&CounterValue[3];
	T_flip_flop u4(.clk(Clock), .reset_b(Reset), .t(w4), .q(CounterValue[4]));
	assign w5 = w4&CounterValue[4];
	T_flip_flop u5(.clk(Clock), .reset_b(Reset), .t(w5), .q(CounterValue[5]));
	assign w6 = w5&CounterValue[5];
	T_flip_flop u6(.clk(Clock), .reset_b(Reset), .t(w6), .q(CounterValue[6]));
	assign w7 = w6&CounterValue[6];
	T_flip_flop u7(.clk(Clock), .reset_b(Reset), .t(w7), .q(CounterValue[7]));
endmodule 

module T_flip_flop (input logic clk ,input logic reset_b ,input logic t,
			output logic q);
	logic d;
	assign d = t^q;
	always_ff @ (posedge clk)
	begin
		if (reset_b) q <= 1'b0;
		else q <= d;
	end
endmodule 