module memory (
	input	[7:0] reg,
	input op,
	input	[7:0] addr,
	input clk,
	input run,
	logic [7:0][255] mem
);

	always @(posedge clk) begin
		if (run == 1'b1) begin        // execute write or read

			if (op == 1'b0) begin       // read operation
				reg <= mem[addr]
			end

			else begin                  // write operation
				mem[addr] <= reg
			end
		end
	end
endmodule
