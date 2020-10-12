function index = find_plateau( series )

fontSize = 10;
y = series(10:end);
filteredSignal = stdfilt(y, ones(5, 1));
xMax = length(filteredSignal);
index = find(filteredSignal < 0.003, 1, 'first');

% subplot(2, 1, 1);
% plot(y, 'b.-', 'MarkerSize', 11);
% grid on;
% xlabel('Index', 'FontSize', fontSize);
% ylabel('Y Signal', 'FontSize', fontSize);
% title('Standard Deviation', 'FontSize', fontSize);
% 
% subplot(2, 1, 2);
% plot(filteredSignal, 'b.-', 'MarkerSize', 11);
% grid on;
% xlim([1, xMax]);
% xlabel('Index', 'FontSize', fontSize);
% ylabel('Standard Deviation of Y', 'FontSize', fontSize);
% title('Standard Deviation', 'FontSize', fontSize);
% 
% % Draw a green patch over it
% yl = ylim;
% hold on;
% patch([index, index, xMax, xMax, index], ...
%   [yl(1), yl(2), yl(2), yl(1), yl(1)], ...
%   'g', 'FaceAlpha', 0.3);
% sprintf('The plateau indexes start at %d', index)
