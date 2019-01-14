%% Covariância
% Danilo Pena

function C = covariancia(x,y)

if length(x)~=length(y)
    error('Os dois vetores devem possuir mesma dimensão!');
end

C = 0;
n = length(x);

for i=1:n
    C = C + (x(i)-mean(x))*(y(i)-mean(y));
end
C = (1/(n-1))*C;

% for i=1:n
%     for j=i:n
%         C = C + (x(i)-x(j))*(y(i)-y(j));
%     end
% end
% C = (1/n^2)*C;

end