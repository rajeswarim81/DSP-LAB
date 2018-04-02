function h = BPFilt(wc,N,Fc)
    h = zeros(N,1);
    k = (N-1)/2;
    for n = 0 : 1 : N-1
        b = n-k;
        if(b == 0)
            h(n+1,1) = wc/pi*cos(2*pi*Fc*b);
        else
            h(n+1,1) = (sin(wc*b))/(pi*b)*cos(2*pi*Fc*b);
        end
        
    end
end