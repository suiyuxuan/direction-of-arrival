%% --- Parameters ---

AngPar.nArrayElements = 10;                         % Numero de elementos no arranjo
AngPar.PropagationVelocity = 340;                        % Velocidade de propagacao
AngPar.DistanceMicrophones = 0.08;   
AngPar.Angles = [60]/180*pi;           % Angulos
AngPar.Samples = 400000;                     % O numero de samples
AngPar.Fsample = 200000;                    % Frequencia de amostragem (200kHz)
AngPar.FsignalNormalized = [pi/100]';            % Frequencia normalizada dos sinais (1kHz)
AngPar.Fsignal = (AngPar.Fsample*AngPar.FsignalNormalized)./(2*pi);            % Frequencia dos sinais  em Hz
AngPar.nSources = length(AngPar.Angles);                 % Numero de fontes de sinais
AngPar.SNR = [-2:2];                        % Relacao sinal ruido


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
                                    
                    ANG = calcule_angle(snr,P,f,wn,fs,N,doa,d,u,M);
                    
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
