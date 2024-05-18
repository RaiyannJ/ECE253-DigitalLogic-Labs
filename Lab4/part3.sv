module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input logic clock;
	input logic  reset;
	input logic ParallelLoadn;
	input logic RotateRight;
	input logic ASRight;
	input logic [3:0] Data_IN;
	output logic [3:0] Q;
	
	logic leftmost;
	
	mux m0(Q[0], Q[3], ASRight, leftmost);
	
	reg_rot r3(leftmost, Q[2], RotateRight, Data_IN[3], ParallelLoadn, clock, reset, Q[3]);
	reg_rot r2(Q[3], Q[1], RotateRight, Data_IN[2], ParallelLoadn, clock, reset, Q[2]);
	reg_rot r1(Q[2], Q[0], RotateRight, Data_IN[1], ParallelLoadn, clock, reset, Q[1]);
	reg_rot r0(Q[1], Q[3], RotateRight, Data_IN[0], ParallelLoadn, clock, reset, Q[0]);
endmodule


module reg_rot(left, right, LoadL, D, loadn, clock, reset, q);
	input logic left;
	input logic right;
	input logic LoadL;
	input logic D;
	input logic loadn;
	input logic clock;
	input logic reset;
	output logic q;
	
	logic RL;
	logic Din;
	
	mux m0(right, left, LoadL, RL);
	mux m1(D, RL, loadn, Din);

	always_ff @(posedge clock)
	begin
		if(reset) q <= 1'b0;
		else q <= Din;
	end
endmodule


module mux(x, y, s, m);
    input logic x;
    input logic y;
    input logic s;
    output logic m;
  
    assign m = (s & y) | (~s & x);

endmodule