% Federal University of Rio Grande do Norte
% Title: Campaign
% Author: Danilo Pena
% Description: Campaign
%
% Function:
% main(input_param, output_name);
%
% Parameters:
% input_param list: "param_DOA", "param_TDOA", "param_TDOA_GMM_analysis", "param_TDOA_alpha_stable_analysis", "param_TDOA_samples_number_analysis"
% output_name: output name

clear
clc

addpath(genpath('algorithms'));
addpath(genpath('aux_codes'));
addpath(genpath('distortion_models'));
addpath(genpath('didactical_codes'));
addpath(genpath('simulations'));
addpath(genpath('simulations'));

main("param_TDOA_GMM_analysis", "TDOAgmm");
main("param_TDOA_GMM_analysis", "TDOAgmm");
