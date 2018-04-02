function w = triWindow(N)
    w = zeros(N,1);
   for n = 0 : 1 : N-1
        w(n+1,1) = 1 - 2*(n-(N-1)/2)/(N-1);
   end
    
end