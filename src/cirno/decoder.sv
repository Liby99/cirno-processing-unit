module decoder (
    input            clk, cmp, decoder_en,
    input      [8:0] inst,
    output reg [1:0] r1, r2,
    output reg [2:0] inst_type,
    output reg [3:0] funct,
    output reg [5:0] immediate,
    output reg       branch, branchi,
    output reg       reg_hi_en, reg_lo_en, reg_readx_en, reg_ready_en, reg_swap_en,
    output reg       y_is_imm, done
);
    initial begin
        reg_readx_en <= 0;
        reg_ready_en <= 0;
        reg_hi_en <= 0;
        reg_lo_en <= 0;
        reg_swap_en <= 0;
        y_is_imm <= 0;
        branch <= 0;
        branchi <= 0;
    end

    always @(posedge clk) begin
        if (decoder_en) begin
            reg_readx_en <= 0;
            reg_ready_en <= 0;
            reg_hi_en <= 0;
            reg_lo_en <= 0;
            reg_swap_en <= 0;
            branch <= 0;
            branchi <= 0;
		    y_is_imm <= 0;
            casex (inst)
                9'b111xxxxxx: begin  // jmpi
                    inst_type <= 2;
                    branchi <= 1;
                    immediate <= inst[5:0];
                end

                9'b1xxxxxxxx: begin // movih, movil, andi
                    r1 <= inst[5:4];
                    case (inst[7:6])
                        2'b01: begin // movhi
                            reg_hi_en <= 1;
                            inst_type <= 4;
                            immediate <= inst[3:0];
                        end
                        2'b00: begin // movli
                            reg_lo_en <= 1;
                            inst_type <= 4;
                            immediate <= inst[3:0];
                        end
                        2'b10: begin    //andi
                            inst_type <= 1;
                            reg_readx_en <= 1;
                            funct <= 4'b0011;
                            immediate <= inst[3:0];
                            y_is_imm <= 1;
                        end
                    endcase
                end

                9'b011xxxxxx: begin
                    r1 <= inst[4:3];
                    immediate <= inst[2:0];
                    inst_type <= 1;
                    reg_readx_en <= 1;
                    y_is_imm <= 1;
                    if (inst[5]) begin //shri
                        funct <= 4'b0111; // 0110 conflict with com
                    end
                    else begin //shli
                        funct <= 4'b1110;
                    end
                end

                9'b01011xxxx: begin //beqi
                    inst_type <= 2;
                    if (cmp) begin
                        branchi <= 1;
                        immediate <= inst[3:0];
                    end
                end

                9'b0000000x: begin  //NIL and HAlt
                    inst_type <= 2;
                    if(inst[0])
                        done <= 1;
                end

                9'b00000xxxx: begin
                    reg_readx_en <= 1;
                    r1 <= inst[1:0];
                    case (inst[3:2])
                        2'b11: begin //incr
                            funct <= 4'b0101;
                            immediate <= 1;
                            inst_type <= 1;
                            y_is_imm <= 1;
                        end

                        2'b10: begin //jmp
                            inst_type <= 3;
                            branch <= 1;
                        end

                        2'b01: begin //beq
                            if (cmp) begin
                                inst_type <= 3;
                                branch <= 1;
                            end
                            else
                                inst_type <= 2;
                        end 
                    endcase
                end

                default: begin
                    r1 <= inst[3:2];
                    r2 <= inst[1:0];
                    reg_readx_en <= 1;
                    reg_ready_en <= 1;
                    case(inst[7:4])
                        4'b1001: begin //store
                            inst_type <= 5;
                        end

                        4'b1000: begin // load
                            inst_type <= 6;
                        end

                        4'b0111: begin // mv
                            inst_type <= 4;
                            reg_swap_en <= 1;
                        end


                        default: begin 
                            inst_type <= 1;
                            funct <= inst[7:4];
                        end
                    endcase
                end         
            endcase
        end
    end

endmodule