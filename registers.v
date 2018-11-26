module registers (
	input clk,    // Clock
	input writeEnable,
	input [4:0] addr1,
	input [4:0] addr2,
	input [4:0] addrWrite,
	input [31:0] dataWrite,
	output [31:0] data1,
	output [31:0] data2
);

	wire clk_wire;
	
	assign clk_wire = ~clk;
	// lembrar de usar o negedge para o clock aqui

endmodule
