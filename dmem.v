module dmem (
	input			write_en, clk,
	input	[8:0]	addr,
	input	[31:0]	data_in,
	output	[31:0]	data_out
);

	reg [31:0] mem [1023:0];

	always @(posedge clk)
	begin
		if (write_en == 1'b1)
			mem[addr] = data_in;
			data_out = 0;
		else
			data_out = mem[addr];
		end
	end

endmodule
