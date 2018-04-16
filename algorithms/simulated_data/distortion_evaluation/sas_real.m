% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Arthur Diego de Lira Lima / Danilo Pena
% Descricao: Canal aditivo alfa-estavel simetrico (SaS)  

% y = x + n
% n: ruido SaS
% x: sinal original (sem ruid)
% y: sinal ruidoso de saida

% GSNR_dB: qualidade do sinal
% alpha: ajuste de calda da distribuicao, 0<alpha<=2. (sugestao: 1<=alpha<=2)
% alpha=2 => Gaussiana; alpha=1 => Cauchy

function y = sas_real(x, alpha, GSNR_dB)

% Second shape parameter: the skewness of the distribution. If beta = 0, then the distribution is symmetric, -1<=beta<=1
beta = 0;
% Location parameter
% delta=0;
% Scale parameter, 0<gam<infty
Cg = 1.7810724179901979852365041031071795491696452143034302053;
A = rms(x);


gam = sqrt( A^2 / ( 4 * 10^(GSNR_dB/10) * Cg^(2/alpha-1) ) ); % complex noise
%gam = sqrt( A^2 / ( 2 * 10^(GSNR_dB/10) * Cg^(2/alpha-1) ) );
%gam = (norm(modulated_signal).^2)/length(modulated_signal)

pd1 = makedist('Stable', 'alpha', alpha, 'gam', gam, 'beta', beta );

n = random(pd1,size(x)) + 1j*random(pd1,size(x));
%n = random(pd1, size(x));


y = x + n;

end