% Federal University of Rio Grande do Norte
% Title: Generalized Fractional Lower-Order Covariation with double
% function
% Author: Danilo Pena
% Description: GFLOC implemeted with FLOC and sigmoid functions
% x: synthetic or real signal
% fs: sampling frequency
% d: distance between the elements

function [theta] = GFLOC(x, fs, d)

xt = tanh(x);

[M,N] = size(xt); % M - element number, N - number of samples
u = 340; % speed of sound
%p = 0.5;

xm = [xt(2,:) xt(2,:)];

R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        NUM = NUM + xt(1,n).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m));
        %NUM = NUM + xt(1,n).*(abs(xm(1,n+m)).^p-1).*sign(xm(1,n+m));
        %DEN = DEN + abs(xm(1,n+m)).^p;
    end
    R(m) = NUM / DEN;
end

[argvalue, argmax] = max(abs(R-mean(R)));
tau = argmax;

tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);

end
