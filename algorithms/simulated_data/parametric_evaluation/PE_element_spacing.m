% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Parametric Evaluation - Element Spacing
% Descricao: Avalia o desempenho do MUSIC em dados simulados variando a
% janela de snapshot

% data: sinal de entrada (sinal simulado)
% d: vetor de distancia entre os microfones
% correctAngle: angulo conhecido na simulacao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 6;
angles = [20];
d = [0.02 0.08 0.16];

elementNo = 10;                 % Quantidade de microfones
fc = 1000;                      % Frequência da portadora
P = 1;                          % Numero de fontes
N = 200;                      % O numero de samples
snapshot = 200;                % Tamanho da janela do snapshot
snr = 0;                       % SNR
u = 340;                        % Velocidade de propagacao da onda
nIter = 1:100;                  % Numero de iteracoes de simulacao

% Parametros do sinal
doa = angles/180*pi;            % Angulos
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [(2*pi*fc)/fs]';           % Frequencia normalizada dos sinais (1kHz)
P = length(doa);                % Numero de fontes de sinais

% preallocate array
RMSE = zeros(1,length(snr));
aboluteError = zeros(1,length(snr));
PD = zeros(1,length(snr));

data.fc = fc;
data.P = P;
data.snapshot = snapshot;

n = 1;
for dValue = d
    results = zeros(length(nIter),3);
    for iter = nIter

        % steering vector
        A = zeros(P,elementNo);         % Matriz com P linhas e M colunas
        for k = 1:P
            A(k,:) = exp(-j*2*pi*fc*dValue*sin(doa(k))/u*[0:elementNo-1]);
        end
        A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

        % Representacao do sinal recebido
        sig = exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
        s = A*sig;                      % Sinal multiplicado pelos atrasos
        signalPower = (1/N)*s(1,:)*s(1,:)';
        signalPower_dB = 10*log10(signalPower);

        noisePower_dB = signalPower_dB - snr;   % Ruido
        noisePower = 10^(noisePower_dB/10);
        noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
        x = s + noise;                          % Adicionando ruido

        data.x = x;
        data.d = dValue;

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
plot(d, RMSE)
title('Parametric Evaluation - Element Spacing')
xlabel('Element Spacing')
ylabel('RMSE')
grid on

figure (2)
plot(d, aboluteError)
title('Parametric Evaluation - Element Spacing')
xlabel('Element Spacing')
ylabel('absolute error')
grid on

figure (3)
plot(d, PD)
title('Parametric Evaluation - Element Spacing')
xlabel('Element Spacing')
ylabel('PD')
grid on