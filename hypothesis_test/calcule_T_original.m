function T = calcule_T(SNR_dB,theta,nArrayElements,nAlgorithm,nEvents,nSources,DifferenceDrop,DifferenceDeviation,Fsample,Fsignal,Magnitude)
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
% --- Labsim/Gppcom ---
% DEPARTAMENTO DE COMUNICAÇÕES - DCO UFRN

%% --- Code ---
% --- Signal definitions ---
Ts = 1/Fsample;                         % Período de amostragem s
Tf = 0.008;                             % Tempo de medicao s
t = (0:Ts:Tf-Ts);                       % Vetor tempo           
signal = Magnitude*cos(2*pi*Fsignal*t + theta*pi.*(1:length(t)));       % Sinal gerado

% --- Calculando e adicionando ruído ---
L = length(signal);                     % Tamanho do sinal
Es = sum(abs(signal).^2)/L;             % Calcula a potência do sinal
SNR = 10^(SNR_dB/10);                   % Calcula a SNR linear
D = Es/SNR;                             % Calcula a densidade espectral do ruído
noiseSigma = sqrt(D);                   % Derivação padrao para ruído AWGN real


% --- Evaluation of T metric ---
if nAlgorithm == 1    
    T = zeros(3,nEvents);                     % Rate matrix.        
    
    for ll = 1:nEvents        
        % --- Real noise 
        noise_real = noiseSigma * randn(1,L);   % Ruido real calculado 
        signal_noise = signal + noise_real;     % Sinal corrompido com ruído, y(t)
        
        
        %% --- Recalculating Music at each event ---
        X = corrmtx(signal_noise,nArrayElements);       % Matrix for autocorrelation matrix estimation
        [S_pow, w] = pmusic(X,2);                       % Music Algorithm
        S_db = pow2db(S_pow);
        
        %% --- Parameters for search
        theta_w = theta * pi;                   % Normalized value
               
        % --- Function to find peaks in the spectrum ---
        [x,y] = findpeaks(S_db,w,'MinPeakProminence',DifferenceDrop);
        
        % --- Increasing rate value ---
        
        if(size(x) == nSources)
            if((y > theta_w-DifferenceDeviation) && (y <= theta_w+DifferenceDeviation)) 
                T(1,ll) = T(1,ll) + 1;  % T(1,:) = Right angle and number of sources
            else
                T(2,ll) = T(2,ll) + 1;  % T(2,:) = Right number of sources and wrong angle
            end
        else
            T(3,ll) = T(3,ll) + 1;      % T(3,:) = Wrong number of sources
        end
    end
end
disp(['Events - ' num2str(nEvents) ' - Right angle and number of sources Detection = ' num2str(sum(T(1,:))) ])
disp(['Events - ' num2str(nEvents) ' - Right number of sources and wrong angle Detection = ' num2str(sum(T(2,:))) ])
disp(['Events - ' num2str(nEvents) ' - Wrong number of sources = ' num2str(sum(T(3,:))) ])
end

