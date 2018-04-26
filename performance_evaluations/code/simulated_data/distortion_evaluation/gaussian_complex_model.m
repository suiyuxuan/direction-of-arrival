% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: Noise Gaussian Model
% Author: Danilo Pena
% Description: Signal generator for known SNR

% Parameters:
% x: synthetic signal
% snr: signal-to-noise rate

function [signal] = gaussian_complex_model(x, snr)

N = length(x);

signalPower = (1/N)*x(1,:)*x(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));

signal = x + noise;

end
