//if - dc - of - alu - rs - if: andi, shri, shli, sh, cmp, add, sub, and, or, xor, incc
//if - dc - if: jmpi, beqi, nil, halt
//if - dc - of - if: jmp, beq
//if - dc - rs - if: movih, movil, mv
//if - dc - of - wm - if: st
//if - dc - of - rm - rs - is: ld
// if = inst fetch,  dc = decode,  of = oprand fetch, rs = result store, rm = read mem, wm = write mem 


module toplevel (
    input   init, clk,
    output  done
);
    logic [7:0] x, y, result, inst;
    logic [3:0] funct;
    logic [5:0] immediate;
    logic [4:0] inst_type;
    logic [1:0] r1, r2;
    logic cmp;
    logic [2:0] step;

	logic reg_readx_en, reg_ready_en, reg_r_en, reg_w_en, reg_hi_en, reg_lo_en, reg_swap_en;
    logic alu_en, decoder_en, memory_w_en, memory_r_en, fetch_unit_en;
    logic exe_done, y_is_imm;
    logic branch, branchi;

    decoder decoder(.*);
    memory memory(.memory_in(x), .addr(y), .memory_r_en, .memory_w_en, .clk, .mem_out(result));
    register register(.*);
    alu alu(.*);
    fetch_unit fetch_unit(.clk, .init, .branch, .branchi, .startAddress, .target(x), .immediate, .inst);


    always @(posedge clk) begin
        case(step)
            1: begin
                fetch_unit_en <= 1;
                branch <= 0;
                branchi <= 1;
            end

            2: begin
                fetch_unit_en <= 0;
                decoder_en <= 1;
            end

            3: begin
                decoder_en <= 0;
                case(inst_type)
                    1: begin
                        register_r_en <= decoder_en;
                        alu_en <= register_r_en;
                        register_w_en <= alu_en;
                        exe_done <= register_w_en;
                    end
                        
                    2: begin;
                        exe_done <= 1;
                    end

                    3: begin
                        register_r_en <= decoder_en;
                        exe_done <= register_r_en;
                    end

                    4: begin

                    end

                    5: begin
                        register_r_en <=  decoder_en;
                        memory_w_en <= register_r_en;
                        exe_done <= register_r_en;
                    end

                    6: begin
                        register_r_en <=  decoder_en;
                        memory_r_en <= register_r_en;
                        register_r_en <=  decoder_en;
                        exe_done <= register_r_en;
                    end
                endcase
            end
        endcase
    end

    always @(posedge exe_done)
        step <= 1;

    always @(posedge y_is_imm) begin
		y <= immediate;
		y_is_imm <= 0;
	end

endmodule