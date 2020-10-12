path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 
myfiles = dir(path);

filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';

files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

files = 1;

weights = [];

for i = 1:files
    data = tdfread( all_files{12+i} );
    weights_from_run = cm_optimisation( data );
    
    weights = [ weights; weights_from_run ];
end

weights