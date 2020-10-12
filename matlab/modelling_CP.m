
%% Load BK Data
BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
load_data(BK_PATH);
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

%% Capture Point & Plots

[ com_vel, com_acc, capture_point ] = cp( bk ); 

%% the FF model is basically an approximation of acceleration 
mdl_time = linspace( 0, 1.31, 131 ); % 131 points, from 0 to 1.31 meters
ff =  (0.8894 + ( 0.8166 .* mdl_time ))'; 
ff_cp = cp_generic(ff, bk.time, 0.8894);


%% LIPM Model

lipm = LIPM( 0.8894, 0.8166, 0.01 ); %  COMX POS, COMX VEL, 0.01 (HZ)
lipm_cp = cp_generic(lipm, bk.time, 0.8894); % 


%% IPM Model
range = 130;

% com = pendulum_func(  bk.time, bk.time, 0.8894, 0.8166);
% two = com(2,:)';
% three = com(3,:)';
% plot( two(1:range) )
hold on
plot( three(1:range) )
hold on
plot( capture_point(1:range) )
hold on
plot( ff_cp(1:range) )

hold on
plot( lipm_cp(1:range) )


%% Regression Features

x1 = bk.toes_r_X(2:end) ;
x2 = bk.toes_l_X(2:end) ;
x3 = bk.pelvis_X(2:end) ;

X = [ x1 x2 x3 ];
Y = capture_point;
[n,d] = size(Y);



%% Capture Point Modelling
         
modelterms = [ 
               0 0 0 ;
               1 0 0 ;
               0 1 0 ;
               0 0 1 ;
               1 1 1 ;
               2 0 0 ;
               0 2 0 ;
               0 0 2 ;
               2 2 0 ;
               0 2 2 ;
               2 2 2 ;
             ];
        
p = polyfitn( X, Y, modelterms );
p.VarNames = { 'x1';'x2'; 'x3'; };
model = polyn2sympoly( p ); 
res = 9.0225 - 9.6311.*x1 - 5.6042.*x2 - 4.5818.*x3 + 3.6783.*x1.*x2.*x3 + 5.0533.*x1.*x1 + 3.3405.*x2.*x2 + 1.3651.*x3.*x3 - 1.4341.*x1.*x1.*x2.*x2 - 0.54554.*x2.*x2.*x3.*x3 - 0.10669.*x1.*x1.*x2.*x2.*x3.*x3 ; 

%% Evaluation

TRUTH = capture_point(1:130);
OUR_MODEL = res(1:130);
FF_MODEL = ff_cp(1:130);
LIPM_MODEL = lipm_cp(1:130);

RMSE_OUR_MODEL = nmse(TRUTH, OUR_MODEL); 
RMSE_FF_MODEL = nmse(TRUTH, FF_MODEL); 
RMSE_LIPM_MODEL = nmse(TRUTH, LIPM_MODEL); 

%% Plot Results

range = 130;

plot( capture_point(1:range) )
hold on
plot( res(1:range) ) 
hold on
plot( ff_cp(1:range) )
hold on
%plot( lipm_cp(1:range) )
str = { "Capture Point", ...
        "REG: " + round(RMSE_OUR_MODEL,3), ...
        "FF: " + round(RMSE_FF_MODEL,3), ...
       % "LIPM: " + round(RMSE_LIPM_MODEL,3) 
      };
legend( str, 'Location', 'northwest' )

% need to use Akaike information criterion
% https://uk.mathworks.com/matlabcentral/answers/324739-how-to-calculate-akaike-information-criterion-and-bic-from-a-neural-network
% value = aic(model);
% https://uk.mathworks.com/matlabcentral/answers/281227-how-to-use-polyfitn-functions-i-am-quite-unclear-with-usage