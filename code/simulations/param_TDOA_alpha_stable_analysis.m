% Federal University of Rio Grande do Norte
% Title: param_TDOA_alpha_stable_analysis
% Author: Danilo Pena
% Description: TDOA analysis of alpha-stable noise (alpha parameter)

%% Parameters
algorithms = ["GCC-PHAT" "GCC-NLT" "FLOC" "GFLOC"];
type_of_data = "simulated-zadoff-chu";
angles = [20];
number_of_sensors = 2;
distance_between_sensors = 0.05;
source_frequency = [1000];
sampling_frequency = 40000;
number_of_samples = 353; %139
number_of_iterations = 1000;
speed_propagation = 340;
number_of_snapshots = 1;
noise{1}.model = "alpha-stable real";
noise{1}.snr = -20:40;
noise{1}.alpha = 1.1;
noise{2}.model = "alpha-stable real";
noise{2}.snr = -20:40;
noise{2}.alpha = 1.3;
noise{3}.model = "alpha-stable real";
noise{3}.snr = -20:40;
noise{3}.alpha = 1.5;
noise{4}.model = "alpha-stable real";
noise{4}.snr = -20:40;
noise{4}.alpha = 1.7;
noise{5}.model = "alpha-stable real";
noise{5}.snr = -20:40;
noise{5}.alpha = 1.9;
deviation_of_angle = 6;
