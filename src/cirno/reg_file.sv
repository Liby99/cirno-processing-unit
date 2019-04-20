module reg_file (
  input clk,
  input [1:0] r1, r2,
  input [7:0] result, mem_out,
  input [5:0] immediate,
  input reg_readx_en, reg_ready_en, reg_r_en, reg_w_en, reg_hi_en, reg_lo_en, reg_swap_en, y_is_imm, reg_mem_w_en,
  output logic [7:0] x, y
);

  logic [7:0] mem [4];

  always @(posedge clk) begin
    if (y_is_imm)
      y <= immediate;

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
    if (reg_mem_w_en)
      mem[r1] <= mem_out;
  end

  initial begin
    mem[0] = 0;
    mem[1] = 0;
    mem[2] = 0;
    mem[3] = 0;
  end

endmodule
