`timescale 1ns / 1ps

module main
(
slideSwitch2,
pushButton1,
clk, // This is the 50 MHz clock
rx, // Serial port pin
tx, // Serial port pin
startSerial,
led
);

input slideSwitch2, pushButton1, clk, rx, startSerial;
output tx;
output led;


wire [7:0] led;
//wire [7:0] rxData;
wire [7:0] txData;
wire tempData;

// signals the serial port to send or not
reg dataReadyToBeSentReg;

// signals used to start PUFs
wire startPuf, challengeData;

// only send data on serial port when the button is down
always @(startSerial)
begin	
	if(startSerial)
	begin
		// button2 just went on, starting oscillation
		// stop sending data
		dataReadyToBeSentReg <= 1;
	end
	else
	begin
		// button2 just went off, stopping oscillation
		// send the data
		dataReadyToBeSentReg <= 0;
	end
end

// configure the serial port interface
serialPort serial(.clk(clk), /*.RxD(rx),*/ .TxD(tx), .txData(txData), /*.rxData(rxData), */.txStart(dataReadyToBeSentReg));

// debounce an input switch
top debouncer1 (.clk(clk), .button_in(pushButton1), .button_out(startPuf));
top debouncer2 (.clk(clk), .button_in(slideSwitch2), .button_out(challengeData));

// configure a PUF
puf puf1 (
    .clk(clk), 
    .start(startPuf), 
    .challenge(challengeData), 
    .response(tempData)
    );
	
//ringoscillator osc(.out(tempData));

// connect outputs
assign txData = tempData + 8'd65;
assign led = tempData;



endmodule
