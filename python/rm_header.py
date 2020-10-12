import os 
from os import listdir
from os.path import isfile, join

DIR = "C:\\Users\\User\\Desktop\\RAW_DATA\\NO_SEGMENTATION\\TRAINING\\"

files = [ f for f in listdir(DIR) ]
for file in files: 
    fpath = DIR + file
    tpath = DIR + "tmp_" + file

    n = 18
    nfirstlines = []

    with open( fpath ) as f, open( tpath, "w" ) as out:
        for x in range(n):
            nfirstlines.append(next(f))
        for line in f:
            out.write(line)

    os.remove( fpath )
    os.rename( tpath, fpath )