module adder(data1, data2, out);
	input [31:0] data1, data2;
	output [31:0] out;

	assign out = data1 + data2;

endmodule