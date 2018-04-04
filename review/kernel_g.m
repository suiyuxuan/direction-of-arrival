function G = kernel_g(x,xi,sigma)

d = 1;

K = 1/((2*pi*sigma^2)^(d/2));

G = K * exp(- ((abs(x-xi)^2) / (2*sigma^2)));

end