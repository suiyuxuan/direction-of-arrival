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
% - varargin -
% noise model: 'gaussian', 'gaussian mixture', 'alpha-stable'
% noise parameters: gaussian (snr), gaussian mixture (means, variances), alpha-stable (alpha, g-snr)
% channel model: 'reverberation', 'echo', 'multiple echos', 'flanging', 'statistical'
% channel parameters: reverberation (a, N)

function [signal] = signal_generator(angles, N, M, d, u, f, fs, varargin)

if (nargin > 4), error('parameters number incorrect.'), end

P = length(angles); % source number
A = zeros(P,M); % steering matrix
wn = (f.*2.*pi)./fs; % normalized frequency source

for k = 1:P
    A(k,:) = exp(-1i*2*pi*f(k)*d*sin((angles(k))/u*[0:M-1]);
end
A = A';

sig = exp(1i*(wn*[1:N]));

% FIXIT: check difference between length(varargin) and nargin
if length(varargin) == 0 % deterministic model
    signal = A*sig;
elseif length(varargin) == 2 % noise model or channel model
    if varargin{1} == list_of_noise_model
        %gaussian_model(); or alpha_stable_model();
    elseif varargin{1} == list_of_channel_model
        %reverberation_model();
    else
        disp('Error in parameters');
    end
elseif length(varargin) == 4 % noise model plus channel model
    % (...)
else
    disp('Error in parameters')
end


%signalPower = (1/N)*s(1,:)*s(1,:)';
%signalPower_dB = 10*log10(signalPower);
%noisePower_dB = signalPower_dB - snr;
%noisePower = 10^(noisePower_dB/10);
%noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
%signal = (A*sig) + noise;


end
