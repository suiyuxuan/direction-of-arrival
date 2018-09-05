% Federal University of Rio Grande do Norte
% Title: Phase Transformation
% Author: Danilo Pena
% Description: Phase Transformation
% x: synthetic or real signal
% P: source numbers
% fs: sampling frequency
% d: distance between the elements

function [output] = PHAT(x, fs, d)

u = 340; % sound speed
[M,N] = size(x);

sig = x(2,:);
refsig = x(1,:);

X1 = fft(x(1,:));
X2 = fft(x(2,:));
X2c = conj(X2);
R = ifft((X1 .* X2c)./abs(X1 .* X2c));
[argvalue, argmax] = max(R);
tau = argmax; % it's necessary subtract maxshift

%tau = gccphat(x(1,:), x(2,:), 200000);
tdoa = tau / fs;

theta = asin(tdoa / (d/u)) * (180/pi);

end
