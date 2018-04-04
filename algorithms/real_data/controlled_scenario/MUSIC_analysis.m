% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% MUSIC Analysis
% Descricao: Analisa a curva pMUSIC de dados aquisitados

clear all

filename = 'Voltage.tdms';
my_tdms_struct = TDMS_getStruct(filename);

variables = fieldnames(my_tdms_struct);

x = [my_tdms_struct.(variables{2}).Dev1_ai0.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai1.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai2.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai3.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai4.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai5.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai6.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai7.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai8.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai9.data];

x = flipud(x); % Invertendo a ordem dos elementos (pois estão invertidos na mesa)

for n=1:10
    x(n,:) = (x(n,:)-mean(x(n,:))); % Removendo nivel DC
end

[theta,pMusic] = MUSIC(x, 1, 1000, 0.08); % x, P, f, d
plot(90-theta,pMusic)