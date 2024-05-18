
module part1(input logic [3:0] a, b, input logic c_in,
		output logic [3:0] s, c_out);
	FA u0(.ci(c_in), .a(a[0]), .b(b[0]), .co(c_out[0]), .s(s[0]));
	FA u1(.ci(c_out[0]), .a(a[1]), .b(b[1]), .co(c_out[1]), .s(s[1]));
	FA u2(.ci(c_out[1]), .a(a[2]), .b(b[2]), .co(c_out[2]), .s(s[2]));
	FA u3(.ci(c_out[2]), .a(a[3]), .b(b[3]), .co(c_out[3]), .s(s[3]));
endmodule


module FA(input logic ci, a, b,
		output logic co, s);
	assign s = a ^ b ^ ci;
	assign co = (a&b)|(ci&a)|(ci&b);
endmodule
