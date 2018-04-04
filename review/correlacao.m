%% Correlacão
% Danilo Pena

function C = correlacao(x,y)

if length(x)~=length(y)
    error('Os dois vetores devem possuir mesma dimensão!');
end

Cov = 0;
n = length(x);

for i=1:n
    Cov = Cov + (x(i)-mean(x))*(y(i)-mean(y));
end
Cov = (1/(n-1))*Cov;

C = Cov/(var(x)*var(y));

end