function ANG = calcule_angle(snr,P,f,wn,fs,N,doa,d,u,M,win)

%% --- Geração do Sinal --- %%

A = zeros(P,M);                 % Matriz de direção com P linhas e M colunas

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
x = x(:,1:6000);

if win == 1
    % --- Rectangular Window --- %%
    Nw = length(x(1,:));
    tam_win = Nw/2; %Tamanho da janela
    w(1:tam_win) = 1; 
end

%% --- Autocovarience with Window --- %%

for kk = 1:M
    for ii=0:tam_win-1
        aut_cov(kk,ii+1) = 0; 
        for jj = 1:(tam_win-ii)
            res = ii + jj;
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + x(kk,jj)*x(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariÃ¢ncia
        end
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/tam_win;
    end
end

%% --- Periodogram --- %%
Np = length(aut_cov(1,:));

for kk =1:M
      mag(kk,:) = fft(aut_cov(kk,:)); %PSD
end


%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---
tam_mag = length(mag)-1000; %Novo tamanho
mag_truc = mag(:,1:tam_mag); %Truncamento da magnitude

for i=1:M
    [mass(i),k_freq(i)] = max(abs(mag_truc(i,:))); %Detecta os picos
end

%% --- To find the phase of each microphone --- %%
for ii = 1:M
     fr(ii,:) = fft(x(ii,1:length(mag_truc(1,:)))); % Correlação cruzada do sinal
end

for i=1:M
   phases(i)=angle(fr(i,k_freq(i))); %Acha as fases de cada microfone
end

%% --- To find a difference of phases ---%
soma=0;
for kk = 1:(M-1) 
    soma = soma + abs(angdiff(phases(kk),phases(kk+1)));
    dif_ph(kk) = soma; %diference between first
end

%% --- To find an average of tau ---%%

av_tau = 0; %Média do tau

for ii = 1:(M-1)
    av_tau = av_tau + dif_ph(ii)/ii; %Relation with the first microphone;
end

av_tau = av_tau/(M-1);

%% --- To find the angle ---%%

ANG = 90 - (180*asin((av_tau*u)/(d*2*pi*f)))/pi;