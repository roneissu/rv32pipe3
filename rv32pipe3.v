module rv32pipe3 (
	output results
);

	wire [31:0] instruction;
	wire [4:0] address;
	wire clock, writeEn;

	imem imem0 (address, instruction);
	
	registers regs0 (clock, writeEn, address, address, address, instruction, results, instruction);

endmodule
