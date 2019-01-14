% Federal University of Rio Grande do Norte
% Title: Phase Transformation
% Author: Danilo Pena
% Description: Delay-and-Sum (DS) operates by coherently averaging the 
% multi-microphone speech signals. Coherence is achieved by focusing on an 
% acoustic source, which is specified by the estimated Time-Differences of 
% Arrival (TDOA). Incoherent averaging attenuates sources not focused by 
% these TDOAs.

function [output] = NW-DS(x)

[nChannels nSamples] = size(x);

output = zeros(1,nSamples);
delays = zeros(1,nChannels);

%margin = 1;
%fs = 1000;
%marginSamples = round(margin*fs);

for k = 1:nChannels
    %[c,lags] = xcorr(x(k,:), x(1,:), marginSamples, 'coeff');
    [c,lags] = xcorr(x(k,:), x(1,:));
    [maxVal, maxIdx] = max(c);
    delays(k) = lags(maxIdx);
    
    mtxMatchSamples(k,1) = delays(k) + 1;
    if (mtxMatchSamples(k,1)<1)
        disp('Pre-padding')
        padLen = 1 - delays(k);
        x = [zeros(nChannels,padLen) x];
        mtxMatchSamples(k,1) = 1;
        mtxMatchSamples(k,2) = mtxMatchSamples(k,2) + padLen;
    end

    mtxMatchSamples(k,2) =  mtxMatchSamples(k,1) + nSamples - 1;
    if (mtxMatchSamples(k,2) > nSamples)
        disp('Post-padding');
        padLen = mtxMatchSamples(k,2) - nSamples + 1; 
        x = [x zeros(nChannels,padLen)];    
    end
    
    alignedWave = x(k,mtxMatchSamples(k,1):mtxMatchSamples(k,2));
    output = output + alignedWave ;
end

delays
output = 0.8*output./max(abs(output));

end
