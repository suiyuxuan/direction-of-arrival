%% Valitading

data = load('../../../data/respeaker/indoor/speech/data.mat');

x = (data.channel_1(75001:150000,2));
plot(x)
x(:,2) = (data.channel_2(75001:150000,2));
x = x';