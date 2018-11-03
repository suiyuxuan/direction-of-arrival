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
gsnr_min = -40;
gsnr_step = 1;
gsnr_max = 20;

alpha = 1.7;
n_iter = 1000;
M = 2;

load gong;
refsig = y;
N = length(y);
delay = 25;
sig = delayseq(refsig,delay);
tau_est = gccphat(sig,refsig);

s = [refsig'; sig'];

%tau = zeros(1, length(snr_min:snr_step:snr_max));
k = 0;
for snr_i = snr_min:snr_step:snr_max

    k = k + 1;
    %tau_tmp = zeros(1,n_iter);
    for iter = 1:n_iter
        for n_source = 1:M
            signalPower = (1/N)*s(n_source,:)*s(n_source,:)';
            signalPower_dB = 10*log10(signalPower);
            noisePower_dB = signalPower_dB - snr_i;   % Ruido
            noisePower = 10^(noisePower_dB/10);
            %noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
            noise = sqrt(noisePower) * randn(size(s(n_source,:)));
            x(n_source,:) = s(n_source,:) + noise;    % Adicionado ruido
        end
    
        tau_tmp(iter) = gccphat(x(2,:)',x(1,:)');
        %tau(k) = mean(tau_tmp);
    end
    error(k) = immse(tau_tmp, delay*ones(1,n_iter));
end

k = 0;
for gsnr_i = gsnr_min:gsnr_step:gsnr_max

    k = k + 1;
    %tau_tmp = zeros(1,n_iter);
    for iter = 1:n_iter
        for n_source = 1:M
            x(n_source,:) = sas_real_model(s(n_source,:), alpha, gsnr_i);
            %x(n_source,:) = s(n_source,:) + noise;    % Adicionado ruido
        end
    
        tau_tmp(iter) = gccphat(x(2,:)',x(1,:)');
        %tau(k) = mean(tau_tmp);
    end
    error_as(k) = immse(tau_tmp, delay*ones(1,n_iter)); 
end

k = 0;
for gsnr_i = gsnr_min:gsnr_step:gsnr_max

    k = k + 1;
    %tau_tmp = zeros(1,n_iter);
    for iter = 1:n_iter
        for n_source = 1:M
            x(n_source,:) = alpha_stable_sigmoid(s(n_source,:), alpha, gsnr_i, 4, -1);
            %x(n_source,:) = s(n_source,:) + noise;    % Adicionado ruido
        end
    
        tau_tmp(iter) = gccphat(x(2,:)',x(1,:)');
        %tau(k) = mean(tau_tmp);
    end
    error_as_nlt(k) = immse(tau_tmp, delay*ones(1,n_iter)); 
end

plot(snr_min:snr_step:snr_max,abs(error))
hold on
plot(gsnr_min:gsnr_step:gsnr_max,abs(error_as),'r')
plot(gsnr_min:gsnr_step:gsnr_max,abs(error_as_nlt),'k')