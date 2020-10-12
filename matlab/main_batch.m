
% Get information about what's inside your folder.
path = "D:\OneDrive\Rahul\Education\Masters\Edinburgh\Artificial Intelligence\Modules 2018-2019\Dissertation\prelim_code\TEST\"; 
myfiles = dir(path);

filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';

files=filenames(endsWith(filenames,'.sto'));
folders=filefolders(endsWith(filenames,'.sto'));
all_files=fullfile(folders,files);

dimensions = size(files);

RMSE_FF = [];
RMSE_LIPM = [];
RMSE_OUR = [];

TEST_DATA = [];

for i = 1:dimensions(1)-2
    data = tdfread( all_files{i} );
    [ comx_cp, cp_vel ] = cp_series( data.ADJ_COMX, data.time, data.LEG_LENGTH ); % 
    
    [ ff_cp, ff ] =  ff_series( data.ADJ_COMX, data.time, data.LEG_LENGTH );
    [ lipm, lipm_cp ] = lipm_new( data.ADJ_COMX, data.time, data.LEG_LENGTH); 

    TRUTH = comx_cp;
    
    %x1 = minmax( data.ADJ_COMX(2:end) ) ;
    %x2 = minmax( cp_vel ) ;
   % X = [ x1 x2 ];
    
   %% FUNC APPROXIMATION
%     pos = data.ADJ_COMX;
%     vel = diff(pos)/(1/100);
%     acc = diff(vel)/(1/100);
% 
%     init = [pos(1);
%             vel(1);
%             acc(1)];
%    w = [0.191772705642497,   2.044316978685702,  -0.320327002659518,   0.099999813160539,   1.310081513726380];
%    VELOCITY = [];
%    len = size(data.time);
%    
%     for i = 1:len(1)
%        y = init(2) + ( w(1) * sin( w(5)*pi*w(2)*(i/100) + w(4) ) + w(3) );
%        VELOCITY = [VELOCITY; y];
%     end
%    
%     OUR_MODEL = vel_series( minmax(data.ADJ_COMX), VELOCITY, data.time, data.LEG_LENGTH);
%     
   %% THIS IS ALL VELOCITY PREDICTION
    len = size( cp_vel );
    initial_pos = minmax( data.ADJ_COMX );
    initial_vel = minmax( cp_vel );
    x1 = initial_pos(2) .* ones(len(1),1) ;
    x2 = initial_vel(1) .* ones(len(1),1);
    x3 = data.N(2:end);
    
    % CREATE TEST DATA FOR PYTHON
    X = [ data.ADJ_COMX(2:end) data.time(2:end) data.LEG_LENGTH(2:end) x1 x2 x3 cp_vel];
    TEST_DATA = [TEST_DATA ; X];
    
    X = [ x1, x2, x3 ];
    velocity = IXPOS_IXVEL_NTIME_FINE_TREE.predictFcn( X );
    OUR_MODEL = vel_series( minmax(data.ADJ_COMX), velocity, data.time, data.LEG_LENGTH);
   
    %% USING COMX VEL and COMX POSITION
    % OUR_MODEL = ADJCOMX_COMXVEL_QUADRATIC.predictFcn(X); %0.01 RMSE
    % Explainability -> LinearModel.Formula.Terms
    % https://uk.mathworks.com/help/stats/linearmodel.addterms.html
    

    FF_MODEL = ff_cp;
    LIPM_MODEL = lipm_cp;
    RMSE_OUR_MODEL = sqrt(immse( minmax(TRUTH), OUR_MODEL)); 
    
    
    RMSE_FF_MODEL = sqrt(immse(TRUTH(2:end), FF_MODEL)); 
    RMSE_LIPM_MODEL = sqrt(immse(TRUTH(2:end), LIPM_MODEL(2:end)));
    
    RMSE_FF = [ RMSE_FF; RMSE_FF_MODEL ];
    RMSE_LIPM = [ RMSE_LIPM; RMSE_LIPM_MODEL ];
    RMSE_OUR = [ RMSE_OUR; RMSE_OUR_MODEL ];
end

csvwrite('NORM_TEST.csv', TEST_DATA)
mean( RMSE_FF )
mean( RMSE_LIPM )
mean( RMSE_OUR )
