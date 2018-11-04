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
snr_max = 40;
gsnr_min = -40;
gsnr_step = 1;
gsnr_max = 40;

alpha = 1.7;
n_iter = 1000;
M = 2;
d = 0.08;
angle = 20;
u = 340;
fs = 40000;
N = 278;

%load gong;
%delay = 25;
R = 25;
tau = (d*sin(angle/180*pi)/u);
delay = round(tau*fs);
sig_tmp = zeros(1,N);
for i=1:N
    sig_tmp(i) = real(exp(-1i*pi*R*(i-1)*(i)/N));
end
for n = 1:M
    s(n,:) = [zeros(1,delay*(n-1)) sig_tmp(1:end-(n-1)*delay)];
end
%sig = delayseq(refsig,delay);
tau_est = gccphat(s(2,:)', s(1,:)');
%s = [refsig'; sig'];

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

    end
    error(k) = immse(tau_tmp, delay*ones(1,n_iter));
end

k = 0;
for gsnr_i = gsnr_min:gsnr_step:gsnr_max
    k = k + 1;
    for iter = 1:n_iter
        x = sas_real_model(s, alpha, gsnr_i);
        x_as_nlt = alpha_stable_sigmoid(s, alpha, gsnr_i, 4, -1);
        x_as_mod = alpha_stable_sigmoid(s, alpha, gsnr_i, 1, -1);
        tau_tmp(iter) = gccphat(x(2,:)',x(1,:)');
        tau_as_nlt(iter) = gccphat(x_as_nlt(2,:)',x_as_nlt(1,:)');
        tau_as_mod(iter) = gccphat(x_as_mod(2,:)',x_as_mod(1,:)');
    end
    error_as(k) = immse(tau_tmp, delay*ones(1,n_iter));
    error_as_nlt(k) = immse(tau_as_nlt, delay*ones(1,n_iter));
    error_as_mod(k) = immse(tau_tmp, delay*ones(1,n_iter));
end

plot(snr_min:snr_step:snr_max,sqrt(abs(error)),'b')
hold on
plot(gsnr_min:gsnr_step:gsnr_max,sqrt(abs(error_as)),'r')
plot(gsnr_min:gsnr_step:gsnr_max,sqrt(abs(error_as_nlt)),'k')
plot(gsnr_min:gsnr_step:gsnr_max,sqrt(abs(error_as_mod)),'g')

legend('AWGN', 'alpha-stable', 'tanh transform', 'modulus transform')
