% Federal University of Rio Grande do Norte
% Title: Sigmoid Functions
% Author: Danilo Pena
% Description: Analysis of Sigmoid function (S-shaped curves)

x = [-5:0.01:5];

%% Delta analysis

delta = [0.5, 0.8, 1, 1.3, 1.5]; % > 0

y(1,:) = (1+exp(-x)).^(-delta(1));
y(2,:) = (1+exp(-x)).^(-delta(2));
y(3,:) = (1+exp(-x)).^(-delta(3));
y(4,:) = (1+exp(-x)).^(-delta(4));
y(5,:) = (1+exp(-x)).^(-delta(5));

plot(x,y(1,:))
hold on
plot(x,y(2,:),'r')
plot(x,y(3,:),'g')
plot(x,y(4,:),'k')
plot(x,y(5,:),'c')
legend('\delta = 0.5', '\delta = 0.8', '\delta = 1.0', '\delta = 1.3', '\delta = 1.5')

%% Known functions

y_tanh = tanh(x);
y_sgn = sign(x);
y_gd = (2/pi) * asin( tanh(x * pi /2) );
y_mod = sign(x).*(1 - (1./(abs(x)+1)));
y_alg = x ./ real(sqrt(1 + x.^2));
y_erf = erf(x * sqrt(pi) / 2 );

plot(x,y_tanh)
hold on
plot(x,y_sgn,'r')
plot(x,y_gd,'g')
plot(x,y_mod,'c')
plot(x,y_alg,'m')
plot(x,y_erf,'k')
legend('tanh', 'sgn', 'gd', 'mod', 'alg', 'erf');

%% Similarity comparison

x1 = [-2:0.01:2];
x2 = [-2:0.01:2];
z = x1'*x2; % E[x_1(n) x_2(n-tau)]
w = tanh(x1)'*tanh(x2); % E[y_1(n) y_2(n-tau)]

figure (1)
surf(x1,x2,z)

figure (2)
surf(x1,x2,w)
