% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithms, correctAngle, delta)

x = data.x;
snapshot = data.snapshot;
[M,N] = size(x);
L = floor(N/snapshot);

% FIXIT: Missing add interations of Monte Carlo

PD = [];
RMSE = [];
absoluteError = [];

while(~isempty(algorithms))
    angleAlgorithm = snapshots(data, algorithms(1));
    algorithms(1) = [];

    % Detection Probability calculus
    PD = [PD (sum((abs(angleAlgorithm - correctAngle)) < delta))/L];

    % Root Mean Square Error calculus
    % FIXIT: Check problem with RMSE
    RMSE = [RMSE sqrt( immse(angleAlgorithm,correctAngle*ones(1,length(angleAlgorithm))) )];

    % Absolute Error calculus
    aboluteError = [absoluteError mean( abs(angleAlgorithm - correctAngle) )];

    % TODO: Variance calculus
    %variancia = var();

    % TODO: Resolution Probability
    %PR

    performance_metrics.RMSE = RMSE;
    performance_metrics.AE = aboluteError;
    performance_metrics_PD =  PD;

end

end
