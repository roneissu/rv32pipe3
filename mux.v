module mux(sel, data1, data2, out);
	input sel;
	input [31:0] data1, data2;
	output reg [31:0] out;

	always @(data1, data2, sel) begin
		if(sel == 0)
			begin
				out = data1;
			end
		else
			begin
				out = data2;
			end
	end
	
endmodule