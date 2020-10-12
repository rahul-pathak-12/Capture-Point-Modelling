import shutil
from os import listdir
from os.path import isfile, join

DESTINATION = "C:\\Users\\User\\Desktop\\RAW_DATA\\SEG\\"
num_person = [ '2' ]

for person in num_person: 
    loc = "C:\\Users\\User\\Desktop\\OpenSim-complete\\S"+str(person)+"\\segmentation\\"
    directories = [f for f in listdir(loc) ]

    for dir in directories: 
        filepath = loc + dir 
        file_dir = [f for f in listdir(filepath) ]
        
        for fdir in file_dir: 
            path = filepath +"\\" +fdir + "\\BK\\" + "Analysis_BodyKinematics_pos_global.sto"
            new_name = person + "_" + dir[-3:] +"_"+fdir + "_"+"Analysis_BodyKinematics_pos_global.sto"
            
            cp_path = DESTINATION + new_name
            shutil.copy2(path, cp_path) # complete target filename given
