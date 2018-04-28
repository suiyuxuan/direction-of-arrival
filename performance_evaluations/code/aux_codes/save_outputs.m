% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Save Outputs
% Description: Save analysis of output
% Parameters:

function save_outputs(performance_metrics, algorithms, angles, varargin)

%if (nargin > 10), error('parameters number incorrect.');, end

inputs = inputParser;
addRequired(inputs, 'performace_metrics');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'angles');
addParameter(inputs, 'noise');
addParameter(inputs, 'channel');

% Plots
figure (1);
%plot(snr, performance_metrics.RMSE);
%title('Parametric Evaluation - SNR');
%xlabel('SNR');
%ylabel('RMSE');
%grid on;
%print('results/RMSE','-depsc');



end
