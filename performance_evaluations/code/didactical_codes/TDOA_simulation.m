clc
clear
close all

M = 10;                         % Numero de elementos no arranjo
%lambda = 150;                  % Comprimento de onda
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
%d = lambda/2;

% Parametros
doa = [20]/180*pi;           % Angulos
N = 1000;                     % O numero de samples
Nt = 10*N;
fs = 200000;                    % Frequencia de amostragem
wn = [pi/100]';                 % Frequencia normalizada dos sinais
fc = (fs*wn)/(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                 % Numero de fontes de sinais
snr = 20;                        % Relacao sinal ruido

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

tau = (d*sin(doa)/u);
delay = round(tau*fs);

s = cos(wn*[1:Nt]);

% Representacao do sinal recebido
%sig = exp(1i*(wn*[1:N]));       % Sinal simulado amostrado 1:N
%s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
%noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
noise = sqrt(noisePower) * randn(1,Nt);
%x = s + noise;    % Adicionado ruido
%x = s;

for k = 0:M-1
    x(k+1,:) = s(1,(1+k*delay):(N+k*delay)) + noise(1,(1+k*delay):(N+k*delay));
%    x(k+1,:) = s(1,(1+k*delay):(N+k*delay)) + noise(1,1:N);
end

