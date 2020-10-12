function [ lipm, lipm_cp ] = lipm_new( COMX, time, height )
    %% Calculated Mechanics
    com_vel = diff( COMX ) ./ diff(time);   
    vel = com_vel(1);

    dimensions = size(time);
    mdl_time = linspace( 0, dimensions(1)/10, dimensions(1) );
    t = mdl_time;
    
    X = [ COMX(1); % First entry of COM X
         vel ];
 
    Ts = 0.01;
    g = 9.81;
    
    Tc = sqrt(height(1)/g); %Time constant
    [x_list,dx_list,u_track]= deal(zeros(1,length(t)));

    % LIPM dynamics matrices 
    C = cosh (Ts/Tc);
    S = sinh (Ts/Tc);
    A = [    C, Tc*S ; ...
          S/Tc,  C  ];
    B = [0;
         1];

        for i = 1:length(t)
                u = 0;
                X = A * X + B * u;
                x_list(i) = X(1);
                dx_list(i) = X(2);
                u_track(i) = u;
        end

    lipm = x_list';
    lipm_cp = cp_series(lipm, time, height); %

end



    
