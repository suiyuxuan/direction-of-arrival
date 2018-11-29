% Federal University of Rio Grande do Norte
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation
%
% algorithms: % "MUSIC", "ESPRIT", "Capon", "Root-MUSIC", "Beamscan", 
% "GCC-PHAT", "GCC-NLT", "FLOS-PHAT", "NLT-MUSIC"
%
% type_of_data: "simulated-sine", "simulated-zadoff-chu",
% "simulated-voice", "real", "demo-gong"
%
% noise{n}.model = "gaussian real", "gaussian complex",
% "alpha-stable real", "alpha-stable complex", 
% "gaussian mixture real", "gaussian mixture complex"

%% Clear and close

clear
close all
clc

%% Param

output_name = "teste";
algorithms = ["MUSIC"];
type_of_data = "simulated-sine";
angles = [20];
number_of_sensors = 10;
distance_between_sensors = 0.08;
source_frequency = [1000];
sampling_frequency = 40000;
number_of_samples = 400; %353; %139
number_of_iterations = 100;
speed_propagation = 340;
number_of_snapshots = 1;
%noise{1}.model = "gaussian real";
%noise{1}.snr = -20:40;
noise{1}.model = "gaussian mixture complex";
noise{1}.snr = -20:40;
noise{1}.rel = 100;
%noise{1}.model = "alpha-stable complex";
%noise{1}.snr = -20:40; % GSNR
%noise{1}.alpha = 1.3;
deviation_of_angle = 6;

%% Check data

data = check_data(type_of_data, output_name, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, speed_propagation, 'noise', noise);

%% Evaluation of results

performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle, 'repeat', number_of_iterations);

%% Save outputs and plot

save_outputs(output_name, performance_metrics);
