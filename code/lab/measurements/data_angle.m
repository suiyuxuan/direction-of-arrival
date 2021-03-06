%% Parametros iniciais
delta1 = 5; % distancia em linha reta em relacao aos sensores
angulo = 45; % em graus

%% Determinar o angulo atraves da distancia
delta2 = 0; % distancia perpendicular em relacao aos sensores

theta = atan(delta2/delta1)*(180/pi);

%% Determinar a distancia atraves do angulo
theta = angulo*(pi/180); % em rad

delta2 = tan(theta)*delta1;

%% Carregar X

filename = 'Voltage.tdms';
my_tdms_struct = TDMS_getStruct(filename);

n = my_tdms_struct.Props.samples_prepared_for_viewing;

variables = fields(my_tdms_struct);

x = [my_tdms_struct.(variables{2}).Dev1_ai0.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai1.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai2.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai3.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai4.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai5.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai6.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai7.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai8.data; ...
    my_tdms_struct.(variables{2}).Dev1_ai9.data];


x = flipud(x);                  % Invertendo a ordem dos elementos (pois est�o invertidos na mesa)
for n=1:10
    x(n,:) = (x(n,:)-mean(x(n,:))); % Removendo nivel DC
end

%% Espectro de X

%x = flipud(x);
f = [fft(x(1,:)); fft(x(2,:)); fft(x(3,:)); fft(x(4,:)); fft(x(5,:)); ...
    fft(x(6,:)); fft(x(7,:)); fft(x(8,:)); fft(x(9,:)); fft(x(10,:))];
%f = [fft(x(10,:)); fft(x(9,:)); fft(x(8,:)); fft(x(7,:)); fft(x(6,:)); ...
%    fft(x(5,:)); fft(x(4,:)); fft(x(3,:)); fft(x(2,:)); fft(x(1,:))];

f(:,1) = 0;

plot(abs(f(1,:)))

% nfreq = (n/10)+1;
%plot(abs(f(1,:)))
nfreq = find(max((f(1,:)))==(f(1,:)));

ph(1) = angle(f(1,nfreq));
ph(2) = angle(f(2,nfreq));
ph(3) = angle(f(3,nfreq));
ph(4) = angle(f(4,nfreq));
ph(5) = angle(f(5,nfreq));
ph(6) = angle(f(6,nfreq));
ph(7) = angle(f(7,nfreq));
ph(8) = angle(f(8,nfreq));
ph(9) = angle(f(9,nfreq));
ph(10) = angle(f(10,nfreq));

%ph = flipud(ph); % Se a medicao for a partir do ultimo sensor

%% Diferenca de fase conhecida
%theta = 0;

d = .08;
w = 2*pi*1000;
theta1 = 90-theta;

tau = (d*w.*sin(theta1.*(pi/180)))/340;
tauc = -[0:9]*tau;
tauc = wrapToPi(tauc)

tau = ones(1,9)*tau;

%% Diferenca de fase de Fourier

for k=1:9
    delta(k) = angdiff(ph(k+1),ph(1));
end
delta = -wrapToPi(delta)

%immse(deltac,tauc)

%% Plots

tau = delta.*(180/pi);

hold on
plot(angle(f(1,:)),'k')
plot(angle(f(2,:)),'b')
plot(angle(f(3,:)),'m')
plot(angle(f(4,:)),'r')
plot(angle(f(5,:)),'c')
plot(angle(f(6,:)),'g')
plot(angle(f(7,:)),'y')
plot(angle(f(8,:)),'w')

hold on
%plot(x(1,7000:7100),'k')
plot(x(2,7000:7100),'b')
plot(x(3,7000:7100),'m')
plot(x(4,7000:7100),'r')
plot(x(5,7000:7100),'c')
plot(x(6,7000:7100),'g')
plot(x(7,7000:7100),'y')
plot(x(8,7000:7100),'k')


%%
% Tentativa de sintetizar dados com angulo conhecido utilizando amostras
% de dados reais

colorspec = {[0 0 0]; [0.1 0.1 0.1]; [0.2 0.2 0.2]; [0.3 0.3 0.3]; [0.4 0.4 0.4]; [0.5 0.5 0.5]; [0.6 0.6 0.6]; [0.7 0.7 0.7]; [0.8 0.8 0.8]; [0.9 0.9 0.9]};
hold on
for i=1:10
    plot(y(i,:),'Color', colorspec{i})
end

f = [fft(x(10,100000:100399)); fft(x(9,100000:100399)); fft(x(8,100000:100399)); ...
    fft(x(7,100000:100399)); fft(x(6,100000:100399)); ...
    fft(x(5,100000:100399)); fft(x(4,100000:100399)); ...
    fft(x(3,100000:100399)); fft(x(2,100000:100399)); fft(x(1,100000:100399))];

f = [fft(x(10,100001:200000)); fft(x(9,100001:200000)); fft(x(8,100001:200000)); ...
    fft(x(7,100001:200000)); fft(x(6,100001:200000)); ...
    fft(x(5,100001:200000)); fft(x(4,100001:200000)); ...
    fft(x(3,100001:200000)); fft(x(2,100001:200000)); fft(x(1,100001:200000))];

f(:,1) = 0;

f(:,1:2000) = 0;
f(:,2002:398000) = 0;
f(:,398002:end) = 0;

f(1,2001)=exp(-j*tau);
for i=2:10
f(i,2001)=exp(-j*i*tau);
end
f(1,398001)=exp(j*tau);
for i=2:10
f(i,398001)=exp(j*i*tau);
end

f(1,2001)=abs(f(1,2001))*exp(-j*ph(1));
for i=2:10
f(i,2001)=abs(f(i,2001))*exp(-j*(ph(i-1)-((i-1)*tau)));
end
f(1,398001)=abs(f(1,398001))*exp(j*tau);
for i=2:10
f(i,398001)=abs(f(i,398001))*exp(j*(ph(i-1)-((i-1)*tau)));
end

xn = [ifft(f(1,:)); ifft(f(2,:)); ifft(f(3,:)); ifft(f(4,:)); ifft(f(5,:)); ...
    ifft(f(6,:)); ifft(f(7,:)); ifft(f(8,:)); ifft(f(9,:)); ifft(f(10,:))];

%f = fliplr(f);

% f(1,:) = fx(10,:);
% f(2,:) = fx(9,:);
% f(3,:) = fx(8,:);
% f(4,:) = fx(7,:);
% f(5,:) = fx(6,:);
% f(6,:) = fx(5,:);
% f(7,:) = fx(4,:);
% f(8,:) = fx(3,:);
% f(9,:) = fx(2,:);
% f(10,:) = fx(1,:);

x(10,:) = [zeros(1,408) x(10,1:end-408)];

for i = 1:9
    x(i+1,:) = [zeros(1,47) x(i,1:end-47)];
end
