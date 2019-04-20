// function
// 0101  -  add
// 0100  -  sub
// 1110  -  left shift   
// 0111  -  right shift
// 0001  -  xor
// 0011  -  and
// 0010  -  or
// 0110  -  cmp
// 1010  -  sh

module alu (
    input[7:0]  x, y,
    input[3:0]  funct,
    output logic[7:0] result,
    output logic      cmp
);
    always @(*) begin
				case(funct)
						4'b0101:
								result <= x + y;
						4'b0100:
								result <= x - y;
						4'b1110:
								result <= x << y;
						4'b0111:
								result <= x >> y;
						4'b0001:
								result <= x ^ y;
						4'b0011:
								result <= x & y;
						4'b0010:
								result <= x | y;
						4'b0110: begin
								cmp    <= x == y;
								result <= x;
						end
						4'b1010: begin
								if (y[3])
										result <= x >> y[2:0];
								else
										result <= x << y[2:0];
						end
				endcase
    end

endmodule
