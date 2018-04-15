%% Read data
clear all;close all;clc;
tic;
baseFolder = ['results'];

% Open simulation campaign parameters
load([pwd filesep baseFolder filesep 'DoaPar_' baseFolder '.mat'], 'DoaPar');
%% Plot PD vs PFA
%legend for sensing algorithms
nAlgorithm = { 'MUSIC'};

%number of events for probability 
nEvents = DoaPar.nEvents;

DetectionProbability = zeros(1,length(DoaPar.SNR));
NoDetectionProbability = zeros(1,length(DoaPar.SNR));


for isnr = 1:length(DoaPar.SNR)
    for idrop = 1:length(DoaPar.DifferenceDrop)
    peak_factor = DoaPar.DifferenceDrop(idrop);
    SNR = DoaPar.SNR(isnr);
    load([baseFolder filesep 'T_detection_' num2str(DoaPar.nAlgorithm) '_SNR_' num2str(SNR) '_Fsample_' num2str(DoaPar.Fsample) '_Fsignal_' num2str(DoaPar.Fsignal) '_nEvents_'  num2str(nEvents) '_DifDrop_' num2str(peak_factor) '.mat'],'T', 'SNR');  
    DetectionProbability(1,isnr) = sum(T(1,:))/nEvents;
    NoDetectionProbability(1,isnr) = (sum(T(2,:))+sum(T(3,:)))/nEvents;
    end
end

figure(1)
plot(DoaPar.SNR,DetectionProbability);
title('P{D} vs SNR');
grid on;

figure(2)
plot(DoaPar.SNR,NoDetectionProbability);
title('P{ND} vs SNR');
grid on;
%% PASSOS
% 1. Iniciar SNR
% 2. Entrar no arquivo
% 3. Ler a primeira linha
% 4. Calular a probabilidade
% 5. Jogar para uma matriz SNR -vs- Probabilidade
% 6. Incrementar SNR
% 7. Reiniciar o processo
