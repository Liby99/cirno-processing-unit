module memory (
	input	[7:0] r0, r1, r2, r3,
	input	[1:0] reg,
	input op,
	input	[7:0] addr,
	input clk,
	input run,
	logic [7:0][4] mem
);

	always @(posedge clk) begin
		if (run == 1'b1) begin        // execute write or read

			if (op == 1'b0) begin       // read operation
				if (reg == 2'b00) begin
					r0 <= mem[addr]
				end

				else if (reg == 2'b01) begin
					r1 <= mem[addr]
				end

				else if (reg == 2'b10) begin
					r2 <= mem[addr]
				end

				else begin
					r3 <= mem[addr]
				end
			end

			else begin                  // write operation
				if (reg == 2'b00) begin
					mem[addr] <= r0
				end

				else if (reg == 2'b01) begin
					mem[addr] <= r1
				end

				else if (reg == 2'b10) begin
					mem[addr] <= r2
				end

				else begin
					mem[addr] <= r3
				end
			end
		end
	end

endmodule
