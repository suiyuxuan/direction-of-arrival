% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function [RMSE, aboluteError, PD] = evaluation(data, algorithm, correctAngle, delta)

x = data.x;
snapshot = data.snapshot;
[M,N] = size(x);
L = floor(N/snapshot);

angleAlgorithm = snapshots(data, algorithm);

% Detection Probability calculus
PD = sum((abs(angleAlgorithm - correctAngle)) < delta);
PD = PD/L;

% Root Mean Square Error calculus
RMSE = sqrt( immse(angleAlgorithm,correctAngle*ones(1,length(angleAlgorithm))) );

% Absolute Error calculus
aboluteError = mean( abs(angleAlgorithm - correctAngle) );

% TODO: Variance calculus
%variancia = var();

end
