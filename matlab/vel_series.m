function [ cp, com_vel ] = cp_series( series, velocity, time, height )
    %% Calculated Mechanics
    g = 9.81;
    dim = size(series);
    com_vel = velocity;    

    cp = [];
    
    %% Capture Point
    for i = 1:dim(1)-1
        series(i+1);
        cp_val =  series(i+1) + times( com_vel(i) , sqrt( height(i)/g ) ); 
        cp = [ cp; cp_val ];
    end
end