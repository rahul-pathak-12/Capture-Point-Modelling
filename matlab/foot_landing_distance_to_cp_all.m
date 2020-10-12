path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\STEP_MODELLING_PROCESSED\"; 

myfiles = dir(path);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
files=filenames(endsWith(filenames,'.csv'));
folders=filefolders(endsWith(filenames,'.csv'));
all_files=fullfile(folders,files);
dimensions = size(files);

dst_to_cp =[];
trial = [];
velocity = []; 


for x = 1:dimensions(1)-1
    data = tdfread( all_files{x} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );
    d =  (data.center_of_mass_Z .* data.talus_r_X); % Enhance Peaks
    [pks, locs] = findpeaks( d ); 
    val = round(mean(diff(locs)), 0);
    index = locs - round((val/1.1),0) + round((val/1.8),0); 
    
    % index_range = index(end-10+1:end); % last 10 gait cycles
    index_range = index(2:end);
    dst_to_cp_values =  abs(minmax(comx_cp(index_range)) - minmax(data.talus_r_X(index_range)));
    dst_to_cp_val = mean(dst_to_cp_values);
    
    trial_fullname = erase(all_files{x}, path);
    trial_val = regexprep(trial_fullname,'_processed(.+)csv','');
    
    dst_to_cp = [dst_to_cp; dst_to_cp_val];
    trial = [trial; trial_val];
    
    velocity_val = mode( data.Speed );
    velocity = [ velocity; velocity_val ];
end

figure(1)
scatter( velocity, minmax(dst_to_cp), 4,'+' )
title( 'DISTANCE TO CP VS. VELOCITY ALL' ) 
xlabel('Velocity')
ylabel('Mean Distance to CP ')
saveas(gcf,'C:\Users\User\Desktop\graphs\ALL_VEL_DSTTOCP_MEAN.pdf')

% 
% figure(1)
% scatter( velocity(1:10), dst_to_cp(1:10), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 3' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP ')
% saveas(gcf,'C:\Users\User\Desktop\graphs\3.pdf')

% figure(2)
% scatter( velocity(11:20), dst_to_cp(11:20), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 4' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\4.pdf')
% 
% figure(3)
% scatter( velocity(21:30), dst_to_cp(21:30), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 5' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\5.pdf')
% 
% figure(4)
% scatter( velocity(31:40), dst_to_cp(31:40), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 6' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\6.pdf')
% 
% figure(5)
% scatter( velocity(41:50), dst_to_cp(41:50), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 7' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\7.pdf')
% 
% figure(6)
% scatter( velocity(51:60), dst_to_cp(51:60), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 8' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\8.pdf')
% 
% figure(7)
% scatter( velocity(60:end), dst_to_cp(60:end), 4,'+' )
% title( 'DISTANCE TO CP VS. VELOCITY 9' ) 
% xlabel('Velocity')
% ylabel('Mean Distance to CP')
% saveas(gcf,'C:\Users\User\Desktop\graphs\9.pdf')

% plot(dst_to_cp)
% title( 'DISTANCE TO CP' ) 
% xlabel('INDEX')
% ylabel('DISTANCE TO CAPTURE POINT')
% 
% 
% plot( data.talus_r_X )
% hold on
% plot( index(2:end), data.talus_r_X(index(2:end)), '+' )
% hold on
% plot( comx_cp )
% legend( 'Talus X', 'Step Location', 'Capture Point' )
% title( 'Step Location' ) 
% xlabel('INDEX')
% ylabel('STEP LOCATIONS')

