function [Homography,c]=RANSAC(corresp1,corresp2)
nofCorresp=size(corresp1); %Find the number of total correspondences
L =4;                      %Number of randum correspondences needed for calculating Homography
RandumIndex = randperm(nofCorresp(1),L);%Creating 4 random correspondences indexes
%%%Finding X and Y of the correspondences%%%%%%%%%%%%
x1=corresp1(RandumIndex(1),1);
y1=corresp1(RandumIndex(1),2);
X1=corresp2(RandumIndex(1),1);
Y1=corresp2(RandumIndex(1),2);
x2=corresp1(RandumIndex(2),1);
y2=corresp1(RandumIndex(2),2);
X2=corresp2(RandumIndex(2),1);
Y2=corresp2(RandumIndex(2),2);
x3=corresp1(RandumIndex(3),1);
y3=corresp1(RandumIndex(3),2);
X3=corresp2(RandumIndex(3),1);
Y3=corresp2(RandumIndex(3),2);
x4=corresp1(RandumIndex(4),1);
y4=corresp1(RandumIndex(4),2);
X4=corresp2(RandumIndex(4),1);
Y4=corresp2(RandumIndex(4),2);
%%%%%
% For the transformation :
%     (x1,y1)-------------->(X1,Y1)
%     (x2,y2)-------------->(X2,Y2)
%     (x3,y3)-------------->(X3,Y3)
%     (x4,y4)-------------->(X4,Y4)
%     
%     
%     Homography can be found out by:
%     
%     | -x1 -y1 -1  0   0   0  x1X1 y1X1 X1 |
%     |  0   0   0 -x1 -y1 -1  x1Y1 y1Y1 Y1 | * transpose(|h11 h12 h13 h21 h22 h23 h31 h32 h33 |) = 0
%     | -x2 -y2 -1  0   0   0  x2X2 y2X2 X2 |
%     |  0   0   0 -x2 -y2 -1  x2Y2 y2Y2 Y2 | 
%     | -x3 -y3 -1  0   0   0  x3X3 y3X3 X3 |
%     |  0   0   0 -x3 -y3 -1  x3Y3 y3Y3 Y3 | 
%     | -x4 -y4 -1  0   0   0  x4X4 y4X4 X4 |
%     |  0   0   0 -x4 -y4 -1  x4Y4 y4Y4 Y4 | 

%%%%%
A=[[-x1,-y1,-1,0,0,0,x1*X1,y1*X1,X1];[0,0,0,-x1,-y1,-1,x1*Y1,y1*Y1,Y1];[-x2,-y2,-1,0,0,0,x2*X2,y2*X2,X2];[0,0,0,-x2,-y2,-1,x2*Y2,y2*Y2,Y2];[-x3,-y3,-1,0,0,0,x3*X3,y3*X3,X3];[0,0,0,-x3,-y3,-1,x3*Y3,y3*Y3,Y3];[-x4,-y4,-1,0,0,0,x4*X4,y4*X4,X4];[0,0,0,-x4,-y4,-1,x4*Y4,y4*Y4,Y4]];
H = null(A);                    %Find homography
c=0;                            %initializing the consensus set size
Homography=zeros(3);            %initializing the Homography matrix 
if numel(H)==9                  %Checking the size of obtained Homography
    H21=reshape(H,[3,3]);       %Reshaping into 3*3 matrix
    Homography=transpose(H21);  %Converting to row major form
    %%%Finding remaining correspondences%%%%%
    RemainingCorresp=(1:nofCorresp(1));
    i=ismember(RemainingCorresp, RandumIndex);
    RemainingCorresp(i)=[];
    s=numel(RemainingCorresp);
    %%% For each of the remaining correspondences (xi, yi) and (Xi,Yi) with i ∈ P = M\R
    %%%checkwhether they satisfy the homography.
    for r = 1:s
        x=corresp1(RemainingCorresp(r),1);
        y=corresp1(RemainingCorresp(r),2);
        X=corresp2(RemainingCorresp(r),1);
        Y=corresp2(RemainingCorresp(r),2);
        ObtainedMatrix=Homography*[x;y;1];
        ObX=ObtainedMatrix(1)/ObtainedMatrix(3);
        ObY=ObtainedMatrix(2)/ObtainedMatrix(3);
        epsilon=sqrt( ((ObX-X)^2)+((ObY-Y)^2));
        if epsilon<10.00
            % add the index of that correspondence to the consensus set.
            c=c+1;
        end
    end
end
