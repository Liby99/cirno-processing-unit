module data_mem (
	input [7:0] mem_in,
	input [7:0] addr,
	input memory_w_en, memory_r_en,
	input clk,
	output logic[7:0] mem_out
);
	logic [7:0] core [256];

	always @(posedge clk) begin
		if (memory_r_en)
			mem_out <= core[addr];
		if (memory_w_en)
			core[addr] <= mem_in;
	end
endmodule
