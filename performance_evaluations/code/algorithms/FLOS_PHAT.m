% Federal University of Rio Grande do Norte
% Title: Fractional Lower-Order Statistics PHAT
% Author: Danilo Pena
% Description: FLOS-PHAT
% x: synthetic or real signal
% P: source numbers
% f: source frequency
% d: distance between the elements

function [theta] = FLOS_PHAT(x, P, f, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound
p = 0.5;

% Frequency domain
X1 = fft(x(1,:).^p);
X2 = fft(x(2,:).^p);
%NUM = (X1 .* conj(X2)) .* (abs(exp(-1i*)).^p) .* conj(exp(-1i*));
NUM = (X1 .* conj(X2));
W = max(abs(NUM),0.01); % max(abs(X1.*X2c), epsilon)
R = ifft(NUM./W);

%for n=1:N
%for m=1:N
%R(m) = (1/N)*sum( abs(x(1,n)).^(a-1) .* x(2,n+m).^(b-1) ); % Time domain
%end
%end

[argvalue, argmax] = max(abs(R));

half = length(x(2,:))/2;

%tau = argmax - 1;
tau = -(argmax - 2*half - 1);
tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);

end
