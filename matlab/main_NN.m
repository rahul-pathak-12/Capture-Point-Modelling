path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\NORM_TEST_3_LAYER.csv"; 
data = csvread( path );
dim = size( data(:,1) );

RMSE_FF = [];
RMSE_LIPM = [];
RMSE_OUR = [];
i = 2;

for x = 1:dim(1)-1

        ADJ_COMX= []; %NOT NORMALISED 
        time = [];
        LEG_LENGTH = []; % NOT NORMALISED 
        NN_VEL = [];
        Y = [];
    
        while data(i, 6)- data(i-1, 6) == 1
            ADJ_COMX= [ADJ_COMX; data(i-1, 1)];
            NN_VEL = [NN_VEL; data(i-1, 8)];
            time = [time; data(i-1, 2)];
            LEG_LENGTH = [LEG_LENGTH;data(i-1, 3) ];
            i = i+1;
        end
        i = i+1; % Increment after 1,2...100,1  -> need to shift to 2
        
        % This is using Normalised Velocity, hence TRUTH needs to be
        % normalised. 
        cp_nn = vel_series( ADJ_COMX, NN_VEL, time, LEG_LENGTH); 
        
        [ comx_cp, cp_vel ] = cp_series( ADJ_COMX, time, LEG_LENGTH ); % 
        [ ff_cp, ff ] =  ff_series( ADJ_COMX, time, LEG_LENGTH );
        [ lipm, lipm_cp ] = lipm_new( ADJ_COMX, time, LEG_LENGTH); 

        OUR_MODEL = cp_nn ;
        FF_MODEL = ff_cp;
        LIPM_MODEL = lipm_cp;
        TRUTH = comx_cp;

        RMSE_OUR_MODEL = sqrt( immse( minmax(TRUTH(2:end)), minmax(OUR_MODEL(2:end)) ) ); % ideal when both normalised i.e. both have minmax
        RMSE_FF_MODEL = sqrt( immse( TRUTH(2:end), FF_MODEL )); 
        RMSE_LIPM_MODEL = sqrt( immse(TRUTH(2:end), LIPM_MODEL(2:end)) );

        RMSE_FF = [ RMSE_FF; RMSE_FF_MODEL ];  
        RMSE_LIPM = [ RMSE_LIPM; RMSE_LIPM_MODEL ];
        RMSE_OUR = [ RMSE_OUR; RMSE_OUR_MODEL ];
end

mean( RMSE_FF )
mean( RMSE_LIPM )
mean( RMSE_OUR )
