% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Real Scenario - Distance and Angles Evaluation
% Descricao: Avalia o desempenho do MUSIC em dados reais variando a
% distancia da fonte e angulos conhecidos

% distances: vetor de distancias da fonte a serem avaliados
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
angles = 0:5:60;
distances = 1:5;
elementNo = 10;
fc = 1000;
d = 0.08;
P = 1;
snapshot = 400;
algorithm = 'MUSIC';

% preallocate array
RMSE = zeros(length(distances),length(angles));
aboluteError = zeros(length(distances),length(angles));
PD = zeros(length(distances),length(angles));

for i=distances % source distance
    for k=angles % angles
        nk = (k/5)+1; % Transformacao de angulo em indice para vetor
        data = load([num2str(elementNo) 'mic_200ksps_sin1k_' num2str(i) 'm_fixed_NS_0oto60o\' num2str(k) '.mat']);
        
        % Adequacao dos dados aquisitados
        x = data.x;
        x = flipud(x);
        for n=1:10
            x(n,:) = (x(n,:)-mean(x(n,:)));
        end
        data.x = x;
        
        data.d = d;
        data.fc = fc;
        data.P = P;
        data.snapshot = snapshot;
        
        correctAngle = 90-k;
        [RMSE(i,nk), aboluteError(i,nk), PD(i,nk)] = evaluation(data, algorithm, correctAngle, delta);
    end
end

figure (1)
surf(angles, distances, RMSE)
title('Real Scenario - Distance and Angles Evaluation')
xlabel('angles')
ylabel('distance source')
zlabel('RMSE')
colormap('gray')

figure (2)
surf(angles, distances, aboluteError)
title('Real Scenario - Distance and Angles Evaluation')
xlabel('angles')
ylabel('distance source')
zlabel('absolute error')
colormap('gray')

figure (3)
stem3(angles, distances, PD)
title('Real Scenario - Distance and Angles Evaluation')
xlabel('angles')
ylabel('distance source')
zlabel('PD')
colormap('gray')
