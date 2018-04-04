clc
clear all
close all

%% --- Signal delay ---

%Parameters
sigma = 35;                         %Angle of arrival
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

for ii = 1:10
    for k=1:N
     mag(ii,k)=0;
     for n=1:N
          mag(ii,k) = mag(ii,k) + aut_cov(ii,n)*exp(-j*k*(2*pi*n/N));  % Transformada de fourier
     end
    mag(ii,k) = mag(ii,k)/N;
    end 
end

%% ---- Plot do gr�fico --- %%
l = 1:N; % Tamanho do vetor X.

mag(N) = 0;  % Zerar nível DC
PSD = 10*log(abs(mag));

semilogx(l,mag) % Espectro de fourier

hold on; % Manter os gráficos

%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---
  
for i=1:10
    [mass(i),k_freq(i)] = max(abs(mag(i,:))); 
end

%% --- To find the phase of each microphone --- %%

for i=1:10
    phases(i)=angle(mag(i,k_freq(i))); 
end
%% --- To find an average of tau ---%
for kk = 1:9
    dif_ph(kk) = angdiff(phases(kk+1),phases(1));
end
dif_ph = -wrapToPi(dif_ph);
%% --- Plots of angles ----%%
hold on
plot(angle(mag(1,:)),'k')
plot(angle(mag(2,:)),'b')
plot(angle(mag(3,:)),'m')
%plot(angle(mag(4,:)),'r')
%plot(angle(mag(5,:)),'c')
%plot(angle(mag(6,:)),'g')
%plot(angle(mag(7,:)),'y')
%plot(angle(mag(8,:)),'w')