
% Get information about what's inside your folder.
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 
myfiles = dir(path);

filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';

files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

dimensions = size(files);


RMSE_FOOT_MODEL = [];


for i = 1:dimensions(1)-2
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); 
    
    len = size( cp_vel );
    
    % recenter 
    data.talus_r_X = data.talus_r_X - data.talus_r_X(1);
    
    %normalise 
    data.talus_r_X = minmax(data.talus_r_X); 
    comx_cp = minmax( comx_cp );
    
    % Find Peak 
    [pks, locs] = findpeaks( data.talus_r_X ); 
    index = round(0.9*locs,0); 
    len = size(index);
  
    if len(1) > 1
        res = comx_cp( index(1) );
        X = comx_cp;
        OUR_MODEL = mean(FOOT_PLACEMENT_TREE.predictFcn(X)) ;
        
        TRUTH = res;
        RMSE_FOOT_MODEL = sqrt(immse( TRUTH, OUR_MODEL)); 
    end
    
    if len(1) == 1
        res = comx_cp(index);
        X = comx_cp;
        TRUTH = res;
        
        OUR_MODEL = mean(FOOT_PLACEMENT_TREE.predictFcn(X)) ; 
        RMSE_FOOT_MODEL = sqrt(immse( TRUTH, OUR_MODEL)); 
    end
    
end

% QUADRATIC RMSE: 0.0061
% LINEAR RMSE: 0.0061
% TREE RMSE: 0.0105
mean( RMSE_FOOT_MODEL )
