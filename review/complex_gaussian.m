%% Gaussiana Complexa
% Danilo Pena

clear

%% Gaussiana bivariada

% Parâmetros
mu1 = 0; mu2= 0;
sigma1 = 0.2; sigma2 = 0.6;
mu = [mu1 mu2];
%sigma = [sigma1^2 covariancia(); covariancia() sigma2^2];
sigma = [1,1.5;1.5,3];

x = mvnrnd(mu,sigma,1000);

%x1 = -3:.2:3; x2 = -3:.2:3;
x1 = linspace(-3,3,50); x2 = linspace(-3,3,50);
[X1,X2] = meshgrid(x1,x2);

F = mvnpdf([X1(:) X2(:)],mu,sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);

caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-3 3 -3 3 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('pdf');

%% Gaussiana bivariada complexa


