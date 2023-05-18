function [ csfeature ] = f_CS_13_Feature_LineSegment( ContourSegment )
%f_CS_13_Feature_LineSegment: this function is used to generate contour
%                                    segment descriptor using line segment
%                                    statistics.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using line segment statistics.
%   description:
%          refer to the paper: 
%          Jarbas Joaci de, Shape classification using line segment
%          statistics, Information sciences, 2015.

mylength = size(ContourSegment,1);
%from the paper, we generate t from 5% to 85%
t = (5:85);
csfeature = zeros(length(t),3);
for myt = 1:length(t)
    portionsize = floor(mylength*(t(myt)/100));
    myindex = 1;
    mysegments = [];
    for i = 1:mylength
        %get the location of the portion start point
        pix = ContourSegment(i,1);
        piy = ContourSegment(i,2);
        %get the index of the portion endpoint
        indexj = i+portionsize-1;
        if indexj == 0
            indexj = i+portionsize;
        end
        if indexj <= mylength
            pjx = ContourSegment(indexj,1);
            pjy = ContourSegment(indexj,2);
            
            %calculate the distance between two points and normalise it
            mysegments(myindex) = sqrt((pix-pjx)^2+(piy-pjy)^2)/mylength;
            myindex = myindex + 1;
        end
    end
    %calculate the average mue and standard deviation sita of all line
    %segments at scale myt
    mymue = mean(mysegments);
    mystd = std(mysegments);
    csfeature(myt,1) = t(myt);
    csfeature(myt,2) = mymue;
    csfeature(myt,3) = mystd;
end

end

