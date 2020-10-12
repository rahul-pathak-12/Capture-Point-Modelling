figure(1); clf;
view(0,0); 
% set(gcf,'Position',[150,700,400,600]);%[left bottom width height]

xlabel('x (m)')
ylabel('y (m)')
axis([-0.1 2 -1 1 -0.05 1]);	

%%
for i=1:1:length(time)        
    hold off;
	newplot;
    grid on;
    hold on;
    view(0,0);
    
	plot3(0,0,0,'bo'); % ankle joint
    plot3(joint(1,i),joint(2,i),joint(3,i),'bo');% tip of pendulum 
    plot3(COM(1,i),COM(2,i),COM(3,i), 'r.','MarkerSize',30); % overall center of mass	
    plot3([joint(1,i), 0],[joint(2,i), 0],[joint(3,i), 0],'b'); % pendulum
    plot3(Dc*u(i), 0, 0,'g.','MarkerSize',20);
    axis([-0.5 0.5 -1 1 -0.05 1]);	
	pause(0.0002);	
end