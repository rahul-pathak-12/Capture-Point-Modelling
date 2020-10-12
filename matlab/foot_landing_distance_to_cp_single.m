path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\STEP_MODELLING_PROCESSED\5_1_processed_sp_bk.csv"; 
data = tdfread( path );
[ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );


d =  (data.center_of_mass_Z .* data.talus_r_X); % Enhance Peaks
% findpeaks( d );
[pks, locs] = findpeaks( d ); 

val = round(mean(diff(locs)), 0);
index = locs - round((val/1.1),0) + round((val/1.8),0); 

dst_to_cp =  comx_cp(index(2:end)) - data.talus_r_X(index(2:end));

plot(dst_to_cp)
title( 'DISTANCE TO CP' ) 
xlabel('INDEX')
ylabel('DISTANCE TO CAPTURE POINT')


plot( data.talus_r_X )  
hold on
plot( index(2:end), data.talus_r_X(index(2:end)), '+' )
hold on
plot( comx_cp )
legend( 'Talus X', 'Step Location', 'Capture Point' )
title( 'Step Location' ) 
xlabel('INDEX')
ylabel('STEP LOCATIONS')
