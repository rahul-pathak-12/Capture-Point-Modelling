
%% File Paths

BK_PATH = 'test_data/BK.tsv';
MK_PATH = 'test_data/Markers.tsv';

%% Load BK Data

load_data(BK_PATH);
bk = tdfread( 'test_data/BK.tsv.proc' );
g = 9.81;

%% Load Marker Data

load_data(MK_PATH);
mk = tdfread( 'test_data/Markers.tsv.proc' );
val = 110; % snapshot at 110th record

leftX = [ mk.Z24(val); mk.Z23(val) ];
leftY = [ mk.X24(val); mk.X23(val) ];

rightX = [ mk.Z21(val); mk.Z20(val) ]; 
rightY = [ mk.X21(val); mk.X20(val) ]; 

left = patch(  leftX, leftY, [ 0.192, 0.192, 0.192] );
hold on
right = patch(  rightX, rightY, [ 0.192, 0.192, 0.192] );
hold off

%% Get Features

time = bk.time;
com_Z = bk.center_of_mass_Z;
com_X = bk.center_of_mass_X; 

com_vel = diff( com_X ) ./ diff(time);
com_acc = diff( com_vel ) ./ diff( time(2:end) );

%% Capture Point

com_Y = bk.center_of_mass_Y;
height = com_Y(2:end);
capture_point =  com_X(2:end) + times( com_vel, sqrt( height/g ) ); 

%% Run Simulation

run simulation_steps.m
hold off

%% Plot COM and Capture Point 

plot(com_X)
hold on
plot(com_Y)
plot(com_Z)
plot(capture_point)
plot( bk.toes_r_X )% right toe
legend('com_X','com_Y','com_Z', 'capture_point', 'right toe' )
