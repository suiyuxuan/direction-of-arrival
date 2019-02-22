% Federal University of Rio Grande do Norte
% Title: param_TDOA
% Author: Danilo Pena
% Description: TDOA

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
noise{1}.model = "gaussian real";
noise{1}.snr = -20:40;
noise{2}.model = "gaussian mixture real";
noise{2}.snr = -20:40;
noise{2}.rel = 1000;
noise{3}.model = "alpha-stable real";
noise{3}.snr = -20:40;
noise{3}.alpha = 1.7;
deviation_of_angle = 6;
