% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Snapshot
% Description: Snapshot settings  
% data: struct of data
% P: source numbers
% fc: source frequency
% d: distance between the elements (microphones)
% snapshot: length of window of snapshot

function angles = snapshots(data, algorithms)

d = data.d;
f = data.f;
P = data.P;
u = data.u;
length_snapshots = data.snapshots;
[M,N] = size(data.signal); % M - number of elements, N - length of samples
L = floor(N/length_snapshots); % number of windows
angles = zeros(1,L); % preallocate output

for nw = 0:L-1

    xw = data.signal(:,(nw*length_snapshots)+1:(nw*length_snapshots)+length_snapshots); % window

    switch algorithms
	case 'MUSIC'
            [theta, result(nw+1,:)] = MUSIC(xw, P, f, d, u);
            [Max,pos_angle] = max(result(nw+1,:));
            angles(nw+1) = (pos_angle-1)/2;
	case 'ESPRIT'
            angles(nw+1) = ESPRIT(xw, P, f, d, u);
	case 'Capon'
            [theta, result(nw+1,:)] = Capon(xw, P, f, d, u);
            [Max,pos_angle] = max(result(nw+1,:));
            angles(nw+1) = 90 - ((pos_angle-1)/2);
	case 'Root MUSIC'
            angles(nw+1) = Root_MUSIC(xw, P, f, d, u);
        otherwise
            error('Incorrect algorithm');
    end

end

end
