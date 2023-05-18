function [ similarity, coorespondings ] = f_CS_3_Similarity_DP_HeightFunction( feature1, feature2 )
%f_CS_3_Matching_HeightFunction: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Junwei Wang, et al., shape matching and classification using 
%          height functions, Pattern Recognition Letters, 2012


similarity = 0;
coorespondings = 0;

num_start = size(feature1,2);
search_step	= 1;
thre = 0.0;

if size(feature1,2) ~= size(feature2,2) || size(feature1,1) ~= size(feature2,1)
    disp(['----error appears: feature1=[',num2str(size(feature1,1)),',',...
        num2str(size(feature1,2)),']',' feature2=[',num2str(size(feature2,1)),...
        ',',num2str(size(feature2,2)),']']);
    return;
end

[costmat] = weighted0_tar_cost(feature1, feature2);
[cvec, match_cost] = mixDPMatching_C(costmat, thre, num_start, search_step);

coorespondings = cvec;

%%%%%%%%additional factor: shape complexity%%%%%%%%%%%%%%%%%%%%%%%
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

dissimilarity = match_cost/(bata+addi1+addi2);
similarity = 1-dissimilarity;
end

