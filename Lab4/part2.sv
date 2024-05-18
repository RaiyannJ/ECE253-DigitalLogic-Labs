
module part2(Clock, Reset_b, Data, Function, ALUout);
	input logic Clock;
	input logic Reset_b;
	input logic [3:0] Data;
	input logic [1:0] Function;
	output logic [7:0] ALUout;

	logic [7:0] q;

	always_ff @(posedge Clock)
	begin
		if (Reset_b)
			ALUout<= 8'b0;
		else
			ALUout <= q;
	end

	always_comb
	begin
		case(Function)
			2'b00: q = Data[3:0]+ALUout[3:0];
			2'b01: q = Data[3:0]*ALUout[3:0];
			2'b10: q = ALUout[3:0] <<< Data[3:0];
			2'b11: q = ALUout;
		endcase
	end

endmodule




