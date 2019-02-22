% Federal University of Rio Grande do Norte
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation
%
% Parameters
% algorithms: % "MUSIC", "ESPRIT", "Capon", "Root-MUSIC", "Beamscan", 
% "GCC-PHAT", "GCC-NLT", "FLOS-PHAT", "NLT-MUSIC"
%
% type_of_data: "simulated-sine", "simulated-zadoff-chu",
% "simulated-voice", "real", "demo-gong"
%
% noise{n}.model = "gaussian real", "gaussian complex",
% "alpha-stable real", "alpha-stable complex", 
% "gaussian mixture real", "gaussian mixture complex"

%% Clear, close plots and add paths

clear
close all
clc

addpath(genpath('algorithms'));
addpath(genpath('aux_codes'));
addpath(genpath('distortion_models'));
addpath(genpath('didactical_codes'));

%% Parameters

% Example 1 - DOA algorithms evaluation
% output_name = "test_DOA";
% algorithms = ["ESPRIT" "Root-MUSIC"];
% type_of_data = "simulated-sine";
% angles = [18];
% number_of_sensors = 8;
% distance_between_sensors = 0.085;
% source_frequency = [2000];
% sampling_frequency = 20000;
% number_of_samples = 100;
% number_of_iterations = 1000;
% speed_propagation = 340;
% number_of_snapshots = 1;
% noise{1}.model = "gaussian complex";
% noise{1}.snr = -20:20;
% noise{2}.model = "gaussian mixture complex";
% noise{2}.snr = -20:40;
% noise{2}.rel = 100;
% noise{3}.model = "alpha-stable complex";
% noise{3}.snr = -20:40;
% noise{3}.alpha = 1.7;
% deviation_of_angle = 6;

% Example 2 - TDOA algorithms evaluation
output_name = "TDOA_test";
algorithms = ["GCC-NLT" "FLOS-PHAT" "GFLOS-PHAT"];
type_of_data = "simulated-zadoff-chu";
angles = [20];
number_of_sensors = 2;
distance_between_sensors = 0.05;
source_frequency = [1000];
sampling_frequency = 40000;
number_of_samples = 353; %139
number_of_iterations = 10000;
speed_propagation = 340;
number_of_snapshots = 1;
noise{1}.model = "gaussian real";
noise{1}.snr = -20:40;
noise{2}.model = "gaussian mixture real";
noise{2}.snr = -20:40;
noise{2}.rel = 1000;
noise{3}.model = "alpha-stable real";
noise{3}.snr = -20:40;
noise{3}.alpha = 1.7;
deviation_of_angle = 6;

%% Check data

data = check_data(type_of_data, output_name, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, speed_propagation, 'noise', noise);

%% Evaluation of results

performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle, 'repeat', number_of_iterations);

%% Save outputs and plot

save_outputs(output_name, performance_metrics);
