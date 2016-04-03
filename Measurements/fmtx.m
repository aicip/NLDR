function g = fmtx(d)
    % Returns a 1D Fourier synthesis dictionary
    g = zeros(d);
    g(1,:) = 1/sqrt(d);
    idx = 0:d-1;
    for k =1:(d-1)/2
        g(k+1,idx+1) = cos(2*pi*k*idx/d) / (sqrt(d/2));
        g(k+(d-1)/2+1,idx+1) = sin(2*pi*k*idx/d) / (sqrt(d/2));
    end
end