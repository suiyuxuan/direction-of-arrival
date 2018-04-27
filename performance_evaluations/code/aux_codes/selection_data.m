% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Selection Data
% Description: Selection of signal for synthetic or real data
% Parameters:
% type: 'real' or 'simulated' data
% - varargin -
% 

function [signal] = selection_data(type_of_data, varargin)

if (nargin > 10), error('parameters number incorrect.');, end

% FIXIT: defaultN attributed before of inputParser
% defaultN
defaultU = 340; % speed sound propagation (~340 m/s)
defaultNoise.noise = 'gaussian';
defaultNoise.snr = 0; % signal-to-noise ratio (0 dB)
defaultChannel.channel = 'none';

inputs = inputParser;
addRequired(inputs, 'type_of_data');
addRequired(inputs, 'angles');
addRequired(inputs, 'number_of_sensors');
addRequired(inputs, 'distance_between_sensors');
addRequired(inputs, 'source_frequency');
addRequired(inputs, 'sampling_frequency');
addOptional(inputs, 'number_of_samples', defaultN, @isnumeric);
addOptional(inputs, 'speed_propagation', defaultU, @isnumeric);
addParameter(inputs, 'noise', defaultNoise);
addParameter(inputs, 'channel', defaultChannel);

parse(inputs, type_of_data, varargin{:});

switch inputs.Results.type_of_data
    case 'simulated'
        signal = signal_generator(inputs.Results.angles, inputs.Results.number_of_samples, inputs.Results.number_of_sensors, inputs.Results.distance_between_sensors, inputs.Results.speed_propagation, inputs.Results.source_frequency, inputs.Results.sampling_frequency, inputs.Results.noise, inputs.Results.channel);
    case 'real'
        %signal = load();
    otherwise
        error('Type of data invalid.');
end

end
