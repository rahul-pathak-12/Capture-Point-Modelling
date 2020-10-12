import os 
from os import listdir
from os.path import isfile, join
from sklearn import preprocessing
import numpy as np
import pandas as pd

VERSION= "TRAIN"
DIR_ORIGIN = "C:\\Users\\User\\Desktop\\RAW_DATA\\SEGMENTATION_NORM\\" + VERSION + "\\"
DIR_DEST = "C:\\Users\\User\\Desktop\\RAW_DATA\\SEGMENTATION_NORM\\" + VERSION + "\\"
files = [ f for f in listdir(DIR_ORIGIN) ]

for file in files: 
    fpath = DIR_ORIGIN + file
    tpath = DIR_DEST + "NORM_" + file

    nfirstlines = []

    with open( fpath ) as f:
      df = pd.read_csv( fpath, sep='\t' )
            
      min_max_scaler = preprocessing.MinMaxScaler( )
      x_scaled = min_max_scaler.fit_transform( df )
      df_new = pd.DataFrame( x_scaled, columns = df.columns )

      nfirstlines.append( next(f) )
      df_new.to_csv( tpath, sep='\t', index_label = 'N' )