function [ similarity ] = f_CS_8_Similarity_Hungarian_BeamAngles( feature1, feature2 )
%f_CS_8_Matching_BeamAngles: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Nadia Payet, et al., From a set of shapes to object 
%          discovery, ECCV 2010.

%Similarity between two contours is estimated by alignling their sequences
%of points by the standard Hungarian algorithm

feature1 = feature1';
feature2 = feature2';
[CostMatrix] = weighted0_tar_cost(feature1, feature2);

[~,match_cost] = f_Hungarian_Fast(CostMatrix);
similarity = 1-match_cost;

end

