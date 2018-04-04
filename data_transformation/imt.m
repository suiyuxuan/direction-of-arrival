% Universidade Federal do Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Arthur Diego de Lira Lima / Danilo Pena
% Descricao: aplica a transformacao de modulo inversao a um sinal (real ou
% complexo)

% x: sinal de entrada (ruidoso, impulsivo)
% y: sinal transformado (ruidoso "gaussianizado")
function y = imt(x)


if(isreal(x))
    y = -sign(x).*( (abs(x)+1).^-1 - 1  );
else
    y = -sign(real(x)).*( (abs(real(x))+1).^-1 - 1  )  ...
        -1j*sign(imag(x)).*( (abs(imag(x))+1).^-1 - 1  );
end

end