module smg_logic_module
(
    input CLK,
	input RSTn,
	input [23:0]Num_output,
    input [3:0]key_value,
	output [3:0]Number_Data
);

	/******************************************/    
	 
	 parameter T1MS = 16'd49999;            //1ms计数
	 
	/******************************************/  
	 
	reg [15:0]C1;
	
	always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
			C1 <= 16'd0;
		else if( C1 == T1MS )
		    C1 <= 16'd0;
		else
		    C1 <= C1 + 1'b1;
	 
	/******************************************/ 
	 

	/*************Logical Section***************/
 /*   reg [23:0]Num_output;
    reg [2:0]j;
    always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		    begin
		        j <= 3'd0;
			    Num_output <= 1'd0;
			end
        else
            case( j )
            0:
				if(key_value[0]) j <= j + 1'b1;
            else Num_output <= 23'b0;

				1:
				if(key_value[0]) j <= j + 1'b1;
				else begin
					Num_output[23:20] <= 4'b0001;

				2:
				if(key_value[0]) j <= j + 1'b1;
				else 
				begin
					Num_output[23:20] <= 4'b0010;
				end
				3:
				j <= 1'b0;
			endcase
*/
/******************数码管写�*******************/
	 reg [3:0]i;
	 reg [3:0]rNumber;
	 always @ ( posedge CLK or negedge RSTn )
	 begin
	     if( !RSTn )
		      begin
		          i <= 4'd0;
			    	 rNumber <= 4'd0;
				end
		  else 
		      case( i )
				
				    0:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Num_output[23:20];          //十万位数码管显示           
	
					 1:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= 1'd0;          //万位数码管显�
					 
					 2:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Num_output[19:16];          //千位数码管显�
					 
					 3:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Num_output[15:12];         //百位数码管显�
					 
					 4:
					 if( C1 == T1MS ) i <= i + 1'b1;
					 else rNumber <= Num_output[11:8];            //十位数码管显�
					 
					 5:
					 if( C1 == T1MS ) i <= 4'd0;
					 else rNumber <= Num_output[7:4];            //低位数码管显�
				
				endcase
	end		
    /******************************************/ 
	 
	 assign Number_Data = rNumber;
	 
	 /******************************************/
	 
endmodule
