% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Snapshot
% Description: Snapshot settings  
% data: struct of data
% P: source numbers
% fc: source frequency
% d: distance between the elements (microphones)
% snapshot: length of window of snapshot

function angles_algorithms = snapshots(algorithms, signal, snapshots, d, f, u)

P = 1; % check the dimension of angles
length_snapshots = snapshots;
[M,N] = size(signal); % M - number of elements, N - length of samples
L = floor(N/length_snapshots); % number of windows
angles = zeros(1,L); % preallocate output

for nw = 0:L-1
    xw = signal(:,(nw*length_snapshots)+1:(nw*length_snapshots)+length_snapshots); % window

    for i = 1:data.iterations

    switch data.algorithms
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
        otherwise
            error('Incorrect algorithm');
    end

    end

    angles_of_interations(nw+1) = mean(angles);
end

angles_algorithms = mean(angles_of_interations);

end
