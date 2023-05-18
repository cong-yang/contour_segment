function [ csfeature ] = f_CS_14_Feature_SubBox( SingleSegment )
%f_CS_13_Feature_LineSegment: this function is used to generate contour
%                                    segment descriptor using line segment
%                                    statistics.
%   input: 
%         SingleSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using line segment statistics.
%   description:
%          refer to the paper: 
%          Cong Yang, et al., Shape-Based Object Retrieval by Contour Segment 
%          Matching, ICIP 2014.

Path = SingleSegment;
%save('aaa.mat','Path');

if size(SingleSegment,1) < 4
    CompareDisEnds = size(SingleSegment,1);
    ComparePathLength = size(SingleSegment,1);
    CompareNFMaxBoxSizeRatio = size(SingleSegment,1);
    CompareNFTopBlockSizeRatio = 1;
    CompareNFMiddleBlockSizeRatio = 1;
    CompareNFBottomBlockSizeRatio = 1;
    CompareNFBottomTopBlockAreaRatio = 1;
    CompareNFMiddleTopBlockAreaRatio= 1;
    CompareNFClosedRegionArea = size(SingleSegment,1);
    CompareRatioConPathandEnd = 1;
    %AverageLineCurvature = 0;
    SuperVector = [CompareDisEnds,...
               ComparePathLength,...
               CompareNFMaxBoxSizeRatio,...
               CompareNFTopBlockSizeRatio,...
               CompareNFMiddleBlockSizeRatio,...
               CompareNFBottomBlockSizeRatio,...
               CompareNFBottomTopBlockAreaRatio,...
               CompareNFMiddleTopBlockAreaRatio,...
               CompareNFClosedRegionArea,...
               CompareRatioConPathandEnd];
     return;
end

%estimate whether line is a straight line
[bool_straight] = f_Estimate_Straight_Line(Path);
if bool_straight == 1 %if it's a straight line
    display('aaaaa');
    pathlength = size(SingleSegment,1);
    CompareDisEnds = pathlength;
    ComparePathLength = pathlength;
    CompareNFMaxBoxSizeRatio = pathlength;
    
    sprehei = round(pathlength/3);
    
    CompareNFTopBlockSizeRatio = 1/sprehei;
    CompareNFMiddleBlockSizeRatio = 1/sprehei;
    CompareNFBottomBlockSizeRatio = 1/sprehei;
    CompareNFBottomTopBlockAreaRatio = 1;
    CompareNFMiddleTopBlockAreaRatio= 1;
    CompareNFClosedRegionArea = pathlength;
    CompareRatioConPathandEnd = 1;
    SuperVector = [CompareDisEnds,...
           ComparePathLength,...
           CompareNFMaxBoxSizeRatio,...
           CompareNFTopBlockSizeRatio,...
           CompareNFMiddleBlockSizeRatio,...
           CompareNFBottomBlockSizeRatio,...
           CompareNFBottomTopBlockAreaRatio,...
           CompareNFMiddleTopBlockAreaRatio,...
           CompareNFClosedRegionArea,...
           CompareRatioConPathandEnd];
     return;
end

%step2: create the path matrix
MaxX = max(Path(:,1));
MaxY = max(Path(:,2));
MinX = min(Path(:,1));
MinY = min(Path(:,2));
newwidth = MaxX;
newheight = MaxY;
MatrixGraph = zeros(newwidth,newheight);
[pathheight,~] = size(Path);
for templinenumber = 1:pathheight
    MatrixGraph(Path(templinenumber,2),Path(templinenumber,1)) = 1;
end

%%%get and draw rectangle
imgori = MatrixGraph;
imgori = im2bw(imgori);
[imgw, ~] = size(imgori);
[r,c] = find(imgori==1);

startpointX = min(c);
startpointY = min(r);
recwidth = max(c)-startpointX + 1;
recheight = max(r)-startpointY + 1;

% figure,imshow(imgori);
% hold on;
% rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');
% plot(startpointX+round(recwidth/2),startpointY,'sg');
% plot(startpointX+round(recwidth/2),startpointY+recheight,'sg');
% 
% x = startpointX+round(recwidth/2);
% y = startpointY:startpointY+recheight;
% plot(x,y,'r');

endx1 = startpointX+round(recwidth/2);
endy1 = startpointY;
endx2 = startpointX+round(recwidth/2);
endy2 = startpointY+recheight;

X1 = [endx1 endy1];
X2 = [endx2 endy2];
Vector1 = X1-X2;

%%%get two end points on edge curve
[temnumber,~] = size(Path);
% plot(Path(1,1),Path(1,2),'+g'); 
% plot(Path(temnumber,1),Path(temnumber,2),'+g'); 

%connect the two start and end points on curve.
endx3 = Path(1,1);
endy3 = Path(1,2);
endx4 = Path(temnumber,1);
endy4 = Path(temnumber,2);
% x = 0:imgw;
% y = ((endy3-endy4)/(endx3-endx4))*x + (endy3-((endy3-endy4)*endx3)/(endx3-endx4));
% plot(x,y,'g');
% hold off;

X3 = [endx3 endy3];
X4 = [endx4 endy4];
Vector2 = X3 - X4;

C=dot(Vector1,Vector2)/(norm(Vector1)*norm(Vector2));
theta_C=acos(C);


%get rotation angle
rotationangle = (theta_C*180/pi);
finalangle = rotationangle;

if f_Check_Possible_Matrix(endx3,endy3,endx4,endy4,imgori,rotationangle) == 1
    finalangle = rotationangle;
    %display('aaa');
end

if f_Check_Possible_Matrix(endx3,endy3,endx4,endy4,imgori,rotationangle+180) == 1
    finalangle = rotationangle+180;
    %display('bbb');
end

if f_Check_Possible_Matrix(endx3,endy3,endx4,endy4,imgori,-rotationangle) == 1
    finalangle = -rotationangle;
    %display('ccc');
end

if f_Check_Possible_Matrix(endx3,endy3,endx4,endy4,imgori,-rotationangle-180) == 1
    finalangle = -rotationangle-180;
    %display('ddd');
end

%rotate image
NewMatrix = imrotate(imgori,finalangle);

%get vector from midpoint to the rest midpoints as well as the assistpoint
[r,c] = find(NewMatrix==1); 
startpointX = min(c);
startpointY = min(r);
recwidth = max(c)-startpointX + 1;
recheight = max(r)-startpointY + 1;

%  figure,imshow(NewMatrix);
%  hold on;
%  rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');
%  hold off;

%get feature 1: oriented bounding box size ratio
CompareNFMaxBoxSizeRatio = recheight/recwidth;
% display(recheight);
% display(recwidth);

%get normalization factor: half perimeter of the oriented bounding box devided
%by 10
NormalizationFactor = (recheight + recwidth)/10;

%get feature 2: path length
[length,~] = size(Path);
ComparePathLength = length;

%get feature 3:distance of endpoints
endx3 = Path(1,1);
endy3 = Path(1,2);
endx4 = Path(temnumber,1);
endy4 = Path(temnumber,2);
CompareDisEnds = sqrt((endx3-endx4).^2+(endy3-endy4).^2);

%get feature 4,5,6: top, middle, bottom block size ratio
[MaBloc1,MaBloc2,MaBloc3] = f_Sub_Matrix_Transfer(NewMatrix);
%block 1:
[topr,topc] = find(MaBloc1==1);
startpointX = min(topc);
startpointY = min(topr);
recwidth = max(topc)-startpointX + 1;
recheight = max(topr)-startpointY + 1;
% figure,imshow(MaBloc1);
% hold on;
% rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');

% TempMatrix = zeros(size(topr,1),2);
% tempindex = 1;
% for mw = 1:size(MaBloc1,1)
%     for mh = 1:size(MaBloc1,2)
%         if MaBloc1(mw,mh) == 1
%             TempMatrix(tempindex,1) = mh;
%             TempMatrix(tempindex,2) = mw;
%             tempindex = tempindex + 1;
%         end
%     end
% end
% MidPointTopX = TempMatrix(round(size(topr,1)/2),1);
% MidPointTopY = TempMatrix(round(size(topr,1)/2),2);
% plot(MidPointTopX,MidPointTopY,'*g');
% hold off;
CompareNFTopBlockSizeRatio = recwidth/recheight;
AreaTopBlock = recwidth * recheight;
%display(feature4);

%block 2:
[midr,midc] = find(MaBloc2==1);
startpointX = min(midc);
startpointY = min(midr);
recwidth = max(midc)-startpointX + 1;
recheight = max(midr)-startpointY + 1;
% figure,imshow(MaBloc2);
% hold on;
% rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');
% 
% TempMatrix = zeros(size(midr,1),2);
% tempindex = 1;
% for mw = 1:size(MaBloc2,1)
%     for mh = 1:size(MaBloc2,2)
%         if MaBloc2(mw,mh) == 1
%             TempMatrix(tempindex,1) = mh;
%             TempMatrix(tempindex,2) = mw;
%             tempindex = tempindex + 1;
%         end
%     end
% end
% MidPointMidX = TempMatrix(round(size(midr,1)/2),1);
% MidPointMidY = TempMatrix(round(size(midr,1)/2),2);
% plot(MidPointMidX,MidPointMidY,'*g');

%print the assist point in the middle block
% AssistPointX = startpointX+recwidth;
% AssistPointY = MidPointMidY;
% plot(AssistPointX,AssistPointY,'+g');
% hold off;
CompareNFMiddleBlockSizeRatio = recwidth/recheight;
AreaMiddleBlock = recwidth * recheight;
%display(feature5);

%block 3:
[botr,botc] = find(MaBloc3==1);
startpointX = min(botc);
startpointY = min(botr);
recwidth = max(botc)-startpointX + 1;
recheight = max(botr)-startpointY + 1;
% figure,imshow(MaBloc3);
% hold on;
% rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');
% 
% %read line and store in the TempMatrix
% TempMatrix = zeros(size(botr,1),2);
% tempindex = 1;
% for mw = 1:size(MaBloc3,1)
%     for mh = 1:size(MaBloc3,2)
%         if MaBloc3(mw,mh) == 1
%             TempMatrix(tempindex,1) = mh;
%             TempMatrix(tempindex,2) = mw;
%             tempindex = tempindex + 1;
%         end
%     end
% end
% MidPointBottomX = TempMatrix(round(size(botr,1)/2),1);
% MidPointBottomY = TempMatrix(round(size(botr,1)/2),2);
% plot(MidPointBottomX,MidPointBottomY,'*g');
% hold off;
CompareNFBottomBlockSizeRatio = recwidth/recheight;
AreaBottomBlock = recwidth * recheight;

%get feature CompareNFBottomTopBlockAreaRatio
CompareNFBottomTopBlockAreaRatio = AreaBottomBlock/AreaTopBlock;

%get feature CompareNFMiddleTopBlockAreaRatio
CompareNFMiddleTopBlockAreaRatio = AreaMiddleBlock/AreaTopBlock;

%get feature CompareNFClosedRegionArea * already normalized
CompareNFClosedRegionArea = f_Get_Region_Area(Path,MatrixGraph);

%get feature CompareRatioConPathandEnd
CompareRatioConPathandEnd = ComparePathLength/CompareDisEnds;

%normalize each feature
CompareDisEnds = CompareDisEnds/NormalizationFactor;
ComparePathLength = ComparePathLength/NormalizationFactor;

csfeature = [CompareDisEnds,...
               ComparePathLength,...
               CompareNFMaxBoxSizeRatio,...
               CompareNFTopBlockSizeRatio,...
               CompareNFMiddleBlockSizeRatio,...
               CompareNFBottomBlockSizeRatio,...
               CompareNFBottomTopBlockAreaRatio,...
               CompareNFMiddleTopBlockAreaRatio,...
               CompareNFClosedRegionArea,...
               CompareRatioConPathandEnd];

end