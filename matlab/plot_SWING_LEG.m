%% Load BK Data
BK_PATH = 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto';
load_data(BK_PATH); % this should do both process and load
bk = tdfread( 'gait_cycles/OpenSim/1/BK/Analysis_BodyKinematics_pos_global.sto.proc' );

% rx = bk.toes_r_X;
% ry = bk.toes_r_Z;
% 
% lx = bk.toes_l_X;
% ly = bk.toes_l_Z;
% 
% sf = fit(lx, ly, 'smoothingspline' );
% plot(sf,lx,ly)

scatter( bk.toes_l_X, bk.toes_l_Y, '.' )
hold on
scatter( bk.toes_r_X , bk.toes_r_Y, '.' )
legend( 'left foot','right foot' )


% subplot(2,1,1);
% plot(bk.toes_l_X)
% hold on
% plot(bk.toes_l_Y)
% hold on
% legend( 'LX','LZ', 'Location', 'northwest' )
% title('left foot')
% 
% subplot(2,1,2);
% plot(bk.toes_r_X)
% hold on
% plot(bk.toes_r_Y)
% hold on
% legend( 'RX','RZ', 'Location', 'northwest' )
% title('right foot')

% left = patch(  bk.toes_l_X, bk.toes_l_Y, [ 0.192, 0.192, 0.192] );
% hold on
% center = patch( [0, 3], [0 , 0], [ 0.192, 0.192, 0.192]  );
% hold on
% right = patch(  bk.toes_r_X, bk.toes_r_Y, [ 0.192, 0.192, 0.192] );