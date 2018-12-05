module controller (inst, ctrl);
	input		[10:0] inst;
	output reg	[0:11] ctrl;
	
	always @(*)
	begin
		case (inst[6:0])
			7'b11: begin // I-type
				ctrl = 12'b010001000001; // LW
			end
			7'b010011: begin // I-type
				case (inst[9:7])
					3'b000: ctrl = 12'b010001000000; // ADDI
					3'b010: ctrl = 12'b010001101100; // SLTI
					3'b011: ctrl = 12'b010001101100; // SLTIU
					3'b100: ctrl = 12'b010001010000; // XORI
					3'b110: ctrl = 12'b010001001100; // ORI
					3'b111: ctrl = 12'b010001001000; // ANDI
					default	: ctrl = 12'b0;
				endcase
			end
			7'b100011: begin // S-type
				ctrl = 12'b000011000010; // SW
			end
			7'b110011: begin // R-type
				case (inst[9:7])
					3'b000: begin
						case (inst[10])
							1'b0: ctrl = 12'b01xxx0000000; // ADD
							1'b1: ctrl = 12'b01xxx0000100; // SUB
							default	: ctrl = 12'b0;
						endcase
					end
					3'b001: ctrl = 12'b01xxx0011000; // SLL
					3'b010: ctrl = 12'b01xxx0101100; // SLT
					3'b011: ctrl = 12'b01xxx0101100; // SLTU
					3'b100: ctrl = 12'b01xxx0010000; // XOR
					3'b101: ctrl = 12'b01xxx0011100; // SRL
					3'b110: ctrl = 12'b01xxx0001100; // OR
					3'b111: ctrl = 12'b01xxx0001000; // AND
					default	: ctrl = 12'b0;
				endcase
			end
			7'b110111: begin // U-type
				ctrl = 12'b010111010100; // LUI
			end
			7'b1100011: begin // SB-type
				case (inst[9:7])
					3'b000: ctrl = 12'b100101100000; // BEQ
					3'b001: ctrl = 12'b100101100100; // BNE
					3'b100: ctrl = 12'b100101101100; // BLT
					3'b101: ctrl = 12'b100101101000; // BGE
					default	: ctrl = 12'b0;
				endcase
			end
			7'b1101111: begin // UJ-type
				ctrl = 12'b111001xxxx00; // JAL
			end
			default	: ctrl = 12'b0;
		endcase
	end
	

endmodule