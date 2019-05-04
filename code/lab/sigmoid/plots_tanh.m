x = -2:0.01:2;

x1 = abs(x);
x2 = abs(x);

xx = x1.*x2;

y1 = tanh(x1);
y2 = tanh(x2);

yy = y1.*y2;

%% Univariated plots
plot(x, x1)
hold on
plot(x, y1)
legend('x', 'y')

a1 = area(x,x1);
a1.FaceAlpha = 0.2;
a2 = area(x,y1);
a2.FaceAlpha = 0.2;



%aa = patch('XData',x,'YData',x1);