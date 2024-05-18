module part3 (ClockIn, Reset, Start, Letter, DotDashOut, NewBitOut);
	parameter CLOCK_FREQUENCY = 4;
	input logic ClockIn, Reset, Start;
	input logic [2:0] Letter;
	output logic DotDashOut, NewBitOut;

	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) rd0(ClockIn, Start, NewBitOut);
	Encoder e0(NewBitOut, Reset, Start, Letter, DotDashOut);

endmodule

module Encoder(input logic ClockIn, input logic Reset, input logic Start, input logic [2:0] Letter,
			output logic out);

	logic [11:0] x;
	logic [4:0]count;

	always@(*)
	begin
		if (Start == 1)
		begin
			case(Letter)
				3'b000: x <= 12'b101110000000;
				3'b001: x <= 12'b111010101000;
				3'b010: x <= 12'b111010111010;
				3'b011: x <= 12'b111010100000;
				3'b100: x <= 12'b100000000000;
				3'b101: x <= 12'b101011101000;
				3'b110: x <= 12'b111011101000;
				3'b111: x <= 12'b101010000000;
				default: x <= 0;
			endcase
			count <= 11;
		end
		if (Reset)
		begin
			x <= 0;
			count <= 0;
			out <= 0;
		end
	end

	always@(posedge ClockIn)
	begin
		if (!Start)
		begin
			out <= x[11];
			if (count != 0)
			begin
				x <= x << 1;
				count <= count - 1;
			end
		end
		

	end
		
endmodule

module RateDivider(input logic ClockIn, input logic Reset,
			output logic Enable);

	parameter CLOCK_FREQUENCY = 4;
	logic [26:0] RateDividerCount;

	always@(posedge ClockIn)
	begin
		if ((Reset == 1) | (RateDividerCount == 0 ))
		begin
			RateDividerCount <= (CLOCK_FREQUENCY/2)-1;
		end
		else if (RateDividerCount != 0)
			RateDividerCount <= RateDividerCount - 1;
	end

	always@(*)
	begin
		if(Reset)
			RateDividerCount <= 0;
	end	
	
	assign Enable = (RateDividerCount == 'b0) ? 'b1:'b0;
endmodule