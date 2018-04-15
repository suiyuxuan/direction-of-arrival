%% LMS Números complexos
% Danilo Pena

N = 1000;
mu = 1;

for n=1:N
    
    e(n) = d(n) - conj(w(n))*r(n);
    
    R(n) = conj(r(n))*r(n);
    w(n+1) = w(n) + ((mu*e(n)*r(n)) / R(n));
    
end