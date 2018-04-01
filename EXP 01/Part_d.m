clear all;
clc;

fs1=12e3;
fs2=24e3;
f=6e3;
nc=10;
f0=400e3;

t0=0:1/f0:nc/f;
x0=2*cos(2*pi*f*t0)+cos(pi*f*t0);

t=0:1/fs1:nc/f;
x=2*cos(2*pi*f*t)+cos(pi*f*t);

figure(1);

plot(t0,x0);
hold on;
stem(t,x);
title('Original signal');

figure(2);
nfft=1024;
z=fftshift(fft(x,nfft));
fval=fs1*(-nfft/2 : nfft/2-1)/nfft;
%subplot(3,2,3);
plot(fval, abs(z));
title('FFT of the sampled signal');

%% SAMPLE AND HOLD
figure(3);
%subplot(3,2,5);
stairs(t,x);
title('Sampled and held');

%% upsampling
figure(4);
z1=upsample(x,2);
t2=0:1/fs2:(length(z1)-1)/fs2;
%subplot(3,2,2);
plot(t0,x0);
hold on;
stem(t2,z1);
title('upsampled signal');

%% FFT OF THE UPSAMPLED SIGNAL

nfft=1024;
z3=fftshift(fft(z1,nfft));
fval=fs1*(-nfft/2 : nfft/2-1)/nfft;
%subplot(3,2,4);
figure(5);
plot(fval, abs(z3));
title('FFT of the upsampled signal');

%% SAMPLE AND HOLD
figure(6);
%subplot(3,2,6);
stairs(t2,z1);
title('Sampled and held');

%% LOW PASS FILTER 


wn=(2/fs2)*f;
b=fir1(20,wn, 'low', kaiser(21,3));
%fvtool(b,1,'fs',fs2);

figure(7);
c=filter(b,1,z1);
subplot(2,1,1);
plot(c);
title('Signal reconstructed from the upsampled signal');

%% sampled at 24 khz
subplot(2,1,2);
t4=0:1/fs1:nc/f;
x4=2*cos(2*pi*f*t4)+cos(pi*f*t4);
plot(t4,x4);
title('Original signal sampled at 24kHz');


