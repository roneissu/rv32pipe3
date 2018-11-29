module alu (
	input [31:0] data1,
	input [31:0] data2,
	input [3:0] op,
	output reg [31:0] out
);

	always @(*) begin
		case (op)
			4'd0: out = data1 + data2;
			4'd1: out = data1 - data2;
			4'd2: out = data1 & data2;
			4'd3: out = data1 | data2;
			4'd4: out = data1 ^ data2;
			4'd5: out = data2 << 16; // load upper
			4'd6: out = data1 == data2;
			4'd7: out = data1 != data2;
			4'd8: out = data1 > data2;
			4'd9: out = data1 < data2;
			4'd10: out = data1 >= data2;
			4'd11: out = data1 <= data2;
			4'd12: out = {31'b1, $signed(data1) < $signed(data2)};
			4'd13: out = {31'b1, data1 < data2};
		endcase
	end

endmodule