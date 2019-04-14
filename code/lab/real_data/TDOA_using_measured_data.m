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
%load('../../../data/respeaker/hall/source/data.mat');
%load('../../../data/respeaker/outdoor/source/data.mat');

% Speech signal source
%load('../../../data/respeaker/indoor/speech/data.mat');
%load('../../../data/respeaker/hall/speech/data.mat');
%load('../../../data/respeaker/outdoor/speech/data.mat');

% window if necessary
%window_sel = 10:length(data.channel_1(:,2));
%window_sel = 75001:150000; % indoor
%window_sel = 78001:88000; % indoor
%window_sel = 70001:150000; % hall
%window_sel = 55001:120000; % outdoor
%window_sel = 108001:116000; % outdoor
%window_sel = 1501:3000;

% Time domain
x(:,1) = (data.channel_1(:,2));
x(:,2) = (data.channel_2(:,2));
x(:,3) = (data.channel_4(:,2));
x(:,4) = (data.channel_3(:,2));
% x = x';
% x(:,1) = (data.channel_3(:,2));
% x(:,2) = (data.channel_4(:,2));
% x(:,3) = (data.channel_2(:,2));
% x(:,4) = (data.channel_1(:,2));
% %x(:,3) = (data.channel_1(:,2));
% %x(:,4) = (data.channel_2(:,2));
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
dl = sqrt(2*d^2);
angles = 20;
f = 1000;
fs = 48000;
u = 340;
%f = ((indice-1)*fs)/length(window_sel);

%% Fourier validation

X_f(1,indice)
X_f(2,indice)
X_f(3,indice)
X_f(4,indice)

delta_1_far_field = (d * 2 * pi * f * sin(angles*(pi/180))) / u; % far-field
delta_1_real = (0.01868124*2*pi*f)/u; % triangular
delta_1_measured = X_f(1,indice)-X_f(2,indice); % measured

tau_1_far_field = ((d * sin(angles*(pi/180))) / u)*fs; % far-field
tau_1_real = ((0.01868124)/u)*fs; % triangular
tau_2_far_field = ((d * cos(angles*(pi/180))) / u)*fs; % far-field
tau_2_real = ((0.060347)/u)*fs; % triangular
tau_3_far_field = -((dl * cos((90-angles+45)*(pi/180))) / u)*fs; % far-field
tau_3_real = ((0.058194)/u)*fs; % triangular

%tau_1_measured = ((X_f(2,indice)-X_f(1,indice))/(2*pi*f))*fs; % measured
tau_1_measured = (angdiff(X_f(2,indice), X_f(1,indice))/((2*pi*f)/fs)); % measured
%tdoa_1_measured = tau_1_measured/fs;
%theta_1_fourier = asin(tdoa_1_measured / (d/u)) * (180/pi);

% Plot Fourier analysis
% h1 = subplot(2,1,1);
% plot(X_f(2,:)-X_f(1,:))
% h2 = subplot(2,1,2);
% plot(X(1,:))
% linkaxes([h2 h1],'x')

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
% X1 = fft(xt(1,:));
% X2 = fft(xt(2,:));
% NUM = (X1 .* conj(X2));
% W = max(abs(NUM),0.01);
% R = ifft(NUM./W);
% [argvalue, argmax] = max(abs(R));
% half = length(x(2,:))/2;
% tau_NLT = -(argmax - 2*half - 1);
tau_1_NLT = gccphat(xt(1,:)',xt(2,:)');
%theta_1_NLT = asin((tau_1_NLT/fs) / (d/u)) * (180/pi);
theta_1_NLT = 90 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_1_NLT*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);

tau_2_NLT = gccphat(xt(3,:)',xt(1,:)');
%theta_2_NLT = acos((tau_2_NLT/fs) / (d/u)) * (180/pi);
%theta_2_NLT = 180 - acos( (1.5/(2*d)) + (d/(2*1.5)) - ((1.5*fs-tau_2_NLT*u)/(fs*sqrt(2*d*1.5)))^2 )*(180/pi);
theta_2_NLT = acos( ((1.5*fs+tau_2_NLT*u)/(fs*sqrt(2*d*1.5)))^2 - (1.5/(2*d)) - (d/(2*1.5)) )*(180/pi);

tau_3_NLT = gccphat(xt(4,:)',xt(1,:)');
%theta_3_NLT = 45+acos((tau_3_NLT/fs) / (d/u)) * (180/pi);
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
