% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(output_name, performance_metrics, axis_x)

%if (nargin > 10), error('parameters number incorrect.');, end

% Initializing

inputs = inputParser;
addRequired(inputs, 'performance_metrics');
addRequired(inputs, 'axis_x');

parse(inputs, performance_metrics, axis_x);

performance_metrics = inputs.Results.performance_metrics;
axis_x = inputs.Results.axis_x;

%% Creating the folder and saving the mat-file

%current_directory = pwd;
%folders = dir;
%addpath(genpath(fullfile(current_directory,folders);s

if ~exist(strcat("../results/", output_name), 'dir') %Initial step, 2 (file), 7 (folder)
    mkdir(char(strcat("../results/", output_name)));
end

save(char(strcat("../results/", output_name, "/results.mat")), 'performance_metrics');

%% Ploting

for k = 1:length(performance_metrics)

if (axis_x ==  "SNR") || (axis_x == "GSNR")
    axisX = performance_metrics(k).noise.snr;
elseif (axis_x == "M")
    axisX = performance_metrics(:).M;
elseif (axis_x == "snapshots")
    % TODO
elseif (axis_x == "d")
    % TODO
else
    error('Axis X invalid.');
end

% Plots
hR = figure (1);
axisY = performance_metrics(k).RMSE;
pR(k) = plot(axisX, axisY);
title('Parametric Evaluation - RMSE');
%xlabel(char(axis_x));
xlabel('SNR - GSNR');
ylabel('RMSE');
grid on;
legend_namesR{k} = char(strcat(performance_metrics(k).algorithms, " - ", performance_metrics(k).noise.model));
hold on

hA = figure (2);
axisY = performance_metrics(k).absolute_error;
pA(k) = plot(axisX, axisY);
title('Parametric Evaluation - Absolute Error');
%xlabel(char(axis_x));
xlabel('SNR - GSNR');
ylabel('Absolute Error');
grid on;
legend_namesA{k} = char(strcat(performance_metrics(k).algorithms, " - ", performance_metrics(k).noise.model));
hold on

end

legend(pR,legend_namesR);
legend(pA,legend_namesA);

print(hR, strcat("../results/", output_name, "/RMSE"),'-depsc');
print(hA, strcat("../results/", output_name, "/AE"),'-depsc');
print(hR, strcat("../results/", output_name, "/RMSE"),'-dpng');
print(hA, strcat("../results/", output_name, "/AE"),'-dpng');


end
