function cost = run_sim(w,init,vel)
   toc 
   w
    timesteps = length(vel);
    ts = 1/100;

    g = -9.81;
    X = [init(1);...
            init(2);...
            init(3)];

    A = [1, ts, ts^2/2;...
           0, 1, ts;
           0, 0, 1];

    B = [ts^3/4;
           ts^2/2;
           ts];

    [pos_track,vel_track] = deal( zeros(timesteps,1) );

    for i = 1:timesteps
        u = 0;
        %X = A * X + B * ( w(1)*i^3 + w(2)*i^2 + w(3)*i + w(4));
        X = A * X + B * w(1) * sin( 2*pi*w(2)*i + init(2) ) ; 
        pos_track(i) = X(1);
        vel_track(i) = X(2);
    end

    cost  = sum((vel_track-vel).^2);

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