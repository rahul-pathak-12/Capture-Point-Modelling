path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\STEP_MODELLING_PROCESSED\"; 

myfiles = dir(path);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
files=filenames(endsWith(filenames,'.csv'));
folders=filefolders(endsWith(filenames,'.csv'));
all_files=fullfile(folders,files);
dimensions = size(files);

dst_to_cp =[];
velocity = []; 
time_last_step = [];
comx_cp_vals = [];

for x = 1:dimensions(1)-1
    data = tdfread( all_files{x} );
    height = data.LEG_LENGTH(1);
    speed = data.Speed( 4000 );
    
    % if speed < 0.8
        [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );
        comx_cp_vals = [comx_cp_vals; comx_cp];
        d =  (data.center_of_mass_Z .* data.talus_r_X); % Enhance Peaks
        [pks, locs] = findpeaks( d ); 
        val = round(mean(diff(locs)), 0);
        index = locs - round((val/1.1),0) + round((val/1.8),0); 

        index_range = index(2:end); % last N gait cycles
        dst_to_cp_val =  (comx_cp(index_range) - data.talus_r_X(index_range)) ; % Div by height wont make sense if its minmax would it? 

        trial_fullname = erase(all_files{x}, path);
        trial_val = regexprep(trial_fullname,'_processed(.+)csv','');

        velocity_val = mode( data.Speed );
        velocity = [ velocity; velocity_val ];

        len = size(index_range);
        time_last_step_val = diff( data.time(index_range) ) ./ len(1) ; % divided  by index range
        time_last_step = [time_last_step; time_last_step_val];
        scatter( time_last_step_val, dst_to_cp_val(2:end), 4,'+' );
    % end
end

scatter( time_last_step, dst_to_cp, 4,'+' );
hold on
title( 'DISTANCE TO CP VS. VELOCITY' ) 
xlabel('Time since last step')
ylabel('Distance to CP ')

%path = 'C:\Users\User\Desktop\graphs\graph_ALL_MINMAXDIFF_MINMAXSTEPTIME';
%saveas(gcf, strcat(path,'.pdf'))  


% plot(dst_to_cp)
% title( 'DISTANCE TO CP' ) 
% xlabel('INDEX')
% ylabel('DISTANCE TO CAPTURE POINT')
 
% plot( data.talus_r_X )
% hold on
% plot( index(2:end), data.talus_r_X(index(2:end)), '+' )
% hold on
% plot( comx_cp )
% legend( 'Talus X', 'Step Location', 'Capture Point' )
% title( 'Step Location' ) 
% xlabel('INDEX')
% ylabel('STEP LOCATIONS')

