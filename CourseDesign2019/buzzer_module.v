`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:55 06/29/2019 
// Design Name: 
// Module Name:    buzzer_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module buzzer_module(
	 input CLK,
    input beep_flag1,
	 input beep_flag2,
    output beep
    );
	reg beep_value;
	always @(posedge CLK)
	begin
		if(beep_flag1||beep_flag2) beep_value <= 0;
		else beep_value <= 1;
	end
	assign beep = beep_value;
endmodule
