clc
clear
close all

%M = 2;                         % Numero de elementos no arranjo
%u = 340;                        % Velocidade de propagacao
%d = 0.04;                       % Distancia entre os elementos
%doa = [20]/180*pi;           % Angulos
%fs = 44000;                    % Frequencia de amostragem
%tau = (d*sin(doa)/u);
%delay = round(tau*fs);

snr_min = -40;
snr_step = 1;
snr_max = 20;

n_iter = 10;

load gong;
refsig = y;
N = length(y);
delay = 25;
sig = delayseq(refsig,delay);
tau_est = gccphat(sig,refsig);

s = [refsig'; sig'];

%tau = zeros(1, length(snr_min:snr_step:snr_max));
k = 0;
for snr = snr_min:snr_step:snr_max

    k = k + 1;
    tau_tmp = zeros(1,n_iter);
    for iter = 1:n_iter
        signalPower = (1/N)*s(1,:)*s(1,:)';
        signalPower_dB = 10*log10(signalPower);
        noisePower_dB = signalPower_dB - snr;   % Ruido
        noisePower = 10^(noisePower_dB/10);
        %noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
        noise = sqrt(noisePower) * randn(size(s));
        x = s + noise;    % Adicionado ruido
    
        tau_tmp(iter) = gccphat(x(2,:)',x(1,:)');
    end
    tau(k) = mean(tau_tmp);

end