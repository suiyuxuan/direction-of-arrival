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



