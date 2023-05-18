function [ similarity ] = f_CS_8_Similarity_DP_BeamAngles( feature1, feature2 )
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
%of points by the standard Dynamic Programming
feature1 = feature1';
feature2 = feature2';
[CostMatrix] = weighted0_tar_cost(feature1, feature2);


%search correspondences using dynamic programming
num_start = size(feature1,2);
search_step	= 1;
thre = 0.0;
[~, match_cost] = mixDPMatching_C(CostMatrix, thre, num_start, search_step);

similarity = 1 - match_cost;

end

