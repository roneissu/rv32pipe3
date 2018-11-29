module immgen (sel, data, out);
	input sel;
	input [15:0] data;
	output reg [31:0] out;

	always @(sel, data)
	begin
		if (sel == 0)
			begin
				out <= data;
			end
		else
			begin
				out <= $signed(data);			
			end
	end
endmodule