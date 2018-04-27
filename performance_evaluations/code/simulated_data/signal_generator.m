% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
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

function [signal] = signal_generator(angles, N, M, d, u, f, fs, varargin)

if (nargin > 13), error('parameters number incorrect.'), end

defaultNoiseModel = 'deterministic';
defaultChannelModel = 'none';

defaultSNR = 0;
defaultAlpha = 1.7;
defaultGSNR = 0;
defaultK = 2;
defaultMeans = [0 0];
defaultVariances = [0.01 1];

inputs = inputParser;
addRequired(inputs, 'angles');
addRequired(inputs, 'N');
addRequired(inputs, 'M');
addRequired(inputs, 'd');
addRequired(inputs, 'u');
addRequired(inputs, 'f');
addRequired(inputs, 'fs');
addParameter(inputs, 'noise', defaultNoiseModel, @ischar);
addOptional(inputs, 'snr', defaultSNR, @isnumeric);
addOptional(inputs, 'alpha', defaultAlpha, @isnumeric);
addOptional(inputs, 'gsnr', defaultGSNR, @isnumeric);
addOptional(inputs, 'k', defaultK, @isnumeric);
addOptional(inputs, 'means', defaultMeans, @isnumeric);
addOptional(inputs, 'variances', defaultVariances, @isnumeric);
addParameter(inputs, 'channel', defaultChannelModel, @ischar);

parse(inputs, angles, N, M, d, u, f, fs, varargin{:});

P = length(angles); % source number
A = zeros(P,M); % steering matrix
wn = (f.*2.*pi)./fs; % normalized frequency source

for k = 1:P
    A(k,:) = exp(-1i*2*pi*f(k)*d*sin((angles(k)*(pi/180)))/u*[0:M-1]);
end
A = A';

sig = exp(1i*(wn*[1:N]));

switch inputs.Results.noise
    case 'deterministic'
        signal = A*sig;
    case 'gaussian'
        signal = gaussian_complex_model(A*sig, inputs.Results.snr);
    case 'alpha-stable'
        signal = sas_complex_model(A*sig, inputs.Results.alpha, inputs.Results.gsnr);
    case 'gaussian mixture'
        signal = gaussian_mixture_model(A*sig, inputs.Results.k, inputs.Results.means, inputs.Results.variances);
    otherwise
        error('noise model incorrect.');
end

switch inputs.Results.channel
    case 'none'
        signal = signal;
    case 'reverberation'
        signal = reverberation_model(signal);
    otherwise
        error('channel model incorrect.');
end

end
