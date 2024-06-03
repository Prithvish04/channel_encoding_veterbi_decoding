`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:51 03/14/2016 
// Design Name: 
// Module Name:    veterbi_decode 
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
module veterbi_decode(
    input [63:0] in_stream,
    output reg [31:0] out_stream
    );
	 integer i;
	 integer dist1;
	 integer dist2;
	 integer dist3;
	 integer dist4;
	 reg [31:0] out_buffer1
	 initial 
	 begin
			for(i=0;i<32;i=i+1)
			begin
				
			end
	 end


endmodule
