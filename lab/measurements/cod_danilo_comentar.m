f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); ...
    fft(x(5,:)); fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); ...
    fft(x(9,:)); fft(x(10,:))]; 

f(:,1) = 0;

k_freq = 2000; % equivalente a 1kHz

%abs(f(1,k_freq))
angle(f(2,k_freq))

sigma = 5;
theta = 90 - sigma;
theta = theta*(pi/180);

d = 0.08;
f2 = 1000;
u = 340;

tau = (d*2*pi*f2*sin(theta))/u;
