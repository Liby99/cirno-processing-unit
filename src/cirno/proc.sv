// dummy processor -- substitute your top level design
// CSE141L   Spring 2019
module prog #(parameter AW = 8, DW = 8)
 (input        clk,
               reset,	       // master reset from bench: "start over"
		       req,		       // from test bench: "do next program"
  output logic ack);	       // to test bench: "done with that program"

logic[15:0] ct;                // dummy cycle counter
// memory connections -- dummied in for now
// you will need to drive these actively
logic  [AW-1:0] MemAdr;	       // memory address pointer, shared for read and write
logic  [DW-1:0] DatIn;		   // data path in, for STORE operations
wire   [DW-1:0] DatOut;		   // data path out, for LOAD operations 
logic           ReadEn  = 1;   // can tie high in most designs
logic           WriteEn = 0;   // normally low, but high for STORE

dm #(.DW(DW),.AW(AW)) dm1(.*); // instantiate data memory
// optional data width and address width parametric overrides

// the following sequence makes sure the test bench
//  stops; in practice, you will want to tie your ack
//  flags to the completion of each program
always @(posedge clk) begin
  if(reset) begin
    ct  <= 0;
	ack <= 0;
  end
  else if(req) begin
	ct  <= 0;
	ack <= 0;
  end
  else begin
    if(ct<255) 
      ct <= ct+1;
    else
      ack <= 1;				   // tells test bench to request next program
  end
end


endmodule