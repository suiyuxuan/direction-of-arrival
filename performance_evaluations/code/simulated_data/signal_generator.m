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
% noise parameters: gaussian (snr), gaussian mixture (means, variances), alpha-stable (alpha, g-snr)
% channel model: 'reverberation', 'echo', 'multiple echos', 'flanging', 'statistical'
% channel parameters: reverberation (a, N)

function [signal] = signal_generator(angles, N, M, d, u, f, fs, varargin)

snr = 10; % TEMPORARY VARIABLE

if (nargin > 11), error('parameters number incorrect.'), end

defaultNoiseModel = 'deterministic';
defaultChannelModel = 'none';

inputs = inputParser;
addRequired(inputs, 'angles');
addRequired(inputs, 'N');
addRequired(inputs, 'M');
addRequired(inputs, 'd');
addRequired(inputs, 'u');
addRequired(inputs, 'f');
addRequired(inputs, 'fs');
addParameter(inputs, 'noise', defaultNoiseModel, @ischar);
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

switch defaultNoiseModel
    case 'deterministic'
        signal = A*sig;
    case 'gaussian'
        signal = gaussian_complex_model(A*sig, snr);
    case 'alpha-stable'
        signal = sas_complex(A*sig, alpha, gsnr);
    case 'gaussian mixture'
        signal = gaussian_mixture_model(A*sig, means, variances);
    otherwise
        error('noise model incorrect.');
end

switch defaultChannelModel
    case 'none'
        signal = signal;
    case 'reverberation'
        signal = reverberation_model(signal);
    otherwise
        error('channel model incorrect.');
end

end
