%--------------------------------------------------------------------------
% Author: Emrah Onat
% Article: "Traffic sign classification using hough transform and SVM"
% Cite: https://ieeexplore.ieee.org/document/7130301
%--------------------------------------------------------------------------

function [T,D,msum] = pca2( a, center );

% [T,D,msum] = pca2( a, center )
%
% Returns principal components
% of xsize x ysize image a as
% eigenvalues and eigenvectors.

hsum = zeros( 2, 2 );
imsiz = size( a );

for i=1:imsiz(1),
  for j=1:imsiz(2),
    if a(i,j) > 0,
      hlp = [ i; j ] - center;
      hsum = hsum + hlp*hlp'*a(i,j);
    end
  end
end

[T,D] = eig(hsum);
msum = hsum;

