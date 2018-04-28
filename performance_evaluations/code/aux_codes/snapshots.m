% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Snapshot
% Description: Snapshot settings  

% data: struct of data
% P: source numbers
% fc: source frequency
% d: distance between the elements (microphones)
% snapshot: length of window of snapshot

function angles = snapshots(data, algorithm)

x = data.x;
d = data.d;
fc = data.fc;
P = data.P;
u = data.u;
snapshot = data.snapshot;
[M,N] = size(x); % M - elements numbers, N - length of samples
L = floor(N/snapshot); % window number
angles = zeros(1,L); % preallocate output

for nw = 0:L-1

    xw = x(:,(nw*snapshot)+1:(nw*snapshot)+snapshot);

    switch algorithm
	case 'MUSIC'
            [theta, result(nw+1,:)] = MUSIC(xw, P, fc, d, u);
            [Max,pos_angle] = max(result(nw+1,:));
            angles(nw+1) = (pos_angle-1)/2;
	case 'ESPRIT'
            angles(nw+1) = ESPRIT(xw, P, fc, d, u);
	case 'Capon'
            [theta, result(nw+1,:)] = Capon(xw, P, fc, d, u);
            [Max,pos_angle] = max(result(nw+1,:));
            angles(nw+1) = (pos_angle-1)/2;
	case 'Root MUSIC'
            angles(nw+1) = Root_MUSIC(xw, P, fc, d, u);
        otherwise
            disp('Incorrect algorithm')
    end

end

end
