
%% Load BK Data

BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
load_data(BK_PATH);
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

%% COM Capture Point
avg_comx = mean(bk.center_of_mass_X);   % 0.8894
[ comx_cp, comx_vel ] = cp_generic(bk.center_of_mass_X, bk.time, 1.4053); % Need correct COM X position

%% Freefall Model  

% the FF model is basically an approximation of acceleration 
mdl_time = linspace( 0, 1.31, 131 );
ff =  (1.4053+ ( 0.8166 .* mdl_time ))'; 
ff_cp = cp_generic( ff, bk.time, 1.4053 );


%% LIPM Model 

lipm = LIPM( 0.8894, 0.8166, 0.01 ); %  COMX, COMX Vel, 0.01
lipm_cp = cp_generic(lipm, bk.time, 0.8894); % 

%% Plot Results

range = 130;

subplot(5, 1, 1);
plot( bk.center_of_mass_X(1:range) )
hold on
plot( comx_cp(1:range) )
legend(  'COM X', 'COM X Capture Point', 'Location', 'northwest' )
title( 'COM X & COM Capture Point' ) 

subplot(5, 1, 2);
plot( lipm(1:range) )
hold on
plot( lipm_cp(1:range) )
legend(  'LIPM', 'LIPM CP', 'Location', 'northwest' )
title( 'LIPM & LIPM Capture Point' ) 

subplot(5, 1, 3);
plot( ff(1:range) )
hold on
plot(ff_cp(1:range)) % 130
legend(  'Frefall', 'Freefall CP', 'Location', 'northwest' )
title( 'Freefall & Freefall Capture Point' ) 

subplot(5, 1, 4);
plot(ff_cp(1:range))
hold on
plot(lipm_cp(1:range))
hold on
plot( comx_cp(1:range) )
legend(  'COM X CP', 'LIPM CP', 'Freefall CP', 'Location', 'northwest' )
title( 'Comparing COM and Freefall Capture Point Models' ) 

subplot(5, 1, 5);
plot(ff_cp(1:range))
hold on
plot( comx_cp(1:range) )
legend(  'COM X CP', 'Freefall CP', 'Location', 'northwest' )
title( 'Comparing COM and Freefall Capture Point Models' ) 