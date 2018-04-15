function ANG = calcule_angle_real_data(x,P,f,d,u,M,win)

x(:,1)=0;   %Zerar nivel dc


for ii=1:M
    x(ii,:) = x(ii,:) - mean(x(ii,:));
end


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


%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---
tam_mag = length(mag(:,1:end/2)); %Novo tamanho
mag_truc = mag(:,1:tam_mag); %Truncamento da magnitude

for i=1:M
    [mass(i),k_freq(i)] = max(abs(mag_truc(i,:))); %Detecta os picos
end

%% --- To find the phase of each microphone --- %%
for ii = 1:M
     %fr(ii,:) = fft(x(ii,1:length(mag_truc(1,:)))); % Correla��o cruzada do sinal
     fr(ii,:) = fft(x(ii,1:end/2)); % Correla��o cruzada do sinal
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

av_tau = 0; %M�dia do tau

for ii = 1:(M-1)
    av_tau = av_tau + dif_ph(ii)/ii; %Relation with the first microphone;
end

av_tau = av_tau/(M-1);

%% --- To find the angle ---%%

ANG = 90 - (180*asin((av_tau*u)/(d*2*pi*f)))/pi;