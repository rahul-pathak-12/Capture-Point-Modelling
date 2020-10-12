import os 
from os import listdir
from os.path import isfile, join
from sklearn import preprocessing
import numpy as np
import pandas as pd

VERSION = "TRAIN"
DIR_ORIGIN = "C:\\Users\\User\\Desktop\\RAW_DATA\\\STEP_MODELLING\\" + VERSION + "\\"
DIR_DEST = "C:\\Users\\User\\Desktop\\RAW_DATA\\\STEP_MODELLING_PROCESSED\\" + VERSION + "\\"
files = [ f for f in listdir(DIR_ORIGIN) ]

#This is V_SACRAL -> X1 in the file
leg_length = { 
                  '2': 0.88392578,
                  '3': 1.0372605,
                  '4': 1.0227856,
                  '5': 1.0670828,
                  '6': 1.0213803,
                  '7': 0.97300665,
                  '8': 0.91221417,
                  '9': 0.93919006,
            }

for file in files: 
    fpath = DIR_ORIGIN + file
    tpath = DIR_DEST + "ADJ_" + file

    nfirstlines = []

    with open( fpath ) as f:
      df = pd.read_csv( fpath, sep='\t' )

      mean = df["center_of_mass_Y"].mean()
      rows = df.shape[0]
      mean_update = [mean] * rows
      df["AVERAGE_COMY"] = mean_update

      subj = file[ 0 ]
      height = leg_length[ subj ]
      leg_length_update = [height] * rows
      df["LEG_LENGTH"] = leg_length_update

      comx = df["center_of_mass_X"][0]
      comx_values = df["center_of_mass_X"] - comx
      df["ADJ_COMX"] = comx_values

      nfirstlines.append( next(f) )

      df.to_csv( tpath, sep='\t', index_label = 'N' )