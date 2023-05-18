function [ similarity ] = f_CS_10_Similarity_ContourFlexibility( feature1, feature2 )
%f_CS_10_Matching_ContourFlexibility: this function is used to calculate the 
%                                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Chunjing Xu, et al., 2D shape matching by contour flexibility,
%          PAMI, 2009.


[M,~] = size(feature1);
bata = 5;
addi1 = 0;
addi2 = 0;
for i = 1:M
    tmp1 = feature1(i,:); % get row data from feature1
    tmp2 = feature2(i,:); % get row data from feature2
    addi1 = addi1 + std(tmp1);
    addi2 = addi2 + std(tmp2);
end
addi1 = addi1/M;
addi2 = addi2/M;

dissimilarity = 1/(bata+addi1+addi2);
similarity = 1-dissimilarity;



end

