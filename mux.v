module mux(
	input [31:0] data1,
	input [31:0] data2,
	input sel,
	output [31:0] out
	);

	always @(data1, data2, sel) begin
		if(sel == 0) 
			out = data1;
		else
			out = data2;
	end
	
endmodule