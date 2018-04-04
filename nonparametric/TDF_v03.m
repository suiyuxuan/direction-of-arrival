clc
clear all
close all

%%              --- Transformada Discreta de Fourier ---

%% --- Definicao de parametros iniciais ---

M = 10;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
N = 6000;                       % O numero de samples

%% --- Sinal Simulado ---

% Parametros
doa = [20]/180*pi;              % Angulos
fa = 3000;                      % Frequencia de amostragem (200kHz)
wn = [pi/100]';                 % Frequencia normalizada dos sinais (1kHz)
fs = (fa*wn)/(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                % Numero de fontes de sinais

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fs*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                          % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = 2*exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
x = A*sig;                       % Sinal multiplicado pelos atrasos

%% --- Transformada Discreta de Fourier (Sinal Simulado) ---

for k=1:N
    mag(k)=0;
  for n=1:N
      mag(k) = mag(k) + x(1,n)*exp(-j*k*(2*pi*n/N));
  end
  mag(k) = mag(k)/N;
end 

% ---- Plot do gráfico --- %
l = 1:N; % Tamanho do vetor X.

mag(N) = 0;  % Zerar nível DC

PSD = abs(mag);

plot(l,PSD) % Plot da tranformada discreta de fourier

%% --- Transformada Discreta de Fourier (Sinal Real) ---

x = x(1,:);

for k=1:N
    mag(k)=0;
  for n=1:N
      mag(k) = mag(k) + x(1,n)*exp(-j*k*(2*pi*n/N));
  end
  mag(k) = mag(k)/N;
end 

% ---- Plot do gráfico --- %
l = 1:N; % Tamanho do vetor X.

mag(N) = 0;  % Zerar nível DC

PSD = abs(mag);

plot(l,PSD) % Plot da tranformada discreta de fourier
