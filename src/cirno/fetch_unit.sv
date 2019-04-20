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
    logic[8:0]   rom1[512];
    logic[8:0]   rom2[512];
    logic[8:0]   rom3[512];
    logic[1:0]          prog = 0;

		initial begin
			$readmemb("programs/prog1.mem", rom1);
			$readmemb("programs/prog2.mem", rom2);
			$readmemb("programs/prog3.mem", rom3);
		end

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
endmodule
