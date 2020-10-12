function cost = run_sim_sin(w,init,vel)
   toc 
   w
    timesteps = length(vel);
    ts = 1/100;

    
    X = [init(1);...
            init(2);...
            init(3)];


    [pos_track,vel_track] = deal( zeros(timesteps,1) );

    for i = 1:timesteps
        
      % y = init(2) + ( w(1) * sin( 2*pi*w(2)*(i/100) ) + w(3) );
        
       y = init(2) + ( w(1) * sin( w(5)*pi*w(2)*(i/100) + w(4) ) + w(3) )
        %pause(0.2)
        vel_track(i) = y;
    end

    cost  = sum( (vel_track-vel).^2 )  
   
    close all
    figure
    hold on
    plot(vel_track)
    plot(vel)
    xlabel('time[ms]')
    ylabel('z pos [m]')
    title('Freefall Z pos')
    pause(0.2)

end