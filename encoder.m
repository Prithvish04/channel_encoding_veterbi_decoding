%%%% convolutional encoding %%%%
clc
clear all
msg=input('Enter the msg signal for convolutional decoding = ');
r=2; %1/r = code rate
K=3;  %constraint length
m=K-1; %memory
msg=[zeros(1,m),msg];
encoded=[];
g=[1 1 1;0 1 1];   %generator polynomial
for i=1:length(msg)-2
    for j=1:r
        k=msg(i:i+2).*g(j,:);
        for l=1:2
            k(1)=xor(k(1),k(1+l));
            n=k(1);
        end
        encoded=[encoded,n];
    end
end
encoded