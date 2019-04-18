
module tb();	       // to test bench: "done with that program"
    logic   clk;
    logic   init;
    logic   done;

    top_level top_level1(.*);

always begin
  #5ns clk = 1;            // tic
  #5ns clk = 0;			   // toc
end				

initial begin
    init <= 1;
    #30ns init <= 0;
    wait(top_level1.done);
end
endmodule