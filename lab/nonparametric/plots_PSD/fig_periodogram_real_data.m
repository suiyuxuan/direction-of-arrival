%%Parameters
Fs = 200000; %Frequência de amostragem
M = 10; %Número de microfones

%%Average sinal to extract noise 
for kk = 1:10
    truc_sinal(kk,:) = x(kk,1:7000); %Truncamento do sinal
end 
for kk = 1:10
    av_sin(kk,:) = truc_sinal(kk,:) - mean(truc_sinal(kk,:)); %Extract noise
end
%%-------------------------------- Windows tests ------------------------------------------%%
%% ---------- Rectangular Window ----------%%
Nw = length(av_sin(1,:));
 
tam_win = Nw;
w(1:tam_win) = 1; 

%% --------- Autocovarience ------------ %%
% ------------ Autocovariancia com Janela ----------------------%
% x ---- Sinal
% aut_cov ---- vetor da autocovariancia
% res ------ atraso
for kk = 1:10
    for ii=0:tam_win-1
        aut_cov(kk,ii+1) = 0; 
        for jj = 1:(tam_win-ii)
            res = ii + jj;
            aut_cov(kk,ii+1) = aut_cov(kk,ii+1) + av_sin(kk,jj)*av_sin(kk,res)*w(jj)*w(res);  % Calculando o vetor da autocovariÃ¢ncia
        end
        aut_cov(kk,ii+1) = aut_cov(kk,ii+1)/tam_win;
    end
end
 
 
 
%% --- Periodogram --- %%
Np = length(aut_cov);    %Tamanho do vetor da autocovariÃ¢ncia
 
for tt = 1:M
   mag(tt,:) = fft(aut_cov(tt,:));
end
 
%% ---- Plot do grÃ¡fico --- %%

tam_mag = 1:(length(mag)/2);
plot_mag = mean(mag(:,tam_mag));
l = linspace(1,(Fs/2),length(mag)/2); 
PSD = 10*log(abs(plot_mag)); % Power Spectral Density
 
semilogx(l,PSD) % Espectro de fourier
xlabel('Frequência'); ylabel('Magnitude');
