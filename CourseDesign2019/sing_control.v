`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:46 06/29/2019 
// Design Name: 
// Module Name:    sing_control 
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
module sing_control(
	 input CLK,
	 input RSTn,
    input sing_flag,
    output [4:0]tone
    );
	 
	parameter TS = 32'd199_999_99;          //1s
	 
	 /******************************/
	reg [3:0]i;
	reg [31:0]C1;
	reg [4:0]tone_value;
	always @ ( posedge CLK or negedge RSTn )
	   if( !RSTn )
		      C1 <= 32'd0;
		else if( C1 == TS )
		      C1 <= 32'd0;
		else 
		      C1 <= C1 + 1'b1;	
				
	 always @ ( posedge CLK or negedge RSTn )
	 
	 begin
	     if( !RSTn || !sing_flag)
		      begin
		          i <= 1'b0;
					 tone_value <= 1'd0;
				end
		  
		  else 
				//if(!sing_flag) i <= 1'b0;
		      case( i )
				
				    0:
					 if( C1 == TS ) i <= i + 1'b1;  
					 else tone_value <= 1'd0;
					 1:
					 if( C1 == TS ) i <= i + 1'b1;  
					 else tone_value <= 4'd1;
					 2:
					 if( C1 == TS ) i <= i + 1'b1;   
				    else tone_value <= 4'd2;
					 3:
					 if( C1 == TS ) i <= i + 1'b1; 
					 else tone_value <= 4'd3;
					 4:
					 if(C1== TS) i <= i + 1'b1;
					 else tone_value <= 4'd4;
					 5:
					 if( C1 == TS ) i <= i + 1'b1;
					 else tone_value <= 4'd5;
					 6:
					 if( C1 == TS ) i <= i + 1'b1;
					 else tone_value <= 4'd6;
					 7:
					 if( C1 == TS ) i <= i + 1'b1;
					 else tone_value <= 4'd7;
					 8:
					 if( C1 == TS ) i <= i + 1'b1;
					 else tone_value <= 4'd8;
					 9:		
					 if( C1 == TS ) i <= i + 1'b1;
					 else tone_value <= 4'd9;
					 10:
					 if( C1 == TS ) i <= 1'b0;
					 else tone_value <= 4'd10;
					 
		
				endcase
			end
		assign tone = tone_value;	 
endmodule
