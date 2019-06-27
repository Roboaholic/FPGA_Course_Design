module Module_Top
(
    input CLK,
	input RSTn,
	input [3:0]KEY_IN,
	output [7:0]SMG_Data,
	output [5:0]Scan_Sig
);

    /******************************/ 
			
    wire [23:0]Number_Sig;
	wire [3:0]key_value;
    Timer U1    
	 (
	    .CLK( CLK ),
		.RSTn( RSTn ),
		.Number_Sig( Number_Sig ) // output - to U2
	 );
	 
	 /******************************/ 
	 smg_interface U2   
	 (
	    .CLK( CLK ),
		.RSTn( RSTn ),
		.Number_Sig( Number_Sig ), // input - from U1
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
endmodule
