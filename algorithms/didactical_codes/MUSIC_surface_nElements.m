clc
clear all
close all

%%
% Definicao de parametros iniciais

Pmusic = [];
PmusicMatrix = [];

M_min = 2;
M_step = 1;
M_max = 20;

for M = M_min:M_step:M_max

%lambda = 150;                  % Comprimento de onda
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
%d = lambda/2;

%%
% Caso utilize sinal modelado/criado no Matlab
% Modelagem do sinal recebido

% Parametros
doa = [20]/180*pi;           % Angulos
N = 400000;                     % O numero de samples
fs = 200000;                    % Frequencia de amostragem (200kHz)
fc = [1000];                    % Frequencia dos sinais  em Hz
wn = [((2*pi*fc)/fs)]';         % Frequencia normalizada dos sinais (1kHz)
P = length(doa);                 % Numero de fontes de sinais
snr = 20;                        % Relacao sinal ruido

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fc*d*sin(doa(k))/u*[0:M-1]);
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
x = s + noise;    % Adicionado ruido

%%
% Encontrando o angulo

% Calculo dos autovalores e autovetores
Rx = x*x';                      % Matriz covariancia dos dados
[AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

% MUSIC
theta = -90:0.5:90;

for ii = 1:length(theta)
    SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
        for jj = 0:M-1
            SS(1+jj) = exp(-(j*2*jj*pi*fc*d*sin(theta(ii)/180*pi))/u);
        end
    PP = SS*NN*NN'*SS';
    Pmusic(ii) = abs(1/PP);
end

Pmusic = 10*log10(Pmusic/max(Pmusic)); % Determinando pico
PmusicMatrix = [PmusicMatrix; Pmusic];

end

% Plots
surf(theta, M_min:M_step:M_max, PmusicMatrix)
xlabel('theta')
ylabel('numbers elements')
zlabel('Pmusic')
