% Definicao de parametros iniciais
for n=1:22

data = load(strcat(num2str(n),'.mat'));
x = data.x;    

M = 10;                         % Numero de elementos no arranjo
%lambda = 150;                  % Comprimento de onda
u = 340;                        % Velocidade de propagacao
d = 0.08;                       % Distancia entre os elementos
%d = lambda/2;

%%
% Caso utilize dados aquisitados dos microfones como sinal recebido
% Adequacao dos dados aquisitados

x = flipud(x);                  % Invertendo a ordem dos elementos (pois est�o invertidos na mesa)
for i=1:10
    x(i,:) = (x(i,:)-mean(x(i,:)));
end

% Parametros conhecidos
fc = 1000;                       % Frequencia do sinal em Hz
fs = 100000;                    % Frequencia de amostragem (200kHz)
P = 1;                          % Numero de fontes de sinais
%N = 400000;                     % Numero de amostras
N = length(x);                  % Numero de amostras

% Analise de Fourier (ja invertendo os elementos)
%f = [fft(x(10,:)); fft(x(9,:)); fft(x(8,:)); fft(x(7,:)); fft(x(6,:)); ...
%    fft(x(5,:)); fft(x(4,:)); fft(x(3,:)); fft(x(2,:)); fft(x(1,:))];

% f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); fft(x(5,:)); ...
%     fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); fft(x(9,:)); fft(x(10,:))];
% 
% % Zerando componente DC
% f(1,1) = 0;
% f(2,1) = 0;
% f(3,1) = 0;
% f(4,1) = 0;
% f(5,1) = 0;
% f(6,1) = 0;
% f(7,1) = 0;
% f(8,1) = 0;
% f(9,1) = 0;
% f(10,1) = 0;
% 
% nfreq = round(((N*fs)/fa)+1);
% ph(1) = angle(f(1,nfreq));
% ph(2) = angle(f(2,nfreq));
% ph(3) = angle(f(3,nfreq));
% ph(4) = angle(f(4,nfreq));
% ph(5) = angle(f(5,nfreq));
% ph(6) = angle(f(6,nfreq));
% ph(7) = angle(f(7,nfreq));
% ph(8) = angle(f(8,nfreq));
% ph(9) = angle(f(9,nfreq));
% ph(10) = angle(f(10,nfreq));

%%
% Encontrando o angulo

% Calculo dos autovalores e autovetores
Rx = x*x';                      % Matriz covariancia dos dados
[AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
NN = AV(:,1:M-P);               % Selecionando subespa�o do ruido (M - P)

% MUSIC
theta = -90:0.5:90;
Pmusic(n,:) = zeros(1,length(theta));

for ii = 1:length(theta)
    SS = zeros(1,length(M));	% Subespa�o do sinal com P dimensoes
        for jj = 0:M-1
            SS(1+jj) = exp(-(1i*2*jj*pi*fc*d*sin(theta(ii)/180*pi))/u);
        end
    PP = SS*(NN*NN')*SS';
    Pmusic(n,ii) = abs(1/PP);
end

Pmusic(n,:) = 10*log10(Pmusic(n,:)/max(Pmusic(n,:))); % Determinando pico

end

surf(theta,1:22,Pmusic)
% Plots
% plot(theta,Pmusic,'-k')
% xlabel('Angulo \theta')
% ylabel('Funcao Espectro P(\theta) /dB')
% title('MUSIC')
% grid on
