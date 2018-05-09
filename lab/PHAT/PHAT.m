% Federal University of Rio Grande do Norte
% Title: Phase Transformation
% Author: Danilo Pena
% Description: Phase Transformation
% x: synthetic or real signal
% P: source numbers
% f: source frequency
% d: distance between the elements

function [theta,pMusic] = PHAT(x, P, f, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound

% Eigenvalues and eigenvectors
Rx = x*x'; % covariance matrix
[AV,V] = eig(Rx);
NN = AV(:,1:M-P); % subspace noise (M - P)

% MUSIC
theta = 0:0.5:90;
pMusic = zeros(1,length(theta));

pMusic = 10*log10(pMusic/max(pMusic));

end
