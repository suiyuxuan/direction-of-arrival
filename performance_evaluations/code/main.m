% Federal University of Rio Grande do Norte
% Title: Main function
% Author: Danilo Pena
% Description: Main function for performance evaluation
%
% type_of_data: "simulated-sine", "simulated-zadoff-chu",
% "simulated-voice", "real", "demo-gong"

clear
close all
clc

algorithms = ["GCC-PHAT" "GCC-NLT"]; % "MUSIC", "ESPRIT", "Capon", "Root MUSIC", "Beamscan", "GCC-PHAT", "GCC-NLT"
type_of_data = "simulated-zadoff-chu"; % "simulated-sine", "simulated-zadoff-chu", "simulated-voice", "demo-gong", "real"
angles = [20]; % This should be a cell (combination of number of source)
number_of_sensors = 10;
distance_between_sensors = 0.08;
source_frequency = [1000];
sampling_frequency = 40000;
number_of_samples = 278;
number_of_iterations = 100;
noise{1}.model = "gaussian complex"; % "deterministic", "gaussian real", "gaussian complex", "alpha-stable real", "alpha-stable complex", "gaussian mixture"
noise{1}.snr = -40:40;
noise{2}.model = "alpha-stable complex";
noise{2}.gsnr = -40:40;
noise{2}.alpha = 1.7;
deviation_of_angle = 6;

% step 1 - selection of simulated or real signal and its parameters
% step 1.1 - selection of interference model (noise and channel models)
data = check_data(type_of_data, angles, number_of_sensors, distance_between_sensors, source_frequency, sampling_frequency, number_of_samples, number_of_iterations, 'noise', noise);

%[theta, pmusic] = MUSIC(signal, 1, 1000, 0.08);
%figure(1);
%plot(theta,pmusic);
%print('test','-depsc'); 

% step 2 - selection of algorithms
% step 2.1 - selection of performance metrics
performance_metrics = evaluation(data, algorithms, angles, deviation_of_angle, 'repeat', number_of_iterations);

%figure (1)
%plot(performance_metrics.algorithms(:).RMSE)
%print('test','-depsc');

% step 3 - save outputs
%save_outputs(performance_metrics, algorithms, noise, channel);

%end
