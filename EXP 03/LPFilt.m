function h = LPFilt(wc,N)
    h = zeros(N,1);
    k = (N-1)/2;
    for n = 0 : 1 : N-1
        b = n-k;
        if(b == 0)
            h(n+1,1) = wc/pi;
        else
            h(n+1,1) = (sin(wc*b))/(pi*b);
        end
        
    end
end