/*module imem (addr, data);
	parameter SIZE = 10;
	parameter MEM_INIT_FILE = "instructions.hex";

	input	[SIZE-1:0]	addr;
	output	[31:0]		data;

	reg [31:0] rom [0:(2**SIZE)-1];
	
	assign data = rom[addr];
	
	initial
	begin
		$readmemh(MEM_INIT_FILE, rom);
	end

endmodule*/

module imem (clk, addr, data);
	input				clk;
	input		[9:0]	addr;
	output	reg	[31:0]	data;

	reg [31:0] rom;

	always @(clk or addr)
	begin
	  case (addr)
	    'd0 : data = 'h00000533;
	    'd1 : data = 'h00250513;
	    'd2 : data = 'h40a505b3;
	    'd3 : data = 'h40a58633;
	    'd4 : data = 'h40a606b3;
	    'd5 : data = 'h40a68733;
	    default : data = 'h0;
	  endcase
	end
endmodule