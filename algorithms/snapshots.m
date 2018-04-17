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
snapshot = data.snapshot;

[M,N] = size(x); % M - elements numbers, N - length of samples

if snapshot == 0
    L = 1;
else
    L = floor(N/snapshot); % window number
end

angles = zeros(1,L); % preallocate output

for nw = 0:L-1

    if snapshot == 0
        xw = x;
    else
        xw = x(:,(nw*snapshot)+1:(nw*snapshot)+snapshot);
    end

    switch algorithm
	case "MUSIC"
            [theta, pMusic] = MUSIC(xw, P, fc, d);
            [Max,pos_angle] = max(pMusic);
	    angles(nw+1) = (pos_angle-1)/2;
	case "ESPRIT"
	    angles(nw+1) = ESPRIT(xw, P, fc, d);
%	case "Capon"
%	    angles(nw+1) = Capon();
%	case "Root MUSIC"
%	    angles(nw+1) = Root_MUSIC();
    end
end

end
