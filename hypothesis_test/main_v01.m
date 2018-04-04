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
% --- Atualizado por ---
% Mário
% --- Labsim/Gppcom ---
% DEPARTAMENTO DE COMUNICAÇÕES - DCO UFRN

%% Configurações do matlab
clc
clear all
close all
format long                   % Long shaping scientific

%% --- Paramenters ---
DoaPar.SNR = [-30:10];                  % Values of SNR
DoaPar.DifferenceDeviation = pi/30;     % Error deviation
DoaPar.nArrayElements = 10;             % Number of elements in the array
DoaPar.dist_sensors = 0.08;             % Distance between sensors
% d = lambda/2
DoaPar.nSources = 1;                    % Number of sources
DoaPar.Fsample = 100000;                % Sample frequency [Hz]
DoaPar.Fsignal = 100;                   % Signal frequency [Hz]
DoaPar.nEvents = 1000;                 % Number of events
DoaPar.Precision = 0.5;                 % Precision of search for DOA ...
                                        % theta = -90:precision:90

% modificado por mário
DoaPar.DOA = [20]/180*pi;               % Number of theta [º]
DoaPar.nAlgorithm = [1];                % 1-Own_Music, 2-Matlab Music ...
                                        % 3-Matlab ESPRIT
DoaPar.PropagSpeed = 340;               % Propagation Speed [m/s]
DoaPar.hypothesis = 1;                      % hypothesis H0: only noise
                                        % hypothesis H1: signal + noise


%% --- Folder to save results ---
folderName = 'results2';
mkdir(folderName);
homeDir = pwd;
save([folderName filesep 'DoaPar_' folderName '.mat'], 'DoaPar');

%% --- Code ---
 for snd_db = DoaPar.SNR
     for doa = DoaPar.DOA
         for differencedeviation = DoaPar.DifferenceDeviation
             for NArrayElements = DoaPar.nArrayElements
                for nalgorithm = DoaPar.nAlgorithm
                    for nsources = DoaPar.nSources
                            for fsample = DoaPar.Fsample
                                for fsignal = DoaPar.Fsignal                  
                                    for events = DoaPar.nEvents
                                        %% --- Calling Function --- 
                                        T = calcule_T_v01(DoaPar.hypothesis,snd_db,doa,NArrayElements,DoaPar.dist_sensors,nalgorithm,events,nsources,differencedeviation,fsample,fsignal,DoaPar.PropagSpeed,DoaPar.Precision,folderName);                                
                                    end
                                end                             
                            end
                    end
                end
             end
         end
     end
 end

 



                  
                       
        
