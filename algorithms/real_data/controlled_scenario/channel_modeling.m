% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Channel Modeling
% Descricao: Realiza a modelagem de canal acustico

%% Deterministic
% point source
r = load('impulse_response.mat'); % acoustic impulse response
s = load('signal.mat'); % signal
N = length(s);
s = [zeros(1,N) s];
N = 2*N;

M = length(r);
for n = 1:N
    for m = 1:M
        x(n) = x(n) + r(n)*s(n-m);
    end
end


% distortion models
x = load('signal.mat'); % signal

% echo model
R = 4;
for n=1:N
    y(n) =  x(n) + alpha*x(n-R);
end
H = 1 + alpha*(z^(-1));
% multiple echos
H = (1 - alpha^N*(z^(-N*R)))/(1 - alpha*z^(-R)); % N=6 R=4 alpha=0.8
H = 1/(1 - alpha*z^(-R));

% reverberation model
H = (alpha + z^(-R))/(1 + alpha*z^(-R)); % alpha < 1, alpha=0.8 R=4

% flanging model
% wn
for n=1:N
    beta(n) = (R/2)*(1 - cos(wn*n))
end
for n=1:N
    y(n) =  x(n) + alpha*x(n- beta(n));
end

%% Statistical

r = e + reb; % impulse response = echo model + reverberation model

