module controller (inst, ctrl)
	input		[16:0] inst;
	output	[0:11] ctrl;
	
	always @(*)
	begin
		case (inst[6:0])
			7'b11: begin // I-type
				ctrl = 12'b0100010[aluop3]01; // LW
			end
			7'b010011: begin // I-type
				case (inst[14:12])
					3'b000: ctrl = 12'b0100010[aluop3]00; // ADDI
					3'b010: ctrl = 12'b0100010[aluop3]00; // SLTI
					3'b011: ctrl = 12'b0100010[aluop3]00; // SLTIU
					3'b100: ctrl = 12'b0100010[aluop3]00; // XORI
					3'b110: ctrl = 12'b0100010[aluop3]00; // ORI
					3'b111: ctrl = 12'b0100010[aluop3]00; // ANDI
				endcase
			end
			7'b100011: begin // S-type
				ctrl = 12'b0000111[aluop3]10; // SW
			end
			7'b110011: begin // R-type
				case (inst[14:12])
					3'b000: begin
						case (inst[30])
							case 0: ctrl = 12'b01xxx0x[aluop3]00; // ADD
							case 1: ctrl = 12'b01xxx0x[aluop3]00; // SUB
						endcase
					end
					3'b001: ctrl = 12'b01xxx0x[aluop3]00; // SLL
					3'b010: ctrl = 12'b01xxx0x[aluop3]00; // SLT
					3'b011: ctrl = 12'b01xxx0x[aluop3]00; // SLTU
					3'b100: ctrl = 12'b01xxx0x[aluop3]00; // XOR
					3'b101: ctrl = 12'b01xxx0x[aluop3]00; // SRL
					3'b110: ctrl = 12'b01xxx0x[aluop3]00; // OR
					3'b111: ctrl = 12'b01xxx0x[aluop3]00; // AND
				endcase
			end
			7'b110111: begin // U-type
				ctrl = 12'b0101110[aluop3]00; // LUI
			end
			7'b1100011: begin // SB-type
				case (inst[14:12])
					3'b000: ctrl = 12'b1001011[aluop3]00; // BEQ
					3'b001: ctrl = 12'b1001011[aluop3]00; // BNE
					3'b100: ctrl = 12'b1001011[aluop3]00; // BLT
					3'b101: ctrl = 12'b1001011[aluop3]00; // BGE
				endcase
			end
			7'b1101111: begin // UJ-type
				ctrl = 12'b1110010[aluop3]00; // JAL
			end
			default	: ctrl = 12'b0;
		endcase
	end
	

endmodule