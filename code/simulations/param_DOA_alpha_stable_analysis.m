% Federal University of Rio Grande do Norte
% Title: param_DOA_alpha_stable_analysis
% Author: Danilo Pena
% Description: DOA evaluation for alpha-stable noise

%% Parameters
algorithms = ["MUSIC", "ESPRIT", "Capon", "Root-MUSIC", "NLT-MUSIC"];
type_of_data = "simulated-sine";
angles = [18];
number_of_sensors = 8;
distance_between_sensors = 0.085;
source_frequency = [2000];
sampling_frequency = 20000;
number_of_samples = 100;
number_of_iterations = 1000;
speed_propagation = 340;
number_of_snapshots = 1;
noise{1}.model = "alpha-stable complex";
noise{1}.snr = -20:40;
noise{1}.alpha = 1.1;
noise{2}.model = "alpha-stable complex";
noise{2}.snr = -20:40;
noise{2}.alpha = 1.3;
noise{3}.model = "alpha-stable complex";
noise{3}.snr = -20:40;
noise{3}.alpha = 1.5;
noise{4}.model = "alpha-stable complex";
noise{4}.snr = -20:40;
noise{4}.alpha = 1.7;
noise{5}.model = "alpha-stable complex";
noise{5}.snr = -20:40;
noise{5}.alpha = 1.9;
deviation_of_angle = 6;
