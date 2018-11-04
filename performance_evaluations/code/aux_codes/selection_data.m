% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function signal = selection_data(type_of_data, angles, M, d, f, fs, N, u, noise, channel)

switch type_of_data
    case "simulated-sine"
        signal = create_signal("sine", angles, M, d, f, fs, N, u, noise, channel);
    case "real"
        signal = load_data(angles, M, d, fs, N, noise, channel); % missing implement
    case "simulated-zadoff-chu"
        signal = create_signal("zadoff-chu", angles, M, d, f, fs, N, u, noise, channel);
    case "simulated-voice"
        signal = create_signal("voice", angles, M, d, f, fs, N, u, noise, channel);
    case "demo-gong"
        signal = create_signal("gong", angles, M, d, f, fs, N, u, noise, channel);
    otherwise
        error("Type of data invalid");
end

end