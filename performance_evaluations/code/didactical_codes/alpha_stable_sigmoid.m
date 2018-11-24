function v = alpha_stable_sigmoid(s, alpha0, GSNR_dB, s_function, s_parameter)

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

noisy_signal = sas_model(s, "complex", alpha0, GSNR_dB);

% See https://en.wikipedia.org/wiki/Sigmoid_function
% https://en.wikipedia.org/wiki/File:Gjl-t(x).svg
switch(s_function)
    case 1 % modulus transformation
        lambda = s_parameter; %-1 parece ser o melhorkurtosis(v)
        if(lambda==0)
            v=sign(noisy_signal).*( log10( abs(noisy_signal) + 1) );
        else
            v=sign(noisy_signal).*( (abs(noisy_signal)+1).^lambda - 1  )./lambda;
        end
    case 2 % spatial signal
        v=noisy_signal./abs(noisy_signal);
    case 3 
        v = tansig(noisy_signal);
    case 4
        v = tanh(noisy_signal);       
    case 5
        v = erf(noisy_signal * sqrt(pi) / 2 );
    case 6
        v = noisy_signal ./ sqrt( 1 + noisy_signal.^2 );
    case 7
        v = 2 / pi * asin( tanh(noisy_signal * pi /2) ); % Gudermannian
    case 8    
        v = 2/pi * atan(pi/2 * noisy_signal);
    case 9
        v = noisy_signal ./ (1 + abs(noisy_signal));
    case 10 % parameterized sigmoid
        nn = s_parameter;
        v = 2 ./ (1 + exp( -nn * noisy_signal) ) - 1;
end