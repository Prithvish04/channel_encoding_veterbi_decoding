`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:55 04/25/2016 
// Design Name: 
// Module Name:    v1_decoding 
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
module v1_decoding(
    input [7:0] in,
    output reg [3:0] out,
    input [7:0] error,
    output reg [3:0] y_odd,
    output reg [3:0] y_even
    );

integer i;
integer d1[3:0],d2[3:0],d3[3:0],d4[3:0];
integer m0[3:0],m1[3:0],m2[3:0],m3[3:0],m4[3:0],m5[3:0],m6[3:0],m7[3:0];
integer state[3:0];
//initialising


always @ (in,error)
begin
	d1[0]=0;
	d2[0]=100;
	d3[0]=100;
	d4[0]=100;
	for(i=0;i<=3;i=i+1)
	begin
		y_even[i] = in[2*i];
		y_odd[i] = in[2*i+1];
	end
	for(i=0;i<4;i=i+1) 
	begin
		//branch metric
		m0[i] = (y_odd[i]^0)+(y_even[i]^0);
		m1[i] = (y_odd[i]^1)+(y_even[i]^1);
		m2[i] = (y_odd[i]^1)+(y_even[i]^1);
		m3[i] = (y_odd[i]^0)+(y_even[i]^0);
		m4[i] = (y_odd[i]^1)+(y_even[i]^0);
		m5[i] = (y_odd[i]^0)+(y_even[i]^1);
		m6[i] = (y_odd[i]^0)+(y_even[i]^1);
		m7[i] = (y_odd[i]^1)+(y_even[i]^0);
		//path metric1
		if(d1[i]+m0[i]<d3[i]+m4[i])
		begin
			d1[i+1] = d1[i]+m0[i];
		end
		else
		begin
			d1[i+1] = d3[i]+m4[i];
		end
		//path metric2
		if(d1[i]+m1[i]<d3[i]+m5[i])
		begin
			d2[i+1] = d1[i]+m1[i];
		end
		else
		begin
			d1[i+1] = d3[i]+m5[i];
		end
		//path metric3
		if(d2[i]+m2[i]<d4[i]+m6[i])
		begin
			d3[i+1] = d2[i]+m2[i];
		end
		else
		begin
			d3[i+1] = d4[i]+m6[i];
		end
		//path metric4
		if(d2[i]+m3[i]<d4[i]+m7[i])
		begin
			d4[i+1] = d2[i]+m3[i];
		end
		else
		begin
			d4[i+1] = d4[i]+m7[i];
		end
	end
	//for last stage, choosing the state that corresponds to minimum distance
	if(d1[3]<d2[3])
	begin
		if(d1[3]<d3[3])
		begin
			if(d1[3]<d4[3])
			begin
				state[3]=0;
			end
		end
	end
	else
	begin
		if(d2[3]<d3[3])
		begin
			if(d2[3]<d4[3])
			begin
				state[3]=1;
			end
		end
		else
		begin
			if(d3[3]<d4[3])
			begin
				state[3]=2;
			end
			else
			begin
				state[3]=3;
			end
		end
	end
	//Starting from the last stage, we decode the previous state and the corresponding input bit
	for(i=3;i>=0;i=i-1)
	begin
		//state 1
		if(state[i]==1)
		begin
        if(d1[i] <= d3[i])
		  begin
            state[i-1]=1;
				out[i]=0;
			end
        else
		  begin
            state[i-1]=3;
				out[i]=0;
			end
		end
		//state 2
   	if(state[i]==2)
		begin
        if(d1[i] <= d3[i])
		  begin
            state[i-1]=1;
				out[i]=1;
			end
        else
		  begin
            state[i-1]=3;
				out[i]=1;
			end
		end
		//state 3
		if(state[i]==3)
		begin
        if(d2[i] <= d4[i])
		  begin
            state[i-1]=2;
				out[i]=0;
			end
        else
		  begin
            state[i-1]=4;
				out[i]=0;
			end
		end
		//state 4
		if(state[i]==4)
		begin
        if(d2[i] <= d4[i])
		  begin
            state[i-1]=2;
				out[i]=1;
			end
        else
		  begin
            state[i-1]=4;
				out[i]=1;
			end
		end
   end
   
    
end
	
	
endmodule
