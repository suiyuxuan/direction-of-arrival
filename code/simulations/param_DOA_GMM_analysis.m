% Federal University of Rio Grande do Norte
% Title: param_DOA_GMM_analysis
% Author: Danilo Pena
% Description: DOA evaluation for GMM noise

%% Parameters
algorithms = ["MUSIC", "ESPRIT", "Capon", "Root-MUSIC", "Beamscan", "NLT-MUSIC"];
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
noise{1}.model = "gaussian mixture complex";
noise{1}.snr = -20:40;
noise{1}.rel = 10;
noise{2}.model = "gaussian mixture complex";
noise{2}.snr = -20:40;
noise{2}.rel = 100;
noise{3}.model = "gaussian mixture complex";
noise{3}.snr = -20:40;
noise{3}.rel = 1000;
deviation_of_angle = 6;
