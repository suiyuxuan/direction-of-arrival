% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Selection Data
% Description: Selection of signal for synthetic or real data
% Parameters:
% type: 'real' or 'simulated' data
% - varargin -
% 

function [data] = selection_data(type_of_data, varargin)

if (nargin > 10), error('parameters number incorrect.');, end

% FIXIT: defaultN attributed before of inputParser
defaultN = 200;
% FIXIT: defaultSnapshots attributed before of inputParser
defaultSnapshots = 200;
defaultU = 340; % speed sound propagation (~340 m/s)
defaultNoise.model = 'deterministic';
defaultChannel.model = 'none';

inputs = inputParser;
addRequired(inputs, 'type_of_data');
addRequired(inputs, 'angles');
addRequired(inputs, 'number_of_sensors');
addRequired(inputs, 'distance_between_sensors');
addRequired(inputs, 'source_frequency');
addRequired(inputs, 'sampling_frequency');
addOptional(inputs, 'number_of_samples', defaultN, @isnumeric);
addOptional(inputs, 'speed_propagation', defaultU, @isnumeric);
addOptional(inputs, 'length_snapshots', defaultSnapshots);
addParameter(inputs, 'noise', defaultNoise);
addParameter(inputs, 'channel', defaultChannel);

parse(inputs, type_of_data, varargin{:});

data.d = inputs.Results.distance_between_sensors;
data.f = inputs.Results.source_frequency;
data.P = length(inputs.Results.angles);
data.u = inputs.Results.speed_propagation;
data.snapshots = inputs.Results.length_snapshots;

switch inputs.Results.type_of_data
    case 'simulated'
        data.signal = signal_generator(inputs.Results.angles, inputs.Results.number_of_samples, inputs.Results.number_of_sensors, inputs.Results.distance_between_sensors, inputs.Results.speed_propagation, inputs.Results.source_frequency, inputs.Results.sampling_frequency, 'noise', inputs.Results.noise, 'channel', inputs.Results.channel);
    case 'real'
        %data.signal = load();
    otherwise
        error('Type of data invalid.');
end

end
