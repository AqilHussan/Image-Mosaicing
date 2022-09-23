close all;
%%%Read Images%%%
img2=imread('img2.png');
img1=imread('img1.png');
img3=imread('img3.png');
figure();
imshow(img1);
figure();
imshow(img2);
figure();
imshow(img3);
% finds the SIFT features of the img2 and img1, and returns the correspondences based on the 
% distance between the nearest and second nearest neighbour.
[corresp1,corresp2]=sift_corresp('img2.png','img1.png');
c=0;                %initializing the consensus set size
P=size(corresp1);   %Find the number of total correspondences
P=P(1)-4;           %Find the remaining correspondences size after taking 4 correspondences for finding homography
%If the consensus set is large enough i.e. if |C| > d(= 0.8|P|), then return homography
while c<(.8*P)
[H21,c]=RANSAC(corresp1,corresp2);
end
% finds the SIFT features of the img2 and img3, and returns the correspondences based on the 
% distance between the nearest and second nearest neighbour.
[corresp1,corresp2]=sift_corresp('img2.png','img3.png');
c=0;                     %initializing the consensus set size
P=size(corresp1);        %Find the number of total correspondences
P=P(1)-4;                %Find the remaining correspondences size after taking 4 correspondences for finding homography
%If the consensus set is large enough i.e. if |C| > d(= 0.8|P|), then return homography
while c<(.8*P)
[H23,c]=RANSAC(corresp1,corresp2);
end
%Defining the canvas size and required shifts
NumCanvasRows=360;
NumCanvasColumns=1250;
OffsetRow=0;
OffsetColumn=250;
canvas = zeros(NumCanvasRows,NumCanvasColumns);
%%%Target to source mapping%%%
for cols = 1:NumCanvasColumns
for rows = 1:NumCanvasRows
%%%Applying the required offsets%%%
i = rows - OffsetRow;    
j = cols - OffsetColumn;
tmp = (H21) * [i;j;1]; % [X Y Z]=H*[x y z]
%normalize so that Z = 1,
i1 = tmp(1) / tmp(3);
j1 = tmp(2) / tmp(3);
tmp = (H23) * [i;j;1];% [X Y Z]=H*[x y z]
%normalize so that Z = 1,
i3 = tmp(1) / tmp(3);
j3 = tmp(2) / tmp(3);
%%%Applying Bilinear Interpolation%%%
v1 = BilinearInterp(i1,j1,img1);
v2 = BilinearInterp(i,j,img2);
v3 = BilinearInterp(i3,j3,img3);
%%%BlendValues%%%
if v1~=0 && v2~=0 && v3~=0
    canvas(rows,cols) = median([v1,v2,v3]);
elseif v1~=0 && v2~=0
        canvas(rows,cols) = median([v1,v2]);
elseif v1~=0 && v3~=0
        canvas(rows,cols) = median([v1,v3]);
elseif v2~=0 && v3~=0
        canvas(rows,cols) = median([v3,v2]);
else
    canvas(rows,cols)=(v1+v2+v3);
end
end
end
output=uint8(canvas);
figure();
imshow(output);






