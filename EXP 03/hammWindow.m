function w = hammWindow(N)
    w = zeros(N,1);
   for n = 0 : 1 : N-1
        w(n+1,1) = 0.54 - 0.46*cos(2*pi*n/(N-1));
   end
    
end