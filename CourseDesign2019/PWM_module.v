`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:25 06/29/2019 
// Design Name: 
// Module Name:    PWM_module 
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
module PWM_module(
    input [4:0]tone,
	 input CLK,
	 input RSTn,
	 input sing_flag,
	 output beep_flag
    );
	 

	parameter T10MS = 23'd499; 	
	parameter T20MS = 23'd999;          
	parameter T30MS = 23'd1499;         
	parameter T40MS = 23'd1999;          
	parameter T50MS = 23'd2499;          
	parameter T60MS = 23'd2999;
	parameter T70MS = 23'd3499;
	parameter T80MS = 23'd3999;
	parameter T90MS = 23'd4499;	 
	parameter T100MS = 23'd4999;          //100ms的计�
	 
	 /******************************/
	reg [3:0]i;
	reg [22:0]C1;
	reg flag;
	reg beep_value;
	always @ ( posedge CLK or negedge RSTn )
	   if( !RSTn )
		      C1 <= 23'd0;
		else if( C1 == T100MS )
		      C1 <= 23'd0;
        
		else 
		      C1 <= C1 + 1'b1;
				
				
	always @ ( posedge CLK or negedge RSTn )
	   if( !RSTn )
			    begin
			        i <= 4'd0;
				 end
		else 
		begin
			case( tone )
				0:       
				beep_value<=1'b0;
				4'd1:
				if( C1 <= T10MS ) beep_value<=1'b1;
				else beep_value<=1'b0;      
				4'd2:
				if( C1 <= T20MS ) beep_value<=1'b1;
				else beep_value<=1'b0;    
				4'd3:
				if( C1 <= T30MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd4:
				if( C1 <= T40MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd5:
				if( C1 <= T50MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd6:
				if( C1 <= T60MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd7:
				if( C1 <= T70MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd8:
				if( C1 <= T80MS ) beep_value<=1'b1;
				else beep_value<=1'b0;  
				4'd9:
				if( C1 <= T90MS ) beep_value<=1'b1;
				else beep_value<=1'b0;				
				4'd7:
				if( C1 <= T100MS ) beep_value<=1'b1;
				else beep_value<=1'b0;   
				
			endcase
		end
		assign beep_flag = beep_value;
endmodule
