close all;
clear;
clc;

%% Spectrum of a square wave

F = 1e3; %for square wave with time period 1 ms and frequency 1 kHz
N = 2048; % Sampling Frequency

%% Generating FFT and reconstruction of signal for various values of N

 Fs = 20e3;
    
    %%  FFT of sampled signal
    
    t_N = linspace(0,(N-1)/Fs, N); %time axis with N points
    x_N = square(t_N*2*pi*F); %corrsponding sampled signal
    
    FFT = fft(x_N, N);%FFT of sampled signal (0,2pi)
    FFT_shift = fftshift(FFT); %FFT of sampled signal (-pi,pi)
    
    f_t = linspace(-1*pi, pi, N); %frequency axis
    figure;
    stem(f_t, abs(FFT_shift));
    str=sprintf('FFT with Fs = %d kHz', Fs/1000);
    title(str);
    xlabel('Frequecy') % x-axis label
    ylabel('FFT') % y-axis label
    saveas(gcf, sprintf('FFT_Fs_%d.jpg', Fs/1000))
    
    %% regconstruction of orignal signal
    
    t = linspace(0,5/F,5000); %time axis for orignal and reconstructed signals
    x_t = square(t*2*pi*F);
    figure;
    subplot(2,1,1);
    plot(t,x_t);
    str=sprintf('Orignal signal with Fs = %d kHz', Fs/1000);
    title(str);
    xlabel('t') % x-axis label
    ylabel('x(t)') % y-axis label
    
    %regeneration
    regen = zeros(1,length(t));
    %interpolation with sinc function
    for i = 1:length(t_N);
        regen = regen + x_N(i)*sinc(t*Fs - i);
    end
    
    subplot(2,1,2);
    plot(t,regen);
    str=sprintf('Reconstructed signal with Fs = %d kHz', Fs/1000);
    title(str);
    xlabel('t') % x-axis label
    ylabel('x(t)') % y-axis label
    saveas(gcf, sprintf('signal_Fs_%d.jpg', Fs/1000))


%% To plot mean sqaured errror vs Fs

N = 2048;
fq = [1e3:1e3:0.5e6];
err = zeros(1,length(fq));

for Fs = fq
    
    t_N = linspace(0,(N-1)/Fs, N); %time axis with N points
    x_N = square(t_N*2*pi*F); %corrsponding sampled signal
    
    FFT = fft(x_N, N);%FFT of sampled signal (0,2pi)
    FFT_shift = fftshift(FFT); %FFT of sampled signal (-pi,pi)
    
    t = linspace(0,1/F,1000); %time axis for orignal and reconstructed signals
    x_t = square(t*2*pi*F);
    
    regen = zeros(1,length(t));
    %interpolation with sinc function
    for i = 1:length(t_N);
        regen = regen + x_N(i)*sinc(t*Fs - i);
    end
    
    D = abs(x_t-regen).^2;
    err(Fs/1000) = sum(D(:))/numel(x_t);
  
end

figure;
plot(fq,err);
title('Variation of Mean Squared Error with Fs');
xlabel('Fs') % x-axis label
ylabel('Mean squared Error') % y-axis label
saveas(gcf, sprintf('MSE.jpg'));