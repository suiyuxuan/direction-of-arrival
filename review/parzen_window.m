gw = gausswin(64);
pw = parzenwin(64);
wvtool(gw,pw)

%x = randn(1,1000);
%[f,xi] = ksdensity(x);
%figure
%plot(xi,f);