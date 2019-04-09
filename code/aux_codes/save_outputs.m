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

noise_model = [];
index_noise = 0;

for k = 1:length(performance_metrics)

axisX = performance_metrics(k).noise.snr;

if ((performance_metrics(k).noise.model == "alpha-stable real")||(performance_metrics(k).noise.model == "alpha-stable complex"))
    complement = strcat("(\alpha-stable) \alpha = ", num2str(performance_metrics(k).noise.alpha));
    x_axis = "GSNR";
    noise_model = [noise_model complement];
elseif ((performance_metrics(k).noise.model == "gaussian mixture real")||(performance_metrics(k).noise.model == "gaussian mixture real"))
    complement = strcat("(GMM) REL = ", num2str(performance_metrics(k).noise.rel));
    x_axis = "GSNR";
    noise_model = [noise_model complement];
else
    complement = "(AWGN)";
    x_axis = "SNR";
    
end

if (sum(noise_model == complement))
    index_noise = find(noise_model==complement);
else
    noise_model = [noise_model complement];
    index_noise = index_noise + 1;
end

% Plots
hR(index_noise*3+1) = figure (index_noise*3+1);
axisY = performance_metrics(k).RMSE;
pR(k) = plot(axisX, axisY);
title(strcat("RMSE ", complement));
xlabel(x_axis);
ylabel('RMSE (degrees)');
grid on;
legend_namesR{k} = char(performance_metrics(k).algorithms);
hold on

hA(index_noise*3+2) = figure (index_noise*3+2);
axisY = performance_metrics(k).absolute_error;
pA(k) = plot(axisX, axisY);
title(strcat("Absolute Error ", complement));
xlabel(x_axis);
ylabel('Absolute Error (degrees)');
grid on;
legend_namesA{k} = char(performance_metrics(k).algorithms);
hold on

hP(index_noise*3+3) = figure (index_noise*3+3);
axisY = performance_metrics(k).PD;
pD(k) = plot(axisX, axisY);
title(strcat("Probability Detection ", complement));
xlabel(x_axis);
ylabel('Probability Detection');
grid on;
legend_namesD{k} = char(performance_metrics(k).algorithms);
hold on

end

for kk=1:index_noise
    legend(pR,legend_namesR);
    legend(pA,legend_namesA);
    legend(pD,legend_namesD);

    print(hR, strcat("../results/", output_name, "/RMSE ", noise_model(kk)),'-depsc');
    print(hA, strcat("../results/", output_name, "/AE ", noise_model(kk)),'-depsc');
    print(hD, strcat("../results/", output_name, "/PD ", noise_model(kk)),'-depsc');

    print(hR, strcat("../results/", output_name, "/RMSE ", noise_model(kk)),'-dpng');
    print(hA, strcat("../results/", output_name, "/AE ", noise_model(kk)),'-dpng');
    print(hD, strcat("../results/", output_name, "/PD ", noise_model(kk)),'-dpng');

    saveas(hR,strcat("../results/", output_name, "/RMSE ", noise_model(kk), ".fig"));
    saveas(hA,strcat("../results/", output_name, "/AE ", noise_model(kk), ".fig"));
    saveas(hD,strcat("../results/", output_name, "/PD ", noise_model(kk), ".fig"));
end

end
