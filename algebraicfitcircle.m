%--------------------------------------------------------------------------
% Author: Emrah Onat
% Article: "Traffic sign classification using hough transform and SVM"
% Cite: https://ieeexplore.ieee.org/document/7130301
%--------------------------------------------------------------------------

function [center,radius] = algebraicfitcircle(points)
 
if size(points,1) ~= 2,
    error('points must be a 2 x N array');
end;
N = size(points,2);
y = points(2,:).';
x = points(1,:).';
M = [2*x 2*y ones(N,1)];
v = x.^2+y.^2;
pars = M\v;
center = pars(1:2);
radius = sqrt(sum(center.^2)+pars(3));
if imag(radius)~=0,
    error('Imaginary squared radius computed');
end;
