% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(performance_metrics, algorithms, noise, channel)

%if (nargin > 10), error('parameters number incorrect.');, end

inputs = inputParser;
addRequired(inputs, 'performance_metrics');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'noise');
addRequired(inputs, 'channel');

parse(inputs, performance_metrics, algorithms, noise, channel);

performance_metrics = inputs.Results.performance_metrics;
algorithms = inputs.Results.algorithms;
noise = inputs.Results.noise;
channel = inputs.Results.channel;

%current_directory = pwd;
%folders = dir;
%addpath(genpath(fullfile(current_directory, folders);

% TODO: step 0 - check if output exist
%Name = path_to_output;
%if exist('../results/results.mat', 'file') == 2 %Initial step, 2 (file), 7 (folder)
%    plot(file)
%else
    %Run simulation
%end

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
