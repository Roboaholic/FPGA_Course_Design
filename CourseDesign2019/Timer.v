module Timer
(
    input CLK,
	input RSTn,
	input [1:0]zero_signal,
    // input Re_flag;
	output [23:0]Number_Sig  //0:3表示0.1s位，4:7表示s位，以此类推，��
);
   
	 /******************************/
	 
	 parameter T100MS = 23'd4_999_999;          //100ms的计�
	 
	 /******************************/
	 
	 reg [22:0]C1;
	 
	 always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
		      C1 <= 23'd0;
		else if( C1 == T100MS )
		      C1 <= 23'd0;
        
		else 
		      C1 <= C1 + 1'b1;
	
	  /*******************************************************/
	 
	 reg [3:0]i;
	 reg [23:0]rNum;
	 reg [23:0]rNumber;
	 
	 always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn || zero_signal)
			    begin
			        i <= 4'd0;
					  rNum <= 24'd0;
					  rNumber <= 24'd0;
				 end
		else
			case( i )
				 
				    0: //0.1s
					if( C1 == T100MS ) 
                    begin 
                        rNum[3:0] <= rNum[3:0] + 1'b1;
                        i <= i + 1'b1; 
                    end                 //个位的计�
					  
					1: //1s �
					if( rNum[3:0] > 4'd9 ) 
                    begin 
                        rNum[7:4] <= rNum[7:4] + 1'b1;
                        rNum[3:0] <= 4'd0; 
                        i <= i + 1'b1; 
                    end                 //个位>9, 进位给十�
					else i <= i + 1'b1; 
					  
					2:
					if( rNum[7:4] > 4'd9 )
                    begin rNum[11:8] <= rNum[11:8] + 1'b1;
                    rNum[7:4] <= 4'd0;
                    i <= i + 1'b1;
                    end                //十位>9, 进位给百�
					else i <= i + 1'b1;
					  
					3:
					if( rNum[11:8] > 4'd9 )
                    begin rNum[15:12] <= rNum[15:12] + 1'b1;
                    rNum[11:8] <= 4'd0;
                    i <= i + 1'b1;
                    end                 //百位>9, 进位给千�
					else i <= i + 1'b1;
					  
					4:
					if( rNum[15:12] > 4'd9 )
                    begin
                        rNum[19:16] <= rNum[19:16] + 1'b1;
                        rNum[15:12] <= 4'd0;
                        i <= i + 1'b1;
                        end             //千位>9, 进位给万�
			        else i <= i + 1'b1;
					  
					5:  //千秒�
					if( rNum[19:16] > 4'd9 )
                    begin
                        rNum[23:20] <= rNum[23:20] + 1'b1;
                        rNum[19:16] <= 4'd0;
                    end             //万位>9, 进位给十万位
					else i <= i + 1'b1;
					  
					6:
					if( rNum[23:20] > 4'd9 )
                    begin
                        rNum <= 24'd0;
                        i <= i + 1'b1;
                    end       //十万�9, 全部�
					else i <= i + 1'b1; 
					  
					7:
					begin 
                    rNumber <= rNum; i <= 4'd0; end    //只有到这里i才会清了，状态机每到这里一次输出一次数字，七个状态后输出一�
				 
			endcase

    /*******************************************************/
	 
	 assign Number_Sig = rNumber;
	 
	 /*******************************************************/
	 
endmodule
