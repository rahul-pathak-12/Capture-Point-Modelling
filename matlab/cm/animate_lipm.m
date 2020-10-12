animate_lipm(x_list,dx_list,ddx_list,z,t,Ts)%,cp)

close all

%setup figures
figure
subplot(3,1,1)
    % define point mass visualisation to reduce computation time
        pm = line;
        pm.Color = [0,0,1];
        pm.LineStyle = 'none';
        pm.LineWidth = 0.5;
        pm.Marker = 'o';
        pm.MarkerSize = 6;
        pm.MarkerFaceColor = 'none';
        pm.ZData = 0;
        pm.YData = z;
    % define leg visualisation to reduce computation time
        leg = line;
        leg.Color = [0 0.4470 0.7410];
        leg.LineStyle = '-';
        leg.LineWidth = 0.5;
        leg.Marker = 'none';
        leg.MarkerSize = 6;
        leg.MarkerFaceColor = 'none';
        
        hold on
       % a = scatter(cp(1),0.1);
        hold off
    xlabel("COM pos")
    ylabel("COM height")
    xlim([-max(abs(x_list)),max(abs(x_list))])
    ylim([0,z])
    
subplot(3,1,2)
    % define pos vs time visualisation to reduce computation time
        pos_plot = line;
        pos_plot.Color = [1 0 1];
        pos_plot.LineStyle = '-';
        pos_plot.LineWidth = 0.5;
        pos_plot.Marker = 'none';
        pos_plot.MarkerSize = 6;
        pos_plot.MarkerFaceColor = 'none';
    xlim([0,t(end)])
    ylim([min(x_list),max(x_list)])
    xlabel('Timestep')
    ylabel('Com Pos')
    grid on
    
subplot(3,1,3)
    % define acc vs vel visualisation to reduce computation time
        va_plot = line;
        va_plot.Color = [1 0 0];
        va_plot.LineStyle = '-';
        va_plot.LineWidth = 0.5;
        va_plot.Marker = 'none';
        va_plot.MarkerSize = 6;
        va_plot.MarkerFaceColor = 'none';
    grid on
    xlim([min(dx_list),max(dx_list)])
    ylim([min(ddx_list),max(ddx_list)])
    xlabel('Velocity')
    ylabel('Acceleration')

% animation plot
for j = 1:length(x_list)

    subplot(3,1,1)

    hold on
        pm.XData = x_list(j);
        leg.XData = [0,x_list(j)];
       % a.XData = cp(j);
        pause(Ts)
    hold off

    subplot(3,1,2)

    hold on
        pos_plot.XData = t(1:j);
        pos_plot.YData = x_list(1:j);
    hold off
    
    subplot(3,1,3)
    hold on
        va_plot.XData = dx_list(1:j);
        va_plot.YData = ddx_list(1:j);
    hold off
    
end

