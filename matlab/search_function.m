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
end

pos = data.ADJ_COMX;
vel = diff(pos)/(1/100);
acc = diff(vel)/(1/100);

init = [pos(1);
        vel(1);
        acc(1)];
    
 xgrid = linspace( 1, 10, 10)
 ygrid = linspace( 1, 2, 10)

  
 for i = xgrid 
     for j = ygrid
         w = [ i, j ];
         run_sim_sin( w , init, vel) ;
     end
 end