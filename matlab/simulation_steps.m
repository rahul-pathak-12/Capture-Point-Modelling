% Create Empty Objects
hold all

a =  patch( 0, 0, [ 0.192, 0.192, 0.192] ) ;
b =  plot( 0, 0, 'r+','MarkerSize', 5  );
c =  plot( 0, 0, 'g+','MarkerSize', 5  );
 
dimensions = size(bk.time);

for i =1:dimensions(1)-1
	y = bk.center_of_mass_Z(i);
    x = bk.center_of_mass_X(i);
    
    if abs( bk.talus_l_Z(i) - bk.toes_l_Z(i) ) <= 0.008
        XData = [ bk.talus_r_Z(i)-0.01; bk.toes_r_Z(i)+0.002; bk.toes_r_Z(i)+0.003;  bk.toes_r_Z(i)+0.02; bk.talus_r_Z(i)];
        YData = [ bk.talus_r_X(i); bk.toes_r_X(i); bk.toes_r_X(i)+0.08; bk.toes_r_X(i)+0.06; bk.talus_r_X(i)];
        
	elseif abs( bk.talus_r_Z(i) - bk.toes_r_Z(i)) <= 0.008
        XData = [ bk.talus_l_Z(i)+0.01;  bk.toes_l_Z(i)-0.002; bk.toes_l_Z(i)-0.003; bk.toes_l_Z(i)-0.02;  bk.talus_l_Z(i)];
        YData = [ bk.talus_l_X(i); bk.toes_l_X(i); bk.toes_l_X(i)+0.08; bk.toes_l_X(i)+0.06;  bk.talus_l_X(i)];
        
    else
        XData = [ bk.talus_r_Z(i); bk.toes_r_Z(i); bk.talus_l_Z(i); bk.talus_l_Z(i);]; 
        YData = [ bk.talus_r_X(i); bk.toes_r_X(i); bk.toes_l_X(i); bk.talus_l_X(i);];  
	end

    % Plot 
    a.XData = XData;
    a.YData = YData;
    
    b.YData= x;
    b.XData= y;
    
    c.XData = 0; 
    c.YData = capture_point(i);
    pause(1/100)
    drawnow 
    
    xlim([-0.5, 0.5])
    ylim([0, 12.7])
    set(gcf,'position',[500,50,300,800])
end
