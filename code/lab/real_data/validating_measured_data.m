%% Valitading

load('../../../data/respeaker/indoor/speech/data.mat');

window = 75001:150000;
window = 78001:88000;

x = (data.channel_1(window,2));
plot(x)
x(:,2) = (data.channel_2(window,2));
x = x';

X = abs(fft(x(1,:)));
%plot(X(1,:))
X(2,:) = abs(fft(x(2,:)));
%plot(X(2,:))

X_f(1,:) = angle(fft(x(1,:)));
%plot(X_f(1,:))
X_f(2,:) = angle(fft(x(2,:)));
%plot(X_f(2,:))

% test
d = 0.05;
angle = 20;
fs = 48000;
f = (index*fs)/length(window);
u = 340;

delta = (d * 2 * pi * f * sin(angle*(pi/180))) / u

[maximum,index] = max(X(1,:));
X_f(1,index)
X_f(2,index)

X_f(2,index)-X_f(1,index)

% Margin error

sin((90-angle)*(pi/180))*0.8

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
