% Federal University of Rio Grande do Norte
% Title: Noise Gaussian Model Real-value based
% Author: Danilo Pena
% Description: Signal generator for known SNR
% Parameters:
% x: steering vector signal
% snrValues: All signal-to-noise ratios

function [signal] = gaussian_real_model(x, snrValues)

N = length(x);
N_param = length(snrValues);
%signal.snr = snrValues;

signalPower = (1/N)*x(1,:)*x(1,:)';
signalPower_dB = 10*log10(signalPower);

k = 1;
for snr = snrValues
    noisePower_dB = signalPower_dB - snr;
    noisePower = 10^(noisePower_dB/10);
    noise = sqrt(noisePower) * randn(size(x));

    signal.x{k} = x + noise;
    signal.snr{k} = snrValues(k);
    k = k + 1;
end

end
