module rv32pipe3 (clk, ctrl, results);
	input clk;
	input [0:12] ctrl;
	output [31:0] results;
	
	// Fetch & Decode
	
	mux mux_1 (ctrl[0], pc_4, pc_shft, pc_mux);
	
	reg [31:0] pc;
	always @(posedge clk)
	begin
		pc = pc_mux;
	end
	
	imem imem_1 (clk, pc[9:0], inst);
	
	adder adder_1 (pc, 3'd4, pc_4);
	
	registers regs_1 (clk, ctrl[1], inst[19:15], inst[24:20], inst[11:7], data1, data2, dataW);
	
	immgen immgen_1 (ctrl[5], inst[31:7], imm_ext);
	
	//
	
	// Execute
	
	shifter shifter_1 (imm_ext, shft);
	
	adder adder_2 (pc, shft, pc_shft);
	
	mux mux_2 (ctrl[6], data2, imm_ext, data2_mux);
	
	alu alu_1 (data1, data2_mux, ctrl[7:10], alu_res);
	
	//
	
	// Memory & WriteBack
	
	dmem dmem_1 (ctrl[11], clk, alu_res[9:0], data2, data_mem);
	
	mux mux_3 (ctrl[12], alu_res, data_mem, dataW);
	
	//

endmodule
