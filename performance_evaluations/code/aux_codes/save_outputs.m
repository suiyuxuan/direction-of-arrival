% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(output_name, performance_metrics, analysis, axis_x, axis_y)

%if (nargin > 10), error('parameters number incorrect.');, end

% Initializing

inputs = inputParser;
addRequired(inputs, 'performance_metrics');
addRequired(inputs, 'analysis');
addRequired(inputs, 'axis_x');
addRequired(inputs, 'axis_y');

parse(inputs, performance_metrics, analysis, axis_x, axis_y);

performance_metrics = inputs.Results.performance_metrics;
analysis = inputs.Results.analysis;
axis_x = inputs.Results.axis_x;
axis_y = inputs.Results.axis_y;

%% Creating the folder and save the mat-file

%current_directory = pwd;
%folders = dir;
%addpath(genpath(fullfile(current_directory,folders);s

if ~exist(strcat("../../results/", output_name), 'dir') %Initial step, 2 (file), 7 (folder)
    mkdir(char(strcat("../../results/", output_name)));
end

%% Ploting

if (axis_x ==  "snr") || (axis_x == "gsnr")
    axisX = performance_metrics(k).noise{1}.snr;
elseif (axis_x == "M")
    % TODO
elseif (axis_x == "snapshots")
    % TODO
elseif (axis_x == "d")
    % TODO
else
    error('Axis X invalid.');
end



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
