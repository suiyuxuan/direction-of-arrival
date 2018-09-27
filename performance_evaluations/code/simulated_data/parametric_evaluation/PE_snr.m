% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: Parametric Evaluation - SNR
% Author: Danilo Pena
% Description: Evaluation of the performance of the MUSIC on simulated data varying SNR

% data: input signal (simulate signal)
% snr: SNR vector to be analyzed
% correctAngle: the known angle of the simulation
% delta: deviation of angle accepted for performance measures

clear
clc
close all

delta = 6;
angles = [20];
snr = -40:1:40;
algorithm = 'MUSIC';

elementNo = 10;                 % Quantidade de microfones
fc = 1000;                      % Frequência da portadora
d = 0.08;                       % Distancia entre os sensores
N = 200;                       % O numero de samples
snapshot = 200;                % Tamanho da janela do snapshot
u = 340;                        % Velocidade de propagacao da onda
nIter = 1:10000;                  % Numero de iteracoes de simulacao

% Parametros do sinal
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [(2*pi*fc)/fs]';           % Frequencia normalizada dos sinais (1kHz)
P = length(angles);                % Numero de fontes de sinais

% preallocate array
RMSE = zeros(1,length(snr));
aboluteError = zeros(1,length(snr));
PD = zeros(1,length(snr));

data.d = d;
data.fc = fc;
data.P = P;
data.u = u;
data.snapshot = snapshot;

n = 1;
for snrValue = snr
    results = zeros(length(nIter),3);
    for iter = nIter
        %x = s + awgn(s,snr);
        x = signal_generator(angles, N, elementNo, d, u, fc, fs, 'noise', 'gaussian', 'snr', snrValue);

        data.x = x;

        correctAngle = angles;
        [RMSE_tmp, aboluteError_tmp, PD_tmp] = evaluation(data, algorithm, correctAngle, delta);
        results(iter,:) = [RMSE_tmp; aboluteError_tmp; PD_tmp];
    end
    RMSE(n) = mean(results(:,1));
    aboluteError(n) = mean(results(:,2));
    PD(n) = mean(results(:,3));
    
    n = n+1;
end

figure (1);
plot(snr, RMSE);
title('Parametric Evaluation - SNR');
xlabel('SNR');
ylabel('RMSE');
grid on;
print('results/RMSE','-depsc');

figure (2);
plot(snr, aboluteError);
title('Parametric Evaluation - SNR');
xlabel('SNR');
ylabel('absolute error');
grid on;
print('results/AE','-depsc');

figure (3);
plot(snr, PD);
title('Parametric Evaluation - SNR');
xlabel('SNR');
ylabel('PD');
grid on;
print('results/PD','-depsc');

