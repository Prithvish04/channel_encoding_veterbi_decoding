`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:17 03/14/2016 
// Design Name: 
// Module Name:    convolutionale_encoding 
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
module convolutionale_encoding(
    input [32:0] in_stream,
    output reg [64:0] out_stream
    );
	 reg [2:0] gen1;
	 reg [2:0] gen2;
	 integer i;
	 initial 
	 begin
		 gen1=3'b111;
		 gen2=3'b101;
		 for(i=0;i<30;i=i+1)
		 begin
				out_stream[2*i] <= (in_stream[i]*gen1[0])^(in_stream[i+1]*gen1[1])^(in_stream[i+2]*gen1[2]);
				out_stream[2*i+1] <=(in_stream[i]*gen2[0])^(in_stream[i+1]*gen2[1])^(in_stream[i+2]*gen2[2]);
		 end
	 end 


endmodule
