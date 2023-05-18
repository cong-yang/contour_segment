function [ similarity ] = f_CS_6_Similarity_DTW_ContourContext( feature1, feature2 )
%f_CS_6_Similarity_DTW_ContourContext: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Qihui Zhu, et al., Contour Context Selection for Object
%          Detection: A Set-to-Set Contour Matching Approach, ECCV 2008

% if size(feature1,2) ~= size(feature2,2) || size(feature1,1) ~= size(feature2,1)
%     disp(['----error appears: feature1=[',num2str(size(feature1,1)),',',...
%         num2str(size(feature1,2)),']',' feature2=[',num2str(size(feature2,1)),...
%         ',',num2str(size(feature2,2)),']']);
%     return;
% end

match_cost = f_dtw(feature1,feature2);
similarity = 1-match_cost;


end

