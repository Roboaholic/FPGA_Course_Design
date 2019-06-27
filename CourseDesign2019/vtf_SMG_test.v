`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:04:29 06/27/2019
// Design Name:   Module_Top
// Module Name:   F:/2019FPGA/2019Course_Design_MarkC/original_code/CourseDesign2019/vtf_SMG_test.v
// Project Name:  CourseDesign2019
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Module_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vtf_SMG_test;

	// Inputs
	reg CLK;
	reg RSTn;

	// Outputs
	wire [7:0] SMG_Data;
	wire [5:0] Scan_Sig;

	// Instantiate the Unit Under Test (UUT)
	Module_Top uut (
		.CLK(CLK), 
		.RSTn(RSTn), 
		.SMG_Data(SMG_Data), 
		.Scan_Sig(Scan_Sig)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RSTn = 0;

		// Wait 100 ns for global reset to finish
		#100;
      RSTn = 1 ;
		// Add stimulus here

	end
	
	always #10 CLK = ~CLK;
endmodule

