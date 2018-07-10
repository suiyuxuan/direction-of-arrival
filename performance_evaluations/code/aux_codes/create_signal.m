% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function signal = create_signal(type_of_data, angles, M, d, f, fs, N, u, snapshots)

switch type_of_data
    case "simulated"
        signal = signal_generator(data);
    case "real"
        signal = load_data(data); % missing implement
    otherwise
        error("Type of data invalid");
end

end
