function [ ff_cp, ff ] = ff_series( comx, time, height )
    %% Calculated Mechanics
    g = 9.81;
    com_vel = diff( comx ) ./ diff(time);    
    dimensions = size(time);
    
    ff = [];
    t = 0.01;
    comx_val = comx(1);
    comx_vel = com_vel(1);
    height_var = height(1);
    
    %% Capture Point
    for i = 1:dimensions(1)-1
        if height_var ~= height(i)
            comx_val = comx(i);
            comx_vel = com_vel(i);
        end
        
        ff_val = comx_val + times( comx_vel, t );
        ff = [ ff; ff_val ];
        t = t + 0.01;
    end
 
   ff_cp = cp_series( ff,  time(2:end), height(2:end) );
end

    
