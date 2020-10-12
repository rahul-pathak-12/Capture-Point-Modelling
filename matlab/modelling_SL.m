%% Modelling swing leg trajectories as a function of CoM velocity and acceleration 
% Extension essentially

%% Load BK Data
BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
load_data(BK_PATH); % this should do both process and load
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

%% Capture Point
[ com_vel, com_acc, capture_point ] = cp( bk ); 

%% Regression Features
x1 = com_vel(2:end) ;
x2 = com_acc ;
x3 = bk.center_of_mass_X(3:end);

X = [ x1 x2 x3 ];
Y = bk.toes_r_X(3:end);

[n,d] = size(Y);

%% Capture Point Modelling
modelterms = [ 
               0 0 0;
               1 0 0;
               0 1 1;
               1 1 1;
             ];
p = polyfitn( X, Y, modelterms );
p.VarNames = { 'x1';'x2'; 'x3' };
model = polyn2sympoly( p ); 
res =  3.518 - 2.541.*x1 - 0.8075.*x2.*x3 + 1.1186.*x1.*x2.*x3;
plot( res ) 
hold all
plot(Y ) 
plot(x1)
plot(x2)
plot(x3) 
legend( 'res','right foot' )


% This offers better clarity compared to above, get it to work : 
% mdl = polyfitn([input1,input2,input3],output, ...
%   {'constant','x1','x1^2','x1^3','x2','x3'});
