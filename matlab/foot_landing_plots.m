% Get information about what's inside your folder.
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 
myfiles = dir(path);

filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';

files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

dimensions = size(files);
% dimensions = 3; % 1 file

dst_to_cp = [];
step_vel = [];
step_length = [];
acc = [];
treadmill_speeds = [];

for i = 1:dimensions(1)-2
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); % 
    
    rheel = ( data.talus_r_X );
    rheel = rheel - rheel(1);
    
    lift = rheel(1);
    plateau = find_plateau( rheel );
    landing = rheel(plateau);
    
    step_length_vel = landing-lift;
    acc_vel = mean(diff( cp_vel ) ./ 0.01 );
    
    if acc_vel < 0
        velocity_val  = mean(cp_vel); 
        treadmill_speeds = [ treadmill_speeds; round(mean(cp_vel),1) ];
        dst_to_cp_val =  comx_cp(plateau) - rheel(plateau);
        dst_to_cp = [dst_to_cp; dst_to_cp_val];
        step_vel = [ step_vel; velocity_val];
        step_length = [ step_length; step_length_vel ];
        acc = [ acc; acc_vel ];
    end
end


%scatter( step_vel, dst_to_cp, 2, '.' )
%hold on
scatter( acc, dst_to_cp, 2, '.' )
hold on
scatter(  treadmill_speeds, dst_to_cp, 2, '.' )
title( 'DISTANCE TO CP' )
xlabel('VELOCITY')
ylabel('DISTANCE TO CAPTURE POINT')
