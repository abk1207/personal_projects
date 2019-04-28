load('timedata.mat')
surf(tdata(1:99,1:99,1),'EdgeColor', 'none', 'FaceColor', 'red')
hold on
surf(tdata(1:99,1:99,2),'EdgeColor', 'none', 'FaceColor', 'green')
% surf(tdata(1:99,1:99,3),'EdgeColor', 'none', 'FaceColor', 'blue')
hold off