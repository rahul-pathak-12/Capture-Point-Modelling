
%% NORM DIRS

NORM_RAW_TRAINING_DIR = 'D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\RAW_DATA\SEGMENTATION_NORM\TRAIN.sto';
NORM_RAW_TEST_DIR = 'D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\RAW_DATA\SEGMENTATION_NORM\TEST.sto';

train_norm = tdfread( NORM_RAW_TRAINING_DIR );
test_norm = tdfread( NORM_RAW_TEST_DIR );

%% ADJ RANGE

SINGLE = 112; 
DOUBLE = 224; 
ALL = 80905;

range = DOUBLE;
%dim = size(test.ADJ_COMX(1:range));
%test.ADJ_COMX = nonzeros(test_norm.ADJ_COMX);

%% PLOTTING

scatter( test_norm.time(1:range), test_norm.toes_r_X(1:range), 1, '.' )
hold on
scatter( test_norm.time(1:range), test_norm.toes_l_X(1:range),  1, '.' )
hold on
scatter(  test_norm.time(1:range), test_norm.pelvis_X(1:range), 1, '.' )
hold on

[ comx_cp, cp_vel ] = cp_series( test_norm.ADJ_COMX(1:range), test_norm.time(1:range), test_norm.LEG_LENGTH(1:range)); % 
hold on
scatter( test_norm.time(2:range), test_norm.ADJ_COMX(2:range), 1, '.' )
hold on
scatter( test_norm.time(2:range), test_norm.ADJ_COMX(2:range), 1, '.' )


%% EXISTING:=============================================[ Freefall Model ]
[ ff_cp, ff ] =  ff_series( test_norm.ADJ_COMX(1:range), test_norm.time(1:range), ones(range) );

plot( comx_cp(1:range-2) )
hold on
plot( ff(1:range-2) )
hold on
plot( test_norm.ADJ_COMX(1:range-2) )
hold on
legend(  'COM X CP', 'Freefall CP','COM X', 'Location', 'northwest' )
title( 'Comparing COM and Freefall Capture Point Models' ) 

%% EXISTING:=======================================================[ LIPM ]

lipm = lipm_series( test_norm.ADJ_COMX(1:range), test_norm.time(1:range), ones(range)  ); %  COMX, COMX Vel, 0.01
plot( comx_cp(1:range-2) )
hold on
plot( lipm(1:range-2) )
hold on
legend(  'COM X CP', 'LIPM CP',  'Location', 'northwest' )
title( 'Comparing COM and LIPM Capture Point Models' )

%% TESTING 
% For each test file plot, FF, LIPM, OUR_MODEL and NMSE Vals
% Create an average NMSE of each.
% Maybe plot one or two of these. 