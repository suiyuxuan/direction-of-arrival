N = 8;
ula = phased.ULA('NumElements',N,'ElementSpacing',0.08);

fc = 1000;
fs = 10000;
lambda = 340/fc;
pos = getElementPosition(ula)/lambda;

rootmusicangle = phased.RootMUSICEstimator('SensorArray',ula,...
'OperatingFrequency',fc,'NumSignalsSource','Property','NumSignals',1);

doas = step(rootmusicangle,x');

%% 

clear all
close all
clc

nelem = 10;
d = 0.08;
snr = 5.0;
elementPos = (0:nelem-1)*d;

nsig = 1;
angles = [45.0];

covmat = sensorcov(elementPos,angles,db2pow(-snr));

doas = musicdoa(covmat,nsig)



