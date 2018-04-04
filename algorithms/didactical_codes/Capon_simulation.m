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
doa = [20]/180*pi;           % Angulos
N = 400000;                     % O numero de samples
fs = 200000;                    % Frequencia de amostragem (200kHz)
fc = [1000];            % Frequencia dos sinais  em Hz
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
sig = 2*exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
x = s + noise;    % Adicionado ruido

% Analise de Fourier do sinal modelado
% f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); fft(x(5,:)); ...
%     fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); fft(x(9,:)); fft(x(10,:))];
% 
% nfreq = round(((N*fs)/fa)+1);
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
% Caso utilize dados aquisitados dos microfones como sinal recebido
% Adequacao dos dados aquisitados

x = flipud(x);                  % Invertendo a ordem dos elementos (pois estão invertidos na mesa)
for i=1:10
    x(i,:) = (x(i,:)-mean(x(i,:)));
end

% Parametros conhecidos
fc = 1000;                       % Frequencia do sinal em Hz
fs = 200000;                    % Frequencia de amostragem (200kHz)
P = 1;                          % Numero de fontes de sinais
%N = 400000;                     % Numero de amostras
N = length(x);                  % Numero de amostras

% Analise de Fourier (ja invertendo os elementos)
%f = [fft(x(10,:)); fft(x(9,:)); fft(x(8,:)); fft(x(7,:)); fft(x(6,:)); ...
%    fft(x(5,:)); fft(x(4,:)); fft(x(3,:)); fft(x(2,:)); fft(x(1,:))];

% f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); fft(x(5,:)); ...
%     fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); fft(x(9,:)); fft(x(10,:))];
% 
% % Zerando componente DC
% f(1,1) = 0;
% f(2,1) = 0;
% f(3,1) = 0;
% f(4,1) = 0;
% f(5,1) = 0;
% f(6,1) = 0;
% f(7,1) = 0;
% f(8,1) = 0;
% f(9,1) = 0;
% f(10,1) = 0;
% 
% nfreq = round(((N*fs)/fa)+1);
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
Rx = (x*x')/N;                      % Matriz covariancia dos dados
INVR = inv(Rx);
L = 361; % -pi/2:0.5:pi/2 -> L = 361
phi = zeros(L,1);

for i = 1 : L,
   a = exp(-j*2*pi*fc*d*sin(-pi/2 + pi*(i-1)/L)/u*[0:M-1].');
   phi(i) = 1/real(a'*INVR*a);
end

plot(linspace(-pi/2,pi/2,361)*180/pi,phi)