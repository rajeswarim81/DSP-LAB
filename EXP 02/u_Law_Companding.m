clear all;
u=255;
Fs=100e3;
t=[0:1/Fs:255*1/Fs]; %63,127,255 for different number of samples
L=length(t);
x=3*cos(2*pi*t*5e3)+2*sin(2*pi*t*4e3);

%uniform quantization
V=max(abs(x));
bit_sig=1;
quant1 = (floor(x*(2^(bit_sig-1))/V))*(V/(2^(bit_sig-1)));

bit_sig=2;
quant2 = (floor(x*(2^(bit_sig-1))/V))*(V/(2^(bit_sig-1)));

%k=sqrt(3^2 + 2^2);
y=sign(x).*log(1+u.*abs(x))/log(1+u);

z=sign(y).*((1+u).^abs(y)-1)/u;

MSE=sum((z-x).^2);

figure(1);
plot(t,x);
title('Input Signal');
xlabel('time(secs)');
ylabel('Amplitute');

figure(2);
plot(t,y);
title('Compressed Signal');
xlabel('time(secs)');
ylabel('Amplitute');

figure(3);
plot(t,z);
title('Extracted Signal');
xlabel('time(secs)');
ylabel('Amplitute');

figure(4);
plot(sign(x).*abs(x), y);
title('Quantization of the signal');
xlabel('Signal amplitude');
ylabel('Quantized Amplitute');

figure(5);
plot(t, quant1);
title('Uniform 1 bit quantization of the signal');
xlabel('time(s)');
ylabel('Quantized Amplitute');

figure(6);
plot(t, quant2);
title('Uniform 2 bits quantization of the signal');
xlabel('time(s)');
ylabel('Quantized Amplitute');


disp(MSE);