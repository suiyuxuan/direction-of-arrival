% --- AUTHOR(S) ---
% Carlos, Danilo, Mario, Matheus e Vicente  
% --- Labsim/Gppcom ---
% DEPARTAMENTO DE COMUNICAÇÕES - DCO UFRN

%% --- Fourier calculation for each microphone's signal ---

fr = [fft(x(10,:)); fft(x(9,:)); fft(x(8,:)); fft(x(7,:)); ...
    fft(x(6,:)); fft(x(5,:)); fft(x(4,:)); fft(x(3,:)); ...
    fft(x(2,:)); fft(x(1,:))]; 

fr(:,1) = 0;        %To remove the DC level

%% --- To find the index(k_freq) of the maximum peak(mass) for each microphone ---

for i=1:10
    [mass(i),k_freq(i)] = max(abs(fr(i,:))); 
end

%% --- To find the phase of each microphone

for i=1:10
    phases(i)=angle(fr(i,k_freq(i))); 
end

%% --- Signal delay --- %%

%Parameters
sigma = 30;                         %Angle of arrival
theta = 90 - sigma; 
theta = theta*(pi/180);             %Convert degree into rad
d = 0.08;                           %Distance of each microphone
f = 1000;                           %Signal Frequency
u = 340;                            %Sound Velocity

%Calculation
tau = (d*2*pi*f*sin(theta))/u;
