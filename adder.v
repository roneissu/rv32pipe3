module adder(
	input [31:0] data1,
	input [31:0] data2,
	output [31:0] out
);

	out = data1 + data2;

endmodule