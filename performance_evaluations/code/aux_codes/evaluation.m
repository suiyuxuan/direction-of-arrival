% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithm, correctAngle, delta)

x = data.x;
snapshot = data.snapshot;
[M,N] = size(x);
L = floor(N/snapshot);

angleAlgorithm = snapshots(data, algorithm);

% Detection Probability calculus
PD = sum((abs(angleAlgorithm - correctAngle)) < delta);
PD = PD/L;

% Root Mean Square Error calculus
% FIXIT: Check problem with RMSE
RMSE = sqrt( immse(angleAlgorithm,correctAngle*ones(1,length(angleAlgorithm))) );

% Absolute Error calculus
aboluteError = mean( abs(angleAlgorithm - correctAngle) );

% TODO: Variance calculus
%variancia = var();

% TODO: Resolution Probability
%PR

performance_metrics.RMSE = RMSE;
performance_metrics.AE = aboluteError;
performance_metrics_PD =  PD;

end
