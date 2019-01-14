theta = [0:5:60];
thetarad = (theta*pi)/180;
hip=20;

xy = zeros(2,length(theta));

xy(1,:) = cos(thetarad(1,:))*hip;
xy(2,:) = sin(thetarad(1,:))*hip;

