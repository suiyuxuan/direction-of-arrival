% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Gaussian Mixture Model
% Descricao: Realiza a modelagem de misturas de Gaussianas
% 
% mean, variance, p
% SNR
%
% 

function [signal] = gaussian_mixture_model(x, varargin)

% Mu = [1 2;-3 -5];
% Sigma = cat(3,[2 0;0 .5],[1 0;0 1]);
% P = ones(1,2)/2;
% gm = gmdistribution(Mu,Sigma,P);
% 
% X = random(gm,1000);
% 
% hist3(X)
% histogram(X(:,1)')
% histogram(X(:,2)')

mu1 = 0;
mu2 = 0;

[M,N] = size(x);
signal = zeros(M,N);

signalPower = (1/N)*x(1,:)*x(1,:)';
signalPower_dB = 10*log10(signalPower);

for snr = snrValues
%for i=1:M
    noisePower_dB = signalPower_dB - snr;
    noisePower = 10^(noisePower_dB/10);
 
%    gm = gmdistribution(means, variances, p);
%    n = random(gm,N)';

    noise1 = normrnd(mu1, sigma1, [N,1]);
    noise2 = normrnd(mu2, sigma2, [N,1]);
    n = [noise1 noise2];
    noise = n(randperm(N));

    signal(i,:) = x(i,:) + noise;
%end
end

end
