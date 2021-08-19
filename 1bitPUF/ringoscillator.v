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

/*
invertergate inputGate(.in(connector),  .out(w[0]));

nandgate inv1(.i1(stop),    .i2(w[0]),  .out(w[1]));
invertergate inv2(			.in(w[1]),  .out(w[2]));
nandgate inv3(.i1(stop),    .i2(w[2]),  .out(w[3]));
invertergate inv4(			.in(w[3]),  .out(w[4]));
nandgate inv5(.i1(stop),    .i2(w[4]),  .out(w[5]));
invertergate inv6(			.in(w[5]),  .out(w[6]));
nandgate inv7(.i1(stop), 	.i2(w[6]),  .out(w[7]));
invertergate inv8(			.in(w[7]),  .out(w[8]));
nandgate inv9(.i1(stop),    .i2(w[8]),  .out(w[9]));
invertergate inv10(			.in(w[9]),  .out(w[10]));
nandgate inv11(.i1(stop), 	.i2(w[10]), .out(w[11]));
invertergate inv12(			.in(w[11]), .out(w[12]));
nandgate inv13(.i1(stop),   .i2(w[12]), .out(w[13]));
invertergate inv14(			.in(w[13]), .out(w[14]));
nandgate inv15(.i1(stop), 	.i2(w[14]), .out(w[15]));
invertergate inv16(			.in(w[15]), .out(w[16]));
nandgate inv17(.i1(stop), 	.i2(w[16]), .out(w[17]));
invertergate inv18(			.in(w[17]), .out(w[18]));
nandgate inv19(.i1(stop), 	.i2(w[18]), .out(w[19]));
invertergate inv20(			.in(w[19]), .out(w[20]));
nandgate inv21(.i1(stop), 	.i2(w[20]), .out(w[21]));
invertergate inv22(			.in(w[21]), .out(w[22]));
nandgate inv23(.i1(stop), 	.i2(w[22]), .out(w[23]));
invertergate inv24(			.in(w[23]), .out(w[24]));
nandgate inv25(.i1(stop), 	.i2(w[24]), .out(w[25]));
invertergate inv26(			.in(w[25]), .out(w[26]));
nandgate inv27(.i1(stop), 	.i2(w[26]), .out(w[27]));
invertergate inv28(			.in(w[27]), .out(w[28]));
nandgate inv29(.i1(stop), 	.i2(w[28]), .out(w[29]));
invertergate inv30(			.in(w[29]), .out(w[30]));
nandgate inv31(.i1(stop), 	.i2(w[30]), .out(w[31]));
invertergate inv32(			.in(w[31]), .out(w[32]));
nandgate inv33(.i1(stop), 	.i2(w[32]), .out(w[33]));
invertergate inv34(			.in(w[33]), .out(w[34]));
nandgate inv35(.i1(stop), 	.i2(w[34]), .out(w[35]));
invertergate inv36(			.in(w[35]), .out(w[36]));
nandgate inv37(.i1(stop), 	.i2(w[36]), .out(finalWire));

nandgate	finalGate(.i1(stop),	.i2(finalWire), .out(connector));
*/

assign out = connector;

endmodule
