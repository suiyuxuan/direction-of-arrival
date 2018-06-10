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


id = 1;
for ii1 = 1:length(inputs.Results.type_of_data)
for ii2 = 1:length(inputs.Results.angles)
for ii3 = 1:length(inputs.Results.number_of_sensors)
for ii4 = 1:length(inputs.Results.distance_between_sensors)
for ii5 = 1:length(inputs.Results.source_frequency)
for ii6 = 1:length(inputs.Results.sampling_frequency)
for ii7 = 1:length(inputs.Results.number_of_samples)
for ii8 = 1:length(inputs.Results.speed_propagation)
for ii9 = 1:length(inputs.Results.length_snapshots)
for ii10 = 1:numel(inputs.Results.noise)

data(id).properties.noise{ii10}.model = inputs.Results.noise{ii10}.model;

if inputs.Results.noise{ii10}.model == "gaussian"

for ii11 = 1:length(inputs.Results.noise{ii10}.snr)

data(id).properties.noise{ii10}.snr(ii11) = inputs.Results.noise{ii10}.snr(ii11);

data(id).properties.type_of_data = inputs.Results.type_of_data(ii1);
data(id).properties.angles = inputs.Results.angles(ii2);
data(id).properties.M = inputs.Results.number_of_sensors(ii3);
data(id).properties.d = inputs.Results.distance_between_sensors(ii4);
data(id).properties.f = inputs.Results.source_frequency(ii5);
data(id).properties.fs = inputs.Results.sampling_frequency(ii6);
data(id).properties.N = inputs.Results.number_of_samples(ii7);
data(id).properties.u = inputs.Results.speed_propagation(ii8);
data(id).properties.snapshots = inputs.Results.length_snapshots(ii9);

end

elseif inputs.Results.noise{ii10}.model == "alpha-stable"

for ii12 = 1:length(inputs.Results.noise{ii10}.alpha)
for ii13 = 1:length(inputs.Results.noise{ii10}.gsnr)

data(id).properties.noise{ii12}.alpha = inputs.Results.noise{ii12}.alpha;
data(id).properties.noise{ii13}.gsnr = inputs.Results.noise{ii13}.gsnr;

data(id).properties.type_of_data = inputs.Results.type_of_data(ii1);
data(id).properties.angles = inputs.Results.angles(ii2);
data(id).properties.M = inputs.Results.number_of_sensors(ii3);
data(id).properties.d = inputs.Results.distance_between_sensors(ii4);
data(id).properties.f = inputs.Results.source_frequency(ii5);
data(id).properties.fs = inputs.Results.sampling_frequency(ii6);
data(id).properties.N = inputs.Results.number_of_samples(ii7);
data(id).properties.u = inputs.Results.speed_propagation(ii8);
data(id).properties.snapshots = inputs.Results.length_snapshots(ii9);

end
end

end

data(id).properties.type_of_data = inputs.Results.type_of_data(ii1);
data(id).properties.angles = inputs.Results.angles(ii2);
data(id).properties.M = inputs.Results.number_of_sensors(ii3);
data(id).properties.d = inputs.Results.distance_between_sensors(ii4);
data(id).properties.f = inputs.Results.source_frequency(ii5);
data(id).properties.fs = inputs.Results.sampling_frequency(ii6);
data(id).properties.N = inputs.Results.number_of_samples(ii7);
data(id).properties.u = inputs.Results.speed_propagation(ii8);
data(id).properties.snapshots = inputs.Results.length_snapshots(ii9);

id = id + 1;

end
end
end
end
end
end
end
end
end
end




end
