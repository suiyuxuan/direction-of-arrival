% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Selection Data
% Description: Selection of signal for synthetic or real data
% Parameters:
% type: 'real' or 'simulated' data
% - varargin -
% 

function [data] = selection_data(type_of_data, varargin)

%if (nargin > 13), error('parameters number incorrect.');, end

% FIXIT: defaultN attributed before of inputParser
defaultN = 200;
% FIXIT: defaultSnapshots attributed before of inputParser
defaultSnapshots = 200;
defaultU = 340; % speed sound propagation (~340 m/s)
defaultNoise.model = 'deterministic';
defaultChannel.model = 'none';

%defaultSNR = 0;
%defaultAlpha = 1.7;
%defaultGSNR = 0;
%defaultMeans = [0 0];
%defaultVariances = [0.01 1];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First, brute force solution

% Idea:
% pp = @(noise) prod(structfun(@numel, noise));
% pp(noise{1})

%data.properties.angles = inputs.Results.angles;
%data = struct('angles', num2cell(inputs.Results.

data.properties.type_of_data = inputs.Results.type_of_data;
data.properties.angles = inputs.Results.angles;
data.properties.M = inputs.Results.number_of_sensors;
data.properties.d = inputs.Results.distance_between_sensors;
data.properties.f = inputs.Results.source_frequency;
data.properties.fs = inputs.Results.sampling_frequency;
data.properties.N = inputs.Results.number_of_samples;
data.properties.u = inputs.Results.speed_propagation;
data.properties.snapshots = inputs.Results.length_snapshots;

data.properties.noise = inputs.Results.noise;
data.properties.channel = inputs.Results.channel;

end
