%% Valitading

load('../../../data/respeaker/indoor/speech/data.mat');

x = (data.channel_1(75001:150000,2));
plot(x)
x(:,2) = (data.channel_2(75001:150000,2));
x = x';

X = abs(fft(x(1,:)));
%plot(X(1,:))
X(2,:) = abs(fft(x(2,:)));
%plot(X(2,:))

X_f = angle(fft(x(1,:)));
%plot(X_f(1,:))
X_f(2,:) = angle(fft(x(2,:)));
%plot(X_f(2,:))

% test
d = 0.05;
angle = 20;
f = (472*48000)/75000;

delta = (d * 2 * pi * f * sin(angle*(pi/180))) / u
