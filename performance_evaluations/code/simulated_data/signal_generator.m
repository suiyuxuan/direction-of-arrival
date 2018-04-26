% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: Signal Generator
% Author: Danilo Pena
% Description: The generator of the simulated signal

% TODO: to implement :P
function [data] = signal_generator(varargin)
% parameters: angle(s), P, M, d, u, f, fs, noise model, noise parameters (SNR, G-SNR, alpha, ...), channel model, channel parameters

A = zeros(P,M);

for k = 1:P
    A(k,:) = exp(-1i*2*pi*fc*d*sin(doa(k))/u*[0:M-1]);
end
A = A';

sig = exp(1i*(wn*[1:N]));
s = A*sig;
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
x = s + noise;


end
