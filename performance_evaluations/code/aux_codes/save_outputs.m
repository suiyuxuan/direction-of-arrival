% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(performance_metrics, algorithms, angles, varargin)

%if (nargin > 10), error('parameters number incorrect.');, end

defaultNoise.model = 'deterministic';
defaultChannel.model = 'none';

inputs = inputParser;
addRequired(inputs, 'performance_metrics');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'angles');
addParameter(inputs, 'noise', defaultNoise);
addParameter(inputs, 'channel', defaultChannel);

parse(inputs, performance_metrics, algorithms, angles, varargin{:});

performance_metrics = inputs.Results.performance_metrics;
algorithms = inputs.Results.algorithms;
angles = inputs.Results.angles;
noise = inputs.Results.noise;
channel = inputs.Results.channel;

% Plots
%figure (1);
%plot(noise.snr, performance_metrics.algorithms(1).RMSE);
%title('Parametric Evaluation - SNR');
%xlabel('SNR');
%ylabel('RMSE');
%grid on;
%print('results/RMSE','-depsc');

% TODO: Organize the structure before to save and conditions

%if (noise.model ~= "deterministic")&&(length(noise.snr)>1))

save('../results/general_results.mat','performance_metrics');

end
