% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Real Scenario - Snapshots Evaluation
% Descricao: Avalia o desempenho do MUSIC em dados reais variando o
% tamanho da larguda do snapshot

% distances: vetor de distancias da fonte a serem avaliados
% minAng: angulo inicial a ser avaliado
% maxAng: angulo final a ser avaliado
% elementNo: quantidade de microfones
% fc: frequência da portadora
% d: distancia entre os sensores
% P: numero de fontes
% snapshots: tamanho da janela do snapshot

% data: sinal de entrada (sinal de cenario real)
% correctAngle: angulo conhecido na medicao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 6;
distances = 1:1;
angles = 45;
elementNo = 10;
fc = 1000;
d = 0.08;
P = 1;
snapshots = [200 400];

% preallocate array
RMSE = zeros(1,length(snapshots));
aboluteError = zeros(1,length(snapshots));
PD = zeros(1,length(snapshots));
RMSE_tmp = zeros(1,length(distances)*length(angles));
aboluteError_tmp = zeros(1,length(distances)*length(angles));
PD_tmp = zeros(1,length(distances)*length(angles));

nn = 1;
for nSnapshot=snapshots
    n = 1; % incremental index de metrics
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
            data.snapshot = nSnapshot;

            correctAngle = 90-k;
            [RMSE_tmp(n), aboluteError_tmp(n), PD_tmp(n)] = MUSIC_eval(data, correctAngle, delta);
            n = n+1;
        end
    end
    RMSE(nn) = mean(RMSE_tmp);
    aboluteError(nn) = mean(aboluteError_tmp);
    PD(nn) = mean(PD_tmp);
    nn = nn+1;
end

figure (1)
plot(snapshots, RMSE)
title('Real Scenario - Snapshots Evaluation')
xlabel('snapshots')
ylabel('RMSE')

figure (2)
plot(snapshots, aboluteError)
title('Real Scenario - Snapshots Evaluation')
xlabel('snapshots')
ylabel('absolute error')

figure (3)
plot(snapshots, PD)
title('Real Scenario - Snapshots Evaluation')
xlabel('snapshots')
ylabel('PD')