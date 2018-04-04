function T_own_music = calcule_T(Hypothesis,SNR_dB,DOA,nArrayElements,d,nAlgorithm,nEvents,nSources,DifferenceDeviation,Fsample,Fsignal,u,Precision,folderName)
% --- READ ME ---
% SNR is the signal-noise relation
% theta is direction of arrival 
% nArrayElements is the number of antennas in the array
% nAlgorithm is the number that identify the algorithm under analysis
% nEvents is the number of times to running the algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- AUTHOR(S) ---
% Lucas, Carlos, Matheus, Vicente, Danilo
% Update for Mário
% --- Labsim/Gppcom ---
% DEPARTAMENTO DE COMUNICAÇÕES - DCO UFRN
%
% Continuar o READ ME
% -----------------------

%% --- Signal definitions ---
Ts = 1/Fsample;                         % Período de amostragem s
Tf = 0.008;                             % Tempo de medicao s
t = (0:Ts:Tf-Ts);                       % Vetor tempo    

doa = DOA;           % Angulos
wn = (2*pi*Fsignal)./(Fsample);
nSources = length(doa);               % Numero de fontes de sinais

%% --- Construction of the steering matrix ---
A = zeros(nSources,nArrayElements);   % Matrix with nSource rows for ...
                                      % nArrayElements columns
for k = 1:nSources
    A(k,:) = exp(-j*2*pi*Fsignal(k)*d*sin(doa(k))/u*[0:nArrayElements-1]);
end
    
A = A';        % Matriz com P fontes (colunas) e M elementos (linhas)

%% --- Generating received signal matrix ---

sig = 2*exp(j*(wn*t));       % Sampled simulated signal
s = A*sig;                   % Sampled simulated signal multiply Steering matrix


%% --- Evaluation of T metric ---

T_own_music = zeros(3,nEvents);        % Rate matrix.
% T_matlab_music = zeros(3,nEvents);        % Rate matrix.
% T_esprit_music = zeros(3,nEvents);        % Rate matrix.

    for ll = 1:nEvents
        if find(nAlgorithm==1)>0 %--- Evaluation of T metric for Own implementation of MUSIC ---
        %% --- Calculating covariance matrix ---
            if Hypothesis==0
                x = awgn(s,SNR_dB);         % H0 Hypothesis: only noise
            else
                x = s + awgn(s,SNR_dB);     % H1 Hypothesis: signal + noise  
            end
            Rx = x*x';                      % Matrix of covariance with nSource rows for ...
                                            % nSource columns
            [AVector,AValues] = eig(Rx);    % Determination of eigenvectors and eigenvalue
            NN = AVector(:,1:nArrayElements-nSources);  % Mounting the subspace of the noise ...
                                                        % with (nArrayElements -
                                                        % nSources) rows and columns       
            theta = -90:Precision:90;                   % Precision of search for DOA
            [Pmusic_spectrum]=own_music(NN,nSources,nArrayElements,d,Fsignal,u,theta);
        end
        if find(nAlgorithm==2)>0
            % Chamar Matlab DOA
        end
        if find(nAlgorithm==3)>0
            % Chamar ESPRIT
        end

        % --- Increasing rate value ---
        if(size(Pmusic_spectrum) == nSources)
            if((Pmusic_spectrum > theta_w-DifferenceDeviation) && (Pmusic_spectrum <= theta_w+DifferenceDeviation)) 
                T_own_music(1,ll) = T_own_music(1,ll) + 1;  % T(1,:) = Right angle and number of sources
            else
                T_own_music(2,ll) = T_own_music(2,ll) + 1;  % T(2,:) = Right number of sources and wrong angle
            end
        else
            T_own_music(3,ll) = T_own_music(3,ll) + 1;      % T(3,:) = Wrong number of sources
        end
    end
% --- Save folder ---
if find(nAlgorithm==1)>0 %--- Evaluation of T metric for Own implementation of MUSIC ---
	save([folderName filesep 'T' num2str(Hypothesis) '_detection_1_SNR_' num2str(SNR_dB) '_Fsample_' num2str(Fsample) '_Fsignal_' num2str(Fsignal) '_nEvents_'  num2str(nEvents) '.mat'],'T_own_music','SNR_dB');                                        
    disp(['Saved in T' num2str(Hypothesis) '_detection_1_SNR_' num2str(SNR_dB) '_Fsample_' num2str(Fsample) '_Fsignal_' num2str(Fsignal) '_nEvents_'  num2str(nEvents) '.mat'])
    clear V
end

disp(['Events - ' num2str(nEvents) ' - Right angle and number of sources Detection = ' num2str(sum(T_own_music(1,:))) ])
disp(['Events - ' num2str(nEvents) ' - Right number of sources and wrong angle Detection = ' num2str(sum(T_own_music(2,:))) ])
disp(['Events - ' num2str(nEvents) ' - Wrong number of sources = ' num2str(sum(T_own_music(3,:))) ])

end

