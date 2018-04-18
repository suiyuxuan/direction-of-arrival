close all; clear all; clc;
 
 
% ======= (1) TRANSMITTED SIGNALS ======= %
 
% Signal source directions
az = [35;39;127]; % Azimuths
el = [63;14;57]; % Elevations
M = length(az); % Number of sources
 
% Transmitted signals
L = 200; % Number of data snapshots recorded by receiver
m = randn(M,L); % Example: normally distributed random signals
 
% ========= (2) RECEIVED SIGNAL ========= %
 
% Wavenumber vectors (in units of wavelength/2)
k = pi*[cosd(az).*cosd(el), sind(az).*cosd(el), sind(el)].';
 
% Number of antennas
N = 10; 
 
% Array geometry [rx,ry,rz] (example: uniform circular array)
radius = 0.5/sind(180/N);
rx = radius*cosd(360*(0:N-1).'/N);
ry = radius*sind(360*(0:N-1).'/N);
r = [rx, ry, zeros(N,1)];
 
% Matrix of array response vectors
A = exp(-1j*r*k);
 
% Additive noise
sigma2 = 0.01; % Noise variance
n = sqrt(sigma2)*(randn(N,L) + 1j*randn(N,L))/sqrt(2);
 
% Received signal
x = A*m + n;
 
% ========= (3) MUSIC ALGORITHM ========= %
 
% Sample covariance matrix
Rxx = x*x'/L;
 
% Eigendecompose
[E,D] = eig(Rxx);
[lambda,idx] = sort(diag(D)); % Vector of sorted eigenvalues
E = E(:,idx); % Sort eigenvalues accordingly
En = E(:,1:end-M); % Noise eigenvectors (ASSUMPTION: M IS KNOWN)
 
% MUSIC search directions
AzSearch = (0:1:180).'; % Azimuth values to search
ElSearch = (0:1:90); % Elevation values to search
 
% 2D MUSIC spectrum
Z = zeros(length(AzSearch),length(ElSearch));
for i = 1:length(ElSearch)
    % Elevation search value
    el = ElSearch(i);
    
    % Points on azimuth array manifold curve to search (for this el)
    kSearch = pi*[cosd(AzSearch)*cosd(el), ...
              sind(AzSearch)*cosd(el), ...
              ones(size(AzSearch))*sind(el)].';
    ASearch = exp(-1j*r*kSearch);
    
    % Compute azimuth spectrum for this elevation
    Z(:,i) = sum(abs(ASearch'*En).^2,2);
end
 
% Plot
figure();
surf(AzSearch, ElSearch, -10*log10(Z.'/N));
shading interp;
title('2D MUSIC Example');
xlabel('Azimuth (degrees)');
ylabel('Elevation (degrees)');
zlabel('MUSIC spectrum (dB)');
grid on; axis tight;