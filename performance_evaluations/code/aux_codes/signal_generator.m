% Federal University of Rio Grande do Norte
% Title: Signal Generator
% Author: Danilo Pena
% Description: The generator of the simulated signal
% Parameters:
% angles: angles of DOA (1xP matrix), P is number of sources
% N: samples number
% M: elements number
% d: distance betwenn elements
% u: propagation speed
% f: source frequency
% fs: sampling frequency
% -varargin -
% noise model: 'gaussian', 'gaussian mixture', 'alpha-stable'
% noise parameters:  (snr), gaussian mixture (means, variances),  (alpha, g-snr)
% snr (optional - gaussian): signal-to-noise ratio (default: 0dB) 
% alpha (optional - alpha-stable): tail of the distribution (default: 1.7)
% gsnr (optional - alpha-stable): quality of signal (default: 0)
% K (optional - gaussian mixture): number of mixture components (default: 2)
% means (optional - gaussian mixture): mean of component i (default: [0 0])
% variances (optional - gaussian mixture): variance of component i (default: [0.01 1])
% channel model: 'reverberation', 'echo', 'multiple echos', 'flanging', 'statistical'
% channel parameters: reverberation (a, N)

function [signal] = signal_generator(angles, M, d, f, fs, N, u, noise, channel)

%angles = data.properties.angles;
%N = data.properties.N;
%M = data.properties.M;
%d = data.properties.d;
%u = data.properties.u;
%f = data.properties.f;
%noise = data.properties.noise;
%channel = data.properties.channel;

P = length(angles); % source number
A = zeros(P,M); % steering matrix
wn = (f.*2.*pi)./fs; % normalized frequency source

for k = 1:P
    A(k,:) = exp(-1i*2*pi*f(k)*d*sin((angles(k)*(pi/180)))/u*[0:M-1]);
end
A = A';

sig = exp(1i*(wn*[1:N]));

switch noise.model
    case "deterministic"
        signal = A*sig;
    case "gaussian"
        signal = gaussian_complex_model(A*sig, noise.snr);
    case "alpha-stable"
        signal = sas_complex_model(A*sig, noise.alpha, noise.gsnr);
    case "gaussian mixture"
        signal = gaussian_mixture_model(A*sig, noise.means, noise.variances);
    otherwise
        error('noise model incorrect.');
end

switch channel.model
    case "none"
        signal = signal;
    case "reverberation"
        signal = reverberation_model(signal, channel.a, channel.R);
    otherwise
        error('channel model incorrect.');
end

end
