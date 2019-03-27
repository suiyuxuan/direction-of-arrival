% Federal University of Rio Grande do Norte
% Title: TDOA evaluation with measured data
% Author: Danilo Pena
% Description: TDOA methods evaluation using measured data (source and speech signals)

clear
close all

%% Load data

% 1 kHz source
%load('../../../data/respeaker/indoor/source/data.mat');
%load('../../../data/respeaker/hall/source/data.mat');
%load('../../../data/respeaker/outdoor/source/data.mat');
% Speech signal source
%load('../../../data/respeaker/indoor/speech/data.mat');
%load('../../../data/respeaker/hall/speech/data.mat');
load('../../../data/respeaker/outdoor/speech/data.mat');

% TDOA parameters
d = 0.0575;
dl = sqrt(2*d^2);
angles = 20;
fs = 48000;
u = 340;

for window_sel = 1:1500:length(data.channel_1(:,2))

% Time domain
x(:,1) = (data.channel_3(window_sel,2));
x(:,2) = (data.channel_4(window_sel,2));
x(:,3) = (data.channel_1(window_sel,2));
x(:,4) = (data.channel_2(window_sel,2));
x = x';

x(1,:) = x(1,:)/max(x(1,:));
x(2,:) = x(2,:)/max(x(2,:));
x(3,:) = x(3,:)/max(x(3,:));
x(4,:) = x(4,:)/max(x(4,:));

%% Methods validation

% GCC-PHAT
[M,N] = size(x);
tau_1_GCC = gccphat(x(1,:)',x(2,:)');
theta_1_GCC = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_GCC*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

tau_2_GCC = gccphat(x(3,:)',x(1,:)');
%theta_2_GCC = 180 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_2_GCC*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);
theta_2_GCC = acos( ((1.5*fs+tau_2_GCC*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

tau_3_GCC = gccphat(x(4,:)',x(1,:)');
theta_3_GCC = 135 - acos( (1.5/(2*dl)) + (dl/(2*1.5)) - ((1.5*fs-tau_3_GCC*u)/(fs*sqrt(2*dl*1.5)))^2 )*(180/pi);
%theta_3_GCC = -45 + acos( ((1.5*fs+tau_3_GCC*u)/(fs*sqrt(2*dl*1.5)))^2 - (1.5/(2*dl)) - (dl/(2*1.5)) )*(180/pi);

% GCC-NLT
xt = tanh(x);
[M,N] = size(xt);
tau_1_NLT = gccphat(xt(1,:)',xt(2,:)');
theta_1_NLT = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_NLT*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

tau_2_NLT = gccphat(xt(3,:)',xt(1,:)');
%theta_2_NLT = 180 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_2_NLT*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);
theta_2_NLT = acos( ((1.5*fs+tau_2_NLT*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

tau_3_NLT = gccphat(xt(4,:)',xt(1,:)');
theta_3_NLT = 135 - acos( (1.5/(2*dl)) + (dl/(2*1.5)) - ((1.5*fs-tau_3_NLT*u)/(fs*sqrt(2*dl*1.5)))^2 )*(180/pi);
%theta_3_NLT = -45 + acos( ((1.5*fs+tau_3_NLT*u)/(fs*sqrt(2*dl*1.5)))^2 - (1.5/(2*dl)) - (dl/(2*1.5)) )*(180/pi);

% % FLOC
% [M,N] = size(x);
% %p = 0.5;
% xm = [x(2,:) x(2,:)];
% R = zeros(1,N);
% for m=1:N
%     NUM = 0;
%     DEN = 0;
%     for n=1:N
%         NUM = NUM + x(1,n).*sign(xm(1,n+m));
%         DEN = DEN + abs(xm(1,n+m));
%         %NUM = NUM + x(1,n).*(abs(xm(1,n+m)).^p-1).*sign(xm(1,n+m));
%         %DEN = DEN + abs(xm(1,n+m)).^p;
%     end
%     R(m) = NUM / DEN;
% end
% [argvalue, argmax] = max(abs(R-mean(R)));
% tau_FLOC = argmax;
% tdoa_FLOC = tau_FLOC / fs;
% theta_FLOC = asin(tdoa_FLOC / (d/u)) * (180/pi);

end
