function [ similarity ] = f_CS_7_Similarity_DP_TurningAngles( feature1, feature2 )
%f_CS_7_Matching_TurningAngles: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Longbin Chen, et al., Efficient Partial Shape Matching Using
%          Smith-Waterman Algorithm, CVPR Workshops, 2008



%first step: calculate the cost matrix, the cost matrix doesn't have to be
%symmetrical
length1 = length(feature1);
length2 = length(feature2);
CostMatrix = zeros(length1, length2);

for i = 1:length1
    for j = 1:length2
        CostMatrix(i,j) = abs(feature1(i)-feature2(j))/(abs(feature1(i))+abs(feature2(j))+1);
    end 
end

%search correspondences using dynamic programming
num_start = length1;
search_step	= 1;
thre = 0.0;
[~, match_cost] = f_CS_7_mixDPMatching_C(CostMatrix, thre, num_start, search_step);

similarity = 1 - match_cost;

end

