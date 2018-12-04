module immgen (sel, data, out);
	input [2:0] sel;
	input wire [24:0] data;
	output reg [31:0] out;
	
	wire [31:0] imm_I, imm_S, imm_B, imm_U, imm_J;
	
	assign imm_I = {{21{data[24]}}, data[23:13]};
	assign imm_S = {{21{data[24]}}, data[23:18], data[4:0]};
	assign imm_B = {{20{data[24]}}, data[0], data[23:18], data[4:1],1'b0};
	assign imm_U = {data[24:5], 12'd0};
	assign imm_J = {{11{data[24]}}, data[12:5], data[13], data[23:14], 1'b0};
	
	always @(sel[2:0], imm_I, imm_S, imm_B, imm_U, imm_J)
	begin
		case (sel[2:0])
			3'b000  : out <= imm_I;
			3'b001  : out <= imm_S;
			3'b010  : out <= imm_B;
			3'b011  : out <= imm_U;
			3'b100  : out <= imm_J;
			default : out <= 32'd0;
		endcase
	end
endmodule