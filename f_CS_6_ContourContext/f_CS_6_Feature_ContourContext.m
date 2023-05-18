function [ csfeature ] = f_CS_6_Feature_ContourContext( ContourSegment )
%f_CS_6_Feature_ContourContext: this function is used to generate contour
%                              segment descriptor using point context.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using point context
%   description:
%          refer to the paper: 
%          Qihui Zhu, et al., Contour Context Selection for Object
%          Detection: A Set-to-Set Contour Matching Approach, ECCV 2008

nbins_theta = 12; %number of bins for theta
nbins_r = 5; %number of bins for log(r)
nbins = nbins_theta * nbins_r;
global_mean_dist = [];
for i = 1:size(ContourSegment,1)
        PointX = ContourSegment(i,1);
        PointY = ContourSegment(i,2);
        [PointContextFeature, mean_dist] = f_CS_6_get_Point_Context_Feature(PointX, PointY, ContourSegment, nbins_theta, nbins_r, global_mean_dist);
        global_mean_dist = mean_dist;
        csfeature(i,1:nbins) = PointContextFeature(:,:);
end


end

