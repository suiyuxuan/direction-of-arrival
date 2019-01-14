% Federal University of Rio Grande do Norte
% Title: Load data
% Author: Danilo Pena
% Description: Load measured data
% Parameters:
% angles: angles of DOA (1xP matrix), P is number of sources
% N: samples number
% M: elements number
% d: distance betwenn elements
% fs: sampling frequency
% -varargin -
% noise model: 'gaussian', 'gaussian mixture', 'alpha-stable'
% noise parameters:  (snr), gaussian mixture (means, variances),  (alpha, g-snr)
% snr (optional - gaussian): signal-to-noise ratio (default: 0dB) 
% alpha (optional - alpha-stable): tail of the distribution (default: 1.7)
% gsnr (optional - alpha-stable): quality of signal (default: 0)
% K (optional - gaussian mixture): number of mixture components (default: 2)
% means (optional - gaussian mixture): mean of component i (default: [0 0])
% variances (optional - gaussian mixture): variance of component i (default: [0.01 1])
% channel model: 'reverberation', 'echo', 'multiple echos', 'flanging', 'statistical'
% channel parameters: reverberation (a, N)

function [signal] = load_data(angles, M, d, fs, N, noise, channel)

P = length(angles);

path = "../../..";
scenario = "";
measure = "";
filename = strcat(num2str(M), " ", num2str(d));
datafile = fopen(filename,"r");

datacell = textscan(datafile, '%f%f', 'HeaderLines', 2);

fclose(datafile);

data.channel1 = [datacell{1} datacell{2}];

save('data.mat', 'data');

end
