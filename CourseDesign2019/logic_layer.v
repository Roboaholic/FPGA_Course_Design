`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:24:59 06/27/2019 
// Design Name: 
// Module Name:    logic_layer 
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
module logic_layer(
		input CLK,
		input RSTn,
		input [3:0]key_value,
	   input [23:0]Number_Sig,
		input beep,
		output [2:0]air_condition,
		output [23:0]Num_output,
		output [1:0]zero_signal
    );
	 reg [23:0]Num;
    reg [2:0]j;
	 reg [23:0]Num_temp;
	 reg [23:0]Num_purpose;  //正常数格式
	 reg [23:0]Num_bias;    
	 reg [23:0]Num_warning;
	 reg [2:0]air_condition_tmp;
	 reg [1:0]zero_flag;
	 reg [28:0]cnt;
	 reg cmp_flag;
	 reg [1:0]mode_flag;//如果是1代表定时睡眠模式，如果等于2代表定时关机模式
	 reg [1:0]beep_flag;
	 reg beep_signal;
	/******************************************/    
	 
	parameter TMS = 28'd99_999_999;  
	 
	/******************************************/  
	 
	reg [15:0]C1;
	
	always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
			C1 <= 23'd0;
		else if( C1 == TMS )
		    C1 <= 23'd0;
		else
		    C1 <= C1 + 1'b1;
/*	
task number_trans;
	input [16:0]NUM_IN;
	output [23:0]NUM_OUT;
	begin
		NUM_OUT[7:4] <= NUM_IN/1%10;
		NUM_OUT[11:8] <= NUM_IN/10%10;
		NUM_OUT[15:12] <= NUM_IN/100%10;
		NUM_OUT[19:16] <= NUM_IN/1000%10;
		NUM_OUT[23:20] <= NUM_IN/10000%10;
	end

endtask


task number_intrans;
	input [23:0]NUM_IN;
	output [16:0]NUM_OUT;
	begin
		NUM_OUT <= NUM_IN[7:4]+ NUM_IN[11:8]*10 + NUM_IN[15:12]*100 + NUM_IN[19:16]*1000;
	end
	
endtask

*/

    always @ ( posedge CLK or negedge RSTn )
	 begin
			if( !RSTn )
			begin
		       j <= 3'd0;
			    Num <= 1'd0;  //Num直接和数码管挂钩
				 Num_temp <= 23'd0;
				 Num_purpose<=23'd99999;  //default maxmum value
				 Num_warning<=12'b0011_0000_0000;
				 beep_signal<=1'b1;
				 beep_flag==1'b1;//允许蜂鸣器响
			end
			else
            case( j )
				
            0:     //init mode
				if(key_value[0]) j <= j + 1'b1;
            else 
				begin
					Num <= 23'b0;  
					mode_flag<=1'b0;
				end
				
				1:  //状态1，设定睡眠时间
				if(key_value[0])
				begin
					j <= j + 1'b1;
					Num_temp <= 23'b0;
				end
				else
				begin
					if(key_value[2])   //二号按键，十位加减
					begin 
						Num_temp <= Num_temp + 16'b1_0000_0000;
						if(Num_temp[11:8]>4'd8) Num_temp[11:8] <= 1'd0;
					end
					else if(key_value[1])   //四号号按键，百位加减
					begin
						Num_temp <= Num_temp + 16'd1_0000_0000_0000;
						if(Num_temp[15:12]>4'd8) Num_temp[15:12] <= 1'd0;
					end
					
					else if(key_value[3])   //三号按键，确定计时
					begin
						Num_purpose[19:4] <= Num_temp[19:4];
						Num_bias[7:4] <= Number_Sig[7:4];
						Num_bias[11:8] <= Number_Sig[11:8];
						Num_bias[15:12] <= Number_Sig[15:12];
						Num_bias[19:16] <= Number_Sig[19:16];
						beep_flag <= 1'b1;  //重新设定时间后，beep_flag置1，允许蜂鸣器
						zero_flag <= 1'b1;
						mode_flag <= 1'd1;
					end
					
					Num <= Num_temp;
					Num[23:20] <= 4'b0001;
				end
				
				
				2:  //状态1，设定关机时间
				if(key_value[0])
				begin
					j <= j + 1'b1;
					Num_temp <= 23'b0;
				end
				else
				begin
					if(key_value[2])   //二号按键，十位加减
					begin 
						Num_temp <= Num_temp + 16'b1_0000_0000;
						if(Num_temp[11:8]>4'd8) Num_temp[11:8] <= 1'd0;
					end
					else if(key_value[1])   //四号号按键，百位加减
					begin
						Num_temp <= Num_temp + 16'd1_0000_0000_0000;
						if(Num_temp[15:12]>4'd8) Num_temp[15:12] <= 1'd0;
					end
					
					else if(key_value[3])   //三号按键，确定计时
					begin
						Num_purpose[19:4] <= Num_temp[19:4];
						Num_bias[7:4] <= Number_Sig[7:4];
						Num_bias[11:8] <= Number_Sig[11:8];
						Num_bias[15:12] <= Number_Sig[15:12];
						Num_bias[19:16] <= Number_Sig[19:16];
						beep_flag <= 1'b1;  //重新设定时间后，beep_flag置1，允许蜂鸣器
						zero_flag <= 1'b1;
						mode_flag <= 1'd2;
					end
					
					Num <= Num_temp;
					Num[23:20] <= 4'b0010;
				end

				3:                    //正计时模式
				if(key_value[0]) 
				begin
					j <= j+1'b1;
					Num_temp<=1'b0;
					cnt<=1'b0;
					cmp_flag<=1'b0;
				end
				else 
				begin 
				/*
					Num[7:4] <= Number_Sig[7:4]-Num_bias[7:4];
					Num[11:8] <= Number_Sig[11:8]-Num_bias[11:8];
					Num[15:12] <= Number_Sig[15:12]-Num_bias[15:12];
					Num[19:16] <= Number_Sig[19:16]-Num_bias[19:16];
					*/
					zero_flag<=1'd0;
					Num<=Number_Sig;
					if(Number_Sig[19:4]>Num_purpose[19:4]) 
					begin
						if(mode_flag==1'd1) Num[19:4]<=16'b1011_1011_1011_1011;
						else if(mode_flag==1'd2) Num[19:4]<=16'b1100_1100_1100_1100;
					end
					if(Number_Sig[19:4]>Num_warning[19:4])
					begin
						//Num[19:4]<=16'b1000_1000_1000_1000;
						if(beep_flag==1'b1) 
						begin
							//beep_flag <= 1'b0;  //蜂鸣器flag关闭，确保下次设时前只响一次
							beep_signal<=1'b0;//蜂鸣器响
							Num[19:4]<=16'b1001_1001_1001_1001;
							if(cnt>TMS) 
							begin
								beep_flag<=1'b0;
								beep_signal<=1'b1;
							end
							cnt <= cnt + 1'b1;
						end
					end	

					Num[23:20] <= 4'b0011;
				end
				4: //设置空气质量
				if(key_value[0]) j <= 1'b0;
				else 
				begin
					if(key_value[1])   //二号按键，空气质量+
					begin 
						Num_temp[7:4] <= Num_temp[7:4] + 1'b1;
						if(Num_temp[7:4]>=3'd5) Num_temp[7:4] <= 1'b0;
					end
					
					else if(key_value[2])   //三号按键，空气质量
					begin
						Num_temp[7:4] <= Num_temp[7:4] - 1'b1;
						if(Num_temp[7:4]==4'b1111) Num_temp[7:4] <= 3'd5;
					end
				
					else if(key_value[3])   //四号按键，确定计时
					begin
						air_condition_tmp[2:0] <= Num_temp[2:0];
					end
				Num<=Num_temp;
				Num[23:20] <= 3'd4;
				end
			endcase
	end
	assign zero_signal = zero_flag;
	assign Num_output = Num;
	assign air_condition = air_condition_tmp;
	assign beep = beep_signal;
endmodule



	