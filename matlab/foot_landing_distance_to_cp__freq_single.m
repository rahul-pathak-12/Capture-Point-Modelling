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


d =  (data.center_of_mass_Z .* data.talus_r_X); % Enhance Peaks
[pks, locs] = findpeaks( d ); 
val = round(mean(diff(locs)), 0);
index = locs - round((val/1.1),0) + round((val/1.8),0); 

indexes = index(2:end); % last 10 gait cycles


plot(data.talus_r_X(1:300 ))
hold on
plot(indexes(1:10 ),rheel_values(1:10 ), '+' )
hold on
plot( comx_cp(1:300 ) )

