`timescale 1ns / 1ps

module mux(i0, i1, select,out);

(* S = "TRUE" *) input i0, i1, select;
output out;

reg temp;

always @*
begin
	if(select)
		temp <= i0;
	else
		temp <= i1;
end

assign out = temp;

endmodule
