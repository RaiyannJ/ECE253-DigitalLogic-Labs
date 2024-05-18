
module part1(a, b, c_in, s, c_out);
	input logic [3:0] a, b;
	input logic c_in;
	output logic [3:0] s, c_out;
	logic w1, w2, w3;
	FA u0(c_in, a[0], b[0], w1, s[0]);
	FA u1(w1, a[1], b[1], w2, s[1]);
	FA u2(w2, a[2], b[2], w3, s[2]);
	FA u3(w3, a[3], b[3], c_out, s[3]);
endmodule


module FA(input logic ci, a, b,
		output logic co, s);
	assign s = a ^ b ^ ci;
	assign co = (a&b)|(ci&a)|(ci&b);
endmodule


module part2(A, B, Function, ALUout);
	output logic [7:0] ALUout;
	input logic [3:0] A, B;
	input logic [1:0] Function;
	
	logic [3:0] S, Co;

	part1 v0(A, B, 0, S, Co);

	always_comb
	begin
		case (Function)
			2'b00: ALUout = {3'b000,Co[0],S[3:0]};
			2'b01: ALUout = {7'b0000000, (|A)|(|B)};
			2'b10: ALUout = {7'b0000000, (&A)&(&B)};
			2'b11: ALUout = {A,B};
			default: ALUout = 8'b00000001;
	     	endcase
	end
endmodule 
