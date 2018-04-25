% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: ESPRIT
% Description: ESPRIT Implementation

% x: synthetic or real signal
% P: source numbers
% fc: source frequency
% d: distance between the elements

function result = ESPRIT(x, P, fc, d)

[M,N] = size(x); % M - element number, N - number of samples
u = 340; % speed of sound

% Eigenvalues and eigenvectors
Rx = (x*x')/N; % covariance matrix
%[AV,V] = eig(Rx);
%NN = AV(:,1:M-P); % subspace noise (M - P)
[AV,D,V]=svd(Rx);
NN = AV(:,1:P); 

% ESPRIT
phi = NN(1:M-1,:)\NN(2:M,:);
w = -angle(eig(phi));
dwn = d/(u/fc);
result = asin(w/dwn/pi/2)*180/pi

end
