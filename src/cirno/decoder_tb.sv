module decoder_tb
    logic      clk;
    logic      init;            
    wire       done; 
    logic[8:0] inst;
    logic      type_1, type_2, type_3, type_4, type_5;
    logic[1:0] r1, r2;
    logic[3:0] funct;
    logic[5:0] immediate;           

    decoder decoder(.*);

    initial begin

endmodule