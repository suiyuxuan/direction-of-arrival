% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(output_name, performance_metrics)

%if (nargin > 10), error('parameters number incorrect.');, end

% Initializing

inputs = inputParser;
addRequired(inputs, 'performance_metrics');

parse(inputs, performance_metrics);

performance_metrics = inputs.Results.performance_metrics;

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

axisX = performance_metrics(k).noise.snr;

% Plots
hR = figure (1);
axisY = performance_metrics(k).RMSE;
pR(k) = plot(axisX, axisY);
title('Parametric Evaluation - RMSE');
xlabel('SNR - GSNR');
ylabel('RMSE');
grid on;
legend_namesR{k} = char(strcat(performance_metrics(k).algorithms, " - ", performance_metrics(k).noise.model));
hold on

hA = figure (2);
axisY = performance_metrics(k).absolute_error;
pA(k) = plot(axisX, axisY);
title('Parametric Evaluation - Absolute Error');
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
saveas(hR,strcat("../results/", output_name, "/RMSE.fig"))
saveas(hA,strcat("../results/", output_name, "/AE.fig"))

end
