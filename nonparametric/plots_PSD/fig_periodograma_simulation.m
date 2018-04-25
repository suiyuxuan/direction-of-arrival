%% Parameters %%

nEvents = 1:10000;
M = 10;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.08;   
doa = [60]/180*pi;           % Angulos
KnowAng = 90 - doa*180/pi;
N = 6000;                     % O numero de samples
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [pi/100]';            % Frequencia normalizada dos sinais (1kHz)
f = (fs*wn)./(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                 % Numero de fontes de sinais
%AngPar.SNR = [-15:0.25:15];                        % Relacao sinal ruido
snr = 150;
win = 1;                       % Tipo de janela
%% --- Gera��o do Sinal --- %%

A = zeros(P,M);                 % Matriz de dire��o com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*f(k)*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

sig = exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos
signalPower = (1/N)*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);
noisePower_dB = signalPower_dB - snr;   % Ruido
noisePower = 10^(noisePower_dB/10);
noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
x = s + noise;    % Adicionado ruido


if win == 1
    % --- Rectangular Window --- %%
    Nw = length(x(1,:));
    tam_win = Nw; %Tamanho da janela
    w(1:tam_win) = 1; 
end

%% --- Autocovarience with Window --- %%

for kk = 1:M
    for ii=0:tam_win-1
        aut_cov(kk,ii+1) = 0; 
        for jj = 1:(tam_win-ii)
            res = ii + jj;
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + x(kk,jj)*x(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariância
        end
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/tam_win;
    end
end

%% --- Periodogram --- %%
Np = length(aut_cov(1,:));

for kk =1:M
      mag(kk,:) = fft(aut_cov(kk,:)); %PSD
end


%% ---- Plot do grÃ¡fico --- %%
tam_mag = 1:(length(mag)/2);
plot_mag = mean(mag(:,tam_mag)); 
PSD = 10*log(abs(plot_mag));
l = linspace(1,(fs/2),length(mag)/2);
  
semilogx(l,PSD) % Espectro de fourier
xlabel('Frequência'); ylabel('Magnitude');