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

%% Mic 1-4

t1 = cos(theta*(pi/180))*d;
t2 = sin(theta*(pi/180))*d;

y1 = sqrt( (z1+t1)^2 + t2^2 );

delta2 = y1 - z1;
tau2 = (delta2/u)*fs;

%% Mic 1-3

% dl = sqrt(2*d^2);
% t1 = cos((theta+45)*(pi/180))*dl;
% t2 = sin((theta+45)*(pi/180))*dl;
% 
% w1 = sqrt( (z1+t1)^2 + t2^2 );
% 
% delta3 = w1 - z1;
% tau3 = (delta3/u)*fs;

