function ANG = calcule_angle(snr,P,f,wn,fs,N,doa,d,u,M)

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

%% --- Rectangular Window --- %%
N = length(x(1,:));
M = N/2;
w(1:M) = 1; 

%% --- Autocovarience with Window --- %%
for kk = 1:10
    for ii=0:M-1
        aut_cov(kk,ii+1) = 0; 
        for jj = 1:(M-ii)
            res = ii + jj;
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + x(kk,jj)*x(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariÃ¢ncia
        end
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/M;
    end
end

%% --- Periodogram --- %%
N = length(aut_cov);    %Tamanho do vetor da autocovariÃ¢ncia

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

for kk = 1:9 
    dif_ph(kk) = angdiff(phases(1),phases(kk+1)); %diference between first
end

%% --- To find an average of tau ---%%

av_tau = 0; %Média do tau

for ii = 1:9
    av_tau = av_tau + dif_ph(ii)/ii; %Relation with the first microphone;
end

av_tau = av_tau/ii;

%% --- To find the angle ---%%

ANG = 90 - 180*asin((av_tau*u)/(d*2*pi*f))/pi;