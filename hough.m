%--------------------------------------------------------------------------
% This program detects the circled in a given image via the Hough Transform
% Author: Emrah Onat
% Article: "Traffic sign classification using hough transform and SVM"
% Cite: https://ieeexplore.ieee.org/document/7130301
%--------------------------------------------------------------------------

clc
clear all
close all

Image = imread('...');
Image2 = imread('...');

figure
imshow(Image2);
title('original image');

original=Image;
size_original = size(original);
original_t = original;
original_t_new = [];
original_t = double(original_t);
threshold_blue = zeros(size_original(1), size_original(2));

for i=1:size_original(1)
    for j=1:size_original(2)
        if(original_t(i,j,1) > 100) && (original_t(i,j,2) < 90  ) && (original_t(i,j,3) < 90  )
            threshold_blue(i,j) = 1;
        end
    end
end

Image=threshold_blue;

Image=(rgb2gray(Image));
Image2=(rgb2gray(Image2));
figure
imshow(Image2);
title('gray image');
edgeimage = EDGE(Image,'canny',0.5,2);
figure
imshow(edgeimage);
title('edge image');
sizex = size(edgeimage,1);
sizey = size(edgeimage,2);
limit = min(sizex,sizey);
A=zeros(sizex,sizey,length(5:limit/2));
%   voting
for ii=1:sizex
   for jj=1:sizey
       if edgeimage(ii,jj)==1
           for r=5:length([5:limit/2]);
               for theta=0:pi/20:2*pi
                   x=round(ii-r*sin(theta));
                   y=round(jj+r*cos(theta));
                   k1 = sizex-x; k2=sizey-y;
                   if 0<k1 && 0<x && 0<k2 && 0<y
                       A(x,y,r)=A(x,y,r)+1;
                    end
               end
           end
       end
   end
end
%   local max
result=[];
thresh =12;     % need to change the threshold value depending on the image
count = 1;
for r=5:length([5:limit/2]);
   AA = A(:,:,r)-thresh;
   for ii=2:sizex-1
       for jj=2:sizey-1
           if AA(ii,jj)>0
               if AA(ii,jj)==max([AA(ii-1,jj-1) AA(ii-1,jj) AA(ii-1,jj+1) ...
                   AA(ii,jj-1) AA(ii,jj) AA(ii,jj+1) AA(ii+1,jj-1)...
                   AA(ii+1,jj) AA(ii+1,jj+1)])
                   result(count,1) = ii;
                   result(count,2) = jj;
                   result(count,3) = r;
                   count = count+1;
               end
           end
       end
   end
end
%   plotting detected circles

figure
imshow(Image);
title('This is a circular Traffic Sign');
hold on;
for cnt = 1:length(result)
   PlotCircle(result(cnt,2),result(cnt,1),result(cnt,3),256,'r');
end
