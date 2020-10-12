import os 
from os import listdir
from os.path import isfile, join
import pandas as pd

VERSION= "TRAIN"
DIR = "C:\\Users\\User\\Desktop\\RAW_DATA\\SEGMENTATION_NORM\\"+VERSION+"\\"
# DIR = "C:\\Users\\User\\Desktop\\RAW_DATA\\SEGMENTATION\\"+VERSION+"\\"

files = [ f for f in listdir(DIR) ]
combined_csv = pd.concat( [ pd.read_csv(DIR+f) for f in files ] )
combined_csv.to_csv( DIR+VERSION+".sto", index=False, index_label = 'N' )