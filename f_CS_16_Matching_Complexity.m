function [ similarity ] = f_CS_16_Matching_Complexity( feature1, feature2 )
%f_CS_17_Matching_ChordDistributions: this function is used to calculate the 
%                                     similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Junwei Wang, et al., shape matching and classification using 
%          height functions, Pattern Recognition Letters, 2012

%%%%%%%%additional factor: shape complexity%%%%%%%%%%%%%%%%%%%%%%%
% [M,~] = size(feature1);
 bata = 5;
% addi1 = 0;
% addi2 = 0;
% for i = 1:M
%     tmp1 = feature1(i,:); % get row data from feature1
%     tmp2 = feature2(i,:); % get row data from feature2
%     addi1 = addi1 + std(tmp1);
%     addi2 = addi2 + std(tmp2);
% end
% addi1 = addi1/M;
% addi2 = addi2/M;

dissimilarity = (feature1 - feature2)/(feature1 + feature2 + bata);
similarity = -dissimilarity;
end

