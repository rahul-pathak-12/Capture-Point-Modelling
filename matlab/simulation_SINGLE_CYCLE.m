
%% File Paths

BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
MK_PATH = 'gait_cycles/markers.trc';

%% Load BK Data

load_data(BK_PATH);
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

%% Load Marker Data

load_data(MK_PATH);
mk = tdfread( 'gait_cycles/markers.trc.proc' );
run check_markers.m

%% Capture Point & Plots

[ com_vel, com_acc, capture_point ] = cp( bk ); 
run plot_cp.m

%% Run Simulation

run simulation_steps.m
hold off


