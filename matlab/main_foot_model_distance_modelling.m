
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TRAIN\"; 
%path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 

myfiles = dir(path);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

dimensions = size(files);

x1 = [];
Y = [];

for i = 1:dimensions(1)-1
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); 
    
    len = size( cp_vel );
    
    % recenter 
    data.talus_r_X = data.talus_r_X - data.talus_r_X(1);
    data.center_of_mass_Z = data.center_of_mass_Z - data.center_of_mass_Z(1);
    
    %normalise 
    data.talus_r_X = minmax(data.talus_r_X); 
    data.center_of_mass_Z = minmax( data.center_of_mass_Z );
    comx_cp = minmax( comx_cp );
    
    % Find Peak 
    [pks, locs] = findpeaks( data.talus_r_X ); 
    index = round(0.9*locs,0); 
    len = size(index);
    
    if len(1) > 1
        dst_to_cp_val =  (comx_cp(index(1)) - data.talus_r_X(index(1)) ) ; 
        x1 = [ x1; comx_cp( index(1) ) ] ;
        Y =  [ Y;  dst_to_cp_val ];
        plot(comx_cp)
        hold on
        plot(data.talus_r_X)
        hold on
        plot( index(1), comx_cp( index(1) ) - dst_to_cp_val, '+')
    end
    
    if len(1) == 1
        dst_to_cp_val =  (comx_cp(index) - data.talus_r_X(index)) ; 
        x1 = [ x1; comx_cp( index ) ] ;
        Y =  [ Y;  dst_to_cp_val ];
        plot(comx_cp)
        hold on
        plot(data.talus_r_X)
        hold on
        plot( index(1), comx_cp( index ) - dst_to_cp_val, '+')
    end

end

X = [ x1 ];
ALL = [ Y ];

% X = [ x1 x2 x3 ];
% ALL = [ x1 x2 x3 Y ];
% plot( index, data.talus_r_X(index), '+')
% CREATE TRAINING DATA FOR PYTHON
ALL = [ x1 Y ];
csvwrite('FOOT_MODELLING_TRAINING_X.csv', ALL)

time = linspace( 1, 342908, 342908 );