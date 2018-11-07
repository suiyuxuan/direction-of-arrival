% Federal University of Rio Grande do Norte
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

% FIXIT: multidimensional function
function [signal] = sas_complex_model(x, alpha, gsnrValues_dB)

% Second shape parameter: the skewness of the distribution. If beta = 0, then the distribution is symmetric, -1<=beta<=1
beta = 0;
% Location parameter
% delta=0;

Cg = 1.7810724179901979852365041031071795491696452143034302053;

[M,N] = size(x);
%y = zeros(M,N);

k = 1;
for gsnr_i = gsnrValues_dB

%    for i=1:M
        A = rms(x(1,:));

        % Scale parameter, 0<gam<infty
        gam = sqrt( A^2 / ( 4 * 10^(gsnr_i/10) * Cg^(2/alpha-1) ) );

        % Configura a geracao da distribuicao alpha-estavel
        pd1 = makedist('Stable', 'alpha', alpha, 'gam', gam, 'beta', beta );

        % ruido - termo aditivo 
        n = random(pd1,size(x)) + 1j*random(pd1,size(x));

        % sinal ruidoso
        signal.x{k} = x + n;
        signal.snr{k} = gsnr_i;
        k = k + 1;
    end

%end

end