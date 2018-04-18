%% Renyi
% Danilo Pena

close all
clear

a = 2;
K = 1/(1-a);

x = randn(1,1000);
[p,xi] = hist(x);
p = p/sum(p);

IP = sum(p(~isinf(p)).^a);  % Potencial de informação

R = K .* log2(IP);          % Entropia de Renyi

