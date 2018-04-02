clear;
clc;
%%
N = 65;
wc = 0.3*pi;
%%
hd = LPFilt(wc,N);
% plot(hd);
%%
w = rectWindow(N);
B1 = hd .* w;
figure;
freqz(B1,1,-0.9*pi:0.005:pi);
title(['Rectanguar Window (N=' num2str(N) ')']);
%%
w = triWindow(N);
B2 = hd .* w;
figure;
freqz(B2,1,-pi:0.005:pi);
title(['Trianguar Window (N=' num2str(N) ')']);
%%
w = hannWindow(N);
B3 = hd .* w;
figure;
freqz(B3,1,-pi:0.005:pi);
title(['Hanning Window (N=' num2str(N) ')']);
%%
w = hammWindow(N);
B4 = hd .* w;
figure;
freqz(B4,1,-pi:0.005:pi);
title(['Hamming Window (N=' num2str(N) ')']);
%%
w = blackWindow(N);
B5 = hd .* w;
figure;
freqz(B5,1,-pi:0.005:pi);
title(['Blackman Window (N=' num2str(N) ')']);
%% Generating Input Signal
Fs = 10 * 1e3;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 2000;             % Length of signal
t = (0:L-1)*T;        % Time vector
x = sin(2*pi*0.1*Fs*t)+sin(2*pi*0.8*Fs*t);
r = rms(x);
%plot(t,x);
plotdft(x,Fs,'input FFT')
%% Filtering using FIR Fiters
y = filtfilt(B1,1,x);
plotdft(y,Fs,'Rectanguar Window output FFT')

y = filtfilt(B2,1,x);
plotdft(y,Fs,'Trianguar Window output FFT')

y = filtfilt(B3,1,x);
plotdft(y,Fs,'Hanning Window output FFT')

y = filtfilt(B4,1,x);
plotdft(y,Fs,'Hamming Window output FFT')

y = filtfilt(B5,1,x);
plotdft(y,Fs,'Blackman Window output FFT')
%% Generation of noise
n = 0.4*r*randn(1,L);
plotdft(n,Fs,'noise')
%%
x1 = x+n;
plotdft(x1,Fs,'Corrupted Signal')
%% Filtering using FIR Fiters
y1 = filtfilt(B1,1,x1);
plotdft(y1,Fs,'Rectanguar Window output FFT')
snr(y1)
y1 = filtfilt(B2,1,x1);
plotdft(y1,Fs,'Trianguar Window output FFT')
snr(y1)
y1 = filtfilt(B3,1,x1);
plotdft(y1,Fs,'Hanning Window output FFT')
snr(y1)
y1 = filtfilt(B4,1,x1);
plotdft(y1,Fs,'Hamming Window output FFT')
snr(y1)
y1 = filtfilt(B5,1,x1);
plotdft(y1,Fs,'Blackman Window output FFT')
snr(y1)
%% Limitation of Windowing Method
wc = 0.05*pi;                           %cutoff of band on either side
Fc = 0.13;                               %center frequency of pass band
N=65;
h1 = 2*BPFilt(wc,N,0.5*Fc)+LPFilt(wc,N); %compensate for division of power in sidebands
w = rectWindow(N);
B1 = h1 .* w;
[A,~]=freqz(B1,1,-0.9*pi:0.005:pi);
%subplot(2,2,1)
plot(-0.9:1.9/size(A,2):1-1.9/size(A,2),20*log10(abs(A)));
xlim([-0.9 1]);
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title(['Rectangular Window (N=' num2str(N) ', F_c=' num2str(Fc) '\pi)']);

%% Parks-McLellan algorithm
h2=2*BPFilt(wc,1001,0.5*Fc)+LPFilt(wc,1001);
[a,~]=freqz(h2,1,-0.9*pi:0.005:pi);
a(1:566)=[];
f=0:1/size(a,2):1-1/size(a,2);
b=firpm(N,f,abs(a));

subplot(3,1,1)
[A,~]=freqz(b,1,-0.9*pi:0.005:pi);
plot(-0.9:1.9/size(A,2):1-1.9/size(A,2),20*log10(abs(A)));
xlim([-0.9 1]);
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title(['Parks-McLellan (N=' num2str(N) ', F_c=' num2str(Fc) '\pi)']);

subplot(3,1,2)
[A,~]=freqz(B1,1,-0.9*pi:0.005:pi);
plot(-0.9:1.9/size(A,2):1-1.9/size(A,2),20*log10(abs(A)));
xlim([-0.9 1]);
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title(['Rectangular Window (N=' num2str(N) ', F_c=' num2str(Fc) '\pi)']);

subplot(3,1,3)
[A,~]=freqz(h2,1,-0.9*pi:0.005:pi);
plot(-0.9:1.9/size(A,2):1-1.9/size(A,2),20*log10(abs(A)));
xlim([-0.9 1]);
xlabel('Normalized Frequency  (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('Original IIR Filter');