module register (
	input clk,
	input [1:0] r1, r2,
	input [7:0] result,
	input [5:0] immediate,
	input reg_readx_en, reg_ready_en, reg_r_en, reg_w_en, reg_hi_en, reg_lo_en, reg_swap_en,
	output logic [7:0] x, y
);
	logic [3:0][7:0] mem;

	always @(posedge clk) begin
		if (reg_r_en) begin
			if (reg_readx_en)
				x <= mem[r1];

			if (reg_ready_en)
				y <= mem[r2];
		end

		if (reg_w_en)
			mem[r1] <= result;

		if (reg_hi_en)
			mem[r1][7:4] <= immediate[3:0];

		if (reg_lo_en) 
			mem[r1][3:0] <= immediate[3:0];

		if (reg_swap_en)
			mem[r1] = mem[r2];
	end

endmodule
