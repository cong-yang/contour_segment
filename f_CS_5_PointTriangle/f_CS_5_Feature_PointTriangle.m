function [ csfeature ] = f_CS_5_Feature_PointTriangle( ContourSegment )
%f_CS_5_Feature_PointTriangle: this function is used to generate contour
%                              segment descriptor using point triangle.
%   input: 
%         ContourSegment: a single contour segment, all points are ordered
%                         along with the clockwise.
%   output:
%          csfeature: the contour segment feature using Point triangle
%   description:
%          refer to the paper: 
%          ChengEn Lu, et al., Shape Guided Contour Grouping with Particle
%          Fileters, ICCV 2009.
%    Given a point A /in X, a shape descriptor of A is a hitogram of all
%    triangles spanned by A and all pairs of points B,C /in X, where point
%    A,B,C must be different.

mylength = size(ContourSegment,1);
lengthlist = (1:mylength)';
allpairwise = combntns(lengthlist,2);

%normalization factor: average pairwise distance of points in CS
facnorm = mean(pdist(ContourSegment,'euclidean'));

%calculate the triangle feature for each point, however, we need to ignore 
%the first and last point. For every triangleBAC, points B, A, C are
%oriented countourclockwise.
indexpoint = 1;
for i = 1:mylength
    Ax = ContourSegment(i,1);
    Ay = ContourSegment(i,2);
    %Start to calculate the point feature
    myindex = 1;
    myfeature = [];
    for j = 1:size(allpairwise,1)
        indexB = allpairwise(j,1); %point B
        indexC = allpairwise(j,2); %point C
        if i ~= indexB && i ~= indexC
            Bx = ContourSegment(indexB,1);
            By = ContourSegment(indexB,2);
            Cx = ContourSegment(indexC,1);
            Cy = ContourSegment(indexC,2);
            
            %start to calculate feature
            %the first feature of point A: angle BAC
            vAB = [Ax-Bx, Ay-By];
            vAC = [Ax-Cx, Ay-Cy];
            C=dot(vAB,vAC)/(norm(vAB)*norm(vAC));
            BAC=acos(C);
            %rotationangle = (BAC*180/pi);
            %the second feature of point A: distance AB
            AB = norm(vAB)/facnorm;
            %the third feature of point A: distance AC
            AC = norm(vAC)/facnorm;
            myfeature(myindex,:) = [BAC, AB, AC];
            myindex = myindex + 1;
        end
    end
    
    csfeature{indexpoint,1} = [Ax, Ay];
    csfeature{indexpoint,2} = myfeature;
    indexpoint = indexpoint + 1;
end

end

