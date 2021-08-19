`timescale 1ns / 10ps

module puf
#
(
parameter N = 128
)
(clk, start, challenge, response);

input clk, start, challenge;
output response;

wire clk, start;
wire [N-1:0] challenge, response;
wire latchWire;

// create a timer
timer theTimer(.clk(clk), .start(start), .running(latchWire));

// generate N 1 bit PUFs and operate them in parallel
genvar i;
generate
	for(i = 0; i < N; i = i + 1) 
	begin : PUFLOOP
		puf1bit pufElement (
			 .clk(clk), 
			 .start(start), 
			 .challenge(challenge[i]), 
			 .response(response[i]),
			 .timerSignal(latchWire)
			 );
	end	
endgenerate

endmodule
