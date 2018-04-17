% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function [RMSE, aboluteError, PD] = MUSIC_eval(data, correctAngle, delta)

x = data.x;
snapshot = data.snapshot;
[M,N] = size(x);
L = floor(N/snapshot);

angleMusic = MUSIC_data(data);

% Detection Probability calculus
PD = sum((abs(angleMusic-correctAngle))<delta);
PD = PD/L;

% Root Mean Square Error calculus
RMSE = sqrt( immse(angleMusic,correctAngle*ones(1,length(angleMusic))) );

% Absolute Error calculus
aboluteError = mean( abs(angleMusic - correctAngle) );

% TODO: Calculo da variancia media
%variancia = var();

end
