function [ csfeature ] = f_CS_17_Feature_ChordDistributions( ContourSegment )
%f_CS_17_Feature_ChordDistributions: this function is used to generate contour
%                                    segment descriptor using Chrod distributions.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Chrod distributions.
%   description:
%          refer to the paper: 
%          M. Donoser, et al., "Partial Shape Matching of Outer Contours" 
%          ACCV, 2009.

mylength = size(ContourSegment,1);
delta = 5;
csfeature = zeros(mylength,mylength);
for i = 1:mylength
    %get the reference point p_{i}
    pix = ContourSegment(i,1);
    piy = ContourSegment(i,2);
    
    for j = 1:mylength
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
        if norm(vpq)*norm(vpr) == 0
            C = 1;
        end
        alphaij = acos(C);
        csfeature(i,j) = roundn(alphaij,-4);
    end  
end

end