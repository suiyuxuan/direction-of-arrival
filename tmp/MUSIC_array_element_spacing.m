clc

clear all

format long

N=200;

doa=[20 60]/180*pi;

w=[pi/4 pi/3]';

M=10;

P=length(w);

lambda=150;

d=lambda/6; %Element Spacing

snr=20;

D=zeros(P,M);

for k=1:P

D(k,:)=exp(-j*2*pi*d*sin(doa(k))/lambda*[0:M-1]);

end

D=D';

xx=2*exp(j*(w*[1:N]));

x=D*xx;

x=x+awgn(x,snr);

R=x*x';

[N,V]=eig(R);

NN=N(:,1:M-P);

theta=-90:0.5:90;

for ii=1:length(theta)

SS=zeros(1,length(M));

for jj=0:M-1

SS(1+jj)=exp(-j*2*jj*pi*d*sin(theta(ii)/180*pi)/lambda);

end

PP=SS*NN*NN'*SS';

Pmusic(ii)=abs(1/ PP);

end

Pmusic=10*log10(Pmusic/max(Pmusic));

plot(theta,Pmusic ,'--k','linewidth',2.0)

hold on

%% 
clc

clear all

format long

N=200;

doa=[20 60]/180*pi;

w=[pi/4 pi/3]';

M=10;

P=length(w);

lambda=150;

d=lambda/2;%Element Spacing

snr=20;

D=zeros(P,M);

for k=1:P

38

D(k,:)=exp(-j*2*pi*d*sin(doa(k))/lambda*[0:M-1]);

end

D=D';

xx=2*exp(j*(w*[1:N]));

x=D*xx;

x=x+awgn(x,snr);

R=x*x';

[N,V]=eig(R);

NN=N(:,1:M-P);

theta=-90:0.5:90;

for ii=1:length(theta)

SS=zeros(1,length(M));

for jj=0:M-1

SS(1+jj)=exp(-j*2*jj*pi*d*sin(theta(ii)/180*pi)/lambda);

end

PP=SS*NN*NN'*SS';

Pmusic(ii)=abs(1/ PP);

end

Pmusic=10*log10(Pmusic/max(Pmusic));

plot(theta,Pmusic,'k','linewidth',1.0)

hold on

%%
clc

clear all

format long

N=200;

doa=[20 60]/180*pi;

w=[pi/4 pi/3]';

M=10;

P=length(w);

lambda=150;

d=lambda;%Element Spacing

snr=20;

D=zeros(P,M);

for k=1:P

D(k,:)=exp(-j*2*pi*d*sin(doa(k))/lambda*[0:M-1]);

end

D=D';

xx=2*exp(j*(w*[1:N]));

x=D*xx;

x=x+awgn(x,snr);

R=x*x';

[N,V]=eig(R);

NN=N(:,1:M-P);

theta=-90:0.5:90;

for ii=1:length(theta)

SS=zeros(1,length(M));

for jj=0:M-1

SS(1+jj)=exp(-j*2*jj*pi*d*sin(theta(ii)/180*pi)/lambda);

end

PP=SS*NN*NN'*SS';


Pmusic(ii)=abs(1/ PP);

end

Pmusic=10*log10(Pmusic/max(Pmusic));

plot(theta,Pmusic,'-.k','linewidth',0.1)

hold off

xlabel('angle \theta/degree')

ylabel('spectrum function P(\theta) /dB')

title('DOA estimation based on MUSIC algorithm')

grid on