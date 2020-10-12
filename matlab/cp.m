function [com_vel, com_acc, cp] = cp( bk )
    %% Calculated Mechanics
    g = 9.81;
    time = bk.time;

    com_vel = diff( bk.center_of_mass_X ) ./ diff(time);    
    com_acc = diff( com_vel ) ./ diff( time(2:end) );

    %% Capture Point
    height = bk.center_of_mass_Y(2:end);
    cp =  bk.center_of_mass_X(2:end) + times( com_vel , sqrt( height/g ) ); 
end