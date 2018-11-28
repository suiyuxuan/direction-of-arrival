% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Snapshot
% Description: Snapshot settings  
% data: struct of data
% P: source numbers
% fc: source frequency
% d: distance between the elements (microphones)
% snapshot: length of window of snapshot

function [mean_angles, RMSE, absolute_error] = snapshots(algorithms, correct_angle, snapshots, iterations, d, f, u, fs, type_of_data, M, N, noise, channel)

P = 1; % check the dimension of angles
%length_snapshots = snapshots;
%[M,N] = size(signal.x{1}); % M - number of elements, N - length of samples
%L = floor(N/length_snapshots); % number of windows
%angles = zeros(1,L); % preallocate output

mean_angles = zeros(1,length(noise.snr));
RMSE = zeros(1,length(noise.snr));
absolute_error = zeros(1,length(noise.snr));

k = 1;
for snr_i = noise.snr(1):noise.snr(end) % SNR or GSNR

    % TODO: Analysis of snapshots
%    for nw = 0:L-1
%        xw = signal.x{snr_i}(:,(nw*length_snapshots)+1:(nw*length_snapshots)+length_snapshots); % window
        %xw = signal.x{snr_i};
        angles = zeros(1,iterations);
        
        for i = 1:iterations

            signal = selection_data(type_of_data, correct_angle, M, d, f, fs, N, u, noise, channel, snr_i);
            
            switch algorithms
                case 'MUSIC'
                    [theta, result(i,:)] = MUSIC(signal, P, f, d, u);
                    [Max,pos_angle] = max(result(i,:));
                    angles(i) = (pos_angle-1)/2;
                case 'ESPRIT'
                    angles(i) = ESPRIT(signal, P, f, d, u);
                case 'Capon'
                    [theta, result(i,:)] = Capon(signal, P, f, d, u);
                    [Max,pos_angle] = max(result(i,:));
                    angles(i) = 90 - ((pos_angle-1)/2);
                case 'Root-MUSIC'
                    angles(i) = Root_MUSIC(signal, P, f, d, u);
                case 'Beamscan'
                    angles(i) = BeamScan(signal, P, f, d, u);
                case 'Root MVDR'
                    angles(i) = Root_MVDR(signal, P, d, u);
                case 'GCC-PHAT'
                    angles(i) = GCC_PHAT(signal, fs, d);
                case 'GCC-NLT'
                    angles(i) = GCC_NLT(signal, fs, d);
                case 'FLOS-PHAT'
                    angles(i) = FLOS_PHAT(signal, fs, d);
                case 'NLT-MUSIC'
                    [theta, result(i,:)] = NLT_MUSIC(signal, P, f, d, u);
                    [Max,pos_angle] = max(result(i,:));
                    angles(i) = (pos_angle-1)/2;
                otherwise
                    error('Incorrect algorithm');
            end

        end

%        angles_of_snapshots(nw+1) = mean(angles);
%    end

%    angles_of_snapshots = angles;

    error_angle = angles - correct_angle;
    
    mean_angles(k) = mean(angles); % Mean Angle
    RMSE(k) = sqrt( mean((error_angle).^2) ); % Root Mean Square Error
    absolute_error(k) = mean( abs(error_angle) ); % Absolute Error
    
    k = k + 1;
end

end
