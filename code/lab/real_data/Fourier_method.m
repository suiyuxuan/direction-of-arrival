
clear
close all

%% Load data

% No source
%load('../../../data/respeaker/indoor/no_source/data.mat');
%load('../../../data/respeaker/hall/no_source/data.mat');
%load('../../../data/respeaker/outdoor/no_source/data.mat');

% 1 kHz source
load('../../../data/respeaker/indoor/source/data.mat');
%load('../../../data/respeaker/hall/source/data.mat');
%load('../../../data/respeaker/outdoor/source/data.mat');

% Speech signal source
%load('../../../data/respeaker/indoor/speech/data.mat');
%load('../../../data/respeaker/hall/speech/data.mat');
%load('../../../data/respeaker/outdoor/speech/data.mat');

% Time domain
x(:,1) = (data.channel_1(:,2));
x(:,2) = (data.channel_2(:,2));
x(:,3) = (data.channel_4(:,2));
x(:,4) = (data.channel_3(:,2));
x = x';

x(1,:) = x(1,:)/max(x(1,:));
x(2,:) = x(2,:)/max(x(2,:));
x(3,:) = x(3,:)/max(x(3,:));
x(4,:) = x(4,:)/max(x(4,:));

% Plots
plot(x(1,:))
hold on
plot(x(2,:),'r')
plot(x(3,:),'g')
plot(x(4,:),'k')
legend('1','2','3','4')

% Fourier analysis
X(1,:) = abs(fft(x(1,:)));
X(2,:) = abs(fft(x(2,:)));
X(3,:) = abs(fft(x(3,:)));
X(4,:) = abs(fft(x(4,:)));

X_f(1,:) = angle(fft(x(1,:)));
X_f(2,:) = angle(fft(x(2,:)));
X_f(3,:) = angle(fft(x(3,:)));
X_f(4,:) = angle(fft(x(4,:)));

% Sensing frequency
[maximum,indice] = max(X(1,:));

% TDOA parameters
d = 0.0575;
dl = sqrt(2*d^2);
angles = 20;
f = 1000;
fs = 48000;
u = 340;

%% Fourier Method

X_f(1,indice)
X_f(2,indice)
X_f(3,indice)
X_f(4,indice)

tau_1_measured = (angdiff(X_f(1,indice), X_f(2,indice))/((2*pi*f)/fs)); % measured
tau_2_measured = (angdiff(X_f(3,indice), X_f(1,indice))/((2*pi*f)/fs)); % measured
tau_3_measured = (angdiff(X_f(4,indice), X_f(1,indice))/((2*pi*f)/fs)); % measured
tau_4_measured = (angdiff(X_f(3,indice), X_f(2,indice))/((2*pi*f)/fs)); % measured
tau_5_measured = (angdiff(X_f(2,indice), X_f(4,indice))/((2*pi*f)/fs)); % measured
tau_6_measured = (angdiff(X_f(4,indice), X_f(3,indice))/((2*pi*f)/fs)); % measured

%tdoa_1_measured = tau_1_measured/fs;
%theta_1_fourier = asin(tdoa_1_measured / (d/u)) * (180/pi);
