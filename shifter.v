module shifter (
	input [31:0] in_shift,
	output [31:0] out_shift
);

	wire [31:0] wire_shift;

	assign wire_shift = (in_shift << 1);

	assign out_shift = wire_shift;

endmodule
