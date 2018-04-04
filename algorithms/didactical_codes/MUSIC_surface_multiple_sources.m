clc
clear all
close all

%%
% Definicao de parametros iniciais

M = 10;                         % Numero de elementos no arranjo
%lambda = 150;                  % Comprimento de onda
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
%d = lambda/2;

%%
% Caso utilize sinal modelado/criado no Matlab
% Modelagem do sinal recebido

% Parametros
doa = [20 60]/180*pi;           % Angulos
N = 400000;                     % O numero de samples
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [pi/100 pi/50]';                 % Frequencia normalizada dos sinais (1kHz)
fs = (fs*wn)./(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                 % Numero de fontes de sinais
%snr = 0;                        % Relacao sinal ruido

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fs(k)*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snrValue;   % Ruido
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
x = s + noise;                          % Adicionando ruido

% Analise de Fourier do sinal modelado
% f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); fft(x(5,:)); ...
%     fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); fft(x(9,:)); fft(x(10,:))];
% 
% ph(1) = angle(f(1,nfreq));
% ph(2) = angle(f(2,nfreq));
% ph(3) = angle(f(3,nfreq));
% ph(4) = angle(f(4,nfreq));
% ph(5) = angle(f(5,nfreq));
% ph(6) = angle(f(6,nfreq));
% ph(7) = angle(f(7,nfreq));
% ph(8) = angle(f(8,nfreq));
% ph(9) = angle(f(9,nfreq));
% ph(10) = angle(f(10,nfreq));

%%
% Encontrando o angulo

% Calculo dos autovalores e autovetores
Rx = x*x';                      % Matriz covariancia dos dados
[AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

% MUSIC
theta = -90:0.5:90;

for kk = 1:P
    
for ii = 1:length(theta)
    SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
        for jj = 0:M-1
            SS(1+jj) = exp(-(j*2*jj*pi*fs(kk)*d*sin(theta(ii)/180*pi))/u);
        end
    PP = SS*NN*NN'*SS';
    Pmusic(ii) = abs(1/PP);
end

Pmusic = 10*log10(Pmusic/max(Pmusic)); % Determinando pico

% Plots
plot(theta,Pmusic,'-k')
xlabel('Angulo \theta')
ylabel('Funcao Espectro P(\theta) /dB')
title('MUSIC')
grid on

hold on

end