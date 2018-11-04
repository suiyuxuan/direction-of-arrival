% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Snapshot
% Description: Snapshot settings  
% data: struct of data
% P: source numbers
% fc: source frequency
% d: distance between the elements (microphones)
% snapshot: length of window of snapshot

function angles_algorithms = snapshots(algorithms, signal, snapshots, iterations, d, f, u, fs)

P = 1; % check the dimension of angles
length_snapshots = snapshots;
[M,N] = size(signal.x{1}); % M - number of elements, N - length of samples
L = floor(N/length_snapshots); % number of windows
angles = zeros(1,L); % preallocate output

for snr_i = 1:length(signal.snr)

    for nw = 0:L-1
        xw = signal.x{snr_i}(:,(nw*length_snapshots)+1:(nw*length_snapshots)+length_snapshots); % window

        for i = 1:iterations

            switch algorithms
                case 'MUSIC'
                    [theta, result(i,:)] = MUSIC(xw, P, f, d, u);
                    [Max,pos_angle] = max(result(i,:));
                    angles(i) = (pos_angle-1)/2;
                case 'ESPRIT'
                    angles(i) = ESPRIT(xw, P, f, d, u);
                case 'Capon'
                    [theta, result(i,:)] = Capon(xw, P, f, d, u);
                    [Max,pos_angle] = max(result(i,:));
                    angles(i) = 90 - ((pos_angle-1)/2);
                case 'Root MUSIC'
                    angles(i) = Root_MUSIC(xw, P, f, d, u);
                case 'GCC-PHAT'
                    angles(i) = GCC_PHAT(xw, fs, d);
		case 'GCC-NLT'
		    angles(i) = GCC_NLT(xw, fs, d);
                otherwise
                    error('Incorrect algorithm');
            end

        end

        angles_of_snapshots(nw+1) = mean(angles);
    end

    angles_algorithms(snr_i) = mean(angles_of_snapshots);
end

end
