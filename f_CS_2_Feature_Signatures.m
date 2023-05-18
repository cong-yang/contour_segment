function [ csfeature ] = f_CS_2_Feature_Signatures( ContourSegment, featype )
%f_CS_2_Feature_Signatures: this function is used to generate contour signatures.
%   input: 
%         ContourSegment: a single contour segment
%         featype: the feature type
%   output:
%          csfeature: the contour segment feature for different types
%   description:
%          type of contour segment signatures:
%         x 1. comcoor: complex coordinates (refer to shape_descriptors_survey_part2.pdf, page 29)
%         x 2. cendistance: centroid distance function (refer to shape_descriptors_survey_part2.pdf, page 30)
%         x 3. tangent: tangent angles (refer to shape_descriptors_survey_part2.pdf, page 31)
%         x 4. curvature: curvature function (refer to shape_descriptors_survey_part2.pdf, page 34)
%         x 5. area: area function (refer to shape_descriptors_survey_part2.pdf, page 36)
%         x 6. tar: triangle area representation (refer to shape_descriptors_survey_part2.pdf, page 38)
%         x 7. chord: chord length function (refer to shape_descriptors_survey_part2.pdf, page 41)

csfeature = 0;

if strcmp(featype, 'chord')
    param = 3;
    
    csfeature=[];
    x2=ContourSegment(:,1);
    y2=ContourSegment(:,2);
    
    %plot(x2,y2,'rx');
    for i=1+param:length(ContourSegment)-param
        tangent = ContourSegment(i+param,:)-ContourSegment(i-param,:);
        tangent = tangent/norm(tangent);
        perpend = [tangent(2) -tangent(1)];
        p1 = ContourSegment(i,:)+1000*perpend;
        p2 = ContourSegment(i,:)-1000*perpend;
        x1 = [p1(1);p2(1)];
        y1 = [p1(2);p2(2)];
        [xi, yi] = polyxpoly(x1,y1,x2,y2);
        alldist = [];
        for j = 1:length(xi)
            p = [xi(j) yi(j)];
            dist = norm(ContourSegment(i,:)-p);
            if dist>0
                alldist = [alldist;dist];
            end            
        end
        %if intersection found, dist is measured
        if length(alldist)>0
            csfeature = [csfeature; min(alldist)];
        %else calculate dist to connecting line from first and last cs-point
        else
            fst = ContourSegment(1,:);
            lst = ContourSegment(length(ContourSegment),:);
            vec = lst-fst;
            fst = fst - 10*vec;
            lst = lst + 10*vec;
            x3 = [fst(1) lst(1)];
            y3 = [fst(2) lst(2)];
            [xi, yi] = polyxpoly(x1,y1,x3,y3);
            p = [xi(j) yi(j)];
            csfeature = [csfeature; norm(ContourSegment(i,:)-p)];
        end
    end
    return
end

if strcmp(featype, 'tar')
    %need delta to define measuring distance in [0,1]
    delta = 0.3;
    
    csfeature = [];
    t_s = round(delta * (length(ContourSegment)/2-2) +1);
    for i=1+t_s:length(ContourSegment)-t_s
        A = [ContourSegment(i-t_s,1) ContourSegment(i-t_s,2) 1;
            ContourSegment(i,1) ContourSegment(i,2) 1;
            ContourSegment(i+t_s,1) ContourSegment(i+t_s,2) 1];
        csfeature = [csfeature; det(A)];
    end
    return
end


if strcmp(featype, 'curvature')
    %need delta to define measuring distance
    delta = 4;
    
    
    line = [];
    for i=1:length(ContourSegment)-delta
        line = [line; i i+delta];
    end
    csfeature = LineCurvature2D(ContourSegment,line);
    return
end

if strcmp(featype, 'area')
    csfeature = [];
    cog = mean(ContourSegment);
    for i=1:length(ContourSegment)-1
       x = [cog(1);ContourSegment(i,1);ContourSegment(i+1,1)];
       y = [cog(2);ContourSegment(i,2);ContourSegment(i+1,2)];
       csfeature = [csfeature;polyarea(x,y)];
    end
    return
end

if strcmp(featype, 'tangent')
    %Need Parameter for windowsize... otherwise just 45° steps
    param = 5;
    
    csfeature = [];
    for i=1:length(ContourSegment)-param
        tangent = ContourSegment(i+param,:)-ContourSegment(i,:);
        angle = atan2(tangent(2), tangent(1));
        if (angle < 0)
            angle = angle + 2 * pi;
        end
        csfeature = [csfeature; angle/(2*pi) * 360];
    end
end
    
if strcmp(featype, 'cendistance')

    %axis equal
    %hold on
    csfeature = [];
    cog = mean(ContourSegment);
    %plot(0,0,'go');
    for i=1:length(ContourSegment)
       relpos = ContourSegment(i,:)-cog;
       tmpdist = sqrt(relpos(1)^2+relpos(2)^2);
       %plot(relpos(1),relpos(2),'r*');
       angle = atan2(relpos(2), relpos(1));
       if (angle < 0)
           angle = angle + 2 * pi;
       end
       angle = angle/(2*pi) * 360;
       %csfeature = [csfeature; [angle tmpdist]]; %this includes angle
       csfeature = [csfeature; tmpdist];
       %if i>1
       %   plot([i-1; i],[csfeature(i-1); csfeature(i)]); 
       %end
    end
    return
end

if strcmp(featype, 'comcoor')
    csfeature = [];
    cog = mean(ContourSegment);
    for j=1:length(ContourSegment)
        tmp = ContourSegment(j,:) - cog;
        csfeature = [csfeature; complex(tmp(1),tmp(2))];
    end
    return
end

function k=LineCurvature2D(Vertices,Lines)
% This function calculates the curvature of a 2D line. It first fits 
% polygons to the points. Then calculates the analytical curvature from
% the polygons;
%
%  k = LineCurvature2D(Vertices,Lines)
% 
% inputs,
%   Vertices : A M x 2 list of line points.
%   (optional)
%   Lines : A N x 2 list of line pieces, by indices of the vertices
%         (if not set assume Lines=[1 2; 2 3 ; ... ; M-1 M])
%
% outputs,
%   k : M x 1 Curvature values
%
%
%
% Example, Circle
%  r=sort(rand(15,1))*2*pi;
%  Vertices=[sin(r) cos(r)]*10;
%  Lines=[(1:size(Vertices,1))' (2:size(Vertices,1)+1)']; Lines(end,2)=1;
%  k=LineCurvature2D(Vertices,Lines);
%
%  figure,  hold on;
%  N=LineNormals2D(Vertices,Lines);
%  k=k*100;
%  plot([Vertices(:,1) Vertices(:,1)+k.*N(:,1)]',[Vertices(:,2) Vertices(:,2)+k.*N(:,2)]','g');
%  plot([Vertices(Lines(:,1),1) Vertices(Lines(:,2),1)]',[Vertices(Lines(:,1),2) Vertices(Lines(:,2),2)]','b');
%  plot(sin(0:0.01:2*pi)*10,cos(0:0.01:2*pi)*10,'r.');
%  axis equal;
%
% Example, Hand
%  load('testdata');
%  k=LineCurvature2D(Vertices,Lines);
%
%  figure,  hold on;
%  N=LineNormals2D(Vertices,Lines);
%  k=k*100;
%  plot([Vertices(:,1) Vertices(:,1)+k.*N(:,1)]',[Vertices(:,2) Vertices(:,2)+k.*N(:,2)]','g');
%  plot([Vertices(Lines(:,1),1) Vertices(Lines(:,2),1)]',[Vertices(Lines(:,1),2) Vertices(Lines(:,2),2)]','b');
%  plot(Vertices(:,1),Vertices(:,2),'r.');
%  axis equal;
%
% Function is written by D.Kroon University of Twente (August 2011)

% If no line-indices, assume a x(1) connected with x(2), x(3) with x(4) ...
if(nargin<2)
    Lines=[(1:(size(Vertices,1)-1))' (2:size(Vertices,1))'];
end

% Get left and right neighbor of each points
Na=zeros(size(Vertices,1),1); Nb=zeros(size(Vertices,1),1);
Na(Lines(:,1))=Lines(:,2); Nb(Lines(:,2))=Lines(:,1);

% Check for end of line points, without a left or right neighbor
checkNa=Na==0; checkNb=Nb==0;
Naa=Na; Nbb=Nb;
Naa(checkNa)=find(checkNa); Nbb(checkNb)=find(checkNb);

% If no left neighbor use two right neighbors, and the same for right... 
Na(checkNa)=Nbb(Nbb(checkNa)); Nb(checkNb)=Naa(Naa(checkNb));

% Correct for sampeling differences
Ta=-sqrt(sum((Vertices-Vertices(Na,:)).^2,2));
Tb=sqrt(sum((Vertices-Vertices(Nb,:)).^2,2)); 

% If no left neighbor use two right neighbors, and the same for right... 
Ta(checkNa)=-Ta(checkNa); Tb(checkNb)=-Tb(checkNb);

% Fit a polygons to the vertices 
% x=a(3)*t^2 + a(2)*t + a(1) 
% y=b(3)*t^2 + b(2)*t + b(1) 
% we know the x,y of every vertice and set t=0 for the vertices, and
% t=Ta for left vertices, and t=Tb for right vertices,  
x = [Vertices(Na,1) Vertices(:,1) Vertices(Nb,1)];
y = [Vertices(Na,2) Vertices(:,2) Vertices(Nb,2)];
M = [ones(size(Tb)) -Ta Ta.^2 ones(size(Tb)) zeros(size(Tb)) zeros(size(Tb)) ones(size(Tb)) -Tb Tb.^2];
invM=inverse3(M);
a(:,1)=invM(:,1,1).*x(:,1)+invM(:,2,1).*x(:,2)+invM(:,3,1).*x(:,3);
a(:,2)=invM(:,1,2).*x(:,1)+invM(:,2,2).*x(:,2)+invM(:,3,2).*x(:,3);
a(:,3)=invM(:,1,3).*x(:,1)+invM(:,2,3).*x(:,2)+invM(:,3,3).*x(:,3);
b(:,1)=invM(:,1,1).*y(:,1)+invM(:,2,1).*y(:,2)+invM(:,3,1).*y(:,3);
b(:,2)=invM(:,1,2).*y(:,1)+invM(:,2,2).*y(:,2)+invM(:,3,2).*y(:,3);
b(:,3)=invM(:,1,3).*y(:,1)+invM(:,2,3).*y(:,2)+invM(:,3,3).*y(:,3);

% Calculate the curvature from the fitted polygon
k = 2*(a(:,2).*b(:,3)-a(:,3).*b(:,2)) ./ ((a(:,2).^2+b(:,2).^2).^(3/2));

function  Minv  = inverse3(M)
% This function does inv(M) , but then for an array of 3x3 matrices
adjM(:,1,1)=  M(:,5).*M(:,9)-M(:,8).*M(:,6);
adjM(:,1,2)=  -(M(:,4).*M(:,9)-M(:,7).*M(:,6));
adjM(:,1,3)=  M(:,4).*M(:,8)-M(:,7).*M(:,5);
adjM(:,2,1)=  -(M(:,2).*M(:,9)-M(:,8).*M(:,3));
adjM(:,2,2)=  M(:,1).*M(:,9)-M(:,7).*M(:,3);
adjM(:,2,3)=  -(M(:,1).*M(:,8)-M(:,7).*M(:,2));
adjM(:,3,1)=  M(:,2).*M(:,6)-M(:,5).*M(:,3);
adjM(:,3,2)=  -(M(:,1).*M(:,6)-M(:,4).*M(:,3));
adjM(:,3,3)=  M(:,1).*M(:,5)-M(:,4).*M(:,2);
detM=M(:,1).*M(:,5).*M(:,9)-M(:,1).*M(:,8).*M(:,6)-M(:,4).*M(:,2).*M(:,9)+M(:,4).*M(:,8).*M(:,3)+M(:,7).*M(:,2).*M(:,6)-M(:,7).*M(:,5).*M(:,3);
Minv=bsxfun(@rdivide,adjM,detM);






