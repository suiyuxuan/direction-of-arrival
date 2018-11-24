% Federal University of Rio Grande do Norte
% Title: Phase Transformation
% Author: Danilo Pena
% Description: Phase Transform
% x: synthetic or real signal
% P: source numbers
% fs: sampling frequency
% d: distance between the elements

% example for validating
% load gong;
% refsig = y;
% delay1 = 5;
% delay2 = 25;
% sig1 = delayseq(refsig,delay1);
% sig2 = delayseq(refsig,delay2);
% tau_est = gccphat([sig1,sig2],refsig)
% x(1,:) = refsig';
% x(2,:) = sig2';

function [theta] = GCC_PHAT(x, fs, d)

u = 340; % sound speed
[M,N] = size(x);

X1 = fft(x(1,:));
X2 = fft(x(2,:));
NUM = (X1 .* conj(X2));
W = max(abs(NUM),0.01); % max(abs(X1.*X2c), epsilon)
R = ifft(NUM./W);
%R = ifft(exp(1i*angle(X1 .* conj(X2))));
%Rn = fftshift(R,1);
[argvalue, argmax] = max(abs(R));
%%[argvalue, argmax] = max(abs(fftshift(R)));
%[argvalue, argmax] = max(fftshift(R));
half = length(x(2,:))/2;
% if argmax>half
%    tau = argmax - 2*half - 1;
% elseif argmax<half
%    tau = argmax - half - 1; % it's necessary subtract maxshift
% end
tau = -(argmax - 2*half - 1);
%tau = argmax - 1;
tau = gccphat(x(2,:)',x(1,:)');
%tau = gccphat(x(2,:)', x(1,:)', 200000);
tdoa = tau / fs;

theta = asin(tdoa / (d/u)) * (180/pi);

end
