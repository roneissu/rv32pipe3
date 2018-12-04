module rv32pipe3 (clk, ctrl, results);
	input clk;
	input [0:12] ctrl;
	output [31:0] results;
	
	wire [31:0] pc_4, pc_shft, pc_mux, inst, data1, data2, dataW, imm_ext,
					shft, data2_mux, alu_res,
					data_mem;
	
	// Fetch & Decode
	
	mux mux_1 (ctrl[0], pc_4, pc_shft, pc_mux);
	
	reg [31:0] pc;
	always @(posedge clk)
	begin
		pc = pc_mux;
	end
	
	imem imem_1 (pc[9:0], inst);
	
	adder adder_1 (pc, 3'd4, pc_4);
	
	registers regs_1 (clk, ctrl[1], inst[19:15], inst[24:20], inst[11:7], data1, data2, dataW);
	
	immgen immgen_1 (ctrl[2:4], inst[31:7], imm_ext);
	
	//
	
	// Execute
	
	shifter shifter_1 (imm_ext, shft);
	
	adder adder_2 (pc, shft, pc_shft);
	
	mux mux_2 (ctrl[5], data2, imm_ext, data2_mux);
	
	alu alu_1 (data1, data2_mux, ctrl[6:8], alu_res);
	
	//
	
	// Memory & WriteBack
	
	dmem dmem_1 (ctrl[9], clk, alu_res[9:0], data2, data_mem);
	
	mux mux_3 (ctrl[10], alu_res, data_mem, dataW);
	
	//
	
	assign results = inst;

endmodule
