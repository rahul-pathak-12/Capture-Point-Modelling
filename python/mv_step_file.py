import shutil
from os import listdir
from os.path import isfile, join
import pandas as pd

DIR_ORIGIN = "C:\\Users\\User\\Desktop\\RAW_DATA\\\STEP_MODELLING\\" 
DIR_DEST = "C:\\Users\\User\\Desktop\\RAW_DATA\\\STEP_MODELLING_PROCESSED\\"
files = [ f for f in listdir(DIR_ORIGIN) ]
num_person = [ '3', '4', '5', '6', '7', '8', '9' ]

#This is V_SACRAL -> X1 in the file
leg_length = { 
                  '3': 1.0372605,
                  '4': 1.0227856,
                  '5': 1.0670828,
                  '6': 1.0213803,
                  '7': 0.97300665,
                  '8': 0.91221417,
                  '9': 0.93919006,
            }

for person in num_person: 
    loc = "C:\\Users\\User\\Desktop\\RAW_DATA\STEP_MODELLING\\"+str(person)+"\\"
    directories = [f for f in listdir(loc) ]

    speed_files = []
    bk_files = []

    for dir in directories: 
        file = loc + dir 

        if "speed" in file:
            speed_files.append( file )
        else: 
            bk_files.append( file )

    num_files = len( speed_files )
    for i in range(num_files): 
            sfile = speed_files[i]
            bkfile = bk_files[i]
            nfirstlines = []

            with open( sfile ) as sf, open( bkfile ) as bf:
                dfs = pd.read_csv( sfile, sep='\t' )
                dfbk = pd.read_csv( bkfile, sep='\t' )

                rows = dfbk.shape[0]

                subj = bkfile[ 46 ]
                height = leg_length[ subj ]
                leg_length_update = [height] * rows
                dfbk["LEG_LENGTH"] = leg_length_update

                comx = dfbk["center_of_mass_X"][0]
                comx_values = dfbk["center_of_mass_X"] - comx
                dfbk["ADJ_COMX"] = comx_values

                speed = dfs["Speed"][0]
                speed = dfs["Speed"]
                dfbk["Speed"] = speed

                tpath = DIR_DEST + subj + "_"+ str(i) +"_processed_sp_bk.csv"
                print(tpath)
                dfbk.to_csv( tpath, sep='\t', index_label = 'N' )

        # path = filepath +"\\" +fdir + "\\BK\\" + "Analysis_BodyKinematics_pos_global.sto"
        # new_name = person + "_" + dir[-3:] +"_"+fdir + "_"+"Analysis_BodyKinematics_pos_global.sto"
        
        # cp_path = DESTINATION + new_name
        # shutil.copy2(path, cp_path) # complete target filename given
