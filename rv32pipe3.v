module rv32pipe3 (clk, reset, results);

	// Ports ------------------------------------------------------------------
	input clk, reset;
	output [31:0] results;
	
	// Datapath wires ---------------------------------------------------------
	wire [31:0] pc_4, pc_shft, pc_mux, inst, data1, data2, dataW, imm_ext, shft, data2_mux, alu_res, data_mem;
	wire [0:12] ctrl;
	
	// Fetch & Decode ---------------------------------------------------------
	
	// Mux_PC
	assign pc_mux = (x_mw_ctrl[0]) ? x_mw[100:69] : pc_4;
	// End Mux_PC
	
	// PC Register ############################################################
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
	// End PC Register ########################################################
	
	// Instruction Memory
	imem imem_1 (pc[9:0], inst);
//	imem imem_1 (clk, pc[9:0], inst);
	
	// PC+4
	assign pc_4 = pc + 'd1;
	// End PC+4
	
	// Register File
	registers regs_1 (clk, x_mw_ctrl[1], inst[19:15], inst[24:20], x_mw[4:0], data1, data2, dataW);
	
	// Immediate extender
	immgen immgen_1 (ctrl[2:4], inst[31:7], imm_ext);
	
	// Controller
	controller controller_1 ({inst[30],inst[14:12],inst[6:0]}, ctrl);

	// Pipeline Register FETCH/DECODE | EXECUTE ###############################
	reg [132:0] fd_x;
	reg [0:8]	fd_x_ctrl;
	always @(posedge clk)
	begin
		fd_x <= {pc, data1, data2, imm_ext, inst[11:7]};
		fd_x_ctrl <= {ctrl[0:1], ctrl[5:11]};
	end
	// ########################################################################

	// Execute ----------------------------------------------------------------
	
	// Shifter
	assign shft = (imm_ext << 1);
	// End Shifter

	// PC+Shift
	assign pc_shft = fd_x[132:101] + shft;
	// End PC+Shift
	
	// Mux_ALU
	assign data2_mux = (fd_x_ctrl[2]) ? fd_x[36:5] : fd_x[68:37];
	// End Mux_ALU
	
	// Arithmetic-Logical Unity
	alu alu_1 (fd_x[100:69], data2_mux, fd_x_ctrl[3:6], alu_res);
	
	// Pipeline Register EXECUTE | MEMORY/WRITEBACK ###########################
	reg [100:0] x_mw;
	reg [0:3]	x_mw_ctrl;
	always @(posedge clk)
	begin
		x_mw <= {pc_shft, alu_res, fd_x[68:37], fd_x[4:0]};
		x_mw_ctrl <= {fd_x_ctrl[0:1], fd_x_ctrl[7:8]};
	end
	// ########################################################################
	
	// Memory & WriteBack -----------------------------------------------------
	
	// Data Memory
	dmem dmem_1 (x_mw_ctrl[2], clk, x_mw[46:37], x_mw[36:5], data_mem);

	// Mux_WB
	assign dataW = (x_mw_ctrl[3]) ? data_mem : x_mw[68:37];
	// End Mux_WB
	
	//
	assign results = inst;

endmodule