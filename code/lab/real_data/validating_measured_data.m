%% Valitading

clear

load('../../../data/respeaker/indoor/speech/data.mat');
load('../../../data/respeaker/hall/speech/data.mat');
load('../../../data/respeaker/outdoor/speech/data.mat');

window = 75001:150000; % indoor
%window = 78001:88000; % indoor
%window = 55001:120000; % outdoor
%window = 70001:150000; % hall

x = (data.channel_1(window,2));
plot(x)
x(:,2) = (data.channel_2(window,2));
x = x';

X(1,:) = abs(fft(x(1,:)));
%plot(X(1,:))
X(2,:) = abs(fft(x(2,:)));
%plot(X(2,:))

X_f(1,:) = angle(fft(x(1,:)));
%plot(X_f(1,:))
X_f(2,:) = angle(fft(x(2,:)));
%plot(X_f(2,:))

[maximum,indice] = max(X(1,:));

% test
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

