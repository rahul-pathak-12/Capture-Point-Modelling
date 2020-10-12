path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TRAIN\ADJ_2_002_1_Analysis_BodyKinematics_pos_global.sto"; 
foot = tdfread( path );
plot( data.toes_r_Z )
hold on
plot( data.toes_r_X )
hold on
plot( data2.toes_r_Z )
title( 'RIGHT FOOT' )

path2 = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TRAIN\ADJ_2_002_2_Analysis_BodyKinematics_pos_global.sto"; 
foot2 = tdfread( path2 );
plot( data.toes_l_Z )
hold on
plot( data.toes_l_X )
hold on
plot( data2.toes_l_Z )
title( 'LEFT FOOT' )