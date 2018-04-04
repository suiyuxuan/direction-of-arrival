clc
clear all
close all

%% --- Signal delay ---

%Parameters
sigma = 35;%Angle of arrival
theta = 90 - sigma; 
theta = theta*(pi/180);             %Convert degree into rad
d = 0.08;                           %Distance of each microphone
f = 1000;                           %Signal Frequency
u = 340;                            %Sound Velocity

%Calculation
tau = (d*2*pi*f*sin(theta))/u;
x = x(:,1:6000);


for kk = 1:10
    x(kk,:) = x(kk,:) - mean(x(kk,:));
end
%%-------------------------------- Windows tests ------------------------------------------%%
%% ---------- Rectangular Window ----------%%

N = length(x(1,:));

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
for kk = 1:10
    for ii=0:M-1
        aut_cov(kk,ii+1) = 0; 
        for jj = 1:(M-ii)
            res = ii + jj;
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + x(kk,jj)*x(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariância
        end
        aut_cov(kk,ii + 1) = aut_cov(kk,ii+1)/M;
    end
end



%% --- Periodogram --- %%
N = length(aut_cov(1,:));    %Tamanho do vetor da autocovariância

for tt = 1:10
    mag(tt,:) = fft(aut_cov(tt,:)); 
end

%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---
tam_mag = 1:(length(mag)-1000);
mag_truc = mag(:,tam_mag);

for i=1:10
    [mass(i),k_freq(i)] = max(abs(mag_truc(i,:))); 
end

%% --- To find the phase of each microphone --- %%
for ii = 1:10
     fr(ii,:) = fft(x(ii,1:3000));
end

for i=1:10
   phases(i)=angle(fr(i,k_freq(i))); 
end
%% --- To find a difference of phases ---%

sum =0;
for kk = 1:9 
    %dif_ph(kk) = angdiff(phases(kk),phases(kk+1)); %diference between each microphones
     
    sum = sum + abs(angdiff(phases(kk),phases(kk+1)))
    dif_ph(kk) = sum %diference between first
    
end
%% --- To find an average of tau ---%%

av_tau = 0; %M�dia do tau

for ii = 1:9
    av_tau = av_tau + dif_ph(ii)/ii; %Relation with the first microphone;
    %av_tau = av_tau + dif_ph(ii); %Relation each microphone 
end

av_tau = av_tau/ii;

%% --- To find the angle ---%%

theta = 90 - 180*asin((av_tau*u)/(d*2*pi*f))/pi;
