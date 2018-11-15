% Federal University of Rio Grande do Norte
% Title: Fractional Lower-Order Statistics PHAT
% Author: Danilo Pena
% Description: FLOS-PHAT
% x: synthetic or real signal
% P: source numbers
% f: source frequency
% d: distance between the elements

function [theta,pMusic] = FLOS-PHAT(x, P, f, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound

% R = robustcov(x(1,:),x(2,:));

% Frequency domain
X1 = fft(x(1,:));
X2 = fft(x(2,:));
NUM = (X1 .* conj(X2)) .* (abs(exp(-1i*)).^p) .* conj(exp(-1i*));
%W = max(abs(NUM),0.01); % max(abs(X1.*X2c), epsilon)
%R = ifft(NUM./W);

%R = (1/N)*sum( x(1,:).^(a) .* x(2,:).^(b) ); % Time domain

[argvalue, argmax] = max(abs(R));

tau = argmax - 1;
tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);

end
