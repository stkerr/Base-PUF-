`timescale 1ns / 1ps

module ringoscillator(out);

output out;

(* KEEP = "TRUE" *)(* S = "TRUE" *) wire connector;
(* KEEP = "TRUE" *)(* S = "TRUE" *) wire [36:0] w;

not inputGate(w[0], connector);

// generate inverters
genvar i;

generate
	for(i = 0; i < 35; i = i + 1) 
	begin : GATELOOP
		not gate(w[i+1], w[i]);
		if(i+1 == 35)
			not endGate(connector, w[i+1]);	
	end	
endgenerate

assign out = connector;

endmodule
