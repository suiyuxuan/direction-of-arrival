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
fa = 200000;                    % Frequencia de amostragem (200kHz)
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
%[AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
%NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)
[AV,D,V]=svd(Rx);
NN = AV(:,P+1:M); 
C=NN*NN';

% Root-MUSIC
for kk=1:2*M-1,
    a(kk,1)=sum(diag(C,kk-M));
end
ra=roots(a);

% Determinando a P raizes do polinomio que sao mais proximas e dentro do
% circulo unitario
[dum,ind]=sort(abs(ra));
rb=ra(ind(1:M-1));

% P raizes mais proximas do circulo unitario
[dumm,I]=sort(abs(abs(rb)-1));
w=angle(rb(I(1:P)));

% doa
dwn = d/(u/fc);
doa = asin(w/dwn/pi/2)*180/pi