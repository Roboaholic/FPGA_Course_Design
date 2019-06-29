module Module_Top
(
    input CLK,
	input RSTn,
	input [3:0]KEY_IN,
	output beep,
	output[3:0]led,
	output [7:0]SMG_Data,
	output [5:0]Scan_Sig
);

    /******************************/ 
	wire [23:0]Num_output;		
   wire [23:0]Number_Sig;
	wire [3:0]key_value; 
	wire [1:0]zero_signal;
	wire [1:0]zero_signal2;
	wire [23:0]Number_Sig2;
	//wire [2:0]air_condition;
    Timer U1    
	 (
	    .CLK( CLK ),
		.RSTn( RSTn ),
		.Number_Sig( Number_Sig ), // output - to U2
		.zero_signal(zero_signal)
	 );
	 
	 /******************************/ 
	 smg_interface U2   
	 (
	    .CLK( CLK ),
		.RSTn( RSTn ),
		.Num_output( Num_output ), // input - from U1
		.key_value(key_value),
		.SMG_Data( SMG_Data ),     // output - to top
		.Scan_Sig( Scan_Sig )      // output - to top
	 );
	 
    /******************************/ 
	key_module U3
	(
		.clk( CLK ),
		.rst_n( RSTn ),
		.key_in( KEY_IN ),
		.key_value( key_value )
	);
	
	logic_layer U4
	(
		.CLK( CLK ),
		.RSTn( RSTn ),
		.Num_output( Num_output ), // input - from U1
		.key_value( key_value ),
		.Number_Sig(Number_Sig),
		.Number_Sig2(Number_Sig2),
		//.air_condition(air_condition),
		.zero_signal(zero_signal),
		.zero_signal2(zero_signal2),
		.beep(beep),
		.led(led)
		);
	  Timer U5 
	 (
	    .CLK( CLK ),
		.RSTn( RSTn ),
		.Number_Sig( Number_Sig2 ), // output - to U2
		.zero_signal(zero_signal2)
	 );	
endmodule
