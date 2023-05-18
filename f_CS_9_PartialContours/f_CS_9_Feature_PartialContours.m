function [ csfeature ] = f_CS_9_Feature_PartialContours( ContourSegment )
%f_CS_9_Feature_PartialContours: this function is used to generate contour
%                                segment descriptor using Partial Contours.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Partial Contours
%   description:
%          refer to the paper: 
%          Hayko Riemenschneider, et al., Using partial edge contour
%          matches for efficient object category localization, ECCV 2010.
%   different from CS_17, in this function, alphaij is calculated by:
%   alphaij = (a) angle(bibj,bjb(j-delta)) if i < j
%   alphaij = (b) angle(bibj,bjb(j+delta)) if i > j
%   alphaij = (c) 0                        if abs(i-j) <= delta

mylength = size(ContourSegment,1);
delta = 5;
csfeature = zeros(mylength,mylength);
for i = 1:mylength
    %get the reference point p_{i}
    pix = ContourSegment(i,1);
    piy = ContourSegment(i,2);
    
    for j = 1:mylength
        %the first situation
        if i < j
            %get the chord point p_{j}
            pjx = ContourSegment(j,1);
            pjy = ContourSegment(j,2);
        
            %get the chord point p_{j-delta}
            indexq = j - delta;
            if indexq <= 0
                indexq = 1;
            end
            pjdeltax = ContourSegment(indexq,1);
            pjdeltay = ContourSegment(indexq,2);
        
            %calculate the angle alphaij
            vpq = [pjx-pjdeltax, pjy-pjdeltay];
            vpr = [pjx-pix, pjy-piy];
            C = dot(vpq,vpr)/(norm(vpq)*norm(vpr));
            if (norm(vpq)*norm(vpr)) == 0
                C = 1;
            end
            alphaij = acos(C);
        end
        
        %the second situation
        if i > j
            %get the chord point p_{j}
            pjx = ContourSegment(j,1);
            pjy = ContourSegment(j,2);
        
            %get the chord point p_{j-delta}
            indexq = j + delta;
            if indexq >= mylength
                indexq = mylength;
            end
            pjdeltax = ContourSegment(indexq,1);
            pjdeltay = ContourSegment(indexq,2);
        
            %calculate the angle alphaij
            vpq = [pjx-pjdeltax, pjy-pjdeltay];
            vpr = [pjx-pix, pjy-piy];
            C = dot(vpq,vpr)/(norm(vpq)*norm(vpr));
            if (norm(vpq)*norm(vpr)) == 0
                C = 1;
            end
            alphaij = acos(C);
        end
        
        %the third situation
        if abs(i-j) <= delta
            alphaij = 0;
        end
        
        csfeature(i,j) = roundn(alphaij,-4);
    end  
end


end