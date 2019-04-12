% Federal University of Rio Grande do Norte
% Title: param_TDOA_GCC
% Author: Danilo Pena
% Description: TDOA with GCC methods

%% Parameters
algorithms = ["GCC-PHAT" "GCC-ROTH" "GCC-SCOT"];
type_of_data = "simulated-zadoff-chu";
angles = [20];
number_of_sensors = 2;
distance_between_sensors = 0.05;
source_frequency = [1000];
sampling_frequency = 48000;
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
noise{3}.alpha = 1.1;
noise{4}.model = "alpha-stable real";
noise{4}.snr = -20:40;
noise{4}.alpha = 1.3;
noise{5}.model = "alpha-stable real";
noise{5}.snr = -20:40;
noise{5}.alpha = 1.5;
noise{6}.model = "alpha-stable real";
noise{6}.snr = -20:40;
noise{6}.alpha = 1.7;
noise{7}.model = "alpha-stable real";
noise{7}.snr = -20:40;
noise{7}.alpha = 1.9;
deviation_of_angle = 6;
