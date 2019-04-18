module memory (
	input [7:0] mem_in,
	input [7:0] addr,
	input memory_w_en, memory_r_en,
	input clk,
	output logic[7:0] mem_out
);
	logic [255:0][7:0] mem;

	always @(posedge clk) begin
		if (memory_r_en)
			mem_out <= mem[addr];
		if (memory_w_en)
			mem[addr] <= mem_in;
	end
	initial begin
		mem[1] = 8'b00000001;
		mem[15] = 8'b00000010;
	end
endmodule
