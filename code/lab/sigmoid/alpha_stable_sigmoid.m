function y = alpha_stable_sigmoid(s, alpha0, GSNR_dB, s_function, s_parameter)

% s: input signal
% s_function: sigmoid function
% s_parameter: parameter of the sigmoid function (if parameterized)

% % Scale parameter, 0<gam<infty
% Cg = 1.7810724179901979852365041031071795491696452143034302053;
% A = rms(s);
% 
% %gam = sqrt( A^2 / ( 4 * 10^(GSNR_dB/10) * Cg^(2/alpha-1) ) ); % complex noise
% gam = sqrt( A^2 / ( 2 * 10^(GSNR_dB/10) * Cg^(2/alpha0-1) ) );
% 
% pd1 = makedist('Stable', 'alpha', alpha0, 'gam', gam);
% 
% %imp_noise=random(pd1,size(s)) + 1j*random(pd1,size(s)); % complex noise
% imp_noise=random(pd1,size(s));
% 
% % additive lpha-stable noise
% noisy_signal = s + imp_noise;

x = sas_model(s, "real", alpha0, GSNR_dB);

% See https://en.wikipedia.org/wiki/Sigmoid_function
% https://en.wikipedia.org/wiki/File:Gjl-t(x).svg
switch(s_function)
    case 1 % modulus transformation
        lambda = s_parameter; %-1 parece ser o melhor kurtosis(v)
        if(lambda == 0)
            y = sign(x).*( log10( abs(x) + 1) );
        else
            y = sign(x).*( (abs(x)+1).^lambda - 1  )./lambda;
        end
    case 2 % spatial signal
        y = x./abs(x);
    case 3 % algebric
        y = x ./ sqrt(1 + x.^2);
    case 4 % hyberbolic
        y = tanh(x); 
    case 5 % error function
        y = erf(x * sqrt(pi) / 2 );
    case 6 % algebric
        y = x ./ sqrt( 1 + x.^2 );
    case 7 % Gudermannian
        y = (2/pi) * asin( tanh(x * pi /2) );
    case 8  % arctan
        y = (2/pi) * atan(pi/2 * x);
    case 9
        y = x ./ (1 + abs(x));
    case 10 % parameterized sigmoid
        nn = s_parameter;
        y = 2 ./ (1 + exp( -nn * x) ) - 1;
end