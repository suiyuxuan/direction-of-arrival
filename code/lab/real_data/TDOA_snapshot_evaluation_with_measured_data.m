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
%lag = 1000;

% scenarios
% 55000:lag:127000-lag lag=1000 (outdoor - speech)
% 50/100/700/1000/20000/40000/80000 (outdoor - speech)
% 200/400/500/700/2000/4000 (outdoor - source)

%window_sel = 75001:150000; % indoor
window_sel = 55001:120000; % outdoor

x(1,:) = (data.channel_3(window_sel,2))';
x(2,:) = (data.channel_4(window_sel,2))';
x(3,:) = (data.channel_1(window_sel,2))';
x(4,:) = (data.channel_2(window_sel,2))';

kk = 1;
for lag = 1000:1000:50000

[rmse_GCC(kk), rmse_NLT(kk), rmse_FLOC(kk)] = TDOA_snapshot_function_measured_data(x, lag);

kk = kk + 1;
end

% plot(real(theta_1_GCC))
% hold on
% plot(real(theta_1_NLT),'r')
%
% media_GCC = (real(theta_1_GCC) + real(theta_2_GCC) + real(theta_3_GCC))./3;
% media_NLT = (real(theta_1_NLT) + real(theta_2_NLT) + real(theta_3_NLT))./3;
% plot(media_GCC)
% hold on
% plot(media_NLT,'r')

plot(rmse_GCC)
hold on
plot(rmse_NLT,'r')
plot(rmse_FLOC,'k')