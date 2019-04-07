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

if ~exist(strcat("../results/", output_name), 'dir') %Initial step, 2 (file), 7 (folder)
   mkdir(char(strcat("../results/", output_name)));
end

save(char(strcat("../results/", output_name, "/results.mat")), 'performance_metrics');

%% Ploting

for k = 1:length(performance_metrics)

axisX = performance_metrics(k).noise.snr;

if ((performance_metrics(k).noise.model == "alpha-stable real")||(performance_metrics(k).noise.model == "alpha-stable complex"))
    complement = strcat("\alpha = ", num2str(performance_metrics(k).noise.alpha));
elseif ((performance_metrics(k).noise.model == "gaussian mixture real")||(performance_metrics(k).noise.model == "gaussian mixture real"))
    complement = strcat("REL = ", num2str(performance_metrics(k).noise.rel));
else
    complement = "AWGN";
end

% Plots
hR = figure (1);
axisY = performance_metrics(k).RMSE;
pR(k) = plot(axisX, axisY);
title('Parametric Evaluation - RMSE');
xlabel('SNR - GSNR');
ylabel('RMSE');
grid on;
legend_namesR{k} = char(strcat(performance_metrics(k).algorithms, " - ", complement));
hold on

hA = figure (2);
axisY = performance_metrics(k).absolute_error;
pA(k) = plot(axisX, axisY);
title('Parametric Evaluation - Absolute Error');
xlabel('SNR - GSNR');
ylabel('Absolute Error');
grid on;
legend_namesA{k} = char(strcat(performance_metrics(k).algorithms, " - ", complement));
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
