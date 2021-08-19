`timescale 1ns / 10ps

module puf(
input wire clk,
input wire start,
input wire challenge,
output wire response
);

// variables
wire latchWire; // latch signal for the counters
(* KEEP = "TRUE" *) (* S = "TRUE" *) wire oscillatorWire1, oscillatorWire2, oscillatorWire3, oscillatorWire4; // connect the oscillators to the mux
wire[63:0] dataLine1, dataLine2; // used for the counters
reg responseBuffer;

// create a timer
timer theTimer(.clk(clk), .start(start), .running(latchWire));

// create N oscillators in pairs
ringoscillator oscillator1 (.out(oscillatorWire1));
ringoscillator oscillator2 (.out(oscillatorWire2));

// top multiplexer and counter
mux mux1(.select(challenge), .i0(oscillatorWire1), .i1(oscillatorWire2), .out(counterClock1));
counter theCounter1(.C(counterClock1), .Q(dataLine1), .clr(start), .latch(latchWire)); 

// bottom multiplexer and counter
mux mux2(.select(challenge), .i0(oscillatorWire2), .i1(oscillatorWire1), .out(counterClock2));
counter theCounter2(.C(counterClock2), .Q(dataLine2), .clr(start), .latch(latchWire)); 

// select the appropriate counter and output the signal
always @*
begin
	if(dataLine1 > dataLine2)
		responseBuffer <= 1;
	else
		responseBuffer <= 0;
end
assign response = responseBuffer;

endmodule
