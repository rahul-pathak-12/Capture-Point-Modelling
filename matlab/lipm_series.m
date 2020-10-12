function [ lipm, lipm_cp ] = lipm_series( COMX, time, height )
    %% Calculated Mechanics
    com_vel = diff( COMX ) ./ diff(time);    
    dimensions = size(time);
    
    lipm = [];
    comx_i = COMX(1);
    initial_height = height(1);
    vel = com_vel(1);
    Ts = 0.01;
    g = 9.81;
    
    %% Capture Point
    for i = 1:dimensions(1)-1
        
        if initial_height ~= height(i)
            comx_i = COMX(i);
            initial_height = height(i);
            vel = com_vel(i);
        end
 
        X = [ comx_i;
            vel ];
        Tc = sqrt( initial_height/g );
         
        % LIPM dynamics matrices 
        C = cosh( Ts/Tc );
        S = sinh( Ts/Tc );
        A = [    C, Tc*S ; ...
              S/Tc,  C  ];
        B = [0;
             1];

        for j = 1:length(time)
            u = 0;
            X = A * X + B * u;
            x_list(j) = X(1);
        end
        
        lipm_vals = x_list';
        lipm = [ lipm; lipm_vals ];
    end
    
    %lipm_cp = cp_series(lipm, time, height); %


end



    
