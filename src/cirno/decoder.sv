//type 1: two regs
//type 2: reg + immed
//type 3: reg
//type 4: immed
//type 5: none
module decoder (
    input       clk,
    input[8:0]  inst,
    output      type_1, type_2, type_3, type_4, type_5
    output[1:0] r1, r2,
    output[3:0] funct,
    output[5:0] immediate,
);

    always @(posedge clk) begin
        if (inst[8:6] == 3'b111) begin      // jmpi
            type_4 <= 1'b1;
            immediate <= inst[5:0];
        end

        else if (inst[8] != 1'b0) begin     // andi movih movil
            type_2 <= 1'b1;
            funct <= inst[7:6]; //TODO bits not match
            r1 <= inst[5:4];
            immediate <= inst[3:0]; //TODO bits not match
        end

        else if (inst[8:6] == 3'b011) begin // shri shli
            type_2 <= 1'b1;
            funct <= inst[5]; //TODO bits not match
            r1 <= inst[4:3];
            immediate <= inst[2:0]; //TODO bits not match
        end

        else if (inst[8:4] == 5'b01011) begin // beqi
            type_4 <= 1'b1;
            immediate <= inst[3:0];
        end

        else if (inst[8:4] != 5'b00000) begin
            type_1 <= 1'b1;
            r1 <= inst[3:2];
            r2 <= inst[1:0];
            funct <= inst[7:4];
        end

        else if (inst[8:1] != 7'b0000000) begin
            type_3 <= 1'b1;
            r1 <= inst[1:0];
            funct <= inst[3:2];
        end

        else begin
            type_5 <= 1'b1;
            funct <= inst[0];
        end
    end

    always @(negedge clk) begin
        type_1 <= 1'b0;
        type_2 <= 1'b0;
        type_3 <= 1'b0;
        type_4 <= 1'b0;
        type_5 <= 1'b0;
        funct <= 4'b0000;
        immediate <= 6'b000000;
    end
    
endmodule