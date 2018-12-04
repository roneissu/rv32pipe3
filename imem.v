module imem (addr, data);
	parameter SIZE = 10;
	parameter MEM_INIT_FILE = "instructions.hex";

	input		[SIZE-1:0]	addr;
	output	[31:0]		data;

	reg [31:0] rom [0:(2**SIZE)-1];
	
	assign data = rom[addr]; // : 32'b0;
	
	initial
	begin
		$readmemh(MEM_INIT_FILE, rom);
	end

endmodule
