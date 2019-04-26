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
load('../../../data/respeaker/indoor/speech/data.mat');
%load('../../../data/respeaker/hall/speech/data.mat');
%load('../../../data/respeaker/outdoor/speech/data.mat');

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

%window_sel = 10:length(data.channel_1(:,2));
window_sel = 75001:150000; % indoor
%window_sel = 70001:150000; % hall
%window_sel = 55001:120000; % outdoor
%window_sel = 1501:3000;

x(1,:) = (data.channel_3(window_sel,2))';
x(2,:) = (data.channel_4(window_sel,2))';
x(3,:) = (data.channel_1(window_sel,2))';
x(4,:) = (data.channel_2(window_sel,2))';

lag = 1000;
N = length(x(1,:));

[theta_1_GCC, theta_1_FLOC, theta_1_NLT] = TDOA_theta_measured_data(x, lag);

rmse_GCC = sqrt( mean( (angles-real(theta_1_GCC)).^2 ) );
rmse_FLOC = sqrt( mean( (angles-real(theta_1_FLOC)).^2 ) );
rmse_NLT = sqrt( mean( (angles-real(theta_1_NLT)).^2 ) );

PR_GCC = sum((angles-real(theta_1_GCC)) < 6) / length(theta_1_GCC);
PR_FLOC = sum((angles-real(theta_1_FLOC)) < 6) / length(theta_1_FLOC);
PR_NLT = sum((angles-real(theta_1_NLT)) < 6) / length(theta_1_NLT);

plot(real(theta_1_GCC))
hold on
plot(real(theta_1_FLOC),'r')
plot(real(theta_1_NLT),'k')
legend('GCC', 'FLOC', 'NLT')