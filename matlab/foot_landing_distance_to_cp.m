path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\STEP_MODELLING_PROCESSED\4_0_processed_sp_bk.csv"; 

data = tdfread( path );
dim = size( data(:,1) );

range = 5000;
cycle = 0;

dst_to_cp = [];
step_vel = [];
step_length = [];
acc = [];

[ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );

buffer = 50 ;
start_I = 1;
end_I = 0;

% Plot indexes and plot rheel and see where they overlap
indexes = []; % These are indexes where the plateau occurs
rheel_values = []; % plot(plateau, rheel(plateau), '+')



[pks, locs] = findpeaks(data.talus_r_X, 'MinPeakDistance',50);

for loc in locs:
    calc distance from cp to talus
    plot the fucking points fuck sake this is fucking bullshit. 

for i=1:4999
    dst_to_cp_val = abs(comx_cp(i) - data.talus_r_X(i));
    
    if dst_to_cp_val < 0.01
        dst_to_cp = [dst_to_cp; dst_to_cp_val];
        indexes = [indexes; i];
        rheel_values = [rheel_values; data.talus_r_X(i)];
    end

end

plot(data.talus_r_X(1:300 ))
hold on
plot(indexes(1:10 ),rheel_values(1:10 ), '+' )
hold on
plot( comx_cp(1:300 ) )

