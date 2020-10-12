
%% NORM DIRS

RAW_TRAINING_DIR = 'D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\RAW_DATA\SEGMENTATION\TRAIN.sto';
RAW_TEST_DIR = 'D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\RAW_DATA\SEGMENTATION\TEST.sto';

train = tdfread( RAW_TRAINING_DIR );
test = tdfread( RAW_TEST_DIR );

%% ADJ RANGE

SINGLE = 112; 
DOUBLE = 223; 
TRIPLE = 336;
ALL = SINGLE;
range = SINGLE;

dim = size(test.ADJ_COMX(1:range));
test.ADJ_COMX = nonzeros(test.ADJ_COMX);



%% PLOTTING

scatter( test.time(1:range), test.toes_r_X(1:range), 1, '.' )
hold on
scatter( test.time(1:range), test.toes_l_X(1:range),  1, '.' )
hold on
scatter(  test.time(1:range), test.pelvis_X(1:range), 1, '.' )
hold on

[ comx_cp, cp_vel ] = cp_series( test.ADJ_COMX(1:range), test.time(1:range), test.LEG_LENGTH(1:range)); % 
hold on
scatter( test.time(2:range), test.ADJ_COMX(2:range), 1, '.' )
hold on
scatter( test.time(2:range), test.ADJ_COMX(2:range), 1, '.' )

%scatter(test.time(2:range-1), comx_cp(2:range-1) , 1, '.' )


%% =============================================[ Freefall Model ]
[ ff_cp, ff ] =  ff_series( test.ADJ_COMX(1:range), test.time(1:range), test.LEG_LENGTH );

plot( test.ADJ_COMX(1:range-2) )
hold on
plot( comx_cp(1:range-2) )
hold on
plot( ff_cp(1:range-2) )
hold on
plot( ff(1:range-2) )
legend(  'COM X', 'COM X CP', 'Freefall CP', 'Freefall', 'Location', 'northwest' )
title( 'Comparing COM and Freefall Capture Point Models' ) 


%% =======================================================[ LIPM ]

[ lipm, lipm_cp] = lipm_new( test.ADJ_COMX(1:range), test.time(1:range), test.LEG_LENGTH(1:range));  
%[ lipm, lipm_cp] = lipm_series( test.ADJ_COMX(1:range), test.time(1:range), test.LEG_LENGTH(1:range));  

plot( comx_cp(1:range-2) )
hold on
legend(  'Capture Point','Location', 'northwest' )
title( 'COM Capture Point' )

%% TESTING 

% For each test file plot, FF, LIPM, OUR_MODEL and NMSE Vals
% Create an average NMSE of each.
% Maybe plot one or two of these. 