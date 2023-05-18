function [ csfeature ] = f_CS_7_Feature_TurningAngles( ContourSegment )
%f_CS_7_Feature_TurningAngles: this function is used to generate contour
%                              segment descriptor using Turning Angles.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Turning Angles
%   description:
%          refer to the paper: 
%          Longbin Chen, et al., Efficient Partial Shape Matching Using
%          Smith-Waterman Algorithm, CVPR Workshops, 2008

mylength = size(ContourSegment,1);

%since the endpoints of contour segment have no immediate predecessor or
%immediate successor point, we only calculate the turning anlge for the
%points between (2,mylength-1).
myindex = 1;
for i = 2:mylength-1
    %current point p
    px = ContourSegment(i,1);
    py = ContourSegment(i,2);
    
    %immediate predecessor q
    qx = ContourSegment(i-1,1);
    qy = ContourSegment(i-1,2);
    
    %immediate successor r
    rx = ContourSegment(i+1,1);
    ry = ContourSegment(i+1,2);
    
    %calculate the turning angle qpr
    vpq = [px-qx, py-qy];
    vpr = [px-rx, py-ry];
    C = dot(vpq,vpr)/(norm(vpq)*norm(vpr));
    qpr = acos(C);
    
    csfeature(myindex) = qpr;
    myindex = myindex + 1;
end

end

