clc
clear
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
doa = [20]/180*pi;           % Angulos
N = 200;                     % O numero de samples
fs = 200000;                    % Frequencia de amostragem
wn = [pi/100]';                 % Frequencia normalizada dos sinais
fc = (fs*wn)/(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                 % Numero de fontes de sinais
snr = 40;                        % Relacao sinal ruido

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

tau = [1:M]*(2*pi*fc*d*sin(doa)/u);
delays = tau*fs;

for k = 1:M
%    A(k,:) = exp(-1i*2*pi*fc*d*sin(doa(k))/u*[0:M-1]);
    s(k,:) = cos(wn*[1:N]);
end
%s = s';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
%sig = exp(1i*(wn*[1:N]));       % Sinal simulado amostrado 1:N
%s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
%noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
noise = sqrt(noisePower) * randn(size(s));
%x = s + noise;    % Adicionado ruido
x = s;

% Plots
%plot(theta,Pmusic,'-k')
%xlabel('Angulo \theta')
%ylabel('Funcao Espectro P(\theta) /dB')
%title('MUSIC')
%grid on
