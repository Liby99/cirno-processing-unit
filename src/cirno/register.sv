module register (
	input	[1:0] r0, r1,
	output	[1:0] x, y,
	input read_enable_x, read_enable_y, write_enable
	input clk,
	input run,
	logic [7:0][4] reg
);

	always @(posedge clk) begin
		if (read_enable_x == 1'b1) begin
			x <= reg[r0]
		end

		if (read_enable_y == 1'b1) begin
			y <= reg[r1]
		end	
	end
endmodule
