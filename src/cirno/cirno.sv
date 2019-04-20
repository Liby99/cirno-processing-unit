//if - dc - of - alu - rs - if: andi, shri, shli, sh, cmp, add, sub, and, or, xor, incc
//if - dc - if: jmpi, beqi, nil, halt
//if - dc - of - if: jmp, beq
//if - dc - rs - if: movih, movil, mv
//if - dc - of - wm - if: st
//if - dc - of - rm - rs - is: ld
// if = inst fetch,  dc = decode,  of = oprand fetch, rs = result store, rm = read mem, wm = write mem

module cirno (
  input init, clk,
  output done
);

  logic [7:0] x, y, result, mem_out;
  logic [8:0] inst;
  logic [3:0] funct;
  logic [5:0] immediate;
  logic [2:0] inst_type;
  logic [1:0] r1, r2;
  logic cmp;
  logic [2:0] step;
  logic [7:0] start_address;

  logic reg_readx_en, reg_ready_en, reg_r_en, reg_w_en, reg_hi_en, reg_lo_en, reg_swap_en, reg_mem_w_en;
  logic alu_en, decoder_en, memory_w_en, memory_r_en, fetch_unit_en;
  logic exe_done, y_is_imm;
  logic branch, branchi, jump;
  logic is_cmp, eq;
  logic temp;

  decoder DECODER(.*);
  alu ALU(.*);
  reg_file REG_FILE(.*);
  data_mem DATA_MEM(.mem_in(x), .addr(y), .memory_r_en, .memory_w_en, .clk, .mem_out);
  instr_mem INSTR_MEM(.clk, .init, .branch, .branchi, .fetch_unit_en, .start_address, .target(x), .immediate, .inst, .jump);

  initial begin
    start_address = 8'b11111111;
    reg_r_en <= 0;
    reg_w_en <= 0;
    alu_en <= 0;
    decoder_en <= 0;
    memory_w_en <= 0;
    memory_r_en <= 0;
    reg_mem_w_en <= 0;
    fetch_unit_en <= 0;
    exe_done <= 0;
    temp <= 0;
  end

  always @(posedge clk) begin
    if (init) step <= 1;
    else if (done) step <= 0;
    else begin
      case(step)
        1: begin
          fetch_unit_en <= 1;
          step <= 2;
        end
        2: begin
          decoder_en <= 1;
          fetch_unit_en <= 0;
          step <= 3;
        end
        3: begin
          decoder_en <= 0;
          temp <= 1;
          step <= 4;
        end
        4: begin
          temp <= 0;
          case(inst_type)
            1: begin
              reg_r_en <= temp;
              alu_en <= reg_r_en;
              reg_w_en <= alu_en;
              exe_done <= reg_w_en;
              if (alu_en & is_cmp) begin
                cmp <= eq;
              end
            end
            2: begin;
              exe_done <= 1;
            end
            3: begin
              reg_r_en <= temp;
              exe_done <= reg_r_en;
            end
            4: begin
              exe_done <= !temp; //TODO
            end
            5: begin
              reg_r_en <= temp;
              memory_w_en <= reg_r_en;
              exe_done <= memory_w_en;
            end
            6: begin
              reg_r_en <= temp;
              memory_r_en <= reg_r_en;
              reg_mem_w_en <=  memory_r_en;
              exe_done <= reg_mem_w_en;
            end
          endcase
          if (exe_done) begin
            exe_done <= 0;
            step <= 1;
          end
        end
      endcase
    end
  end
endmodule
