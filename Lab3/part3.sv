
module part3(A, B, Function, ALUout);
	parameter N = 4;
	output logic [2*N - 1:0] ALUout;
	input logic [N-1:0] A, B;
	input logic [1:0] Function;
	
	logic [N-1:0] S, Co;

	always_comb
	begin
		case (Function)
			2'b00: ALUout = A+B;
			2'b01: ALUout = {(|A)|(|B)};
			2'b10: ALUout = {(&A)&(&B)};
			2'b11: ALUout = {A,B};
	     	endcase
	end
endmodule
