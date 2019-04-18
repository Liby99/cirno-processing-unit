module fetch_unit(
    input       clk,
    input       init,
    input       branch,
    input       branchi,
    input       fetch_unit_en,
    input[8:0]  startAddress,
    input[7:0]  target,
    input[5:0]  immediate,
    output logic[8:0] inst
);
    logic[8:0]          pc;
    logic[511:0][8:0]   rom;
    
    always @(posedge clk) begin
        if (fetch_unit_en) begin
            if (init) 
                pc <= startAddress;
            else if (branch)
                pc <= target;
            else if (branchi)
                pc <= pc + immediate;
            else
                pc <= pc + 1;
        end
    end

    // assign  rom[0] = 9'b101000101;      // movih r0 0101
    // assign  rom[1] = 9'b100001010;      // movil r0 1010

    // assign  rom[2] = 9'b101011101;      // movih r0 0101
    // assign  rom[3] = 9'b100011110;      // movil r0 1010

    // assign  rom[4] = 9'b001010001;      // add r0 r1 result should be 00111000
    // assign  rom[5] = 9'b111000011;      // jmpi 2
    // assign  rom[7] = 9'b110000001;      // andi r0 1
    // assign  rom[8] = 9'b011100010;      // shri r0 2
    // assign  rom[9] = 9'b011000011;      // shli r0 3
    // assign  rom[10] = 9'b001100000;     // cmp r0 r0
    // assign  rom[11] = 9'b010110011;     // beqi 3
    // assign  rom[14] = 9'b010100001;     // sh r0 r1
    // assign  rom[15] = 9'b001110001;     // mov r0 r1
    // assign  rom[16] = 9'b101000001;     // movih r0 1
    // assign  rom[17] = 9'b100000100;     // movil r0 2
    // assign  rom[18] = 9'b000001000;     // jmp r0
    // assign  rom[20] = 9'b000000100;     // beq r0

    assign  rom[0] = 9'b101000000;      // movih r0 0
    assign  rom[1] = 9'b100000001;      // movil r0 1
    assign  rom[2] = 9'b010000100;      // ld r1 r0
    assign  rom[3] = 9'b000001101;      // inc r1
    assign  rom[4] = 9'b010010100;      // st r1 r0

    assign  rom[21] = 9'b000000001;      // halt

    always @(pc) begin
        inst <= rom[pc];
    end

endmodule
