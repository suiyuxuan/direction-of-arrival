%% Read data
clear all;close all;clc;
tic;
baseFolder = ['results'];

% Open simulation campaign parameters
load([pwd filesep baseFolder filesep 'AngPar_' baseFolder '.mat'], 'AngPar');

%% Plot PD vs PFA
%legend for sensing algorithms
nAlgorithm = { 'Retangular'};

k_ang = AngPar.KnowAngle;
for isnr = 1:length(AngPar.SNR)
    
    SNR = AngPar.SNR(isnr);
    load([baseFolder filesep 'Ang_window_' num2str(AngPar.Window) '_SNR_' num2str(SNR) '_Fsample_' num2str(AngPar.Fsample) '_Fsignal_' num2str(AngPar.Fsignal) '_nSources_'  num2str(AngPar.nSources) '_Samples_'  num2str(AngPar.Samples) '.mat'],'ang' , 'vec_ang' );
    rmse(isnr) = immse(ang,k_ang);
end
%% Plot do gr�fico
plot(AngPar.SNR,rmse);
title('EMQ vs SNR');
xlabel('Relação sinal ruído'); ylabel('Erro médio quadrático');
grid on;