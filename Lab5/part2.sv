module part2 (ClockIn, Reset, Speed, CounterValue);
	parameter CLOCK_FREQUENCY = 500;
	input logic ClockIn, Reset;
	input logic [1:0] Speed;
	output logic [3:0] CounterValue;
	logic EnableDC;
	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) rd0(ClockIn, Reset, Speed, EnableDC);
	DisplayCounter dc0(ClockIn, Reset, EnableDC, CounterValue);

	
	
endmodule

module RateDivider (input logic ClockIn, input logic Reset, input logic [1:0] Speed,
			output logic Enable);
	parameter CLOCK_FREQUENCY = 500;
	logic [$clog2(4*CLOCK_FREQUENCY):0] RateDividerCount;

	always@(posedge ClockIn)
	begin
		if ((Reset == 1) | (RateDividerCount == 0 ))
		begin
			case(Speed)
				2'b00: RateDividerCount <= 1'b1 - 1;
				2'b01: RateDividerCount <= CLOCK_FREQUENCY - 1;
				2'b10: RateDividerCount <= CLOCK_FREQUENCY*2 - 1;
				2'b11: RateDividerCount <= CLOCK_FREQUENCY*4 - 1;
				default: RateDividerCount <= 0;
			endcase
		end 
		else if (RateDividerCount != 0)
			RateDividerCount <= RateDividerCount - 1;
	end

	assign Enable = (RateDividerCount == 'b0) ? 'b1:'b0;
endmodule


module DisplayCounter (input logic Clock, input logic Reset, input logic EnableDC,
			output logic [3:0] CounterValue);

	always@(posedge Clock)
		begin
			if (Reset)
				CounterValue <= 4'b0000;
			else if (EnableDC)
				CounterValue <= CounterValue + 1;
		end

endmodule
