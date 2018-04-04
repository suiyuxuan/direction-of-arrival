clc
clear all
close all

%%
% Definicao de parametros iniciais

angles = [20];                  % Vetor de angulos
M = 4;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.02;                       % Distancia entre os elementos
N = 200;                     % O numero de samples
Pmusic = [];
PmusicMatrix = [];

% Modelagem do sinal recebido

% Parametros
doa = angles/180*pi;            % Angulos
fc = [1000];                    % Frequencia da portadora (Hz)
fs = 200000;                    % Frequencia de amostragem (200kHz)
wn = [((2*pi*fc)/fs)]';         % Frequencia normalizada dos sinais (1kHz)
P = length(doa);                % Numero de fontes de sinais

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-1i*2*pi*fc*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = exp(1i*(wn*[1:N]));       % Sinal simulado amostrado 1:N
s = A*sig;                      % Sinal multiplicado pelos atrasos

signalPower = 1/N*s(1,:)*s(1,:)';
signalPower_dB = 10*log10(signalPower);

snr_min = -40;
snr_step = 5;
snr_max = 40;

for snr = snr_min:snr_step:snr_max

    %x = s + awgn(s,snr);
    noisePower_dB = signalPower_dB - snr;   % Ruido
    noisePower = 10^(noisePower_dB/10);
    noise = sqrt(noisePower/2) * (randn(size(s)) + 1j*randn(size(s)));
    x = s + noise;                          % Adicionando ruido

    %%
    % Encontrando o angulo

    % Calculo dos autovalores e autovetores
    Rx = x*x';                      % Matriz covariancia dos dados
    [AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
    NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

    % MUSIC
    theta = -90:0.5:90;

    for ii = 1:length(theta)
        SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
            for jj = 0:M-1
                SS(1+jj) = exp(-(1i*2*jj*pi*fc*d*sin(theta(ii)/180*pi))/u);
            end
        PP = SS*NN*NN'*SS';
        Pmusic(ii) = abs(1/PP);
    end

    Pmusic = 10*log10(Pmusic/max(Pmusic)); % Determinando pico
    PmusicMatrix = [PmusicMatrix; Pmusic];

end

surf(theta, snr_min:snr_step:snr_max, PmusicMatrix)
xlabel('theta')
ylabel('SNR')
zlabel('Pmusic')
