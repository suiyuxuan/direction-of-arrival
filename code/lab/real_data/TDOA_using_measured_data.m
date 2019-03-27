% Federal University of Rio Grande do Norte
% Title: TDOA using measured data
% Author: Danilo Pena
% Description: TDOA methods evaluation using measured data (source and speech signals)

clear
close all

%% Load data

% No source
%load('../../../data/respeaker/indoor/no_source/data.mat');
%load('../../../data/respeaker/hall/no_source/data.mat');
%load('../../../data/respeaker/outdoor/no_source/data.mat');

% 1 kHz source
load('../../../data/respeaker/indoor/source/data.mat');
load('../../../data/respeaker/hall/source/data.mat');
load('../../../data/respeaker/outdoor/source/data.mat');

% Speech signal source
load('../../../data/respeaker/indoor/speech/data.mat');
load('../../../data/respeaker/hall/speech/data.mat');
load('../../../data/respeaker/outdoor/speech/data.mat');

% window if necessary
%window = 75001:150000; % indoor
%window = 78001:88000; % indoor
%window = 70001:150000; % hall
%window = 55001:120000; % outdoor
%window = 108001:116000; % outdoor

% Time domain
x(:,1) = (data.channel_1(window,2));
plot(x)
x(:,2) = (data.channel_2(window,2));
x = x';

% Fourier analysis
X(1,:) = abs(fft(x(1,:)));
%plot(X(1,:))
X(2,:) = abs(fft(x(2,:)));
%plot(X(2,:))

X_f(1,:) = angle(fft(x(1,:)));
%plot(X_f(1,:))
X_f(2,:) = angle(fft(x(2,:)));
%plot(X_f(2,:))

% Sensing frequency
[maximum,indice] = max(X(1,:));

% TDOA parameters
d = 0.05;
angles = 20;
fs = 48000;
f = (indice*fs)/length(window);
u = 340;

delta = (d * 2 * pi * f * sin(angles*(pi/180))) / u

X_f(1,indice)
X_f(2,indice)

X_f(2,indice)-X_f(1,indice)

% Margin error

sin((90-angles)*(pi/180))*0.8

sin_x = .72/.8
asin_x = asin(sin_x)*(180/pi)
delta_margin_inf = (d * 2 * pi * f * sin((90-asin_x)*(pi/180))) / u

sin_x = .78/.8
asin_x = asin(sin_x)*(180/pi)
delta_margin_sup = (d * 2 * pi * f * sin((90-asin_x)*(pi/180))) / u

% Plot analysis

h1 = subplot(2,1,1);
plot(X_f(2,:)-X_f(1,:))
h2 = subplot(2,1,2);
plot(X(1,:))
linkaxes([h2 h1],'x')

% GCC-PHAT

[M,N] = size(x);
X1 = fft(x(1,:));
X2 = fft(x(2,:));
NUM = (X1 .* conj(X2));
W = max(abs(NUM),0.01);
R = ifft(NUM./W);
[argvalue, argmax] = max(abs(R));
half = length(x(2,:))/2;
tau = -(argmax - 2*half - 1);
tdoa = tau / fs;
theta = asin(tdoa / (d/u)) * (180/pi);
