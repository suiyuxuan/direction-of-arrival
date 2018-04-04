clear all

filename = 'Voltage.tdms';
my_tdms_struct = TDMS_getStruct(filename);

variables = fieldnames(my_tdms_struct);

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

x = flipud(x); % Invertendo a ordem dos elementos (pois estão invertidos na mesa)

for n=1:10
    x(n,:) = (x(n,:)-mean(x(n,:))); % Removendo nivel DC
end

[theta,pMusic] = MUSIC(x, 1, 1000, 0.08);
plot(90-theta,pMusic)

% for n = 1:10
%     x(n,:) = x(n,:)./max(x(n,:));
% end

% for n = 1:499
%     xn = x(:,n*400:(n*400)+400);
%     [theta,pMusic(n,:)] = MUSIC(xn, 1, 500, 0.08);
% end
% surf(90-theta, 1:499, pMusic)