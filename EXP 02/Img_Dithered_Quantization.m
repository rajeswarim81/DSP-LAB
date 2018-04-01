clear all;
clc;
img=rgb2gray(imread('lena.ppm'));
s=size(img);


for i=1:1:s(1)
    error=0;
    for j=1:1:s(2)
       if img(i,j)+error>127
           y(i,j)=255;
       else
           y(i,j)=0;
       end
       error=(img(i,j)+error)-y(i,j);
    end
end
imwrite(y,'DFTBA_Dithered_Quantization.jpg');



