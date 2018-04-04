%% --- Parameters ---

AngPar.nArrayElements = 10;                         % Numero de elementos no arranjo
AngPar.PropagationVelocity = 340;                        % Velocidade de propagacao
AngPar.DistanceMicrophones = 0.08;   
AngPar.Angles = [60]/180*pi;           % Angulos
AngPar.KAngle = 90 - AngPar.Angles*180/pi;
AngPar.Samples = 400000;                     % O numero de samples
AngPar.Fsample = 200000;                    % Frequencia de amostragem (200kHz)
AngPar.FsignalNormalized = [pi/100]';            % Frequencia normalizada dos sinais (1kHz)
AngPar.Fsignal = (AngPar.Fsample*AngPar.FsignalNormalized)./(2*pi);            % Frequencia dos sinais  em Hz
AngPar.nSources = length(AngPar.Angles);                 % Numero de fontes de sinais
AngPar.SNR = [-15:0.5:15];                        % Relacao sinal ruido
AngPar.Window = 1;                       % Tipo de janela

%% --- Folder to save results ---
folderName = 'results_teste';

mkdir(folderName);

homeDir = pwd;

save([folderName filesep 'AngPar_' folderName '.mat'], 'AngPar');

%% --- Code --- 
for snr = AngPar.SNR
    for P = AngPar.nSources
        for f = AngPar.Fsignal
            for wn = AngPar.FsignalNormalized
                for fs = AngPar.Fsample
                    for N = AngPar.Samples
                        for doa = AngPar.Angles
                            for d = AngPar.DistanceMicrophones
                                for u = AngPar.PropagationVelocity
                                    for M = AngPar.nArrayElements
                                        for win = AngPar.Window
                                            for KAng = AngPar.KAngle
                                                   %% --- Calling the function 
                                                   ANG = calcule_angle(snr,P,f,wn,fs,N,doa,d,u,M,win);
                                                    %% --- Save folder
                                                  save([folderName filesep 'Ang_window_' num2str(win) '_SNR_' num2str(snr) '_Fsample_' num2str(fs) '_Fsignal_' num2str(AngPar.Fsignal) '_nSources_'  num2str(P) '_Samples_'  num2str(N) '.mat'],'ANG', 'snr', 'KAng');                                        
                                                  disp(['Saved in Ang_window_' num2str(win) '_SNR_' num2str(snr) '_Fsample_' num2str(fs) '_Fsignal_' num2str(AngPar.Fsignal) '_nSources_'  num2str(P) '_Samples_'  num2str(N) '.mat'])
                                                  clear V
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
save([folderName filesep 'AngPar_' folderName '.mat'], 'AngPar');
