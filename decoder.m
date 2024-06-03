clc
clear all
close all

r_bits = input('Enter the received bits (even no. of terms): ');
l=length(r_bits);
if(mod(l,2)==0)
y0=r_bits(1:2:l); %Odd
y1=r_bits(2:2:l); %Even 

%4 states = 00 01 10 11
%initial cost
dist(1,1)=0;
dist(2,1)=Inf;
dist(3,1)=Inf;
dist(4,1)=Inf;

for i=1:(l/2)
        %calculating branch metric
            metric(1,i)=abs(y0(i)-0)+abs(y1(i)-0);  %branch metric for transition from state 00 to 00
            metric(2,i)=abs(y0(i)-1)+abs(y1(i)-1);    %branch metric for transition from state 00 to 10
            metric(3,i)=abs(y0(i)-1)+abs(y1(i)-1);    %branch metric for transition from state 10 to 01    
            metric(4,i)=abs(y0(i)-0)+abs(y1(i)-0);    %branch metric for transition from state 10 to 11
            metric(5,i)=abs(y0(i)-1)+abs(y1(i)-0);    %branch metric for transition from state 01 to 00
            metric(6,i)=abs(y0(i)-0)+abs(y1(i)-1);    %branch metric for transition from state 01 to 10
            metric(7,i)=abs(y0(i)-0)+abs(y1(i)-1);    %branch metric for transition from state 11 to 01
            metric(8,i)=abs(y0(i)-1)+abs(y1(i)-0);    %branch metric for transition from state 11 to 11
  
            %calculating path metric
            dist(1,i+1)=min(dist(1,i)+metric(1,i),dist(3,i)+metric(5,i));%Min dist to reach state 00 at time i
            dist(2,i+1)=min(dist(1,i)+metric(2,i),dist(3,i)+metric(6,i));%Min dist to reach state 10 at time i
            dist(3,i+1)=min(dist(2,i)+metric(3,i),dist(4,i)+metric(7,i));%Min dist to reach state 01 at time i
            dist(4,i+1)=min(dist(2,i)+metric(4,i),dist(4,i)+metric(8,i))%Min dist to reach state 11 at time i     
        end
    
[~,state]=min(dist(:,l/2+1)); %For the last stage choosing the state corresponding to minimum distance
%Starting from the last stage, we decode the previous state and the corresponding input bit
        for j=l/2:-1:1
            [state,decodedBit]=prev_stage(state,dist(:,j));
            decodedOutput(j)=decodedBit(:); %Storing the decoded bits in a vector
        end
        decodedOutput
else
    disp('Bits missing!');
end
    