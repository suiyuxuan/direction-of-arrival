% Federal University of Rio Grande do Norte
% Title: Fractional Lower-Order Statistics PHAT
% Author: Danilo Pena
% Description: FLOS-PHAT
% x: synthetic or real signal
% P: source numbers
% f: source frequency
% d: distance between the elements

function [theta] = FLOS_PHAT(x, fs, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound
p = 0.5;

% Frequency domain
% X1 = fft(x(1,:).^p);
% X2 = fft(x(2,:).^p);
% %NUM = (X1 .* conj(X2)) .* (abs(exp(-1i*)).^p) .* conj(exp(-1i*));
% NUM = (X1 .* conj(X2));
% W = max(abs(NUM),0.01); % max(abs(X1.*X2c), epsilon)
% R = ifft(NUM./W);

xm = [x(2,:) x(2,:)];

R = zeros(1,N);

% for m=1:N
%     for n=1:N
%         R(m) = R(m) + (1/N)*( abs(x(1,n)) .* (xm(1,n+m)).^(p-1) ); % Time domain
%     end
% end

NUM = zeros(1,N);
DEN = zeros(1,N);
R = zeros(1,N);
for m=1:N
    for n=1:N
        NUM(n) = NUM(n) + x(1,n).*(abs(xm(1,n+m)).^p-1).*sign(xm(1,n+m));
        DEN(n) = DEN(n) + abs(xm(1,n+m)).^p;
    end
    R(m) = NUM(n) / DEN(n);
end

[argvalue, argmax] = max(abs(R-mean(R)));

%half = length(x(2,:))/2;
%%tau = argmax - 1;
%tau = -(argmax - 2*half - 1);
tau = argmax;

tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);

end
