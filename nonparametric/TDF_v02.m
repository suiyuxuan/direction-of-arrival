clc
clear all
close all

%% --- Transformada Discreta de Fourier ---


%% --- Signal delay ---

%Parameters
sigma = 30;                         %Angle of arrival
theta = 90 - sigma; 
theta = theta*(pi/180);             %Convert degree into rad
d = 0.08;                           %Distance of each microphone
f = 1000;                           %Signal Frequency
u = 340;                            %Sound Velocity

%Calculation
tau = (d*2*pi*f*sin(theta))/u;


%% --- Sinal Simulado ---

Fs = 3000;
N  = 6000;
t  = (0:N-1)/Fs;
phi=2;
x = cos(2*pi*f*t+phi);
%snr=-1;
%x = x + awgn(x,snr);


%% --- Transformada Discreta de Fourier ---
N = length(x);

for k=1:N
    mag(k)=0;
  for n=1:N
      mag(k) = mag(k) + x(1,n)*exp(-j*k*(2*pi*n/N));
  end
  mag(k) = mag(k)/N;
end 

% ---- Plot do gráfico --- %
l = 1:N; % Tamanho do vetor X.

mag(N) = 0;  % Zerar nível DC

PSD = abs(mag);

plot(l,PSD) % Plot da tranformada discreta de fourier


