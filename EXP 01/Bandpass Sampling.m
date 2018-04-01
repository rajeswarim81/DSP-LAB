clear all;
clc;
f=  4e3;   %Frequency of sinusoid
fh=3*f;
fl=(2.7)*f;
fm=(fh+fl)/2;
bw=fh-fl;
bwg=(0.1)*bw;
kmax=floor(fh/bw);
fs1=fh/kmax;
fs=(2.8)*fs1;
fsa=30e3; % sampling rate 30 kHz


t=0:1/fs:511*1/fs; %time index
ta=0:1/fsa:511*1/fsa; %time index
L=length(t);
%x=10*cos(2*pi*f*t)+6*cos(2*pi*2*f*t)+2*cos(2*pi*3*f*t);
x=10*cos(2*pi*fl*t)+6*cos(2*pi*fm*t)+2*cos(2*pi*fh*t);
xa=10*cos(2*pi*fl*ta)+6*cos(2*pi*fm*ta)+2*cos(2*pi*fh*ta);


figure(1);
subplot(1,2,1)
plot(ta(1:120),xa(1:120))
title('Actual Signal(fs=30KHz)')
xlabel('Time(s)');
ylabel('Amplitude');
subplot(1,2,2)
plot(t(1:120),x(1:120));
title('Signal reconstructed after bandpass sampling')
xlabel('Time(s)');
ylabel('Amplitude');

%n1 = 64; 
X =(fft(x));
Y =fftshift(X);
m = abs(Y);
F=-fs/2:fs/L:fs/2-fs/L;

Xa =(fft(xa));
Ya =fftshift(Xa);
ma = abs(Ya);
Fa=-fsa/2:fsa/L:fsa/2-fsa/L;

figure(2);
subplot(2,1,1);
plot(Fa,2*ma/L)
title('DTFT of the actual signal (fs=30KHz)')
xlabel('Frequency (Hz)');
ylabel('Magnitude of FFT');
subplot(2,1,2);

plot(F,2*m/L)
title('DTFT of the signal obtained after bandpass sampling')
xlabel('Frequency (Hz)');
ylabel('Magnitude of FFT');

%fs=(2.5)*fs1;
%fs=12e3; % sampling rate 12 kHz


