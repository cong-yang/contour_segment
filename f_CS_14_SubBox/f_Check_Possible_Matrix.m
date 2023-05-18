function [ boolen_rotated ] = f_Check_Possible_Matrix( endx3,endy3,endx4,endy4,OriMatrix, angle )
%CheckPossibleMatrix: check possible rotation angle
%     Input:  
%            OriMatrix reconstructed matrix
%            angle: potation rotation angle
%     Output:
%            boolen_rotated: 1 meet the demand, 2 don't meet the demand
boolen_rotated = 2;
mymatrix = OriMatrix;
oristartX = endx3;
oristartY = endy3;
oriendX = endx4;
oriendY = endy4;

    
    
    tempmatrix = zeros(size(mymatrix,1),size(mymatrix,2));
    tempmatrix(oristartY,oristartX) = 100;
    tempmatrix(oriendY,oriendX) = 100;
    rotatedtemp = imrotate(tempmatrix, angle, 'bilinear');

    %figure,imshow(rotatedtemp);
    
    rotatedmatrix = imrotate(mymatrix, angle,'bilinear');
    %display(size(rotatedmatrix,1));
    
    imcombine = rotatedmatrix + rotatedtemp;
%     figure,imshow(imcombine);
%     hold on;
    tempindex = 1;
    for mm = 1:size(rotatedtemp,1)
        for kk = 1:size(rotatedtemp,2)
            if rotatedtemp(mm,kk)>5
                %plot(kk,mm,'*r');
                NewEndPoints(tempindex,1) = mm;
                NewEndPoints(tempindex,2) = kk;
                tempindex = tempindex + 1;
            end
        end
    end
    
    newstartpointX = NewEndPoints(1,2);
    newendpointX = NewEndPoints(size(NewEndPoints,1),2);
%     if size(NewEndPoints,1) < 2
%         boolen_rotated = 2;
%         return;
%     end
%     display(NewEndPoints);
%     display(newstartpointX);
%     display(newendpointX);
    
    [r,c] = find(imcombine>=1);
    startpointX = min(c);
    startpointY = min(r);
    recwidth = max(c)-startpointX;
    recheight = max(r)-startpointY;
%     rectangle('Position',[startpointX,startpointY,recwidth,recheight],'LineWidth',1,'EdgeColor','r');
%     plot(startpointX+round(recwidth/2),startpointY,'sg');
%     plot(startpointX+round(recwidth/2),startpointY+recheight,'sg');
    
    midpoint = startpointX+round(recwidth/2);
%     display(midpoint);
% 
%     display(newstartpointX);
%     display(newendpointX);
    
    maxrow = max(c);
    minrow = min(c);
    %display(maxrow);
    
    if abs(newstartpointX-newendpointX)<=2 && newstartpointX < midpoint 
        if maxrow > newstartpointX && (abs(maxrow - newstartpointX) >= abs(minrow-newstartpointX))
            boolen_rotated = 1;
        end
    end
    
    if abs(newstartpointX-newendpointX)<=2 && abs(midpoint-newstartpointX)<=1
        if maxrow > midpoint
            boolen_rotated = 1;
            %display('3333');
        end
    end
    
%     if abs(newstartpointX-newendpointX)<=2 && newstartpointX >= midpoint
%         if maxrow > midpoint && (abs(maxrow - newstartpointX) <= abs(minrow-newstartpointX))
%             boolen_rotated = 1;
%             %display('3333');
%         end
%     end
end
