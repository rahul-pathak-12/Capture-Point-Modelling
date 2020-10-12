path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\STEP_MODELLING_PROCESSED\"; 

myfiles = dir(path);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
files=filenames(endsWith(filenames,'.csv'));
folders=filefolders(endsWith(filenames,'.csv'));
all_files=fullfile(folders,files);
dimensions = size(files);

dst_to_cp = [];
step_vel = [];
step_length = [];
total_cp = [];
acc = [];


for x = 1:dimensions(1)-1
    data = tdfread( all_files{x} );
    buffer = 20 ;
    start_I = 1;
    end_I = 0;
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );
    total_cp = [ total_cp; comx_cp ];
    
    for i=1:5000
        if (i < 4800)
            if (abs(data.toes_l_X(i) - data.toes_r_X(i)) < 0.01) 
                end_I = i+buffer;
                rheel = ( data.talus_r_X( start_I:end_I+buffer) );
                rheel = rheel - rheel(1);

                lift = rheel(1);
                plateau = find_plateau( rheel );
                landing = rheel(plateau);

                step_length_vel = landing-lift;
                step_length = [ step_length; step_length_vel ];

                dst_to_cp_val =  comx_cp(plateau) - rheel(plateau);
                dst_to_cp = [dst_to_cp; dst_to_cp_val];

                step_vel = [ step_vel; data.Speed(i)];

                start_I = end_I;
            end
        end
    end
end

scatter( step_vel, dst_to_cp ,3, '+') 
% plot( step_vel, dst_to_cp )
title( 'DISTANCE TO CP' ) 
xlabel('TREADMILL VELOCITY')
ylabel('DISTANCE TO CAPTURE POINT')
