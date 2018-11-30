module imem (clk, addr, data);
	parameter SIZE = 10;
	parameter MEM_INIT_FILE = "instructions.hex";

	input							clk;
	input			[SIZE-1:0]	addr;
	output reg	[31:0]		data;

	reg [31:0] rom [0:(2**SIZE)-1];
	
	initial
	begin
		if (MEM_INIT_FILE != "")
			begin
				$readmemh(MEM_INIT_FILE, rom);
			end
	end
	
	always @(posedge clk)
	begin
		data = rom[addr];
	end

endmodule
