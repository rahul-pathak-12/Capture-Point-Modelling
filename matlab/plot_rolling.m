
function plot_rolling( range, XData, YData )
    a =  patch( 0, 0, 'r+','MarkerSize', 5 ) ;
    
    for i = 1:range
        a.XData = XData(i);
        a.YData = YData(i);
        drawnow 
    end
end
