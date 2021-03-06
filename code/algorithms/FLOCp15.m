% Federal University of Rio Grande do Norte
% Title: Fractional Lower-Order Covariation
% Author: Danilo Pena
% Description: FLOC
% x: synthetic or real signal
% fs: sampling frequency
% d: distance between the elements

function [theta] = FLOCp15(x, fs, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound
p = 1.5;

xm = [x(2,:) x(2,:)];

R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        %NUM = NUM + x(1,n).*sign(xm(1,n+m));
        %DEN = DEN + abs(xm(1,n+m));
        NUM = NUM + x(1,n).*(abs(xm(1,n+m)).^p-1).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m)).^p;
    end
    R(m) = NUM / DEN;
end

[argvalue, argmax] = max(abs(R-mean(R)));
tau = argmax;

tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);

end
