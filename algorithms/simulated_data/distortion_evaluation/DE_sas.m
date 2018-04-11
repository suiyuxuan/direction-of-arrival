% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Parametric Evaluation - Impulsive Noise
% Descricao: Avalia o desempenho do MUSIC em dados simulados variando a
% G-SNR para ruido impusilvo modelado por SaS

% data: sinal de entrada (sinal simulado)
% snr: vetor de valores de SNR a serem analisados
% correctAngle: angulo conhecido na simulacao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 6;
angles = [20];
alpha = 1.5;                    % SaS (ex.: 1.5->muito impulsivo, 1.7->medio, 1.9->pouco)
gsnr = -40:10:60;

elementNo = 10;                 % Quantidade de microfones
fc = 1000;                      % Frequência da portadora
d = 0.08;                       % Distancia entre os sensores
N = 200;                       % O numero de samples
snapshot = 200;                % Tamanho da janela do snapshot
u = 340;                        % Velocidade de propagacao da onda
nIter = 1:1000;                  % Numero de iteracoes de simulacao

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
sig = exp(1i*(wn*[1:N]));       % Sinal simulado amostrado 1:N
x = A*sig;                      % Sinal multiplicado pelos atrasos

% preallocate array
RMSE = zeros(1,length(gsnr));
aboluteError = zeros(1,length(gsnr));
PD = zeros(1,length(gsnr));
y = zeros(size(x));

n = 1;
for gsnrValue = gsnr
    results = zeros(length(nIter),3);
    for iter = nIter
        for i=1:10
            y(i,:) = sas_complexo(x(i,:),alpha,gsnrValue);
        end

        data.x = y;
        data.d = d;
        data.fc = fc;
        data.P = P;
        data.snapshot = snapshot;

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
plot(gsnr, RMSE)
title('Parametric Evaluation - G-SNR')
xlabel('G-SNR')
ylabel('RMSE')
grid on

figure (2)
plot(gsnr, aboluteError)
title('Parametric Evaluation - G-SNR')
xlabel('G-SNR')
ylabel('absolute error')
grid on

figure (3)
plot(gsnr, PD)
title('Parametric Evaluation - G-SNR')
xlabel('G-SNR')
ylabel('PD')
grid on