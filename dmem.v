module dmem (write_en, clk, addr, data_in, data_out);
	parameter SIZE = 10;
	
	input						write_en, clk;
	input		[SIZE-1:0]	addr;
	input		[31:0]		data_in;
	output	[31:0]		data_out;

	reg [31:0] ram [(2**SIZE)-1:0];

	always @(posedge clk)
	begin
		if (write_en == 1'b1)
			begin
				ram[addr] <= data_in;
			end
		
	end
	
	assign data_out = ram[addr];

endmodule
