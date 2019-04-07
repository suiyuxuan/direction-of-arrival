% Federal University of Rio Grande do Norte
% Title: Campaign
% Author: Danilo Pena
% Description: Campaign
%
% Function:
% main(input_param, output_name);
%
% Parameters:
% input_param list:
% DOA - "param_DOA", "param_DOA_GMM_analysis", "param_DOA_alpha_stable_analysis", 
%"param_DOA_samples_number_analysis"
% TDOA - "param_TDOA", "param_TDOA_GMM_analysis", "param_TDOA_alpha_stable_analysis", 
%"param_TDOA_samples_number_analysis", "param_TDOA_demo_chirp"
% output_name: output name

clear
clc

addpath(genpath('algorithms'));
addpath(genpath('aux_codes'));
addpath(genpath('distortion_models'));
addpath(genpath('didactical_codes'));
addpath(genpath('simulations'));

main("param_TDOA", "TDOA");
%main("param_TDOA_alpha_stable_analysis", "TDOA_alpha");
%main("param_TDOA_GMM_analysis", "TDOA_GMM");
% main("param_DOA", "DOA");
% main("param_DOA_alpha_stable_analysis", "DOA_alpha");
% main("param_DOA_GMM_analysis", "DOA_GMM");
% main("param_DOA_samples_number_analysis", "DOA_samples_number");
