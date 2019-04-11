% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Title: MUSIC (MUltiple SIgnal Classification)
% Author: Danilo Pena
% Description: MUSIC Implementation

% x: synthetic or real signal
% P: source numbers
% fc: source frequency
% d: distance between the elements

function result = Root_MUSIC(x, P, f, d, u)

[M,N] = size(x); % M - element number, N - number of samples

% Eigenvalues and eigenvectors
Rx = (x*x')/N; % covariance matrix
%[AV,V] = eig(Rx);
%NN = AV(:,1:M-P);
[AV,D,V] = svd(Rx);
NN = AV(:,P+1:M); 
C = NN*NN';

% Root-MUSIC
for kk = 1:2*M-1
    a(kk,1) = sum(diag(C,kk-M));
end
ra = roots(a);

% P roots of polynom that are nearest and inside of unity circle
[dum,ind] = sort(abs(ra));
rb = ra(ind(1:M-1));

% P roots nearest of unity circle
[dumm,I] = sort(abs(abs(rb)-1));
w = angle(rb(I(1:P)));

% doa
dwn = d/(u/f);
result = (-1)*asin(w/dwn/pi/2)*180/pi;

end
