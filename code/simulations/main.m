% Federal University of Rio Grande do Norte
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation
%
% Parameters
% algorithms:
% DOA - "MUSIC", "ESPRIT", "Capon", "Root-MUSIC", "Beamscan", "NLT-MUSIC"
% TDOA - "GCC-PHAT", "GCC-NLT", "FLOC", "GFLOC"
%
% type_of_data: "simulated-sine", "simulated-zadoff-chu",
% "simulated-voice", "real", "demo-gong"
%
% noise{n}.model = "gaussian real", "gaussian complex",
% "alpha-stable real", "alpha-stable complex", 
% "gaussian mixture real", "gaussian mixture complex"

function main(parameters, output_name)

%% Clear, close plots and add paths

clear
close all
clc

addpath(genpath('../algorithms'));
addpath(genpath('../aux_codes'));
addpath(genpath('../distortion_models'));
addpath(genpath('../didactical_codes'));
addpath(genpath('../simulations'));

%% Parameters
eval(parameters);

%% Check data

data = check_data(type_of_data, output_name, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, speed_propagation, 'noise', noise);

%% Evaluation of results

performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle, 'repeat', number_of_iterations);

%% Save outputs and plot

save_outputs(output_name, performance_metrics);

end