clear all;
clc;
image =(rgb2gray(imread('lena.ppm')));
x=double(image);
s=size(x);
B=4;

for i=1:1:s(1)
    for j=1:1:s(2)
         if image(i,j)<128
            U(i,j)=63;
         else if image(i,j)>127 && image(i,j)<256
            U(i,j)=192;
             end
         end
    end
    
end
a(1:1:2^B)=2^(8-B):2^(8-B):2^8;
b(1)=0;
b(2^B+1)=255;
for i=1:1:length(a)-1
    b(i+1)=(a(i)+a(i+1))/2;
end

 for k=1:1:5
     for r=1:1:2^B
        sum_a=0;
        count=0;
        for i=1:1:s(1)
            for j=1:1:s(2)
                if x(i,j)>=b(r) && x(i,j)<b(r+1)
                    sum_a=sum_a+x(i,j);
                    count=count+1;
                end
            end
        end
        a(r)=floor(sum_a/count);
    end
    b(1)=0;
    b(2^B+1)=255;
    for i=1:1:length(a)-1
        b(i+1)=(a(i)+a(i+1))/2;
    end
 end

a=floor(a);
b=floor(b);
MSE=0;

for i=1:1:s(1)
    for j=1:1:s(2)
        for r=1:1:2^B
            if x(i,j)>=b(r) && x(i,j)<b(r+1)
                y(i,j)=a(r);
                MSE=MSE+(y(i,j)-x(i,j))^2;
            end
        end
        if x(i,j)==b(2^B+1)
            y(i,j)=a(2^B);
            MSE=MSE+(y(i,j)-x(i,j))^2;
        end
    end
end
y=uint8(y);
imwrite(y,'DFTBA_Unequal_Quantization_Max_Lloyd.jpg');

U=uint8(U);
imwrite(U,'bit1.jpg');


figure(1);
histogram(x);
title('Histogram of the input image');



figure(2);
histogram(y);
title('Histogram of the quantized image');



figure(3);
histogram(U);
title('Histogram of 1 bit uniformly quantized image');

disp(MSE);