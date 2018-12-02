% Federal University of Rio Grande do Norte
% Programa de Pos-Graduacao em Engenharia Eletrica e de Computacao
% Arthur Diego de Lira Lima / Danilo de Santana Pena
% Descricao: aplica a transformacao de modulo inversao a um sinal (real ou
% complexo)
% Parameters:
% x: sinal de entrada (ruidoso, impulsivo)
% y: sinal transformado (ruidoso "gaussianizado")

function y = imt(x)

[M,N] = size(x);
y = zeros(M,N);

for i=1:M

    if(isreal(x(i,:)))
        y(i,:) = -sign(x(i,:)).*( (abs(x(i,:))+1).^-1 - 1  );
    else
        y(i,:) = -sign(real(x(i,:))).*( (abs(real(x(i,:)))+1).^-1 - 1  )  ...
            -1j*sign(imag(x(i,:))).*( (abs(imag(x(i,:)))+1).^-1 - 1  );
    end
    
end

end