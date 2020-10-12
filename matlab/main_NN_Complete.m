% path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\NORM_TEST_3_LAYER.csv"; 
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\NORM_TEST_3_LAYER_NEW_FOOT.csv"; 
data = csvread( path );
dim = size( data(:,1) );

RMSE_FF = [];
RMSE_LIPM = [];
RMSE_OUR = [];
i = 2;

% LOAD MODELS 
load('FOOT_PLACEMENT_LINEAR.mat')
load('DST_TO_CP_LINEAR_REGRESSION.mat')

X_ACTUAL = [];
X_PREDICTED = []; 
Y_ACTUAL = [];
Y_PREDICTED = []; 
        
for x = 1: dim(1)-1

        ADJ_COMX= []; %NOT NORMALISED 
        time = [];
        LEG_LENGTH = []; % NOT NORMALISED 
        NN_VEL = [];
        TALUS_R = []; % NORMALISED
        
        while data(i, 6)- data(i-1, 6) == 1
            ADJ_COMX= [ADJ_COMX; data(i-1, 1)];
            NN_VEL = [NN_VEL; data(i-1, 8)];
            time = [time; data(i-1, 2)];
            LEG_LENGTH = [LEG_LENGTH;data(i-1, 3) ];
            TALUS_R = [TALUS_R; data(i-1, 9)];
            i = i+1;
        end
        i = i+1; % Increment after 1,2...100,1  -> need to shift to 2
        
        % SIMULATED : USING NORMALISED VELOCITY
        cp_nn = vel_series( ADJ_COMX, NN_VEL, time, LEG_LENGTH); 
        
        % NORMALISE SYNTHETIC CP
        cp_nn = minmax(cp_nn);
        
        % SIMULATED LANDING POSITION
        cp_nn_model_value = mean( FOOT_PLACEMENT_LINEAR.predictFcn(cp_nn) );
        landing_position = find(abs(cp_nn-0.5077)<=0.01);
        len_predicted = size(landing_position);
        
        % ACTUAL
        [ comx_cp, cp_vel ] = cp_series( ADJ_COMX, time, LEG_LENGTH );
        comx_cp = minmax( comx_cp );
        [pks, locs] = findpeaks( TALUS_R ); 
        index = round( 0.9*locs, 0 ); 
        len = size(index);
        
        
        if locs > 0
            if len_predicted(1) > 1 
                plot_landing_position = landing_position(1);

                % SIMULATED DISTANCE
                distance = DST_TO_CP_LINEAR_REGRESSION.predictFcn( cp_nn(plot_landing_position) );
                % plot(cp_nn)
                % hold on
                % plot(plot_landing_position,   cp_nn(plot_landing_position) - distance, '+' )

                X_PREDICTED = [X_PREDICTED; plot_landing_position]; 
                Y_PREDICTED = [Y_PREDICTED;  cp_nn(plot_landing_position) - distance]; 
            end

            if len_predicted(1) == 1
                plot_landing_position = landing_position;   
                % SIMULATED DISTANCE
                distance = DST_TO_CP_LINEAR_REGRESSION.predictFcn( cp_nn(plot_landing_position) );
                % plot(cp_nn)
                % hold on
                % plot(plot_landing_position,   cp_nn(plot_landing_position) - distance, '+' )

                X_PREDICTED = [X_PREDICTED; plot_landing_position]; 
                Y_PREDICTED = [Y_PREDICTED;  cp_nn(plot_landing_position) - distance]; 
            end

            if len(1) == 1
                actual_landing_position = comx_cp(index);
                actual_distance = (comx_cp(index) - TALUS_R(index) );
                %plot(comx_cp)
                %hold on
                %plot(index,   actual_landing_position - actual_distance, '+' )

                X_ACTUAL = [X_ACTUAL; index];
                Y_ACTUAL = [Y_ACTUAL; actual_landing_position - actual_distance];
            end

            if len(1) >1
                actual_landing_position = comx_cp(index(1));
                actual_distance = (comx_cp(index(1)) - TALUS_R(index(1)) );
                %plot(comx_cp)
                %hold on
                %plot(actual_landing_position,   comx_cp(actual_landing_position) - actual_distance, '+' )

                X_ACTUAL = [X_ACTUAL; index(1)];
                Y_ACTUAL = [Y_ACTUAL; actual_landing_position - actual_distance];
            end
            
        end
       

end


RMSE_X = sqrt( immse( X_ACTUAL, X_PREDICTED )); 
RMSE_Y = sqrt( immse( Y_ACTUAL, Y_PREDICTED )); 

% Xer = plot_landing_position;
% Yerr = cp_nn(plot_landing_position)-distance; 
% 
% plot(cp_nn)
% hold on
% patch( [Xer-11.98,  Xer, Xer+11.98, Xer], [Yerr,  Yerr-0.0742, Yerr, Yerr+0.0742], [0.8 0.8 0.8] )
% hold on
% plot(plot_landing_position,   cp_nn(plot_landing_position) - distance, '+' )
% plot(comx_cp)
% hold on
% plot(index,   actual_landing_position - actual_distance, '+' )
% 
% legend('NN CP','Error', 'Predicted Position', 'Actual CP', 'Actual Position')

% Freefall model emphasises how bad it is. 
%ff = ff_series( ADJ_COMX, t, LEG_LENGTH );