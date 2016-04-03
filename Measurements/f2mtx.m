function F = f2mtx(d)
    % Returns a complete 2D Fourier synthesis dictionary
    g = fmtx(d)';
    g0 = g(:, 1);
    g1 = g(:, 2:(d-1)/2+1);
    g2 = g(:, (d-1)/2+2:end);
    F0 = kron(g0, g0);
    F1 = kron(g0, g1);
    F2 = kron(g1, g0);
    F3 = kron(g1, g1) / sqrt(2);
    F4 = kron(g2, g2) / sqrt(2);
    F5 = kron(g0, g2) / sqrt(2);
    F6 = kron(g2, g0) / sqrt(2);
    F7 = kron(g1, g2) / sqrt(2);
    F8 = kron(g2, g1) / sqrt(2);
    F = cat(2,F0,F1,F2,F3-F4,F3+F4,F5+F6,F5-F6,F7+F8,F7-F8);
end