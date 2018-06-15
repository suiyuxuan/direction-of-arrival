% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function signal = create_signal(data)

%%%%%%%%%%%%%%%%%%%%%%
% FORCE BRUTE SOLUTION
%%%%%%%%%%%%%%%%%%%%%%

for n_tod = 1:length(data.properties.type_of_data)
for n_a = 1:length(data.properties.angles)
for n_m = 1:length(data.properties.M)
for n_d = 1:length(data.properties.d)
for n_f = 1:length(data.properties.f)
for n_fs = 1:length(data.properties.fs)
for n_n = 1:length(data.properties.N)
for n_u = 1:length(data.properties.u)
for n_s = 1:length(data.properties.snapshots)

switch data.properties.type_of_data(n_tod)
    case "simulated"
        signal = signal_generator(data);
    case "real"
        signal = load_data(data); % missing implement
    otherwise
        error("Type of data invalid");
end

end
