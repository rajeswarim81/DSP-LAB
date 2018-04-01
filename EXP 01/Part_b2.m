clear all;
clc;

fs=4e3;
f0=200e3;

t=0:1/f0:59/fs;
x = 10*cos(2*pi*1000*t) + 6*cos(2*pi*2000*t) + 2*cos(2*pi*4000*t);

t0=0:1/fs:59/fs;
x0 = 10*cos(2*pi*1000*t0) + 6*cos(2*pi*2000*t0) + 2*cos(2*pi*4000*t0);
figure(4);
plot(t,x);
hold on;
stem(t0,x0);
grid on;
xlabel('Time'); 
ylabel('Amplitude');
title('Original signal sampled at F=4kHz');


n1=64;
t1=0: 1/fs: (n1-1)/fs;
x1 = 10*cos(2*pi*1000*t1) + 6*cos(2*pi*2000*t1) + 2*cos(2*pi*4000*t1);
y1=fft(x1,n1);
y11=fftshift(y1);
f1=linspace(-pi, pi, n1);



figure(1);
stem(f1, abs(y11));
xlabel('Frequency'); 
ylabel('FFT');
title('FFT of the sampled signal with N=64');
grid on;

n2=128;
t2=0: 1/fs: (n2-1)/fs;
x2 = 10*cos(2*pi*1000*t2) + 6*cos(2*pi*2000*t2) + 2*cos(2*pi*4000*t2);
y2=fft(x2,n2);
y21=fftshift(y2);
f2=linspace(-pi, pi, n2);

figure(2);
stem(f2, abs(y21));
xlabel('Frequency'); 
ylabel('FFT');
title('FFT of the sampled signal with N=128');
grid on;

n3=256;
t3=0: 1/fs: (n3-1)/fs;
x3 = 10*cos(2*pi*1000*t3) + 6*cos(2*pi*2000*t3) + 2*cos(2*pi*4000*t3);
y3=fft(x3,n3);
y31=fftshift(y3);
f3=linspace(-pi, pi, n3);

figure(3);
stem(f3, abs(y31));
xlabel('Frequency'); 
ylabel('FFT');
title('FFT of the sampled signal with N=256');
grid on;





