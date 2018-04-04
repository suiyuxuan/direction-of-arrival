% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Real Scenario - Distance and Angles Evaluation
% Descricao: Avalia o desempenho do MUSIC em sinais sinteticos ou reais

% data: sinal de entrada (sinal de cenario real)
% correctAngle: angulo conhecido na medicao
% delta: desvio de angulo aceito para medicao de performance

function [RMSE, aboluteError, PD] = MUSIC_eval(data, correctAngle, delta)

x = data.x;
d = data.d; % Distancia entre os sensores
fc = data.fc; % Frequencia da portadora
P = data.P; % Numero de fontes
snapshot = data.snapshot; % Largura da janela de snapshot
[M,N] = size(x); % Numero de sensores e numero de amostras respectivamente
L = floor(N/snapshot); % Numero de snapshots

angleMusic = MUSIC_data(data, P, fc, d, snapshot);

% Calculo de PD
PD = sum((abs(angleMusic-correctAngle))<delta);
PD = PD/L;

% Calculo do RMSE medio
RMSE = mean( sqrt( immse(angleMusic,correctAngle*ones(1,length(angleMusic))) ) );

% Calculo do erro medio absoluto
aboluteError = mean( abs(angleMusic - correctAngle) );

% TODO: Calculo da variancia media
%variancia = mean( );

end