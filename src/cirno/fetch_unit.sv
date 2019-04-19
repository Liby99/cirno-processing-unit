module fetch_unit(
    input       clk,
    input       init,
    input       branch,
    input       branchi,
    input       fetch_unit_en,
    input       jump,
    input[8:0]  startAddress,
    input[7:0]  target,
    input[5:0]  immediate,
    output logic[8:0] inst
);
    logic[8:0]          pc;
    logic[511:0][8:0]   rom;
     
    always @(posedge clk) begin
        if (init) 
            pc <= startAddress;
        if (fetch_unit_en) begin
            if (branch)
                pc <= target;
            else if (branchi)
                if (jump) begin
                    if (immediate[5])
                        pc <= pc - immediate[4:0];
                    else
                        pc <= pc + immediate[4:0];
                end
                else begin
                    if (immediate[3])
                        pc <= pc - immediate[2:0];
                    else
                        pc <= pc + immediate[2:0];
                end
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

    // assign  rom[0] = 9'b101000000;      // movih r0 0
    // assign  rom[1] = 9'b100000001;      // movil r0 1
    // assign  rom[2] = 9'b010000100;      // ld r1 r0
    // assign  rom[3] = 9'b000001101;      // inc r1
    // assign  rom[4] = 9'b010010100;      // st r1 r0

    // assign  rom[21] = 9'b000000001;      // halt
assign rom[0] = 9'b101010001;
assign rom[1] = 9'b100011110;
assign rom[2] = 9'b101001111;
assign rom[3] = 9'b100001101;
assign rom[4] = 9'b010010100;
assign rom[5] = 9'b110010000;
assign rom[6] = 9'b010001001;
assign rom[7] = 9'b100001010;
assign rom[8] = 9'b010011000;
assign rom[9] = 9'b000001101;
assign rom[10] = 9'b010001101;
assign rom[11] = 9'b000001101;
assign rom[12] = 9'b100001111;
assign rom[13] = 9'b010010100;
assign rom[14] = 9'b011011100;
assign rom[15] = 9'b011110100;
assign rom[16] = 9'b000101110;
assign rom[17] = 9'b100001011;
assign rom[18] = 9'b010011100;
assign rom[19] = 9'b001111011;
assign rom[20] = 9'b011110001;
assign rom[21] = 9'b110010000;
assign rom[22] = 9'b101000000;
assign rom[23] = 9'b100000111;
assign rom[24] = 9'b000011110;
assign rom[25] = 9'b011110001;
assign rom[26] = 9'b000001101;
assign rom[27] = 9'b001100100;
assign rom[28] = 9'b010110010;
assign rom[29] = 9'b111100101;
assign rom[30] = 9'b011011100;
assign rom[31] = 9'b101001111;
assign rom[32] = 9'b100001010;
assign rom[33] = 9'b010001000;
assign rom[34] = 9'b110101110;
assign rom[35] = 9'b000101110;
assign rom[36] = 9'b100001100;
assign rom[37] = 9'b010011100;
assign rom[38] = 9'b100001011;
assign rom[39] = 9'b010001100;
assign rom[40] = 9'b100001000;
assign rom[41] = 9'b000111100;
assign rom[42] = 9'b100001010;
assign rom[43] = 9'b010001000;
assign rom[44] = 9'b011110001;
assign rom[45] = 9'b110100111;
assign rom[46] = 9'b000101110;
assign rom[47] = 9'b001111011;
assign rom[48] = 9'b011110001;
assign rom[49] = 9'b110010000;
assign rom[50] = 9'b101000000;
assign rom[51] = 9'b100000111;
assign rom[52] = 9'b000011110;
assign rom[53] = 9'b011110001;
assign rom[54] = 9'b000001101;
assign rom[55] = 9'b001100100;
assign rom[56] = 9'b010110010;
assign rom[57] = 9'b111100101;
assign rom[58] = 9'b110110001;
assign rom[59] = 9'b101001111;
assign rom[60] = 9'b100001100;
assign rom[61] = 9'b010001000;
assign rom[62] = 9'b000101011;
assign rom[63] = 9'b011010001;
assign rom[64] = 9'b100001010;
assign rom[65] = 9'b010001100;
assign rom[66] = 9'b110110001;
assign rom[67] = 9'b000101011;
assign rom[68] = 9'b011010001;
assign rom[69] = 9'b100001100;
assign rom[70] = 9'b010011000;
assign rom[71] = 9'b100001011;
assign rom[72] = 9'b010001100;
assign rom[73] = 9'b001111011;
assign rom[74] = 9'b011110001;
assign rom[75] = 9'b000011110;
assign rom[76] = 9'b011110010;
assign rom[77] = 9'b000011110;
assign rom[78] = 9'b011110001;
assign rom[79] = 9'b000011110;
assign rom[80] = 9'b100001010;
assign rom[81] = 9'b010001000;
assign rom[82] = 9'b000011110;
assign rom[83] = 9'b011110010;
assign rom[84] = 9'b000011110;
assign rom[85] = 9'b011110001;
assign rom[86] = 9'b000011110;
assign rom[87] = 9'b110110001;
assign rom[88] = 9'b100001100;
assign rom[89] = 9'b010001000;
assign rom[90] = 9'b000101011;
assign rom[91] = 9'b011010001;
assign rom[92] = 9'b010011000;
assign rom[93] = 9'b100001011;
assign rom[94] = 9'b010001100;
assign rom[95] = 9'b001111011;
assign rom[96] = 9'b011110010;
assign rom[97] = 9'b110010000;
assign rom[98] = 9'b101000000;
assign rom[99] = 9'b100000011;
assign rom[100] = 9'b000011110;
assign rom[101] = 9'b011110010;
assign rom[102] = 9'b000001101;
assign rom[103] = 9'b001100100;
assign rom[104] = 9'b010110010;
assign rom[105] = 9'b111100101;
assign rom[106] = 9'b101001111;
assign rom[107] = 9'b100001010;
assign rom[108] = 9'b010001000;
assign rom[109] = 9'b000011110;
assign rom[110] = 9'b011110001;
assign rom[111] = 9'b000011110;
assign rom[112] = 9'b011110010;
assign rom[113] = 9'b000011110;
assign rom[114] = 9'b110110001;
assign rom[115] = 9'b100001100;
assign rom[116] = 9'b010001000;
assign rom[117] = 9'b000101011;
assign rom[118] = 9'b100001101;
assign rom[119] = 9'b010000100;
assign rom[120] = 9'b010011001;
assign rom[121] = 9'b000001101;
assign rom[122] = 9'b100001011;
assign rom[123] = 9'b010001100;
assign rom[124] = 9'b010011101;
assign rom[125] = 9'b000001101;
assign rom[126] = 9'b100001101;
assign rom[127] = 9'b010010100;
assign rom[128] = 9'b100001111;
assign rom[129] = 9'b010000100;
assign rom[130] = 9'b101100001;
assign rom[131] = 9'b100101110;
assign rom[132] = 9'b001100110;
assign rom[133] = 9'b010110100;
assign rom[134] = 9'b101110000;
assign rom[135] = 9'b100110110;
assign rom[136] = 9'b000001011;

    assign rom[137] = 9'b000000001;

    always @(pc) begin
        inst <= rom[pc];
    end

endmodule
