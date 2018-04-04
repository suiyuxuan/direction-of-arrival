% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Real Scenario - Distance Evaluation
% Descricao: Avalia o desempenho do MUSIC em dados reais variando a
% distancia da fonte

% distances: vetor de distancias da fonte a serem avaliados
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
elementNo = 10;
fc = 1000;
d = 0.08;
P = 1;
snapshot = 1000;
angles = 0:5:60;

% preallocate array
RMSE = zeros(1,length(distances));
aboluteError = zeros(1,length(distances));
PD = zeros(1,length(distances));
RMSE_tmp = zeros(length(distances),length(angles));
aboluteError_tmp = zeros(length(distances),length(angles));
PD_tmp = zeros(length(distances),length(angles));

for i=distances % source distance
    for k=angles % angles
        nk = (k/5)+1; % Transformacao de angulo em indice para vetor
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
    RMSE(i) = mean(RMSE_tmp(i,:));
    aboluteError(i) = mean(aboluteError_tmp(i,:));
    PD(i) = mean(PD_tmp(i,:));
end

figure (1)
plot(distances, RMSE)
title('Real Scenario - Distance Evaluation')
xlabel('distance source')
ylabel('RMSE')

figure (2)
plot(distances, aboluteError)
title('Real Scenario - Distance Evaluation')
xlabel('distance source')
ylabel('absolute error')

figure (3)
plot(distances, PD)
title('Real Scenario - Distance Evaluation')
xlabel('distance source')
ylabel('PD')