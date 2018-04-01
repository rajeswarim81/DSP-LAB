clear all;
clc;

Fs=100e3;
t=(0:1/Fs:127*1/Fs); 
L=length(t);
x=10*cos(2*pi*t*1e3)+3*sin(2*pi*t*5e3);

xm=x/max(abs(x));
B=12;
B_Final=8;
if xm*2^(B-1)-floor(xm*2^(B-1))<0.5
    y_x=floor(xm*2^(B-1))/2^(B-1);
else
    y_x=ceil(xm*2^(B-1))/2^(B-1);
end

y=awgn(y_x,20*(B_Final-1)*0.301);

if y*2^(B_Final-1)-floor(y*2^(B_Final-1))<0.5
    z=floor(y*2^(B_Final-1))/2^(B_Final-1);
else
    z=ceil(y*2^(B_Final-1))/2^(B_Final-1);
end
audio=audioplayer(z,Fs);
play(audio);

figure(1);
plot(t,xm);
title('Normalised Input Signal');
xlabel('time(secs)');
ylabel('Amplitute');

figure(2);
plot(t,y_x);
title('Quantised Input Signal (12 bit)');
xlabel('time(secs)');
ylabel('Amplitute');

figure(3);
plot(t,y);
title('Input signal with addded white noise');
xlabel('time(secs)');
ylabel('Amplitute');

figure(4);
plot(t,z);
title('Quantized Signal with added white noise');
xlabel('time(secs)');
ylabel('Amplitute');
