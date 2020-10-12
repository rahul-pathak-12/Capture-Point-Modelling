
%% Load BK Data

BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
load_data(BK_PATH);
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

%% COM Capture Point

[ comz_cp, comx_vel ] = cp_generic(bk.center_of_mass_Y, bk.time, 0.8894);

%% LIPM Model  

COM_AVG_HEIGHT = mean(bk.center_of_mass_Y);
lipmz = ones(length(bk.center_of_mass_Y),1) .* COM_AVG_HEIGHT;

%% Freefall Model 

ffz = freefall( 131, COM_AVG_HEIGHT ); 

%% Plot Results

range = 130;

% The COM Height Changing over time
subplot(4, 1, 1);
plot( bk.center_of_mass_Y)
legend(  'COM Z','Location', 'northeast' )
title( 'COM Z' ) 

% The COM Height Changing over time
subplot(4, 1, 2);
plot( comz_cp )
hold on
legend(  'COM Z CP','Location', 'northeast' )
title( 'COM Z CP' ) 

% How the freefall Model changes over time
subplot(4, 1, 3);
plot(ffz(1:range))
legend(  'FREEFALL Z','Location', 'northeast' )
title( 'FREEFALL Z' ) 

% The LIPM Height is constant because LIPM assumes height doesnt change
subplot(4, 1, 4); 
plot( lipmz ) 
legend(  'LIPM Z','Location', 'northeast' )
title( 'LIPM Z' ) 