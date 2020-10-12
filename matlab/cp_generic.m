function [ cp, com_vel ] = cp_generic( series, time, height )
    %% Calculated Mechanics
    g = 9.81;
    com_vel = diff( series ) ./ diff(time);    

    %% Capture Point
    cp =  series(2:end) + times( com_vel , sqrt( height/g ) ); 
end