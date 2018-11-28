module immgen( 
	input sel, 
	input [15:0] data, 
	output reg [31:0] out 
);

	always @(data) begin
		if (sel == 0)
			out <= data;
		else
			out <= $signed(data);			
	end

endmodule