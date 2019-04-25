% Federal University of Rio Grande do Norte
% Title: TDOA evaluation with measured data
% Author: Danilo Pena
% Description: TDOA methods evaluation using measured data (source and speech signals)

% clear
% close all

%% Load data

% 1 kHz source
%load('../../../data/respeaker/indoor/source/data.mat');
%load('../../../data/respeaker/hall/source/data.mat');
%load('../../../data/respeaker/outdoor/source/data.mat');
% Speech signal source
%load('../../../data/respeaker/indoor/speech/data.mat');
%load('../../../data/respeaker/hall/speech/data.mat');
%load('../../../data/respeaker/outdoor/speech/data.mat');

% TDOA parameters
% d = 0.0575;
% dl = sqrt(2*d^2);
% angles = 20;
% fs = 48000;
% u = 340;
%lag = 1000;

% scenarios
% 55000:lag:127000-lag lag=1000 (outdoor - speech)
% 50/100/700/1000/20000/40000/80000 (outdoor - speech)
% 200/400/500/700/2000/4000 (outdoor - source)

function [rmse_GCC, rmse_NLT, rmse_FLOC] = TDOA_snapshot_function_measured_data(sinal, lag)

d = 0.0575;
dl = sqrt(2*d^2);
angles = 20;
fs = 48000;
u = 340;

k = 1;
for window_current = 1:lag:length(sinal(1,:))-lag

window_sel = window_current:window_current+lag;
    
% Time domain
x(1,:) = (sinal(1,window_sel))';
x(2,:) = (sinal(2,window_sel))';
x(3,:) = (sinal(3,window_sel))';
x(4,:) = (sinal(4,window_sel))';

x(1,:) = x(1,:)/max(abs(x(1,:)));
x(2,:) = x(2,:)/max(abs(x(2,:)));
x(3,:) = x(3,:)/max(abs(x(3,:)));
x(4,:) = x(4,:)/max(abs(x(4,:)));

%% Methods validation

% GCC-PHAT
[M,N] = size(x);
tau_1_GCC(k) = abs(gccphat(x(1,:)',x(2,:)'));
theta_1_GCC(k) = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_GCC(k)*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

tau_2_GCC(k) = abs(gccphat(x(3,:)',x(1,:)'));
%theta_2_GCC(k) = 180 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_2_GCC(k)*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);
theta_2_GCC(k) = acos( ((1.5*fs+tau_2_GCC(k)*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

tau_3_GCC(k) = abs(gccphat(x(4,:)',x(1,:)'));
theta_3_GCC(k) = 135 - acos( (1.5/(2*dl)) + (dl/(2*1.5)) - ((1.5*fs-tau_3_GCC(k)*u)/(fs*sqrt(2*dl*1.5)))^2 )*(180/pi);
%theta_3_GCC(k) = -45 + acos( ((1.5*fs+tau_3_GCC(k)*u)/(fs*sqrt(2*dl*1.5)))^2 - (1.5/(2*dl)) - (dl/(2*1.5)) )*(180/pi);

% GCC-NLT
xt = tanh(x);
[M,N] = size(xt);
tau_1_NLT(k) = abs(gccphat(xt(1,:)',xt(2,:)'));
theta_1_NLT(k) = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_NLT(k)*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

tau_2_NLT(k) = abs(gccphat(xt(3,:)',xt(1,:)'));
%theta_2_NLT(k) = 180 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_2_NLT(k)*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);
theta_2_NLT(k) = acos( ((1.5*fs+tau_2_NLT(k)*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

tau_3_NLT(k) = abs(gccphat(xt(4,:)',xt(1,:)'));
theta_3_NLT(k) = 135 - acos( (1.5/(2*dl)) + (dl/(2*1.5)) - ((1.5*fs-tau_3_NLT(k)*u)/(fs*sqrt(2*dl*1.5)))^2 )*(180/pi);
%theta_3_NLT(k) = -45 + acos( ((1.5*fs+tau_3_NLT(k)*u)/(fs*sqrt(2*dl*1.5)))^2 - (1.5/(2*dl)) - (dl/(2*1.5)) )*(180/pi);

% FLOC
[M,N] = size(x);
xm = [x(2,:) x(2,:)];
R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        NUM = NUM + x(1,n).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m));
    end
    R(m) = NUM / DEN;
end
[argvalue, argmax] = max(abs(R-mean(R)));
tau_1_FLOC(k) = min((N-argmax),argmax);
%theta_1_FLOC(k) = asin((tau_1_FLOC(k)/fs) / (d/u)) * (180/pi);
theta_1_FLOC(k) = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_FLOC(k)*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

[M,N] = size(x);
xm = [x(1,:) x(1,:)];
R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        NUM = NUM + x(3,n).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m));
    end
    R(m) = NUM / DEN;
end
[argvalue, argmax] = max(abs(R-mean(R)));
tau_2_FLOC(k) = argmax;
%theta_2_FLOC(k) = asin((tau_2_FLOC(k)/fs) / (d/u)) * (180/pi);
theta_2_FLOC(k) = acos( ((1.5*fs+tau_2_FLOC(k)*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

[M,N] = size(x);
xm = [x(1,:) x(1,:)];
R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        NUM = NUM + x(4,n).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m));
    end
    R(m) = NUM / DEN;
end
[argvalue, argmax] = max(abs(R-mean(R)));
tau_3_FLOC(k) = argmax;
%theta_3_FLOC(k) = asin((tau_3_FLOC(k)/fs) / (d/u)) * (180/pi);
theta_3_FLOC(k) = 135 - acos( (1.5/(2*dl)) + (dl/(2*1.5)) - ((1.5*fs-tau_3_FLOC(k)*u)/(fs*sqrt(2*dl*1.5)))^2 )*(180/pi);

k = k + 1;
end

rmse_GCC = sqrt( mean( (angles-real(theta_1_GCC)).^2 ) );
rmse_NLT = sqrt( mean( (angles-real(theta_1_NLT)).^2 ) );
rmse_FLOC = sqrt( mean( (angles-real(theta_1_FLOC)).^2 ) );

% plot(real(theta_1_GCC))
% hold on
% plot(real(theta_1_NLT),'r')
%
% media_GCC = (real(theta_1_GCC) + real(theta_2_GCC) + real(theta_3_GCC))./3;
% media_NLT = (real(theta_1_NLT) + real(theta_2_NLT) + real(theta_3_NLT))./3;
% plot(media_GCC)
% hold on
% plot(media_NLT,'r')

end