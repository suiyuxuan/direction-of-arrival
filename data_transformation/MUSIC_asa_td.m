% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Arthur Diego de Lira Lima / Danilo Pena
% Descricao: MUSIC com canal SaS com transformacao de dados

% y = x + n
% x: sinal original (sem ruido)
% y: sinal com ruido SaS
% z: sinal apos transformacao de dados

clc
clear all
close all

%%
% Definicao de parametros iniciais

M = 10;                         % Numero de elementos no arranjo
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
alpha = 1.5;                    % Parametro do modelo alpha stable
gsnr_min = -40;
gsnr_step = 1;
gsnr_max = 60;

%%
% Modelagem do sinal recebido

% Parametros
doa = [20]/180*pi;              % Angulos
N = 400000;                     % O numero de samples
fa = 200000;                    % Frequencia de amostragem (200kHz)
wn = [pi/100]';                 % Frequencia normalizada dos sinais (1kHz)
fs = (fa*wn)/(2*pi);            % Frequencia dos sinais  em Hz
P = length(doa);                % Numero de fontes de sinais

% Matriz de direcao
A = zeros(P,M);                 % Matriz com P linhas e M colunas

for k = 1:P
    A(k,:) = exp(-j*2*pi*fs*d*sin(doa(k))/u*[0:M-1]);
end
A = A';                         % Matriz com P fontes (colunas) e M elementos (linhas)

% Representacao do sinal recebido
sig = 2*exp(j*(wn*[1:N]));       % Sinal simulado amostrado 1:N
x = A*sig;                      % Sinal multiplicado pelos atrasos

%%
% Encontrando o angulo
Pmusic = [];
PmusicMatrix = [];

for gsrn = gsnr_min:gsnr_step:gsnr_max

    for i=1:10
        y(i,:) = sas_complexo(x(i,:),alpha,gsrn);
    end
    
    for i=1:10
        z(i,:) = imt(y(i,:));
    end 

    % Calculo dos autovalores e autovetores
    Rx = z*z';                      % Matriz covariancia dos dados
    [AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
    NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

    % MUSIC
    theta = -90:0.5:90;

    for ii = 1:length(theta)
        SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
            for jj = 0:M-1
                SS(1+jj) = exp(-(j*2*jj*pi*fs*d*sin(theta(ii)/180*pi))/u);
            end
        PP = SS*NN*NN'*SS';
        Pmusic(ii) = abs(1/PP);
    end

    Pmusic = 10*log10(Pmusic/max(Pmusic)); % Determinando pico
    PmusicMatrix = [PmusicMatrix; Pmusic];

end

% Plots
surf(theta, gsnr_min:gsnr_step:gsnr_max, PmusicMatrix)
xlabel('theta')
ylabel('GSNR')
zlabel('Pmusic')
