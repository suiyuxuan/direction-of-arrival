% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation

function [results] = main(varargin)

% TODO: step 1 - selection of simulated or real signal and its parameters
% TODO: step 1.1 - selection of interference model (noise and channel models)
data = selection_data(type, parameters_signal);

% TODO: step 2 - selection of algorithms
% TODO: step 2.1 - selection of performance metrics
performance_metrics = evaluation(data, algorithm);

% TODO: step 3 - selection how will be the output
Name = path_to_output;
if exist(Name, 'file') == 2 %Initial step
    plot(file)
else
    %Run simulation
end

end
