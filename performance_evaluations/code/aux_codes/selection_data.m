% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Selection Data
% Description: Selection of signal for synthetic or real data
% Parameters:
% type: 'real' or 'simulated' data
% - varargin -
% 

function [signal] = selection_data(type, varargin)

% FIXIT: defaultN attributed before of inputParser
% defaultN
defaultU = 340; % speed sound propagation
defaultNoise.noise = 'gaussian';
defaultNoise.snr = 0;
defaultChannel.channel = 'none';

inputs = inputParser;
addRequired(inputs, 'type');
addRequired(inputs, 'angles');
addRequired(inputs, 'M');
addRequired(inputs, 'd');
addRequired(inputs, 'f');
addRequired(inputs, 'fs');
addOptional(inputs, 'N', defaultN, @isnumeric);
addOptional(inputs, 'u', defaultU, @isnumeric);
addParameter(inputs, 'noise', defaultNoise);
addParameter(inputs, 'channel', defaultChannel);

parse(inputs, type, varargin{:});



end
