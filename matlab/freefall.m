function pos_track = freefall(timesteps, COM_AVG_HEIGHT)
    ts = 1/100;
    g = -9.81;
    Z = [COM_AVG_HEIGHT;...
            0.1;...
            0];

    A = [1, ts, ts^2/2;...
           0, 1, ts;
           0, 0, 1];

    B = [ts^3/4;
           ts^2/2;
           ts];

    [pos_track,vel_track] = deal(zeros(timesteps,1));
   
        for i = 1:timesteps
            Z = A * Z + B * g;
            pos_track(i) = Z(1);
            vel_track(i) = Z(2);
        end
end

%close all
%figure
%plot(pos_track)
%xlabel('time[ms]')
%ylabel('z pos [m]')
%title('Freefall Z pos')

