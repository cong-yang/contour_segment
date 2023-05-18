function [ similarity ] = f_CS_1_Matching_Simples( feature1, feature2, featype )
%f_CS_1_Matching_Simples: this function is used to calculate the similarity 
%                        between different simple features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%         featype: the feature type
%   output:
%          similarity: similarity between two contour segments
%   description:
%          type of contour segment feature:
%          1. area: the area between cs and the connection line between
%                   two endpoints. (normalised by cs length)
%          2. circularity: perimeter^2/area
%          3. eccentricity: length of major axis/length of minor axis (refers to the shape_descriptors_svrvey.pdf, page 15)
%          4. bending: average bending energy (refers to the shape_descriptors_svrvey.pdf, page 13)
%          5. rectangularity: Bounding box rectangle (refers to the shape_descriptors_svrvey.pdf, page 17 and page 20)
%          6. lineRatio: How similar to a straight line (refers to the shape_descriptors_svrvey.pdf, page 18)
%          7. profiles: The profiles are the projection of the shape to
%             x-axis and y-axis on Cartesian corrdinates system.(refers to the shape_descriptors_svrvey.pdf, page 24)
%          8. convexity: convexity is defined as the ratio of permeters of
%             the convex hull over that of original contour. (refers to the shape_descriptors_svrvey.pdf, page 21)
%          9. solidity: solidity describes the extent to which the shape is convex or concave. 
%             (refers to the shape_descriptors_svrvey.pdf, page 22)
%          10. dislength: ratio between distance of endpoints and contour length

similarity = 0;

if strcmp(featype, 'profiles')
   return 
end

%if strcmp(featype,'area') || strcmp(featype,'circularity') || strcmp(featype,'eccentricity')
    %normalize
    features = [feature1 feature2] / max([feature1 feature2])
    similarity =  min(features);
    return;
%end


end

