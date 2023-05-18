function [ csfeature ] = f_CS_1_Feature_Simples( ContourSegment, featype )
    %f_CS_1_Feature_Simples: this function is used to generate simple contour
    %                       segment descriptors.
    %   input:
    %         ContourSegment: a single contour segment
    %         featype: the feature type
    %   output:
    %          csfeature: the contour segment feature for different types
    %   description:
    %          type of contour segment feature:
    %          1. area: the area between cs and the connection line between
    %                   two endpoints.
    %          2. circularity: perimeter^2/area (perimeter = length along the
    %          contour)
    %          3. eccentricity: length of major axis/length of minor axis (refers to the shape_descriptors_svrvey.pdf, page 15)
    %          4. bending: average bending energy (refers to the shape_descriptors_svrvey.pdf, page 13)
    %          5. rectangularity: might be eccentricity? Bounding box rectangle (refers to the shape_descriptors_svrvey.pdf, page 17 and page 20)
    %          6. lineratio: How similar to a straight line (refers to the shape_descriptors_svrvey.pdf, page 18)
    %          7. profiles: The profiles are the projection of the shape to
    %             x-axis and y-axis on Cartesian corrdinates system.(refers to the shape_descriptors_svrvey.pdf, page 24)
    %          8. convexity: convexity is defined as the ratio of permeters of
    %             the convex hull over that of original contour. (refers to the shape_descriptors_svrvey.pdf, page 21)
    %          9. solidity: solidity describes the extent to which the shape is convex or concave.
    %             (refers to the shape_descriptors_svrvey.pdf, page 22)
    %          10. dislength: ratio between distance of endpoints and contour length
    
    csfeature = 0;
    if strcmp(featype,'area')
        csfeature = length(ContourSegment)/getArea(ContourSegment);
        return;
    end
    if strcmp(featype,'circularity')
        len_CS = length(ContourSegment);
        csfeature = (len_CS*len_CS)/getArea(ContourSegment);
        return;
    end
    if strcmp(featype,'eccentricity') || strcmp(featype,'rectangularity')
        cog = sum(ContourSegment)/length(ContourSegment); %cog(1) = g_x;cog(2) = g_y
        matsum = zeros(2,2);
        for i=1:length(ContourSegment)
           diff = ContourSegment(i,:) - cog;
           matsum = matsum + transpose(diff)*diff;
        end
        C = matsum/length(ContourSegment);
        sum_xx_yy = C(1,1)+C(2,2);
        sqrt_ = sqrt( sum_xx_yy*sum_xx_yy - 4*( C(1,1)*C(2,2) - C(1,2)*C(1,2)));
        l1 = 1/2 * (sum_xx_yy+sqrt_);
        l2 = 1/2 * (sum_xx_yy-sqrt_);
        csfeature = l1/l2;
        return;
    end
    if strcmp(featype,'bending')
       curvature = [ContourSegment(2,:)-ContourSegment(1,:)];
       for i = 2:length(ContourSegment)-1
           curvature = [ curvature;ContourSegment(i+1,:)-ContourSegment(i-1,:)];
       end
       curvature = [curvature; ContourSegment(length(ContourSegment),:) - ContourSegment(length(ContourSegment)-1,:)];
       curvsum = 0;
       for i = 1:length(curvature)
           curvsum = curvsum + curvature(i)*curvature(i);
       end
       csfeature = curvsum/length(curvature);
       return;
    end
    if strcmp(featype,'dislength') || strcmp(featype,'lineratio')
        csfeature = norm(ContourSegment(1,:)-ContourSegment(end,:))/length(ContourSegment);
        return;
    end
    if strcmp(featype,'profiles')
        csfeature = {ContourSegment(:,1) ContourSegment(:,2)};
        return;
    end
    if strcmp(featype,'convexity')
        l_orig = length(ContourSegment);
        l_conv = length(convhull(ContourSegment(:,1),ContourSegment(:,2)));
        csfeature = l_conv/l_orig;
        return;
    end
    if strcmp(featype,'solidity')
        csfeature = getArea(ContourSegment)/getConvexArea(ContourSegment);
        return;
    end
    
end

function area = getConvexArea(ContourSegment)
    k = convhull(ContourSegment(:,1),ContourSegment(:,2));

    convexsegment = [];
    for i=1:length(ContourSegment)
        I = find(k==i);
        if length(I)>0
            convexsegment = [convexsegment; ContourSegment(i,:)];
        end
    end
    
    area = polyarea(convexsegment(:,1),convexsegment(:,2));

end

function point = projPointOnLine(point, line)
    %PROJPOINTONLINE Project of a point orthogonally onto a line
    %
    %   PT2 = projPointOnLine(PT, LINE).
    %   Computes the (orthogonal) projection of point PT onto the line LINE.
    %
    %   Function works also for multiple points and lines. In this case, it
    %   returns multiple points.
    %   Point PT1 is a [N*2] array, and LINE is a [N*4] array (see createLine
    %   for details). Result PT2 is a [N*2] array, containing coordinates of
    %   orthogonal projections of PT1 onto lines LINE.
    %
    %   Example
    %     line = [0 2  2 1];
    %     projPointOnLine([3 1], line)
    %     ans =
    %          2   3
    %
    %   See also:
    %   lines2d, points2d, isPointOnLine, linePosition
    %
    %   ---------
    %   author : David Legland
    %   INRA - TPV URPOI - BIA IMASTE
    %   created the 07/04/2005.
    %
    
    %   HISTORY
    %   2005-08-06 correct bug when several points were passed as param.
    %   2012-08-23 remove repmats
    
    % direction vector of the line
    vx = line(:, 3);
    vy = line(:, 4);
    
    % difference of point with line origin
    dx = point(:,1) - line(:,1);
    dy = point(:,2) - line(:,2);
    
    % Position of projection on line, using dot product
    tp = (dx .* vx + dy .* vy ) ./ (vx .* vx + vy .* vy);
    
    % convert position on line to cartesian coordinates
    point = [line(:,1) + tp .* vx, line(:,2) + tp .* vy];
end

function area = getArea(ContourSegment)
    x1 = ContourSegment(1,:);
    x2 = ContourSegment(end,:);
    vec = x2-x1;
    
    linepoints = [];
    distances = [];
    alpha = [];
    
    %uncomment for plot
    %close all
    %axis equal
    %hold on
    
    for i=1:length(ContourSegment)
        x3 = ContourSegment(i,:);
        x4 = projPointOnLine(x3, [x1 vec]);
        d = norm(x3-x4);
        diff = x4 - x1;
        a = diff(1)/ vec(1);
        
        linepoints = [linepoints; x4];
        distances = [distances; d];
        alpha = [alpha; a];
        
        %uncomment for plot
        %x=[x3(1),x4(1)];
        %y=[x3(2),x4(2)];
        %plot(x4(1),x4(2),'ro');
        %plot(x3(1),x3(2),'b+');
        %plot(x,y);
        
    end
    
    area = 0;
    
    for i=1:length(linepoints)-1
        dist = distances(i)+distances(i+1);
        dist = dist/2;
        area = area + dist*(alpha(i+1)-alpha(i));
    end
    area = area*norm(x1-x2);
    
end
