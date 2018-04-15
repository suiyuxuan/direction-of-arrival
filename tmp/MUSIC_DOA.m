close all; clear all; clc;


% ======= (1) TRANSMITTED SIGNALS ======= %

% Signal source directions
az = [45]; % Azimuths
el = zeros(size(az)); % Simple example: assume elevations zero
M = length(az); % Number of sources

% Transmitted signals
L = 200; % Number of data snapshots recorded by receiver
m = randn(M,L); % Example: normally distributed random signals

% ========= (2) RECEIVED SIGNAL ========= %

% Wavenumber vectors (in units of wavelength/2)
k = pi*[cosd(az).*cosd(el), sind(az).*cosd(el), sind(el)].';

% Array geometry [rx,ry,rz]
N = 10; % Number of antennas
r = [(-(N-1)/2:(N-1)/2).',zeros(N,2)]; % Assume uniform linear array

% Matrix of array response vectors
A = exp(-1j*r*k);

% Additive noise
sigma2 = 0.01; % Noise variance
n = sqrt(sigma2)*(randn(N,L) + 1j*randn(N,L))/sqrt(2);

% Received signal
x = A*m + n;

% ========= (3) MUSIC ALGORITHM ========= %

% Sample covariance matrix
x = flipud(x);
L = 400000;
M = 1;
N = 10;
d = 0.08;
r = [(0:d:(N-1)*d).',zeros(N,2)];

Rxx = x*x'/L;

% Eigendecompose
[E,D] = eig(Rxx);
[lambda,idx] = sort(diag(D)); % Vector of sorted eigenvalues
E = E(:,idx); % Sort eigenvalues accordingly
En = E(:,1:end-M); % Noise eigenvectors (ASSUMPTION: M IS KNOWN)

% MUSIC search directions
AzSearch = (0:1:180).'; % Azimuth values to search
ElSearch = zeros(size(AzSearch)); % Simple 1D example

% Corresponding points on array manifold to search
kSearch = pi*[cosd(AzSearch).*cosd(ElSearch), ...
          sind(AzSearch).*cosd(ElSearch), sind(ElSearch)].';
ASearch = exp(-1j*r*kSearch);

% MUSIC spectrum
Z = 1./sum(abs(ASearch'*En).^2,2);

% Plot
figure();
plot(AzSearch,10*log10(Z));
title('Simple 1D MUSIC Example');
xlabel('Azimuth (degrees)');
ylabel('MUSIC spectrum (dB)');
grid on; axis tight;