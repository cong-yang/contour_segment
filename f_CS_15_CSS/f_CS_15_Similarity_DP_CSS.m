function [ similarity ] = f_CS_15_Similarity_DP_CSS( feature1, feature2 )
%f_CS_15_Matching_CSS: this function is used to calculate the 
%                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          A. Rattarangsi, et al., "Scale-based detection of corners of 
%          planar curves," PAMI, 1992.

%generate cost matrix
mylength1 = length(feature1);
mylength2 = length(feature2);
costmatrix = zeros(mylength1,mylength2);

for i = 1:mylength1
    for j = 1:mylength2
        costmatrix(i,j) = abs(feature1(i) - feature2(j));
    end
end

num_start = mylength1;
search_step	= 1;
thre = 0.0;

[~, match_cost] = mixDPMatching_C(costmatrix, thre, num_start, search_step);

similarity = 1 - match_cost;
end

