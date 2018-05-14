% Federal University of Rio Grande do Norte
% Title: Noise Gaussian Model
% Author: Danilo Pena
% Description: Signal generator for known SNR
% Parameters:
% x: steering vector signal
% snr: signal-to-noise ratio

function [signal] = gaussian_complex_model(x, snr)

N = length(x);

signalPower = (1/N)*x(1,:)*x(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;
noisePower = 10.^(noisePower_dB./10);
noise = sqrt(noisePower./2) .* (randn(size(x)) + 1j.*randn(size(x)));

signal = x + noise;

end
