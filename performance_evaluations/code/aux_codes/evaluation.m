% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithms, angles, varargin)

defaultDelta = 6;
defaultRepeat = 1;

if (nargin > 10), error('parameters number incorrect.');, end

inputs = inputParser;
addRequired(inputs, 'data');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'angles');
addOptional(inputs, 'delta', defaultDelta);
addParameter(inputs, 'repeat', defaultRepeat);

parse(inputs, data, algorithms, angles, varargin{:});

delta = inputs.Results.delta;
iterations = inputs.Results.repeat;


PD = [];
RMSE = [];
absolute_error = [];

for id = 1:numel(data)
    switch data(id).properties.type_of_data
        case "simulated"
            signal = signal_generator(data(id));    
        case "real"
            signal = load_data(data(id)); % missing implement
        otherwise
            error("Type of data invalid");
    end

%length_snapshots = data.properties.snapshots;
%[M,N] = size(data.signal);
%L = floor(N/length_snapshots);

    for i = 1:iterations
        angle_algorithm = snapshots(data(id), signal);

        % Detection Probability calculus
%        PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))/L];
        PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))];

        % Root Mean Square Error calculus
        % FIXIT: Check problem with RMSE
        RMSE = [RMSE sqrt( immse(angle_of_algorithm,correct_angle*ones(1,length(angle_of_algorithm))) )];

        % Absolute Error calculus
        absolute_error = [absolute_error mean( abs(angle_of_algorithm - correct_angle) )];

        % TODO: Variance calculus
        %variancia = var();

        % TODO: Resolution Probability
        %PR
    end
    performance_metrics.algorithms(current_algorithm).RMSE = RMSE;
    performance_metrics.algorithms(current_algorithm).AE = absolute_error;
    performance_metrics.algorithms(current_algorithm).PD = PD;
    RMSE = [];
    AE = [];
    PD = [];
end

end
