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
n_iter = 100;
M = 2;
d = 0.05;
angle = 20;
u = 340;
fs = 40000;
N = 353; % N = 278;

%load gong;
%delay = 25;
R = 25;
tau = (d*sin(angle/180*pi)/u);
delay = round(tau*fs);
sig_tmp = zeros(1,N);
for i=1:N
    sig_tmp(i) = exp(-1i*pi*R*(i-1)*(i)/N); % sig_tmp(i) = real(exp(-1i*pi*R*(i-1)*(i)/N));
end
s = zeros(M,N);
for n = 1:M
    s(n,:) = [zeros(1,delay*(n-1)) sig_tmp(1:end-(n-1)*delay)];
end
%sig = delayseq(refsig,delay);
tau_est = gccphat(s(2,:)', s(1,:)');
%s = [refsig'; sig'];

%tau = zeros(1, length(snr_min:snr_step:snr_max));
k = 0;
tau_awgn = zeros(1,n_iter);
x = zeros(M,N);
error_awgn = zeros(1,length(snr_min:snr_step:snr_max));

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
        tau_awgn(iter) = gccphat(x(2,:)',x(1,:)');
    end
    %error(k) = immse(tau_awgn, delay*ones(1,n_iter));
    error_awgn(k) = sqrt( sum( (tau_awgn-delay).^2 )/n_iter );
end

k = 0;
tau_as = zeros(1,n_iter);
tau_as_nlt = zeros(1,n_iter);
tau_as_mod = zeros(1,n_iter);
tau_as_ts = zeros(1,n_iter);
tau_as_erf = zeros(1,n_iter);
tau_as_gud = zeros(1,n_iter);
tau_as_ps = zeros(1,n_iter);
error_as = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_nlt = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_mod = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_ts = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_erf = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_gud = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));
error_as_ps = zeros(1,length(gsnr_min:gsnr_step:gsnr_max));

for gsnr_i = gsnr_min:gsnr_step:gsnr_max
    k = k + 1;
    for iter = 1:n_iter
        x_as = sas_model(s, "complex", alpha, gsnr_i);
        x_as_nlt = alpha_stable_sigmoid(s, alpha, gsnr_i, 4, -1);
%         x_as_mod = alpha_stable_sigmoid(s, alpha, gsnr_i, 1, -1);
%         x_as_ts = alpha_stable_sigmoid(s, alpha, gsnr_i, 3, -1);
%         x_as_erf = alpha_stable_sigmoid(s, alpha, gsnr_i, 5, -1);
%         x_as_gud = alpha_stable_sigmoid(s, alpha, gsnr_i, 7, -1);
%         x_as_ps = alpha_stable_sigmoid(s, alpha, gsnr_i, 10, -1);
        tau_as(iter) = gccphat(x_as(2,:)',x_as(1,:)');
        tau_as_nlt(iter) = gccphat(x_as_nlt(2,:)',x_as_nlt(1,:)');
%         tau_as_mod(iter) = gccphat(x_as_mod(2,:)',x_as_mod(1,:)');
%         tau_as_ts(iter) = gccphat(x_as_ts(2,:)',x_as_ts(1,:)');
%         tau_as_erf(iter) = gccphat(x_as_erf(2,:)',x_as_erf(1,:)');
%         tau_as_gud(iter) = gccphat(x_as_gud(2,:)',x_as_gud(1,:)');
%         tau_as_ps(iter) = gccphat(x_as_ps(2,:)',x_as_ps(1,:)');
        tdoa_as(iter) = tau_as(iter) / fs;
        theta_as(iter) = asin(tdoa_as(iter) / (d/u)) * (180/pi);
        tdoa_as_nlt(iter) = tau_as_nlt(iter) / fs;
        theta_as_nlt(iter) = asin(tdoa_as_nlt(iter) / (d/u)) * (180/pi);
    end
    error_as(k) = sqrt( sum( (theta_as - angle).^2 )/n_iter );
    error_as_nlt(k) = sqrt( sum( (theta_as_nlt - angle).^2 )/n_iter );
%     error_as(k) = sqrt( sum( (tau_as-delay).^2 )/n_iter );
%     error_as_nlt(k) = sqrt( sum( (tau_as_nlt-delay).^2 )/n_iter );
%     error_as_mod(k) = sqrt( sum( (tau_as_mod-delay).^2 )/n_iter );
%     error_as_ts(k) = sqrt( sum( (tau_as_ts-delay).^2 )/n_iter );
%     error_as_erf(k) = sqrt( sum( (tau_as_erf-delay).^2 )/n_iter );
%     error_as_gud(k) = sqrt( sum( (tau_as_gud-delay).^2 )/n_iter );
%     error_as_ps(k) = sqrt( sum( (tau_as_ps-delay).^2 )/n_iter );
end

%plot(snr_min:snr_step:snr_max,error_awgn,'k-')
hold on
plot(gsnr_min:gsnr_step:gsnr_max,error_as,'k-x')
plot(gsnr_min:gsnr_step:gsnr_max,error_as_nlt,'k-o')
%plot(gsnr_min:gsnr_step:gsnr_max,error_as_mod,'k--+')
%plot(gsnr_min:gsnr_step:gsnr_max,error_as_ts,'k-.')
%plot(gsnr_min:gsnr_step:gsnr_max,error_as_erf,'k-d')
%plot(gsnr_min:gsnr_step:gsnr_max,error_as_gud,'k--^')
%plot(gsnr_min:gsnr_step:gsnr_max,error_as_ps,'k--^')

grid on
legend('AWGN', 'alpha-stable', 'tanh transform', 'modulus transform', 'tansig', 'erf', 'Gudermannian', 'parameterized sigmoid')
