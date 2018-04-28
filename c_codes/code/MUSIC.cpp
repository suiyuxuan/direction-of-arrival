/*
Federal University of Rio Grande do Norte
Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
Author: Danilo Pena
Desc: MUSIC (MUltiple SIgnal Classification) - Implementação do MUSIC em C++
*/

#include <stdio.h>
// TODO: Create results.h

//Results::results(){};

//Results MUSIC(float *x, int P, float fc, int d){
int main(float *x, int P, float fc, int d){

//Results pMusic;
int pMusic;
int u = 340; // speed of sound

//[M,N] = size(x);                % M - numero de elementos, N - total de samples

// Calculo dos autovalores e autovetores
//Rx = x*x';                      % Matriz covariancia dos dados
//[AV,V] = eig(Rx);               % Autovetores e Autovalores de R respectivamente
//NN = AV(:,1:M-P);               % Selecionando subespaço do ruido (M - P)

// MUSIC
//theta = 0:0.5:90;               % Varredura do grid de angulo
//pMusic = zeros(1,length(theta));

/*for ii = 1:length(theta)
    SS = zeros(1,length(M));	% Subespaço do sinal com P dimensoes
        for jj = 0:M-1
            SS(1+jj) = exp(-(1i*2*jj*pi*fc*d*sin(theta(ii)/180*pi))/u);
        end
    PP = SS*NN*NN'*SS';
    pMusic(ii) = abs(1/PP);
end*/

//pMusic = 10*log10(pMusic/max(pMusic));

pMusic = 0;

// TODO: Return theta too
return pMusic;
}
