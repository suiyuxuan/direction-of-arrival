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
window_sel = 1:length(data.channel_1(:,2));
%window_sel = 75001:150000; % indoor
%window_sel = 78001:88000; % indoor
%window_sel = 70001:150000; % hall
%window_sel = 55001:120000; % outdoor
%window_sel = 108001:116000; % outdoor

% Time domain
x(:,1) = (data.channel_1(:,2));
x(:,2) = (data.channel_2(:,2));
x(:,3) = (data.channel_3(:,2));
x(:,4) = (data.channel_4(:,2));
x = x';

% Plots
plot(x(1,:))
hold on
plot(x(2,:),'r')
plot(x(3,:),'g')
plot(x(4,:),'k')

% Fourier analysis
X(1,:) = abs(fft(x(1,:)));
%plot(X(1,:))
X(2,:) = abs(fft(x(2,:)));
%plot(X(2,:))
X(3,:) = abs(fft(x(3,:)));
X(4,:) = abs(fft(x(4,:)));

X_f(1,:) = angle(fft(x(1,:)));
%plot(X_f(1,:))
X_f(2,:) = angle(fft(x(2,:)));
%plot(X_f(2,:))
X_f(3,:) = angle(fft(x(3,:)));
X_f(4,:) = angle(fft(x(4,:)));

% Sensing frequency
[maximum,indice] = max(X(1,:));

% TDOA parameters
d = 0.0575;
angles = 20;
fs = 48000;
u = 340;
f = ((indice-1)*fs)/length(window_sel);

%% Fourier validation

X_f(1,indice)
X_f(2,indice)
X_f(3,indice)
X_f(4,indice)

delta_1 = (d * 2 * pi * f * sin(angles*(pi/180))) / u; % far-field
delta_1_real = (0.01868124*2*pi*f)/u; % triangular
delta_1_measured = X_f(1,indice)-X_f(2,indice); % measured

tau_1 = ((d * sin(angles*(pi/180))) / u)*fs;
tau_1_real = ((0.01868124)/u)*fs; % triangular
tau_1_measured = ((X_f(1,indice)-X_f(2,indice))/(2*pi*f))*fs; % measured

tdoa_1_measured = tau_1_measured/fs;
theta_1_fourier = asin(tdoa_1 / (d/u)) * (180/pi);

% Plot Fourier analysis
h1 = subplot(2,1,1);
plot(X_f(2,:)-X_f(1,:))
h2 = subplot(2,1,2);
plot(X(1,:))
linkaxes([h2 h1],'x')

%% Methods validation

% GCC-PHAT
[M,N] = size(x);
% X1 = fft(x(1,:));
% X2 = fft(x(2,:));
% NUM = (X1 .* conj(X2));
% W = max(abs(NUM),0.01);
% R = ifft(NUM./W);
% [argvalue, argmax] = max(abs(R));
% half = length(x(2,:))/2;
% tau_GCC = -(argmax - 2*half - 1);
tau_1_GCC = gccphat(x(2,:)',x(1,:)');
tdoa_1_GCC = tau_1_GCC / fs;
theta_1_GCC = asin(tdoa_1_GCC / (d/u)) * (180/pi);

tau_2_GCC = gccphat(x(1,:)',x(3,:)');
theta_2_GCC = acos((tau_2_GCC*u) / (fs*d)) * (180/pi);

tau_3_GCC = gccphat(x(1,:)',x(4,:)');
tdoa_3_GCC = tau_3_GCC / fs;
theta_3_GCC = 45 + acos((tau_3_GCC*u) / (fs*d)) * (180/pi);

% GCC-NLT
xt = tanh(x);
[M,N] = size(xt);
% X1 = fft(xt(1,:));
% X2 = fft(xt(2,:));
% NUM = (X1 .* conj(X2));
% W = max(abs(NUM),0.01);
% R = ifft(NUM./W);
% [argvalue, argmax] = max(abs(R));
% half = length(x(2,:))/2;
% tau_NLT = -(argmax - 2*half - 1);
tau_1_NLT = gccphat(xt(2,:)',xt(1,:)');
tdoa_1_NLT = tau_1_NLT / fs;
theta_1_NLT = asin(tdoa_1_NLT / (d/u)) * (180/pi);

tau_2_NLT = gccphat(xt(1,:)',xt(3,:)');
tdoa_2_NLT = tau_2_NLT / fs;
theta_2_NLT = asin(tdoa_2_NLT / (d/u)) * (180/pi);

tau_3_NLT = gccphat(xt(1,:)',xt(4,:)');
tdoa_3_NLT = tau_3_NLT / fs;
theta_3_NLT = asin(tdoa_3_NLT / (d/u)) * (180/pi);

% FLOC
[M,N] = size(x);
%p = 0.5;
xm = [x(2,:) x(2,:)];
R = zeros(1,N);
for m=1:N
    NUM = 0;
    DEN = 0;
    for n=1:N
        NUM = NUM + x(1,n).*sign(xm(1,n+m));
        DEN = DEN + abs(xm(1,n+m));
        %NUM = NUM + x(1,n).*(abs(xm(1,n+m)).^p-1).*sign(xm(1,n+m));
        %DEN = DEN + abs(xm(1,n+m)).^p;
    end
    R(m) = NUM / DEN;
end
[argvalue, argmax] = max(abs(R-mean(R)));
tau_FLOC = argmax;
tdoa_FLOC = tau_FLOC / fs;
theta_FLOC = asin(tdoa_FLOC / (d/u)) * (180/pi);
