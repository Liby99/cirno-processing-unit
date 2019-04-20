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
    logic[511:0][8:0]   rom1;
    logic[511:0][8:0]   rom2;
    logic[511:0][8:0]   rom3;
    logic[1:0]          prog = 0;
     
    always @(posedge clk) begin
        if (init) begin
            pc <= startAddress;
            prog <= prog + 1;
        end

        if (fetch_unit_en) begin
            if (branch)
                pc <= target;
            else if (branchi) begin
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
			end
            else
                pc <= pc + 1;
        end
    end

    always @(pc) begin
        case (prog)
            2'b01: inst <= rom1[pc];
            2'b10: inst <= rom2[pc];
            2'b11: inst <= rom3[pc];
        endcase
    end

assign rom1[0] = 9'b101010001;
assign rom1[1] = 9'b100011110;
assign rom1[2] = 9'b101001111;
assign rom1[3] = 9'b100001101;
assign rom1[4] = 9'b010010100;
assign rom1[5] = 9'b110010000;
assign rom1[6] = 9'b010001001;
assign rom1[7] = 9'b100001010;
assign rom1[8] = 9'b010011000;
assign rom1[9] = 9'b000001101;
assign rom1[10] = 9'b010001101;
assign rom1[11] = 9'b000001101;
assign rom1[12] = 9'b100001111;
assign rom1[13] = 9'b010010100;
assign rom1[14] = 9'b011011100;
assign rom1[15] = 9'b011110100;
assign rom1[16] = 9'b000101110;
assign rom1[17] = 9'b100001011;
assign rom1[18] = 9'b010011100;
assign rom1[19] = 9'b001111011;
assign rom1[20] = 9'b011110001;
assign rom1[21] = 9'b110010000;
assign rom1[22] = 9'b101000000;
assign rom1[23] = 9'b100000111;
assign rom1[24] = 9'b000011110;
assign rom1[25] = 9'b011110001;
assign rom1[26] = 9'b000001101;
assign rom1[27] = 9'b001100100;
assign rom1[28] = 9'b010110010;
assign rom1[29] = 9'b111100101;
assign rom1[30] = 9'b011011100;
assign rom1[31] = 9'b101001111;
assign rom1[32] = 9'b100001010;
assign rom1[33] = 9'b010001000;
assign rom1[34] = 9'b110101110;
assign rom1[35] = 9'b000101110;
assign rom1[36] = 9'b100001100;
assign rom1[37] = 9'b010011100;
assign rom1[38] = 9'b100001011;
assign rom1[39] = 9'b010001100;
assign rom1[40] = 9'b100001000;
assign rom1[41] = 9'b000111100;
assign rom1[42] = 9'b100001010;
assign rom1[43] = 9'b010001000;
assign rom1[44] = 9'b011110001;
assign rom1[45] = 9'b110100111;
assign rom1[46] = 9'b000101110;
assign rom1[47] = 9'b001111011;
assign rom1[48] = 9'b011110001;
assign rom1[49] = 9'b110010000;
assign rom1[50] = 9'b101000000;
assign rom1[51] = 9'b100000111;
assign rom1[52] = 9'b000011110;
assign rom1[53] = 9'b011110001;
assign rom1[54] = 9'b000001101;
assign rom1[55] = 9'b001100100;
assign rom1[56] = 9'b010110010;
assign rom1[57] = 9'b111100101;
assign rom1[58] = 9'b110110001;
assign rom1[59] = 9'b101001111;
assign rom1[60] = 9'b100001100;
assign rom1[61] = 9'b010001000;
assign rom1[62] = 9'b000101011;
assign rom1[63] = 9'b011010001;
assign rom1[64] = 9'b100001010;
assign rom1[65] = 9'b010001100;
assign rom1[66] = 9'b110110001;
assign rom1[67] = 9'b000101011;
assign rom1[68] = 9'b011010001;
assign rom1[69] = 9'b100001100;
assign rom1[70] = 9'b010011000;
assign rom1[71] = 9'b100001011;
assign rom1[72] = 9'b010001100;
assign rom1[73] = 9'b011111001;
assign rom1[74] = 9'b001111011;
assign rom1[75] = 9'b011110001;
assign rom1[76] = 9'b000011110;
assign rom1[77] = 9'b011110011;
assign rom1[78] = 9'b000011110;
assign rom1[79] = 9'b011110001;
assign rom1[80] = 9'b000011110;
assign rom1[81] = 9'b100001010;
assign rom1[82] = 9'b010001000;
assign rom1[83] = 9'b000011110;
assign rom1[84] = 9'b011110010;
assign rom1[85] = 9'b000011110;
assign rom1[86] = 9'b011110001;
assign rom1[87] = 9'b000011110;
assign rom1[88] = 9'b110110001;
assign rom1[89] = 9'b100001100;
assign rom1[90] = 9'b010001000;
assign rom1[91] = 9'b000101011;
assign rom1[92] = 9'b011010001;
assign rom1[93] = 9'b010011000;
assign rom1[94] = 9'b100001011;
assign rom1[95] = 9'b010001100;
assign rom1[96] = 9'b001111011;
assign rom1[97] = 9'b011110010;
assign rom1[98] = 9'b110010000;
assign rom1[99] = 9'b101000000;
assign rom1[100] = 9'b100000011;
assign rom1[101] = 9'b000011110;
assign rom1[102] = 9'b011110010;
assign rom1[103] = 9'b000001101;
assign rom1[104] = 9'b001100100;
assign rom1[105] = 9'b010110010;
assign rom1[106] = 9'b111100101;
assign rom1[107] = 9'b101001111;
assign rom1[108] = 9'b100001010;
assign rom1[109] = 9'b010001000;
assign rom1[110] = 9'b000011110;
assign rom1[111] = 9'b011110001;
assign rom1[112] = 9'b000011110;
assign rom1[113] = 9'b011110010;
assign rom1[114] = 9'b000011110;
assign rom1[115] = 9'b110110001;
assign rom1[116] = 9'b100001100;
assign rom1[117] = 9'b010001000;
assign rom1[118] = 9'b000101011;
assign rom1[119] = 9'b100001101;
assign rom1[120] = 9'b010000100;
assign rom1[121] = 9'b010011001;
assign rom1[122] = 9'b000001101;
assign rom1[123] = 9'b100001011;
assign rom1[124] = 9'b010001100;
assign rom1[125] = 9'b010011101;
assign rom1[126] = 9'b000001101;
assign rom1[127] = 9'b100001101;
assign rom1[128] = 9'b010010100;
assign rom1[129] = 9'b100001111;
assign rom1[130] = 9'b010000100;
assign rom1[131] = 9'b101100001;
assign rom1[132] = 9'b100101110;
assign rom1[133] = 9'b001100110;
assign rom1[134] = 9'b010110100;
assign rom1[135] = 9'b101110000;
assign rom1[136] = 9'b100110110;
assign rom1[137] = 9'b000001011;

    assign rom1[138] = 9'b000000001;


    assign rom2[0] = 9'b101000101;
    assign rom2[1] = 9'b100001110;
    assign rom2[2] = 9'b101011111;
    assign rom2[3] = 9'b100011011;
    assign rom2[4] = 9'b010010001;
    assign rom2[5] = 9'b101000100;
    assign rom2[6] = 9'b100000000;
    assign rom2[7] = 9'b010001000;
    assign rom2[8] = 9'b000001100;
    assign rom2[9] = 9'b010001100;
    assign rom2[10] = 9'b000001100;
    assign rom2[11] = 9'b101011111;
    assign rom2[12] = 9'b100011111;
    assign rom2[13] = 9'b010010001;
    assign rom2[14] = 9'b100011110;
    assign rom2[15] = 9'b010011001;
    assign rom2[16] = 9'b100011101;
    assign rom2[17] = 9'b010011101;
    assign rom2[18] = 9'b011110111;
    assign rom2[19] = 9'b110010000;
    assign rom2[20] = 9'b101000000;
    assign rom2[21] = 9'b100000111;
    assign rom2[22] = 9'b000011011;
    assign rom2[23] = 9'b011111001;
    assign rom2[24] = 9'b000001101;
    assign rom2[25] = 9'b001100001;
    assign rom2[26] = 9'b010110010;
    assign rom2[27] = 9'b111100101;
    assign rom2[28] = 9'b110100001;
    assign rom2[29] = 9'b011010001;
    assign rom2[30] = 9'b101001111;
    assign rom2[31] = 9'b100001100;
    assign rom2[32] = 9'b010011000;
    assign rom2[33] = 9'b100001101;
    assign rom2[34] = 9'b010001100;
    assign rom2[35] = 9'b100001000;
    assign rom2[36] = 9'b000111100;
    assign rom2[37] = 9'b100001110;
    assign rom2[38] = 9'b010001000;
    assign rom2[39] = 9'b011110100;
    assign rom2[40] = 9'b110100111;
    assign rom2[41] = 9'b000101110;
    assign rom2[42] = 9'b010001000;
    assign rom2[43] = 9'b011110011;
    assign rom2[44] = 9'b110010000;
    assign rom2[45] = 9'b101000000;
    assign rom2[46] = 9'b100000111;
    assign rom2[47] = 9'b000011011;
    assign rom2[48] = 9'b011111001;
    assign rom2[49] = 9'b000001101;
    assign rom2[50] = 9'b001100001;
    assign rom2[51] = 9'b010110010;
    assign rom2[52] = 9'b111100101;
    assign rom2[53] = 9'b110100001;
    assign rom2[54] = 9'b101001111;
    assign rom2[55] = 9'b100001100;
    assign rom2[56] = 9'b010000100;
    assign rom2[57] = 9'b000100110;
    assign rom2[58] = 9'b011001001;
    assign rom2[59] = 9'b100001110;
    assign rom2[60] = 9'b010001000;
    assign rom2[61] = 9'b011110001;
    assign rom2[62] = 9'b001111110;
    assign rom2[63] = 9'b011111001;
    assign rom2[64] = 9'b000011011;
    assign rom2[65] = 9'b011111011;
    assign rom2[66] = 9'b000011011;
    assign rom2[67] = 9'b011111001;
    assign rom2[68] = 9'b000011011;
    assign rom2[69] = 9'b100001101;
    assign rom2[70] = 9'b010001100;
    assign rom2[71] = 9'b000011011;
    assign rom2[72] = 9'b011111001;
    assign rom2[73] = 9'b000011011;
    assign rom2[74] = 9'b011111011;
    assign rom2[75] = 9'b000011011;
    assign rom2[76] = 9'b011111001;
    assign rom2[77] = 9'b000011011;
    assign rom2[78] = 9'b110100001;
    assign rom2[79] = 9'b000100110;
    assign rom2[80] = 9'b011001001;
    assign rom2[81] = 9'b100001100;
    assign rom2[82] = 9'b010010100;
    assign rom2[83] = 9'b110010000;
    assign rom2[84] = 9'b100001110;
    assign rom2[85] = 9'b010001000;
    assign rom2[86] = 9'b001111110;
    assign rom2[87] = 9'b011111010;
    assign rom2[88] = 9'b101000000;
    assign rom2[89] = 9'b100000011;
    assign rom2[90] = 9'b000011011;
    assign rom2[91] = 9'b011111010;
    assign rom2[92] = 9'b000001101;
    assign rom2[93] = 9'b001100001;
    assign rom2[94] = 9'b010110010;
    assign rom2[95] = 9'b111100101;
    assign rom2[96] = 9'b101001111;
    assign rom2[97] = 9'b100001101;
    assign rom2[98] = 9'b010001100;
    assign rom2[99] = 9'b110010000;
    assign rom2[100] = 9'b101000000;
    assign rom2[101] = 9'b100000100;
    assign rom2[102] = 9'b000011011;
    assign rom2[103] = 9'b011111010;
    assign rom2[104] = 9'b000001101;
    assign rom2[105] = 9'b001100001;
    assign rom2[106] = 9'b010110010;
    assign rom2[107] = 9'b111100101;
    assign rom2[108] = 9'b110100001;
    assign rom2[109] = 9'b101001111;
    assign rom2[110] = 9'b100001100;
    assign rom2[111] = 9'b010000100;
    assign rom2[112] = 9'b000100110;
    assign rom2[113] = 9'b110000000;
    assign rom2[114] = 9'b110110000;
    assign rom2[115] = 9'b001111001;
    assign rom2[116] = 9'b001110001;
    assign rom2[117] = 9'b011100001;
    assign rom2[118] = 9'b000101000;
    assign rom2[119] = 9'b011100001;
    assign rom2[120] = 9'b000101000;
    assign rom2[121] = 9'b011100001;
    assign rom2[122] = 9'b000111000;
    assign rom2[123] = 9'b110100001;
    assign rom2[124] = 9'b000001111;
    assign rom2[125] = 9'b001101011;
    assign rom2[126] = 9'b010110010;
    assign rom2[127] = 9'b111001010;
    assign rom2[128] = 9'b100001001;
    assign rom2[129] = 9'b001000100;
    assign rom2[130] = 9'b010101101;
    assign rom2[131] = 9'b101001111;
    assign rom2[132] = 9'b100001101;
    assign rom2[133] = 9'b010001000;
    assign rom2[134] = 9'b000011011;
    assign rom2[135] = 9'b010011000;
    assign rom2[136] = 9'b111001110;
    assign rom2[137] = 9'b110000000;
    assign rom2[138] = 9'b001100100;
    assign rom2[139] = 9'b010110010;
    assign rom2[140] = 9'b111000010;
    assign rom2[141] = 9'b111001001;
    assign rom2[142] = 9'b000001100;
    assign rom2[143] = 9'b001000100;
    assign rom2[144] = 9'b010100001;
    assign rom2[145] = 9'b101011111;
    assign rom2[146] = 9'b100011110;
    assign rom2[147] = 9'b010001001;
    assign rom2[148] = 9'b000011000;
    assign rom2[149] = 9'b010011001;
    assign rom2[150] = 9'b101111111;
    assign rom2[151] = 9'b100111011;
    assign rom2[152] = 9'b010000011;
    assign rom2[153] = 9'b100111101;
    assign rom2[154] = 9'b010000111;
    assign rom2[155] = 9'b011001100;
    assign rom2[156] = 9'b100111110;
    assign rom2[157] = 9'b010001011;
    assign rom2[158] = 9'b011110010;
    assign rom2[159] = 9'b110100001;
    assign rom2[160] = 9'b000100110;
    assign rom2[161] = 9'b010001011;
    assign rom2[162] = 9'b011110011;
    assign rom2[163] = 9'b110101110;
    assign rom2[164] = 9'b000100110;
    assign rom2[165] = 9'b010010100;
    assign rom2[166] = 9'b000001100;
    assign rom2[167] = 9'b100111101;
    assign rom2[168] = 9'b010000111;
    assign rom2[169] = 9'b011101100;
    assign rom2[170] = 9'b010010100;
    assign rom2[171] = 9'b000001100;
    assign rom2[172] = 9'b100111011;
    assign rom2[173] = 9'b010010011;
    assign rom2[174] = 9'b100111111;
    assign rom2[175] = 9'b010000011;
    assign rom2[176] = 9'b101110101;
    assign rom2[177] = 9'b100111110;
    assign rom2[178] = 9'b001100011;
    assign rom2[179] = 9'b010110100;
    assign rom2[180] = 9'b101010000;
    assign rom2[181] = 9'b100010111;
	assign rom2[182] = 9'b000001001;
	assign rom2[183] = 9'b000000001;

    assign rom3[0] = 9'b110010000;
    assign rom3[1] = 9'b101101100;
    assign rom3[2] = 9'b100100010;
    assign rom3[3] = 9'b010010110;
    assign rom3[4] = 9'b101101100;
    assign rom3[5] = 9'b100100001;
    assign rom3[6] = 9'b010010110;
    assign rom3[7] = 9'b101101100;
    assign rom3[8] = 9'b100100011;
    assign rom3[9] = 9'b101010011;
    assign rom3[10] = 9'b100011111;
    assign rom3[11] = 9'b010010110;
    assign rom3[12] = 9'b101001100;
    assign rom3[13] = 9'b100000101;
    assign rom3[14] = 9'b101011000;
    assign rom3[15] = 9'b100010000;
    assign rom3[16] = 9'b010010100;
    assign rom3[17] = 9'b101111000;
    assign rom3[18] = 9'b100110000;
    assign rom3[19] = 9'b010000111;
    assign rom3[20] = 9'b101101100;
    assign rom3[21] = 9'b100100110;
    assign rom3[22] = 9'b010010110;
    assign rom3[23] = 9'b101101100;
    assign rom3[24] = 9'b100100011;
    assign rom3[25] = 9'b010000110;
    assign rom3[26] = 9'b101001000;
    assign rom3[27] = 9'b100001101;
    assign rom3[28] = 9'b110110000;
    assign rom3[29] = 9'b001100111;
    assign rom3[30] = 9'b000000100;
    assign rom3[31] = 9'b101110000;
    assign rom3[32] = 9'b100110001;
    assign rom3[33] = 9'b001000111;
    assign rom3[34] = 9'b010010110;
    assign rom3[35] = 9'b101101100;
    assign rom3[36] = 9'b100100101;
    assign rom3[37] = 9'b010000110;
    assign rom3[38] = 9'b101110000;
    assign rom3[39] = 9'b100110001;
    assign rom3[40] = 9'b001010111;
    assign rom3[41] = 9'b010010110;
    assign rom3[42] = 9'b101011000;
    assign rom3[43] = 9'b100010000;
    assign rom3[44] = 9'b010000101;
    assign rom3[45] = 9'b101101100;
    assign rom3[46] = 9'b100100111;
    assign rom3[47] = 9'b010010110;
    assign rom3[48] = 9'b110010000;
    assign rom3[49] = 9'b101101100;
    assign rom3[50] = 9'b100101000;
    assign rom3[51] = 9'b010010110;
    assign rom3[52] = 9'b101010000;
    assign rom3[53] = 9'b100011000;
    assign rom3[54] = 9'b101101100;
    assign rom3[55] = 9'b100100100;
    assign rom3[56] = 9'b010010110;
    assign rom3[57] = 9'b101001000;
    assign rom3[58] = 9'b100000010;
    assign rom3[59] = 9'b110110000;
    assign rom3[60] = 9'b001100111;
    assign rom3[61] = 9'b000000100;
    assign rom3[62] = 9'b101101100;
    assign rom3[63] = 9'b100100110;
    assign rom3[64] = 9'b010000110;
    assign rom3[65] = 9'b101101100;
    assign rom3[66] = 9'b100100000;
    assign rom3[67] = 9'b010001110;
    assign rom3[68] = 9'b000010111;
    assign rom3[69] = 9'b101101111;
    assign rom3[70] = 9'b100100000;
    assign rom3[71] = 9'b000110110;
    assign rom3[72] = 9'b101000110;
    assign rom3[73] = 9'b100000100;
    assign rom3[74] = 9'b110110000;
    assign rom3[75] = 9'b001100111;
    assign rom3[76] = 9'b000000100;
    assign rom3[77] = 9'b101101100;
    assign rom3[78] = 9'b100100110;
    assign rom3[79] = 9'b010000110;
    assign rom3[80] = 9'b011001001;
    assign rom3[81] = 9'b101001100;
    assign rom3[82] = 9'b100000111;
    assign rom3[83] = 9'b010001100;
    assign rom3[84] = 9'b011111111;
    assign rom3[85] = 9'b000100111;
    assign rom3[86] = 9'b010010110;
    assign rom3[87] = 9'b010001100;
    assign rom3[88] = 9'b011011001;
    assign rom3[89] = 9'b010011100;
    assign rom3[90] = 9'b101101100;
    assign rom3[91] = 9'b100100100;
    assign rom3[92] = 9'b010000110;
    assign rom3[93] = 9'b101110000;
    assign rom3[94] = 9'b100110001;
    assign rom3[95] = 9'b001000111;
    assign rom3[96] = 9'b010010110;
    assign rom3[97] = 9'b101000011;
    assign rom3[98] = 9'b100001001;
    assign rom3[99] = 9'b000001000;
    assign rom3[100] = 9'b101101100;
    assign rom3[101] = 9'b100100010;
    assign rom3[102] = 9'b010000110;
    assign rom3[103] = 9'b101110000;
    assign rom3[104] = 9'b100110001;
    assign rom3[105] = 9'b001010111;
    assign rom3[106] = 9'b010010110;
    assign rom3[107] = 9'b101101100;
    assign rom3[108] = 9'b100100100;
    assign rom3[109] = 9'b010000110;
    assign rom3[110] = 9'b101100000;
    assign rom3[111] = 9'b100100100;
    assign rom3[112] = 9'b000110110;
    assign rom3[113] = 9'b000010110;
    assign rom3[114] = 9'b101000111;
    assign rom3[115] = 9'b100001010;
    assign rom3[116] = 9'b110110000;
    assign rom3[117] = 9'b001100111;
    assign rom3[118] = 9'b000000100;
    assign rom3[119] = 9'b101000100;
    assign rom3[120] = 9'b100001101;
    assign rom3[121] = 9'b000001000;
    assign rom3[122] = 9'b101101100;
    assign rom3[123] = 9'b100101000;
    assign rom3[124] = 9'b101010000;
    assign rom3[125] = 9'b100010001;
    assign rom3[126] = 9'b010010110;
    assign rom3[127] = 9'b101000100;
    assign rom3[128] = 9'b100001101;
    assign rom3[129] = 9'b000001000;
    assign rom3[130] = 9'b101101100;
    assign rom3[131] = 9'b100100001;
    assign rom3[132] = 9'b010000110;
    assign rom3[133] = 9'b101001100;
    assign rom3[134] = 9'b100001000;
    assign rom3[135] = 9'b010001100;
    assign rom3[136] = 9'b001010111;
    assign rom3[137] = 9'b010010110;
    assign rom3[138] = 9'b101000001;
    assign rom3[139] = 9'b100000111;
    assign rom3[140] = 9'b000001000;
    assign rom3[141] = 9'b110010000;
    assign rom3[142] = 9'b101101100;
    assign rom3[143] = 9'b100101000;
    assign rom3[144] = 9'b010010110;
    assign rom3[145] = 9'b101010000;
    assign rom3[146] = 9'b100010101;
    assign rom3[147] = 9'b101101100;
    assign rom3[148] = 9'b100100100;
    assign rom3[149] = 9'b010010110;
    assign rom3[150] = 9'b101001100;
    assign rom3[151] = 9'b100001000;
    assign rom3[152] = 9'b110110000;
    assign rom3[153] = 9'b001100111;
    assign rom3[154] = 9'b000000100;
    assign rom3[155] = 9'b101101100;
    assign rom3[156] = 9'b100100110;
    assign rom3[157] = 9'b010000110;
    assign rom3[158] = 9'b101101100;
    assign rom3[159] = 9'b100100000;
    assign rom3[160] = 9'b010001110;
    assign rom3[161] = 9'b000010111;
    assign rom3[162] = 9'b101101111;
    assign rom3[163] = 9'b100100000;
    assign rom3[164] = 9'b000110110;
    assign rom3[165] = 9'b101001011;
    assign rom3[166] = 9'b100001001;
    assign rom3[167] = 9'b110110000;
    assign rom3[168] = 9'b001100111;
    assign rom3[169] = 9'b000000100;
    assign rom3[170] = 9'b101101100;
    assign rom3[171] = 9'b100100110;
    assign rom3[172] = 9'b010000110;
    assign rom3[173] = 9'b011001001;
    assign rom3[174] = 9'b010010110;
    assign rom3[175] = 9'b101101100;
    assign rom3[176] = 9'b100100100;
    assign rom3[177] = 9'b010000110;
    assign rom3[178] = 9'b101110000;
    assign rom3[179] = 9'b100110001;
    assign rom3[180] = 9'b001000111;
    assign rom3[181] = 9'b010010110;
    assign rom3[182] = 9'b101001001;
    assign rom3[183] = 9'b100000110;
    assign rom3[184] = 9'b000001000;
    assign rom3[185] = 9'b101101100;
    assign rom3[186] = 9'b100100010;
    assign rom3[187] = 9'b010000110;
    assign rom3[188] = 9'b101110000;
    assign rom3[189] = 9'b100110001;
    assign rom3[190] = 9'b001010111;
    assign rom3[191] = 9'b010010110;
    assign rom3[192] = 9'b101101100;
    assign rom3[193] = 9'b100101000;
    assign rom3[194] = 9'b101010000;
    assign rom3[195] = 9'b100010001;
    assign rom3[196] = 9'b010010110;
    assign rom3[197] = 9'b101001010;
    assign rom3[198] = 9'b100001010;
    assign rom3[199] = 9'b000001000;
    assign rom3[200] = 9'b101101100;
    assign rom3[201] = 9'b100100001;
    assign rom3[202] = 9'b010000110;
    assign rom3[203] = 9'b101001100;
    assign rom3[204] = 9'b100001000;
    assign rom3[205] = 9'b010001100;
    assign rom3[206] = 9'b001010111;
    assign rom3[207] = 9'b010010110;
	assign rom3[208] = 9'b000000001;


endmodule