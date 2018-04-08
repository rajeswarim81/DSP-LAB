clear all;
clc;
%frequencies
f=[697 770 852 941 1209 1336 1477 1633];
%sampling frequency
fs=10000;
wc=2*pi*f/fs;%normalized frequency
%time scale
t=0:1/fs:1000/fs;
%input character
k=input('Press any key','s');
%generating corresponding DTMF signals
if(k=='1')
    x=sin(2*pi*697*t)+sin(2*pi*1209*t);
elseif(k=='2')
    x=sin(2*pi*697*t)+sin(2*pi*1336*t);
elseif(k=='3')
    x=sin(2*pi*697*t)+sin(2*pi*1477*t);
elseif(k=='A')
    x=sin(2*pi*697*t)+sin(2*pi*1633*t);
elseif(k=='4')
    x=sin(2*pi*770*t)+sin(2*pi*1209*t);
elseif(k=='5')
    x=sin(2*pi*770*t)+sin(2*pi*1336*t);
elseif(k=='6')
    x=sin(2*pi*770*t)+sin(2*pi*1477*t);
elseif(k=='B')
    x=sin(2*pi*770*t)+sin(2*pi*1633*t);
elseif(k=='7')
    x=sin(2*pi*852*t)+sin(2*pi*1209*t);
elseif(k=='8')
    x=sin(2*pi*852*t)+sin(2*pi*1336*t);
elseif(k=='9')
    x=sin(2*pi*852*t)+sin(2*pi*1477*t);
elseif(k=='C')
    x=sin(2*pi*852*t)+sin(2*pi*1633*t);
elseif(k=='*')
    x=sin(2*pi*941*t)+sin(2*pi*1209*t);
elseif(k=='0')
    x=sin(2*pi*941*t)+sin(2*pi*1336*t);
elseif(k=='#')
    x=sin(2*pi*941*t)+sin(2*pi*1477*t);
elseif(k=='D') 
    x=sin(2*pi*941*t)+sin(2*pi*1633*t); 
else
    display('Invalid')
end
figure,
plot(t,x);
title('Analog waveform for key=2');
xlabel('Time')
ylabel('Amplitude');
figure,
plot(abs(fft(x)));
title('Frequency spectrum for key=2')
xlabel('Frquency')
ylabel('Amplitude');
L=65;%order of filter
w=-pi:.001:pi;
n=0:1:L;
% 8 filters
h=zeros(8,L+1);
%filter functions
for i=1:8
    h(i,:)=cos(wc(i)*n);
end
%array for storing maximum values of filter ouputs
S=zeros(1,8);
for j=1:8
y(j,:)=filter(h(j,:),1,x(:)); %sending through a filter and storing the output in y
figure,
plot(y(j,:));%plotting the output of a certain filter
title('Output of filter corresponding to 1336Hz and key=2')
xlabel('Time')
ylabel('Amplitude');
figure,
plot(abs(fft(y(j,:))));
title('Filter Output spectrum corresponding to 1336Hz and key=2')
xlabel('Frequency')
ylabel('Amplitude')%plotting the fft of output of a certain filter
S(j)=max(abs(fft(y(j,:))));%storing the maximum value of a certain filter output
end
symbol = {'1','2','3','A';'4','5','6','B';'7','8','9','C';'*','0','#','D'};
% determining frequency components present in each segment
a=find(S==max(S)); % finding 1st maximum 
S(a)=0;
b=find(S==max(S)); %finding 2nd maximum 
if(a>b)
    a=a+b;
    b=a-b;
    a=a-b;
end
%///// Decoding to find which key was pressed
if (a==1)
    if(b==5) 
        disp('frequency components present are');disp('697');disp('1209');
        disp('number typed is 1');
    elseif(b==6)
        disp('frequency componenst present are');disp('697');disp('1336');
        disp('number typed is 2');
    elseif(b==7)
        disp('frequency components present are');disp('697');disp('1477');
        disp('number typed is 3');
    else
        disp('frequency components present are');disp('697');disp('1633');
        disp('number typed is A');
    end
elseif (a==2)
    if(b==5) 
        disp('frequency components present are');disp('770');disp('1209');
        disp('number typed is 4');
    elseif(b==6)
        disp('frequency components present are');disp('770');disp('1336');
        disp('number typed is 5');
    elseif(b==7)
        disp('frequency components present are');disp('770');disp('1477');
        disp('number typed is 6');
    else
        disp('frequency components present are');disp('770');disp('1633');
        disp('number typed is B');
    end
elseif (a==3)
    if(b==5) 
        disp('frequency components present are');disp('852');disp('1209');
        disp('number typed is 7');
    elseif(b==6)
        disp('frequency components present are');disp('852');disp('1336');
        disp('number typed is 8');
    elseif(b==7)
        disp('frequency components present are');disp('852');disp('1477');
        disp('number typed is 9');
    else
        disp('frequency components present are');disp('852');disp('1633');
        disp('number typed is C');
    end
else
    if(b==5) 
        disp('frequency components present are');disp('941');disp('1209');
        disp('number typed is *');
    elseif(b==6)
        disp('frequency components present are');disp('941');disp('1336');
        disp('number typed is 0');
    elseif(b==7)
        disp('frequency components present are');disp('941');disp('1477');
        disp('number typed is #');
    else
        disp('frequency components present are');disp('941');disp('1633');
        disp('number typed is D');
    end
end

