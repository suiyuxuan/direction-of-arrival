clc
clear all
close all

%% --- Signal delay ---

%Parameters
sigma = 15;                         %Angle of arrival
theta = 90 - sigma; 
theta = theta*(pi/180);             %Convert degree into rad
d = 0.08;                           %Distance of each microphone
f = 1000;                           %Signal Frequency
u = 340;                            %Sound Velocity

%Calculation
tau = (d*2*pi*f*sin(theta))/u;
x = x - mean(x);
%%-------------------------------- Windows tests ------------------------------------------%%
%% ---------- Rectangular Window ----------%%
N = length(x);

M = N/2;
w(1:M) = 1; 
%% ---------- Hamming Window -------------%%


N = length(x); % Tamanho do sinal

M = N/2; % Tamanho da janela;

for mm = 0:M-1
    w(mm+1) = 0.54 + 0.46*cos(2*pi*mm/M); 
end

%% ---------- Hanning Window -------------%%

M = N/4; % Tamanho da janela;

for mm = 0:M-1
    w(mm+1) = 0.5 + 0.5*cos(2*pi*mm/(M-1)); 
end


%% ---------- Blackman Window -------------%%

M = N/4; % Tamanho da janela;

for mm = 0:M-1
    w(mm+1) = 0.42 + 0.5*cos(2*pi*mm/(M-1)); 
end

%% ---------- Barrett Window ------------- %%

M = N/4; % Tamanho da janela;

for mm = 0:M-1
    w(mm+1) = 1 - (2*mm/(M-1)); 
end

%% --------- Autocovarience ------------ %%
% ------------ Autocovariancia com Janela ----------------------%
% x ---- Sinal
% aut_cov ---- vetor da autocovariancia
% res ------ atraso

for ii=0:M-1
    aut_cov(ii+1) = 0; 
    for jj = 1:(M-ii)
        res = ii + jj;
         aut_cov(ii+1) = aut_cov(ii+1) + x(jj)*x(res)*w(jj)*w(res);  % Calculando o vetor da autocovariância
    end
    aut_cov(ii + 1) = aut_cov(ii+1)/M;
end




%% --- Periodogram --- %%
N = length(aut_cov);    %Tamanho do vetor da autocovariância


for k=1:N
    mag(k)=0;
  for n=1:N
      mag(k) = mag(k) + aut_cov(1,n)*exp(-j*k*(2*pi*n/N));  % Transformada de fourier
  end
  mag(k) = mag(k)/N;
end    

% ---- Plot do gráfico --- %
l = 1:N; % Tamanho do vetor X.

mag(N) = 0;  % Zerar nível DC
mag = 10*log(mag);
PSD = abs(mag);

plot(l,PSD) % Espectro de fourier

hold on; % Manter os gráficos
