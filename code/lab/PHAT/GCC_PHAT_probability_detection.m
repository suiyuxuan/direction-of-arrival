% Federal University of Rio Grande do Norte
% Title: GCC-PHAT PD
% Author: Danilo Pena
% Description: Evaluation of probability detection using GCC-PHAT

angles = 20;
d = 0.05;
u = 340;
fs = 48000;
N = 353;
M = 2;
snr_i = -20;
snr_step = 1;
snr_f = 20;

RR = 25;
tau = (d*sin(angles/180*pi)/u);
delay = round(tau*fs);
sig_tmp = zeros(1,N);
for i=1:N
    sig_tmp(i) = real(exp(-1i*pi*RR*(i-1)*(i)/N));
end
for n = 1:M
    sig(n,:) = [zeros(1,delay*(n-1)) sig_tmp(1:end-(n-1)*delay)];
end

ii = 1;
for snr = snr_i:snr_step:snr_f

N = length(sig);
signalPower = (1/N)*sig(1,:)*sig(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower) * randn(size(sig));

x = sig + noise;

[M,N] = size(x);
X1 = fft(x(1,:));
X2 = fft(x(2,:));
NUM = (X1 .* conj(X2));
W = max(abs(NUM),0.01); % max(abs(X1.*X2c), epsilon)
R(ii,:) = ifft(NUM./W);
%R = ifft(exp(1i*angle(X1 .* conj(X2))));
[argvalue, argmax] = max(abs(R(ii,:))); % max(fftshift(R))
half = length(x(2,:))/2;
tau = -(argmax - 2*half - 1); % argmax - 1;
%tau = gccphat(x(2,:)',x(1,:)');
tdoa = tau / fs;

theta = asin(tdoa / (d/u)) * (180/pi);

ii = ii+1;
end
