% Federal University of Rio Grande do Norte
% Title: Positioning
% Author: Danilo Pena
% Description: ReSpeaker 4-mic

clear
close all

theta = 70; % degrees
z1 = 1.50; % meters

% parameters
d = 0.0575;
u = 340;
fs = 48000;

%% Mic 2-1

t1 = sin((90-theta)*(pi/180))*d;
t3 = cos((90-theta)*(pi/180))*d;
t2 = z1 - t3;

x1 = sqrt( t2^2 + t1^2 );

delta1 = z1 - x1;
tau1 = (delta1/u)*fs;

