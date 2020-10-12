
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
x2 = [];
Y = [];

for i = 1:dimensions(1)-1
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); 
    
    len = size( cp_vel );
    
    % recenter 
    data.talus_r_X = data.talus_r_X - data.talus_r_X(1);
    
    %normalise 
    data.talus_r_X = minmax(data.talus_r_X); 
    comx_cp = minmax( comx_cp );
    cp_vel = minmax( cp_vel );
    
    % Find Peak 
    [pks, locs] = findpeaks( data.talus_r_X ); 
    index = round( 0.9*locs, 0 ); 
    len = size(index);
    
    if len(1) > 1
        len =  size(comx_cp);
        res = ones(1, len(1))';
        res = res*comx_cp( index(1) );
        
        x1 = [ x1; comx_cp ] ;
    %    x2 = [ x2; cp_vel  ];
        Y = [ Y; res ] ;     
    end
    
    if len(1) == 1   
        len =  size(comx_cp);
        res = ones(1, len(1))';
        res = res*comx_cp(index);
        
        x1 = [ x1; comx_cp ] ;
     %   x2 = [ x2; cp_vel  ];
        Y = [ Y; res ] ;
    end

end

ALL = [ x1 x2 Y ];
% plot( index, data.talus_r_X(index), '+')

% CREATE TRAINING DATA FOR PYTHON
csvwrite('FOOT_MODELLING_TRAINING_PLACEMENT.csv', ALL)

time = linspace( 1, 342908, 342908 );