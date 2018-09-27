% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function signal = selection_data(type_of_data, angles, M, d, f, fs, N, u, noise, channel)

switch type_of_data
    case "simulated"
        signal = create_signal(angles, M, d, f, fs, N, u, noise, channel);
    case "real"
        signal = load_data(angles, M, d, fs, N, noise, channel); % missing implement
    otherwise
        error("Type of data invalid");
end

end
