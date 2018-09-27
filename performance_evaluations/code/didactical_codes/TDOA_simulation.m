clc
clear
close all

M = 2;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos

doa = [20]/180*pi;           % Angulos
%fs = 200000;                    % Frequencia de amostragem
%wn = [pi/100]';                 % Frequencia normalizada dos sinais
%fc = (fs*wn)/(2*pi);            % Frequencia dos sinais  em Hz
%P = length(doa);                 % Numero de fontes de sinais

A = zeros(P,M);                 % Matriz com P linhas e M colunas

tau = (d*sin(doa)/u);
delay = round(tau*fs);

load gong;
refsig = y;
N = length(y);
delay1 = 5;
delay2 = 25;
sig1 = delayseq(refsig,delay1);
sig2 = delayseq(refsig,delay2);
tau_est = gccphat([sig1,sig2],refsig)

s = [refsig'; sig2'];

snr = -10;
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
%noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
noise = sqrt(noisePower) * randn(size(s));
x = s + noise;    % Adicionado ruido
gccphat(x(2,:)',x(1,:)')

for k = 0:M-1
    x(k+1,:) = s(1,(1+k*delay):(N+k*delay)) + noise(1,(1+k*delay):(N+k*delay));
%    x(k+1,:) = s(1,(1+k*delay):(N+k*delay)) + noise(1,1:N);
end



