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

%% Creating the folder and saving the mat-file

%current_directory = pwd;
%folders = dir;
%addpath(genpath(fullfile(current_directory,folders);s

if ~exist(strcat("../../results/", output_name), 'dir') %Initial step, 2 (file), 7 (folder)
    mkdir(char(strcat("../../results/", output_name)));
end

save(char(strcat("../../results/", output_name, "/results.mat")), 'performance_metrics');

%% Ploting

if (axis_x ==  "snr") || (axis_x == "gsnr")
    axisX = performance_metrics(1).noise.snr;
elseif (axis_x == "M")
    % TODO
elseif (axis_x == "snapshots")
    % TODO
elseif (axis_x == "d")
    % TODO
else
    error('Axis X invalid.');
end

axisY = performance_metrics(1).RMSE;

% Plots
figure (1);
plot(axisX, axisY);
title('Parametric Evaluation - SNR');
xlabel('SNR');
ylabel('RMSE');
grid on;
legend(char(performance_metrics(1).algorithms));
print(char(strcat("../../results/", output_name, "/results")),'-depsc');
print(char(strcat("../../results/", output_name, "/results")),'-dpng');

% TODO: Organize the structure before to save and conditions

%if (noise.model ~= "deterministic")&&(length(noise.snr)>1))

save('../results/general_results.mat','performance_metrics');

end
