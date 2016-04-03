% define the soft threshold function, which is used above.
function y = soft(x,tau)

y = sign(x).*max(abs(x)-tau,0); % this is equal to y = max(0, tau/abs(x))x

% Y = sign(X) returns an array Y the same size as X, where each element of Y is:
% 
% 1 if the corresponding element of X is greater than zero
% 0 if the corresponding element of X equals zero
% -1 if the corresponding element of X is less than zero
% For nonzero complex X, sign(X) = X./abs(X).