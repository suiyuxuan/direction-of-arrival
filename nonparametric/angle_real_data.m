%% --- Parameters ---

AngPar.nArrayElements = 10;               % Array elements                     
AngPar.nSources = 1;                      % Sources
AngPar.Window = 1;                        % Type Window
AngPar.Fsignal = 1000;                    % Signal Frequency (Hz)
AngPar.DistanceMicrophones = 0.08;        % Distance between microphones (m)
AngPar.PropagationVelocity = 340;         % Propagation Velocity
%% --- Folder to save results ---
folderName = 'results';

mkdir(folderName);

homeDir = pwd;

save([folderName filesep 'AngPar_' folderName '.mat'], 'AngPar');

%% --- Code --- 

x = x(:,1:80000);

for P = AngPar.nSources
   for M = AngPar.nArrayElements
     for u = AngPar.PropagationVelocity
       for win = AngPar.Window
         for f = AngPar.Fsignal
           for d = AngPar.DistanceMicrophones
              for cont=1:100                                  
                   snpc = x(:,(1+((cont-1)*800)):(cont*800));
                     %% --- Calling the function 
                     vec_ang(cont) = calcule_angle(snpc,P,f,d,u,M,win);
              end                                   
                ang = mean(vec_ang);
                %% --- Save folder
                   save([folderName filesep 'Ang_window_' num2str(win) '_Fsignal_' num2str(AngPar.Fsignal) '_nSources_'  num2str(P) '.mat'],'ang');                                        
                   disp(['Saved in Ang_window_' num2str(win) '_Fsignal_' num2str(AngPar.Fsignal) '_nSources_'  num2str(P) '.mat'])
                   clear V  
           end       
         end                                             
       end
     end
   end
end

save([folderName filesep 'AngPar_' folderName '.mat'], 'AngPar');
