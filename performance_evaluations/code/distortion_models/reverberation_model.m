% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Description: Reveberator

function [signal] = reverberation_model(x, a, R)

% Matlab Solution (https://www.mathworks.com/help/audio/ref/reverberator-system-object.html)
reverb = reverberator('PreDelay', 0.5, 'WetDryMix', 1);
signal = step(reverb, x);

% My simple solution
%H = (alpha + z^(-R))/(1 + alpha*z^(-R)); % alpha < 1, alpha=0.8 R=4
%H = (alpha*z^(R) + 1)/(z^(R) + alpha);
%H = (alpha*z^(R))/(z^(R) + alpha) + 1/(z^(R) + alpha);
%H = alpha/(1 + alpha*z^(-R)) + z^(-R)/(1 + alpha*z^(-R));
% implements delay loop of transfer function in time domain

end
