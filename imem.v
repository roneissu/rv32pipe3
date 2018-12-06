module imem (addr, data);
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

endmodule

/*
module imem (addr, data);
	input		[9:0]	addr;
	output	reg	[31:0]	data;

	reg [31:0] rom;

	always @(addr)
	begin
	  case (addr)
	    'd0 	: data = 'h00000533;
	    'd1 	: data = 'h00250513;
	    'd2 	: data = 'h40a505b3;
	    'd3 	: data = 'h0035c613;
	    'd4 	: data = 'h00a5f733;
	    'd5 	: data = 'h00676693;
	    'd6 	: data = 'h00b02023;
	    'd7 	: data = 'h00002783;
	    'd8 	: data = 'h00000533;
	    'd9 	: data = 'h000005b3;
	    'd10 	: data = 'h00b50463;
	    'd11 	: data = 'h0000006f;
	    'd12 	: data = 'h00000533;
	    'd13 	: data = 'h00000533;
	    'd14 	: data = 'h00250513;
	    'd15 	: data = 'h40a505b3;
	    'd16 	: data = 'h0035c613;
	    'd17 	: data = 'h00a5f733;
	    'd18 	: data = 'h00676693;
	    'd19 	: data = 'h00b02023;
	    'd20 	: data = 'h00002783;
	    'd21 	: data = 'h00000533;
	    'd22 	: data = 'h000005b3;
	    'd23 	: data = 'h00000533;
	    'd24 	: data = 'h00250513;
	    'd25 	: data = 'h40a505b3;
	    'd26 	: data = 'h0035c613;
	    'd27 	: data = 'h00a5f733;
	    'd28 	: data = 'h00676693;
	    'd29 	: data = 'h00b02023;
	    'd30 	: data = 'h00002783;
	    'd31 	: data = 'h00000533;
	    'd32 	: data = 'h000005b3;
	    'd33 	: data = 'h00000000;
	    'd34 	: data = 'h00000000;
	    'd35 	: data = 'h00000000;
	    'd36 	: data = 'h00000000;
	    'd37 	: data = 'h00000000;
	    'd38 	: data = 'h00000000;
	    'd39 	: data = 'h00000000;
	    default : data = 'h0;
	  endcase
	end
endmodule*/