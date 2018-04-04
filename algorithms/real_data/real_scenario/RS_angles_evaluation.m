% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Real Scenario - Angles Evaluation
% Descricao: Avalia o desempenho do MUSIC em dados reais variando os
% angulos conhecidos

% angles: vetor de angulos
% elementNo: quantidade de microfones
% fc: frequência da portadora
% d: distancia entre os sensores
% P: numero de fontes
% snapshot: tamanho da janela do snapshot

% data: sinal de entrada (sinal de cenario real)
% correctAngle: angulo conhecido na medicao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 6;
distances = 1:5;
angles = 0:5:60;
elementNo = 10;
fc = 1000;
d = 0.08;
P = 1;
snapshot = 1000;

% preallocate array
RMSE = zeros(1,length(angles));
aboluteError = zeros(1,length(angles));
PD = zeros(1,length(angles));
RMSE_tmp = zeros(length(distances),length(angles));
aboluteError_tmp = zeros(length(distances),length(angles));
PD_tmp = zeros(length(distances),length(angles));

for k=angles % angles
    nk = (k/5)+1; % Transformacao de angulo em indice para vetor
    for i=distances % source distance
        data = load([num2str(elementNo) 'mic_200ksps_sin1k_' num2str(i) 'm_fixed_0oto60o\' num2str(k) '.mat']);
        
        % Adequacao dos dados aquisitados
        x = data.x;
        x = flipud(x);                  % Invertendo a ordem dos elementos (pois estão invertidos na mesa)
        for n=1:10
            x(n,:) = (x(n,:)-mean(x(n,:))); % Removendo nivel DC
        end
        data.x = x;
        
        data.d = d;
        data.fc = fc;
        data.P = P;
        data.snapshot = snapshot;
        
        correctAngle = 90-k;
        [RMSE_tmp(i,nk), aboluteError_tmp(i,nk), PD_tmp(i,nk)] = MUSIC_eval(data, correctAngle, delta);
    end
    RMSE(nk) = mean(RMSE_tmp(:,nk));
    aboluteError(nk) = mean(aboluteError_tmp(:,nk));
    PD(nk) = mean(PD_tmp(:,nk));
end

figure (1)
plot(angles, RMSE)
title('Real Scenario - Angles Evaluation')
xlabel('angles')
ylabel('RMSE')

figure (2)
plot(angles, aboluteError)
title('Real Scenario - Angles Evaluation')
xlabel('angles')
ylabel('absolute error')

figure (3)
plot(angles, PD)
title('Real Scenario - Angles Evaluation')
xlabel('angles')
ylabel('PD')