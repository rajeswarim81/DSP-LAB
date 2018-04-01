clear all;
x = rgb2gray(imread('lena.ppm'));
s=size(x);
bits=4;
p=2^bits;
y=0;
intensity(1:256)=0; %keeps count of intensity level
for i=1:1:s(1)
    for j=1:1:s(2) 
        intensity(x(i,j)+1)=intensity(x(i,j)+1)+1;  
    end
end

figure(1);
histogram(x);
title('Histogram of the input image');
j=1;
z(1:p)=0;
bin(1:p+1)=255;
error=0;
% intensity(25)=0;
for i=1:1:255
    if abs(error+z(j)-s(1)*s(2)/p)<abs(error+z(j)+intensity(i)-s(1)*s(2)/p)
        bin(j)=i;
        j=j+1;
        error=z(j)-s(1)*s(2)/p;
    end
    z(j)=z(j)+intensity(i);
end

for i=1:1:s(1)
    for j=1:1:s(2)
        for k=1:1:p
            if ((x(i,j)>=bin(k))&&(x(i,j)<bin(k+1)))
                y(i,j)=bin(k);
            end
            if x(i,j)==bin(p+1)
                y(i,j)=bin(p+1);
            end
       end
    end
end
y=uint8(y);

figure(2);
histogram(y);
title('Histogram of the unequally quantized image output');
imwrite(y,'DFTBA_Unequal_Quantization.jpg');
