module rv32single (clk, reset, results);
	input clk, reset;
	output [31:0] results;
	
	wire [31:0] pc_4, pc_shft, pc_mux, inst, data1, data2, dataW, imm_ext, shft, data2_mux, alu_res, data_mem;
	wire [0:12] ctrl;
	
	// Fetch & Decode
	
	// Mux_PC
	assign pc_mux = (ctrl[0]) ? pc_shft : pc_4;
	// End Mux_PC
	
	reg [31:0] pc;
	always @(posedge clk)
	begin
		if (reset)
			begin
				pc <= 'd0;
			end
		else
			begin
				pc <= pc_mux;
			end
	end
	
	imem imem_1 (pc[9:0], inst);
//	imem imem_1 (clk, pc[9:0], inst);
	
	// PC+4
	assign pc_4 = pc + 'd1;
	// End PC+4
	
	registers regs_1 (clk, ctrl[1], inst[19:15], inst[24:20], inst[11:7], data1, data2, dataW);
	
	immgen immgen_1 (ctrl[2:4], inst[31:7], imm_ext);
	
	controller controller_1 ({inst[30],inst[14:12],inst[6:0]}, ctrl);

	//
	
	// Execute
	
	//shifter shifter_1 (imm_ext, shft);
	// Shifter
	assign shft = (imm_ext << 1);

	// PC+Shift
	assign pc_shft = pc + shft;
	// End PC+Shift
	
	// Mux_ALU
	assign data2_mux = (ctrl[5]) ? imm_ext : data2;
	// End Mux_ALU
	
	alu alu_1 (data1, data2_mux, ctrl[6:9], alu_res);
	
	//
	
	// Memory & WriteBack
	
	dmem dmem_1 (ctrl[10], clk, alu_res[9:0], data2, data_mem);

	// Mux_WB
	assign dataW = (ctrl[11]) ? data_mem : alu_res;
	// End Mux_WB
	
	//
	assign results = inst;

endmodule
