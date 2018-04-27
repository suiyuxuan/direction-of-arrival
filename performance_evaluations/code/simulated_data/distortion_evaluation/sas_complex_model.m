% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Authors: Arthur Diego de Lira Lima / Danilo de Santana Pena
% Description: Additive channel complex symmetric alpha-stable (SaS)
% Parameters:
% y = x + n
% n: noise SaS
% x: original signal (no noise)
% y: output

% GSNR_dB: quality of signal
% alpha: tail of the distribution, 0<alpha<=2. (tip: 1<=alpha<=2)
% alpha=2 => Gaussian; alpha=1 => Cauchy

function y = sas_complex_model(x, alpha, GSNR_dB)

% Second shape parameter: the skewness of the distribution. If beta = 0, then the distribution is symmetric, -1<=beta<=1
beta = 0;
% Location parameter
% delta=0;

Cg = 1.7810724179901979852365041031071795491696452143034302053;

[M,N] = size(x);
y = zeros(M,N);

for i=1:M
    A = rms(x(i,:));

    % Scale parameter, 0<gam<infty
    gam = sqrt( A^2 / ( 4 * 10^(GSNR_dB/10) * Cg^(2/alpha-1) ) );

    % Configura a geracao da distribuicao alpha-estavel
    pd1 = makedist('Stable', 'alpha', alpha, 'gam', gam, 'beta', beta );

    % ruido - termo aditivo 
    n = random(pd1,size(x(i,:))) + 1j*random(pd1,size(x(i,:)));

    % sinal ruidoso
    y(i,:) = x(i,:) + n;
end

end