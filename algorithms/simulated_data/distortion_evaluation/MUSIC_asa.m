% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Authors: Arthur Diego de Lira Lima / Danilo Pena
% Descricao: MUSIC com canal aditivo alfa-estavel simetrico (SaS)  

% y = x + n
% x: sinal original (sem ruido)
% y: sinal com ruido SaS

% GSNR_dB: qualidade do sinal
% alpha: ajuste de calda da distribuicao, 0<alpha<=2. (sugestao: 1<=alpha<=2)
% alpha=2 => Gaussiana; alpha=1 => Cauchy

clc
clear all
close all

%%
% Definicao de parametros iniciais

M = 10;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
alpha = 1.5;                    % SaS (ex.: 1.5->muito impulsivo, 1.7->medio, 1.9->pouco)
gsnr_min = -40;                 % Varredura de gsnr
gsnr_step = 10;
gsnr_max = 60;

%%
% Modelagem do sinal recebido

% Parametros
angulo = 20;                    % Angulo de direcao em graus
doa = [angulo]/180*pi;          % Angulos
N = 400000;                     % O numero de samples
fa = 200000;                    % Frequencia de amostragem (200kHz)
wn = [pi/100]';                 % Frequencia normalizada dos sinais (1kHz)
fs = (fa*wn)/(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                % Numero de fontes de sinais

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fs*d*sin(doa(k))/u*[0:M-1]);
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

%%
% Encontrando o angulo
Pmusic = [];
PmusicMatrix = [];

for gsrn = gsnr_min:gsnr_step:gsnr_max

    for i=1:10
        y(i,:) = sas_complexo(x(i,:),alpha,gsrn);
    end

    % Calculo dos autovalores e autovetores
    Rx = y*y';                      % Matriz covariancia dos dados
    [AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
    NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

    % MUSIC
    theta = -90:0.5:90;

    for ii = 1:length(theta)
        SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
            for jj = 0:M-1
                SS(1+jj) = exp(-(j*2*jj*pi*fs*d*sin(theta(ii)/180*pi))/u);
            end
        PP = SS*NN*NN'*SS';
        Pmusic(ii) = abs(1/PP);
    end

    Pmusic = 10*log10(Pmusic/max(Pmusic)); % Determinando pico
    PmusicMatrix = [PmusicMatrix; Pmusic];

end

% Plots
my_surface = surf(theta, gsnr_min:gsnr_step:gsnr_max, PmusicMatrix);
view(145,30);
title('MUSIC with impulsive noise (SaS)');
xlabel('\theta');
ylabel('GSNR');
zlabel('p(\theta)');
print('results/my_surface','-depsc');
