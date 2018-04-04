% --- READ ME ---
% SNR is the signal-noise relation
% nSamples is the number of samples to be considered
% theta is direction of arrival 
% nArrayElements is the number of antennas in the array
% nAlgorithm is the number that identify the algorithm under analysis
% nEvents is the number of times to running the algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- AUTHOR(S) ---
% Lucas, Carlos, Matheus, Vicente, Danilo 
% --- Labsim/Gppcom ---
% DEPARTAMENTO DE COMUNICAÇÕES - DCO UFRN

%% --- Paramenters ---
DoaPar.SNR = [-30:0];                          % Values of SNR
DoaPar.theta = 0.257;                           % Number of theta
DoaPar.nArrayElements = 10;                     % Number of elements in the array
DoaPar.nAlgorithm = 1;                          % Number of algorithm
DoaPar.nEvents = 5000;                         % Number of events
DoaPar.nSources = 1;                            % Number of sources
DoaPar.DifferenceDrop = 2;                      % Used for findpeaks
DoaPar.DifferenceDeviation = pi/30;             % Error deviation
DoaPar.Fsample = 100000;                        % Sample frequency Hz
DoaPar.Fsignal = 20000;                           % Signal frequency
DoaPar.Magnitude = 1;                           % Amplitude

%% --- Folder to save results ---
folderName = 'results_20k';

mkdir(folderName);

homeDir = pwd;

save([folderName filesep 'DoaPar_' folderName '.mat'], 'DoaPar');

%% --- Code ---
 for SNR = DoaPar.SNR
     for theta = DoaPar.theta
         for deviation = DoaPar.DifferenceDeviation
             for array = DoaPar.nArrayElements
                for algorithms = DoaPar.nAlgorithm
                    for sources = DoaPar.nSources
                        for peak_factor = DoaPar.DifferenceDrop
                            for fsample = DoaPar.Fsample
                                for fsignal = DoaPar.Fsignal
                                
                                    for events = DoaPar.nEvents
                                        %% --- Calling Function --- 
                                        T = calcule_T(SNR,theta,array,algorithms,events,sources,peak_factor,deviation,fsample,fsignal,DoaPar.Magnitude);
                                
                                        %% Save folder
                                        save([folderName filesep 'T_detection_' num2str(algorithms) '_SNR_' num2str(SNR) '_Fsample_' num2str(fsample) '_Fsignal_' num2str(fsignal) '_nEvents_'  num2str(events) '_DifDrop_'  num2str(peak_factor) '.mat'],'T', 'SNR');                                        
                                        disp(['Saved in T_detection_' num2str(algorithms) '_SNR_' num2str(SNR) '_Fsample_' num2str(fsample) '_Fsignal_' num2str(fsignal) '_nEvents_'  num2str(events) '_DifDrop_'  num2str(peak_factor) '.mat'])
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
 
 save([folderName filesep 'DoaPar_' folderName '.mat'], 'DoaPar');
 



                  
                       
        
