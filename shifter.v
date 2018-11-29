module shifter (in, out);
	input  [31:0] in;
	output wire [31:0] out = (in << 1);
endmodule
