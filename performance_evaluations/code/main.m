% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation

% FIXIT: function or not?
%function [results] = main(varargin)

algorithms = ["MUSIC" "ESPRIT" "Capon" "Root_MUSIC"];
type_of_data = 'simulated';
angles = [20];
number_of_sensors = 10;
distance_between_sensors = 0.08;
source_frequency = 1000;
sampling_frequency = 200000;
number_of_samples = 200;
noise.model = 'gaussian';
noise.snr = 0;
deviation_of_angle = 6;

% TODO: step 0 - selection how will be the output
% TODO: step 0.1 - check if output exist
%Name = path_to_output;
if exist('../results/results.mat', 'file') == 2 %Initial step, 2 (file), 7 (folder)
%    plot(file)
else
    %Run simulation
end

% step 1 - selection of simulated or real signal and its parameters
% step 1.1 - selection of interference model (noise and channel models)
data = selection_data(type_of_data, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, 'noise', noise);

%[theta, pmusic] = MUSIC(signal, 1, 1000, 0.08);
%figure(1);
%plot(theta,pmusic);
%print('test','-depsc'); 

% step 2 - selection of algorithms
% step 2.1 - selection of performance metrics
performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle);

% step 3 - save outputs
%save_outputs(performance_metrics, algorithms, angles, 'noise', noise, 'channel', channel);

%end
