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
    logic[8:0][511:0]   rom;
    
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

    assign  rom[0] = 9'b101000101;      // movih r0 0101
    assign  rom[1] = 9'b100001010;      // movil r0 1010

    assign  rom[2] = 9'b101011101;      // movih r0 0101
    assign  rom[3] = 9'b100011110;      // movil r0 1010

    assign  rom[4] = 9'b001010001;      // add r0 r1 result should be 00111000

    assign  rom[5] = 9'b000000001;      // halt

    always @(pc) begin
        inst <= rom[pc];
    end

endmodule
