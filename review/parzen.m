%% Parzen
% Danilo Pena

clear

sigma = .2;
x = randn(1,100000);

[p,xi] = hist(x,100);
p = p/sum(p);

N = length(x);
N2 = length(xi);
N3 = 100;

p_ = zeros(1,N3);

for k=1:N3
    for i=1:N
        p_(k) = p_(k) + kernel_g(((k-1)/10),x(i),sigma);  
    end
    p_(k) = (1/(N*sigma)) * p_(k);
end

%P_ = fliplr(p_);
%P_ = [P_ p_];
%hist(x,100)
%figure,plot((-49:50)/10,P_(49:148))
