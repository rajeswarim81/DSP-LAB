clear all;
A=87.6;
Fs=100e3;
t=[0:1/Fs:255*1/Fs]; %63,127,255 for different number of samples
L=length(t);
x=1.5*cos(2*pi*t*5e3)+sin(2*pi*t*4e3);

%uniform quantization
V=max(abs(x));
bit_sig=1;
quant1 = (floor(x*(2^(bit_sig-1))/V))*(V/(2^(bit_sig-1)));

bit_sig=2;
quant2 = (floor(x*(2^(bit_sig-1))/V))*(V/(2^(bit_sig-1)));




for i=1:1:length(x)
    if abs(x(i))<1/A
        y(i)=sign(x(i))*A*abs(x(i))/(1+log(A));
    else 
        y(i)=sign(x(i))*(1+log(A*abs(x(i))))/(1+log(A));
    end
end
MSE=0;
for i=1:1:length(x)
    if abs(y(i))<1/(1+log(A))
        z(i)=sign(y(i))*abs(y(i))*(1+log(A))/A;
    else
        z(i)=sign(y(i))*exp(abs(y(i))*(1+log(A))-1)/A;
    end
    MSE=MSE+(z(i)-x(i))^2;
end

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
xlabel('Signal Amplitude');
ylabel('Quantized Amplitude');

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