%--------------------------------------------------------------------------
% Author: Emrah Onat
% Article: "Traffic sign classification using hough transform and SVM"
% Cite: https://ieeexplore.ieee.org/document/7130301
%--------------------------------------------------------------------------

function PlotCircle(Column,Row,Radius,N,Color)

% if(N<=1)
%     error('N must be greater than 1');
% end
% 
% if (Color ~='b') && (Color ~='g') && (Color ~= 'r') && (Color ~='c') &&(Color ~='m') && (Color ~='y') && (Color ~='k') && (Color ~='w')
%     error('This is not an available color, Please use help PlotCircle to choose an appropriate color');
% end

hold on
t=(0:N)*2*pi/N;
x=Radius*cos(t)+Column;
y=Radius*sin(t)+Row;
plot(x,y,Color);
