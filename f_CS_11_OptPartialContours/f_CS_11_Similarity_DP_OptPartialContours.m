function [ similarity ] = f_CS_11_Similarity_DP_OptPartialContours( feature1, feature2 )
%f_CS_10_Matching_ContourFlexibility: this function is used to calculate the 
%                                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Peter Kontschieder, et al., Discriminative learning of contour
%          fragments for object detection, BMVC 2011.

% mythres = 0.5; %setup some threshold for removing some useless segments
% mylength1 = length(feature1);
% mylength2 = length(feature2);
% 
% for i = 1:mylength1
%     feasegment1 = feature1{i};
%     for j = 1:mylength2
%         feasegment2 = feature2{j};
%         DisCost(i,j) = (sum(sum((feasegment1 - feasegment2).^2)))/(size(feasegment1,1)^2);
%     end
% end
% 
% %normalise the distance into [0,1]
% maxvalue = max(max(DisCost));
% if sum(sum(DisCost)) == 0
%     similarity = 1;
%     return;
% else
%     DisCost = DisCost./maxvalue;
% end
% 
% num_start = length(feature1);
% search_step	= 1;
% thre = 0.0;
% [Corresponding, ~] = mixDPMatching_C(DisCost, thre, num_start, search_step);
% 
% dissimilarity = 0;
% myindex = 0;
% for i = 1:length(Corresponding)
%     if DisCost(i,Corresponding(i)) <= mythres
%         dissimilarity = dissimilarity + DisCost(i,Corresponding(i));
%         myindex = myindex + 1;
%     end
% end
% 
% if myindex == 0
%     similarity = 0;
% else
%     similarity = 1- dissimilarity/myindex;
% end



[CostMatrix] = weighted0_tar_cost(feature1, feature2);

%search correspondences using dynamic programming
num_start = size(feature1,2);
search_step	= 1;
thre = 0.0;
[~, match_cost] = mixDPMatching_C(CostMatrix, thre, num_start, search_step);

similarity = 1 - match_cost;
end

