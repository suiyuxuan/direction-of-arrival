% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Author: Danilo Pena
% Title: Selection Data
% Description: Selection of signal for synthetic or real data

% data: struct of data
% correctAngle: known angle
% delta: acceptable angle deviation for detection

function [signal] = selection_data(type, varargin)

inputs = inputParser;
addRequired(inputs, 'type', @ischar);

end
