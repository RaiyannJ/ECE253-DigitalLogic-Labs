module v7404(input logic pin1, pin3, pin5, pin9, pin11, pin13,
			output logic pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule
			

module v7408(input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule
			
			
module v7432(input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule
	
	
module mux2to1(input logic x,y,s, output logic m);
	logic c1;
	logic c2;
	logic c3;
	
	
	v7408 B1(
		.pin1(y),
		.pin2(s),
		.pin3(c1)
	
	);
	
	
	v7404 B2(
		.pin1(s),
		.pin2(c2)
	);
	
	v7408 B3(
		.pin1(x),
		.pin2(c2),
		.pin3(c3)
	);
	
	v7432 B4(
		.pin1(c1),
		.pin2(c3),
		.pin3(m)
	);	
	
endmodule