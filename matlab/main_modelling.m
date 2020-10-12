
% path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TRAIN\"; 
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 

myfiles = dir(path);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

dimensions = size(files);

x1 = [];
x2 = [];
x3 = [];
x4 = [];
Y = [];

for i = 1:dimensions(1)-1
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); 
    
    len = size( cp_vel );
    initial_pos = minmax( data.ADJ_COMX );
    initial_vel = minmax( cp_vel );
    data.talus_r_X = data.talus_r_X - data.talus_r_X(1);
    talus_r = minmax( data.talus_r_X );
    %initial_pos = data.ADJ_COMX;
    %initial_vel = cp_vel;
    
    x1 = [ x1; initial_pos(2) .* ones(len(1),1) ] ;
    x2 = [ x2; initial_vel(1) .* ones(len(1),1) ];
    x3 = [ x3; data.N(2:end) ];
    x4 = [ x4; talus_r(2:end) ];
    Y =  [ Y;  cp_vel ];
    
   % x1 = [ x1; minmax( data.toes_r_X(2:end) ) ] ;
   % x2 = [ x2; minmax( data.toes_l_X(2:end) ) ] ;
   % x3 = [ x3; minmax( data.pelvis_X(2:end) ) ] ;
   % Y =  [ Y; minmax( comx_cp ) ]; 
end

% X = [ x1 x2 x3 x4 ];
% ALL = [ x1 x2 x3 x4 Y ];

% X = [ x1 x2 x3 ];
% ALL = [ x1 x2 x3 Y ];

% CREATE TRAINING DATA FOR PYTHON
ALL = [ x4 ];
csvwrite('NORM_TRAINING_FOOT_NEW_TEST.csv', ALL)

