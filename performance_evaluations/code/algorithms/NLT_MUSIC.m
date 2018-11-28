% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: NLT-MUSIC (Non-Linear Transform MUltiple SIgnal Classification)
% Author: Danilo Pena
% Description: MUSIC Implementation with Non-Linear Transform

% x: synthetic or real signal
% P: source numbers
% f: source frequency
% d: distance between the elements

function [theta,pMusic] = NLT_MUSIC(x, P, f, d, u)

xt = tanh(x); % Non Linear Transform

[M,N] = size(xt); % M - element number, N - number of samples

% Eigenvalues and eigenvectors
Rx = xt*xt'; % covariance matrix
[AV,V] = eig(Rx);
NN = AV(:,1:M-P); % subspace noise (M - P)

% MUSIC
theta = 0:0.5:90;
pMusic = zeros(1,length(theta));

for ii = 1:length(theta)
    SS = zeros(1,length(M));
        for jj = 0:M-1
            SS(1+jj) = exp(-(1i*2*jj*pi*f*d*sin(theta(ii)/180*pi))/u);
        end
    PP = SS*NN*NN'*SS';
    pMusic(ii) = abs(1/PP);
end

pMusic = 10*log10(pMusic/max(pMusic));

end
