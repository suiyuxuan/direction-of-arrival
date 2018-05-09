% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
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

signal = data.signal;
length_snapshots = data.snapshots;
[M,N] = size(signal);
L = floor(N/length_snapshots);

% FIXIT: Missing add interations of Monte Carlo

PD = [];
RMSE = [];
absolute_error = [];
performance_metrics.RMSE = [];
performance_metrics.AE = [];
performance_metrics.PD =  [];

while(~isempty(algorithms))
    for i = 1:iterations
        angle_of_algorithm = snapshots(data, algorithms(1));

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

% FIXIT: IMPLEMENT METRICS STORAGE
        performance_metrics.algorithm(1).RMSE = [performance_metrics.RMSE RMSE];
        performance_metrics.AE = [performance_metrics.AE absolute_error];
        performance_metrics.PD = [performance_metrics.PD PD];
    end
    algorithms(1) = [];
end

end
