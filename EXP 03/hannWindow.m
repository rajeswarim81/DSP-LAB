function w = hannWindow(N)
    w = zeros(N,1);
   for n = 0 : 1 : N-1
        w(n+1,1) = 0.5 - 0.5*cos(2*pi*n/(N-1));
   end
    
end