`timescale 1ns / 1ps

module timer(
	input wire clk, start,
	output reg running);
	
	reg[20:0] counter;
	
	always @(posedge clk)
	begin
		if(start)
		begin
			counter <= ~20'b0;
			running <= 1'b0; // initializing, not running
		end
		else
		begin
			if(counter > 20'b0)
				begin
					counter <= counter - 1;
					running <= 1'b1; // running, so open the latch at the other side
				end
			else
				begin
					running <= 1'b0; // timer has finished, so not running anymore
				end
		end
	end
	
endmodule

module counter 
#(parameter N=64)
(C, Q, latch, clr);

input C, clr, latch;
output [N-1:0] Q;
reg [N-1:0] r_reg;
wire [N-1:0] r_next;

// on a clock edge, increment the count, assuming no clear signal and the latch is activated
always @	(posedge C)
	if(clr)
	begin
		r_reg <= 0;
	end
	else
	begin
		if(latch)
			r_reg <= r_next;
	end
	
// output the counter register to the output signal
assign Q = r_reg;
assign r_next = r_reg + 1;

endmodule

module top (clk, button_in, button_out);
  input             clk;              
  input       		  button_in;        
  reg        [19:0] count = 0;        
  reg               button_tmp = 0;   
  output reg        button_out = 0;   

  always @ (posedge clk) begin
    count <= count + 1;
    button_tmp <= button_in;
    if (count == 0)
      button_out <= button_tmp;
  end
endmodule

