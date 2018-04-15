% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Parametric Evaluation - SNR
% Descricao: Avalia o desempenho do MUSIC em dados simulados variando a
% SNR

% data: sinal de entrada (sinal simulado)
% snr: vetor de valores de SNR a serem analisados
% correctAngle: angulo conhecido na simulacao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 6;
angles = [20];
snr = -40:5:40;

elementNo = 10;                 % Quantidade de microfones
fc = 1000;                      % Frequência da portadora
d = 0.08;                       % Distancia entre os sensores
N = 200;                       % O numero de samples
snapshot = 200;                % Tamanho da janela do snapshot
u = 340;                        % Velocidade de propagacao da onda
nIter = 1:100;                  % Numero de iteracoes de simulacao

% Parametros do sinal
doa = angles/180*pi;            % Angulos
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [(2*pi*fc)/fs]';           % Frequencia normalizada dos sinais (1kHz)
P = length(doa);                % Numero de fontes de sinais

% steering vector
A = zeros(P,elementNo);         % Matriz com P linhas e M colunas
for k = 1:P
    A(k,:) = exp(-j*2*pi*fc*d*sin(doa(k))/u*[0:elementNo-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);

% preallocate array
RMSE = zeros(1,length(snr));
aboluteError = zeros(1,length(snr));
PD = zeros(1,length(snr));

data.d = d;
data.fc = fc;
data.P = P;
data.snapshot = snapshot;

n = 1;
for snrValue = snr
    results = zeros(length(nIter),3);
    for iter = nIter
        %x = s + awgn(s,snr);
        noisePower_dB = signalPower_dB - snrValue;
        noisePower = 10^(noisePower_dB/10);
        noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
        x = s + noise;

        data.x = x;

        correctAngle = angles;
        [RMSE_tmp, aboluteError_tmp, PD_tmp] = MUSIC_eval(data, correctAngle, delta);
        results(iter,:) = [RMSE_tmp; aboluteError_tmp; PD_tmp];
    end
    RMSE(n) = mean(results(:,1));
    aboluteError(n) = mean(results(:,2));
    PD(n) = mean(results(:,3));
    
    n = n+1;
end

figure (1)
plot(snr, RMSE)
title('Parametric Evaluation - SNR')
xlabel('SNR')
ylabel('RMSE')
grid on

figure (2)
plot(snr, aboluteError)
title('Parametric Evaluation - SNR')
xlabel('SNR')
ylabel('absolute error')
grid on

figure (3)
plot(snr, PD)
title('Parametric Evaluation - SNR')
xlabel('SNR')
ylabel('PD')
grid on