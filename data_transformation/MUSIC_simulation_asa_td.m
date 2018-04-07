% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Distortion Evaluation - G-SNR
% Descricao: Avalia o desempenho do MUSIC em dados simulados variando a
% G-SNR

% data: sinal de entrada (sinal simulado)
% snr: vetor de valores de SNR a serem analisados
% correctAngle: angulo conhecido na simulacao
% delta: desvio de angulo aceito para medicao de performance

clear
clc
close all

delta = 3;
angles = [20];
alpha = 1.7;                    % SaS (ex.: 1.5->muito impulsivo, 1.7->medio, 1.9->pouco)
gsnr = -40:5:60;

elementNo = 10;                 % Quantidade de microfones
fc = 1000;                      % Frequência da portadora
d = 0.08;                       % Distancia entre os sensores
N = 4000;                       % O numero de samples
snapshot = 400;                 % Tamanho da janela do snapshot
u = 340;                        % Velocidade de propagacao da onda
nIter = 1:10000;                % Numero de iteracoes de simulacao

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
s = A*sig;                      % Sinal multiplicado pelos atrasos
%signalPower = (1/N)*s(1,:)*s(1,:)';
%signalPower_dB = 10*log10(signalPower);
%noisePower_dB = signalPower_dB - snr;   % Ruido
%noisePower = 10^(noisePower_dB/10);
%noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
%x = s + noise;    % Adicionado ruido
x = s;

% preallocate array
RMSE = zeros(1,length(gsnr));
aboluteError = zeros(1,length(gsnr));
PD = zeros(1,length(gsnr));

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

RMSE_DT = zeros(1,length(gsnr));
aboluteError_DT = zeros(1,length(gsnr));
PD_DT = zeros(1,length(gsnr));

n = 1;
for gsnrValue = gsnr
    results = zeros(length(nIter),3);
    for iter = nIter
        for i=1:10
            y(i,:) = sas_complexo(x(i,:),alpha,gsnrValue);
        end
        
        for i=1:10
            z(i,:) = imt(y(i,:));
        end 

        data.x = z;
        data.d = d;
        data.fc = fc;
        data.P = P;
        data.snapshot = snapshot;

        correctAngle = angles;
        [RMSE_tmp, aboluteError_tmp, PD_tmp] = MUSIC_eval(data, correctAngle, delta);
        results(iter,:) = [RMSE_tmp; aboluteError_tmp; PD_tmp];
    end
    RMSE_DT(n) = mean(results(:,1));
    aboluteError_DT(n) = mean(results(:,2));
    PD_DT(n) = mean(results(:,3));
    
    n = n+1;
end

figure (1)
plot(gsnr, RMSE)
hold on
plot(gsnr, RMSE_DT, '-.*')
title('Parametric Evaluation - GSNR')
xlabel('GSNR')
ylabel('RMSE')
legend('MUSIC','MUSIC with Data Transformation')
grid on

figure (2)
plot(gsnr, aboluteError)
hold on
plot(gsnr, aboluteError_DT, '-.*')
title('Parametric Evaluation - GSNR')
xlabel('GSNR')
ylabel('absolute error')
legend('MUSIC','MUSIC with Data Transformation')
grid on

figure (3)
plot(gsnr, PD)
hold on
plot(gsnr, PD_DT, '-.*')
title('Parametric Evaluation - GSNR')
xlabel('GSNR')
ylabel('PD')
legend('MUSIC','MUSIC with Data Transformation')
grid on