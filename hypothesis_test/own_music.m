function [Pmusic_spectrum] = own_music(NN,nSources,nArrayElements,d,Fsignal,u,theta)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    for kk = 1:nSources            % Loop to calculate the DOA for each incident nSourece    
        for ii = 1:length(theta)   % Loop for try to find the DOA
            SS = zeros(1,length(nArrayElements));	% subspace of the nSignal with
                                                    % nSignal dimensions

                for jj = 0:nArrayElements-1 % Loot to mount the subspace of the nSignal
                    SS(1+jj) = exp(-(j*2*jj*pi*Fsignal(kk)*d*sin(theta(ii)/180*pi))/u);
                end

            PP = SS*NN*NN'*SS'; % If Theta is equal to DOA one of the signals, ...
                                % SS(theta) ? NN and the denominator is identically zero
            Pmusic(nSources,ii) = abs(1/PP);
        end
    Pmusic_spectrum = 10*log10(Pmusic/max(Pmusic)); % normalizes the peak
    end
end

