function plotdft(x1,Fs1,str)
L = length(x1);
Y = fft(x1);
f = Fs1 *(0:L-1)/L;
f = f-Fs1/2;
f = f/(Fs1/2);
Y = abs(fftshift(Y));
figure;
plot(f,Y);
xlabel('Frequency x \pi Radians');
ylabel('|X(f)|/N'); 
title(str);
end