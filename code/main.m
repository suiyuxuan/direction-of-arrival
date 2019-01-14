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

output_name = "teste_DOA";
algorithms = ["MUSIC" "NLT-MUSIC"];
type_of_data = "simulated-sine";
angles = [20];
number_of_sensors = 10;
distance_between_sensors = 0.08;
source_frequency = [1000];
sampling_frequency = 40000;
number_of_samples = 400;
number_of_iterations = 10000;
speed_propagation = 340;
number_of_snapshots = 1;
noise{1}.model = "gaussian complex";
noise{1}.snr = -20:40;
noise{2}.model = "gaussian mixture complex";
noise{2}.snr = -20:40;
noise{2}.rel = 100;
noise{3}.model = "alpha-stable complex";
noise{3}.snr = -20:40;
noise{3}.alpha = 1.7;
deviation_of_angle = 6;

% output_name = "teste_TDOA";
% algorithms = ["GCC-PHAT" "GCC-NLT" "FLOS-PHAT"];
% type_of_data = "simulated-zadoff-chu";
% angles = [20];
% number_of_sensors = 2;
% distance_between_sensors = 0.05;
% source_frequency = [1000];
% sampling_frequency = 40000;
% number_of_samples = 353; %139
% number_of_iterations = 10000;
% speed_propagation = 340;
% number_of_snapshots = 1;
% noise{1}.model = "gaussian real";
% noise{1}.snr = -20:40;
% noise{2}.model = "gaussian mixture real";
% noise{2}.snr = -20:40;
% noise{2}.rel = 100;
% noise{3}.model = "alpha-stable real";
% noise{3}.snr = -20:40;
% noise{3}.alpha = 1.7;
% deviation_of_angle = 6;

%% Check data

data = check_data(type_of_data, output_name, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, speed_propagation, 'noise', noise);

%% Evaluation of results

performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle, 'repeat', number_of_iterations);

%% Save outputs and plot

save_outputs(output_name, performance_metrics);
