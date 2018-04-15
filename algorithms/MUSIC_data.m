% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% MUSIC Data
% Descricao: Adequacao dos dados simulados ou reais para o MUSIC

% data: estrutura com informacoes dos dados
% P: numero de fontes
% fc: frequencia da fonte
% d: distancia entre os sensores (microfones)
% snapshot: tamanho da janela do snapshot

function angles = MUSIC_data(data)

x = data.x;
d = data.d; % Distancia entre os sensores
fc = data.fc; % Frequencia da portadora
P = data.P; % Numero de fontes
snapshot = data.snapshot; % Largura da janela de snapshot
[M,N] = size(x); % M - numero de elementos, N - total de samples
if snapshot == 0
    L = 1;
else
    L = floor(N/snapshot); % Numero de janelas
end
angles = zeros(1,L); % Prealocando a saida

for nw = 0:L-1 % Varrendo as janelas
    if snapshot == 0
        xw = x;
    else
        xw = x(:,(nw*snapshot)+1:(nw*snapshot)+snapshot); % Sinal em um snapshot
    end

    % TODO: Inserir switch para diferentes algoritmos
    [theta, pMusic] = MUSIC(xw, P, fc, d);

    % TODO: Retornar estrutura com saida adequada para cada algoritmo
    [Max,Ind] = max(pMusic); % Capturando o pico (maximo) valor do pMusic
    angles(nw+1) = (Ind-1)/2;
end

end