function [ newmatrix1, newmatrix2, newmatrix3 ] = f_Sub_Matrix_Transfer( OriMatrix )
%submatrixtransfer transfer the old matrix into three sub matrix with same
%height, and output these three submatrix
% input: rotated matrix
% output: three sub matrix

[r,c] = find(OriMatrix==1); 

startpointX = min(c);
startpointY = min(r);
recwidth = max(c)-startpointX;
recheight = max(r)-startpointY;

% figure,imshow(OriMatrix);
% hold on;
% rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');

%split the rotated image into three parts
sprecheight = round(recheight/3);
% x = startpointX:startpointX+recwidth;
% y1 = startpointY + sprecheight;
% y2 = startpointY + 2 * sprecheight;
% plot(x,y1,'g');
% plot(x,y2,'g');

%scanning the original image matrix and split it
newmatrix1 = OriMatrix(startpointY:startpointY+sprecheight,startpointX:startpointX+recwidth);
newmatrix2 = OriMatrix(startpointY+sprecheight:startpointY+2*sprecheight,startpointX:startpointX+recwidth);
if (startpointY+3*sprecheight) >= size(OriMatrix,1)
    newmatrix3 = OriMatrix(startpointY+2*sprecheight:size(OriMatrix,1),startpointX:startpointX+recwidth);
else
    newmatrix3 = OriMatrix(startpointY+2*sprecheight:startpointY+3*sprecheight,startpointX:startpointX+recwidth);
end
% hold off;
end