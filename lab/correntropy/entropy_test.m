%% Entropia
% Danilo Pena

clear
close all

x = randn(1,1000000);
%hist(x)
h = hist(x,100);
p = h/sum(h); % pmf
plot(p)

mu = 0;
sigma = 1;
pd = makedist('Normal',mu,sigma);
x = -3:0.01:3;
p = pdf(pd,x);
plot(x,p)

%I = -log2(h);
H = -sum(p(~isinf(p)).*log2(p(~isinf(p))))
