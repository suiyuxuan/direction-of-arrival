clc
clear all
close all

%%
% Definicao de parametros iniciais

M = 10;                         % Numero de elementos no arranjo
%lambda = 150;                  % Comprimento de onda
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
%d = lambda/2;

%%
% Caso utilize sinal modelado/criado no Matlab
% Modelagem do sinal recebido

% Parametros
doa = [60]/180*pi;           % Angulos
N = 400000;                     % O numero de samples
fa = 200000;                    % Frequencia de amostragem (200kHz)
wn = [pi/100]';            % Frequencia normalizada dos sinais (1kHz)
fs = (fa*wn)./(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                 % Numero de fontes de sinais
snr = 15;                        % Relacao sinal ruido

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fs(k)*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
x = s + noise;    % Adicionado ruido
x = x(:,1:6000);

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
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/M;
    end
end



%% --- Periodogram --- %%
N = length(aut_cov);    %Tamanho do vetor da autocovariância

for tt = 1:10
    for k=1:N
        mag(tt,k)=0;
        for n=1:N
            mag(tt,k) = mag(tt,k) + aut_cov(tt,n)*exp(-j*k*(2*pi*n/N));  % Transformada de fourier
        end
        mag(tt,k) = mag(tt,k)/N;
    end 
end

%% ---- Plot do gráfico --- %%
plot_mag = mag(:,1:(length(mag)-1000));

l = 1:length(plot_mag); % Tamanho do vetor X.


PSD = 10*log(abs(plot_mag));

semilogx(l,PSD) % Espectro de fourier

hold on; % Manter os gráficos
%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---
  
for i=1:10
    [mass(i),k_freq(i)] = max(abs(mag(i,:))); 
end
%% --- To find the phase of each microphone --- %%

for i=1:10
    phases(i)=angle(mag(i,k_freq(i))); 
end
