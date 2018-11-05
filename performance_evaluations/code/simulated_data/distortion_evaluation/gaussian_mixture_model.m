% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Gaussian Mixture Model
% Descricao: Realiza a modelagem de misturas de Gaussianas
% 
% mean, variance, p
% SNR

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

[M,N] = size(x);
signal = zeros(M,N);

for i=1:M
    gm = gmdistribution(means, variances);
    n = random(gm,N)';
    %n = mvnrnd(means, diag(variances),N);
    noise = n(randperm(N));
    signal(i,:) = x(i,:) + noise;
end

end
