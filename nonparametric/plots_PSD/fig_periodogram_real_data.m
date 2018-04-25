%%Parameters
Fs = 200000;
lfft = 2000;

%%Average sinal to extract noise 
for kk = 1:10
    truc_sinal(kk,:) = x(kk,1:7000); %Truncamento do sinal
end 
for kk = 1:10
    av_sin(kk,:) = truc_sinal(kk,:) - mean(truc_sinal(kk,:)); %Extract noise
end
%%-------------------------------- Windows tests ------------------------------------------%%
%% ---------- Rectangular Window ----------%%
N = length(av_sin(1,:));
 
M = N/2;
w(1:M) = 1; 

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
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + av_sin(kk,jj)*av_sin(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariÃ¢ncia
        end
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/M;
    end
end
 
 
 
%% --- Periodogram --- %%
N = length(aut_cov);    %Tamanho do vetor da autocovariÃ¢ncia
 
for tt = 1:10
   mag(tt,:) = fft(aut_cov(tt,:),lfft)/lfft; 
end
 
%% ---- Plot do grÃ¡fico --- %%

tam_mag = 1:(length(mag));
plot_mag = mean(mag(:,tam_mag));
%aux = length(plot_mag)+1;
%aux2 = length(mag(1,:));
%plot_mag(:, aux : aux2) = 0


l2hz = [0: Fs/lfft : Fs-Fs/lfft];  %Vetor em Hz
 
PSD = 10*log(abs(plot_mag)); % Power Spectral Density
 
semilogx(l2hz,PSD) % Espectro de fourier
xlabel('Frequência'); ylabel('Magnitude');
