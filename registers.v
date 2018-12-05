module registers (clk, wen, addr1, addr2, addrW, data1, data2, dataW);
	input			clk, wen;
	input 	[4:0] 	addr1, addr2, addrW;
	input 	[31:0]	dataW;
	output 	[31:0]	data1, data2;
	
	reg [31:0] regs [31:0];
	reg [31:0] data1, data2;
	
	always @(negedge clk)
	begin
		if(wen == 1'b1)
			begin
				regs[addrW] = dataW;
			end
	end
	
	always @(posedge clk)
	begin
		data1 = regs[addr1];
		data2 = regs[addr2];
	end

endmodule
