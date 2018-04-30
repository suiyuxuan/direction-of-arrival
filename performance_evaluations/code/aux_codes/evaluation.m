% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithms, correct_angle, delta)

signal = data.signal;
length_snapshots = data.snapshots;
[M,N] = size(signal);
L = floor(N/length_snapshots);

% FIXIT: Missing add interations of Monte Carlo

PD = [];
RMSE = [];
absolute_error = [];

while(~isempty(algorithms))
    angle_of_algorithm = snapshots(data, algorithms(1));
    algorithms(1) = [];

    % Detection Probability calculus
    PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))/L];

    % Root Mean Square Error calculus
    % FIXIT: Check problem with RMSE
    RMSE = [RMSE sqrt( immse(angle_of_algorithm,correct_angle*ones(1,length(angle_of_algorithm))) )];

    % Absolute Error calculus
    abolute_error = [absolute_error mean( abs(angle_of_algorithm - correct_angle) )];

    % TODO: Variance calculus
    %variancia = var();

    % TODO: Resolution Probability
    %PR

    performance_metrics.RMSE = RMSE;
    performance_metrics.AE = abolute_error;
    performance_metrics_PD =  PD;

end

end
