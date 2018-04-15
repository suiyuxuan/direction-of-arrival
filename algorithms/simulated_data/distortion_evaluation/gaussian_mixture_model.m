% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Gaussian Mixture Model
% Descricao: Realiza a modelagem de misturas de Gaussianas

Mu = [1 2;-3 -5];
Sigma = cat(3,[2 0;0 .5],[1 0;0 1]);
P = ones(1,2)/2;
gm = gmdistribution(Mu,Sigma,P);

% gmPDF = @(x,y)pdf(gm,[x y]);
% figure;
% ezcontour(gmPDF,[-10 10],[-10 10]);
% hold on
% title('GMM - PDF Contours');

X = random(gm,1000);
% scatter(X(:,1),X(:,2),10,'.')
% title('GMM - PDF Contours and Simulated Data');

hist3(X)
histogram(X(:,1)')
histogram(X(:,2)')


