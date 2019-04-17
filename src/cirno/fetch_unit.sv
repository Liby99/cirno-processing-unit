module fetch_unit(
    input       clk,
    input       init,
    input       branch,
    input       branchi,
    input       fetch_unit_en,
    input[8:0]  startAddress,
    input[8:0]  target,
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

    always @(pc) begin
        inst <= rom[pc];
    end

endmodule
