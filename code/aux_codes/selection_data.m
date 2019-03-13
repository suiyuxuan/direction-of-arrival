% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function signal = selection_data(type_of_data, angles, M, d, f, fs, N, u, noise, channel, snr)

switch type_of_data
    case "simulated-sine"
        signal = create_signal("sine", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "real"
        signal = load_data(angles, M, d, fs, N, noise, channel); % missing implement
    case "simulated-zadoff-chu"
        signal = create_signal("zadoff-chu", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "simulated-voice"
        signal = create_signal("voice", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-gong"
        signal = create_signal("gong", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-chirp"
        signal = create_signal("chirp", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-handel"
        signal = create_signal("handel", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-splat"
        signal = create_signal("splat", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-laughter"
        signal = create_signal("laughter", angles, M, d, f, fs, N, u, noise, channel, snr);
    case "demo-train"
        signal = create_signal("train", angles, M, d, f, fs, N, u, noise, channel, snr);
    otherwise
        error("Type of data invalid");
end

end
