module alu (data1, data2, op, out);
	input 		[31:0]	data1, data2;
	input 		[3:0] 	op;
	output reg	[31:0]	out;

	always @(data1 or data2 or op)
	begin
		case (op)
			4'd0	: out = data1 + data2;				// sum
			4'd1	: out = data1 - data2;				// subtraction
			4'd2	: out = data1 & data2;				// and
			4'd3	: out = data1 | data2;				// or
			4'd4	: out = data1 ^ data2;				// xor
			4'd5	: out = data2 << 16;				// load upper
			4'd6	: out = data1 << data2;				// shift left
			4'd7	: out = data1 >> data2;				// shift rigth
			4'd8	: out = (data1 == data2)?'b1:'b0;	// equal
			4'd9	: out = (data1 != data2)?'b1:'b0;	// not equal
			4'd10	: out = (data1 >= data2)?'b1:'b0;	// equal or greater than
			4'd11	: out = (data1 < data2)?'b1:'b0;	// less than
			default	: out = 32'd0;
		endcase
	end

endmodule