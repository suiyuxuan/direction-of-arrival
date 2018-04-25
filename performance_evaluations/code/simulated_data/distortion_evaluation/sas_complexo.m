% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Arthur Diego de Lira Lima / Danilo Pena
% Descricao: Canal aditivo alfa-estavel simetrico (SaS) complexo

% y = x + n
% n: ruido SaS
% x: sinal original (sem ruid)
% y: sinal ruidoso de saida

% GSNR_dB: qualidade do sinal
% alpha: ajuste de calda da distribuicao, 0<alpha<=2. (sugestao: 1<=alpha<=2)
% alpha=2 => Gaussiana; alpha=1 => Cauchy

function y = sas_complexo(x, alpha, GSNR_dB)

% Second shape parameter: the skewness of the distribution. If beta = 0, then the distribution is symmetric, -1<=beta<=1
beta = 0;
% Location parameter
% delta=0;

Cg = 1.7810724179901979852365041031071795491696452143034302053;
A = rms(x);

% Scale parameter, 0<gam<infty
gam = sqrt( A^2 / ( 4 * 10^(GSNR_dB/10) * Cg^(2/alpha-1) ) );

% Configura a geracao da distribuicao alpha-estavel
pd1 = makedist('Stable', 'alpha', alpha, 'gam', gam, 'beta', beta );

% ruido - termo aditivo 
n=random(pd1,size(x)) + 1j*random(pd1,size(x));

% sinal ruidoso
y = x + n;

end