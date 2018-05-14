% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithms, correct_angle, varargin)

defaultDelta = 6;
defaultRepeat = 1;

if (nargin > 10), error('parameters number incorrect.');, end

inputs = inputParser;
addRequired(inputs, 'data');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'correct_angle');
addOptional(inputs, 'delta', defaultDelta);
addParameter(inputs, 'repeat', defaultRepeat);

parse(inputs, data, algorithms, correct_angle, varargin{:});

delta = inputs.Results.delta;
iterations = inputs.Results.repeat;

length_snapshots = data.snapshots;
[M,N] = size(data.signal);
L = floor(N/length_snapshots);

PD = [];
RMSE = [];
absolute_error = [];

for current_algorithm = 1:length(algorithms)
    for i = 1:iterations
        angle_of_algorithm = snapshots(data, algorithms(current_algorithm));

        % Detection Probability calculus
        PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))/L];

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
