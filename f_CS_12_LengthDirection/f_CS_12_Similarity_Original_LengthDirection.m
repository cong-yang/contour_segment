function [ similarity ] = f_CS_12_Similarity_Original_LengthDirection( feature1, feature2 )
%f_CS_10_Matching_ContourFlexibility: this function is used to calculate the 
%                                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Tianyang Ma, et al., From partial shape matching through local
%          deformation to robust global shape similarity for object
%          detection, CVPR 2011.

FullDistanceMatrix1 = feature1{1};
FullAngleMatrix1 = feature1{2};
FullDistanceMatrix2 = feature2{1};
FullAngleMatrix2 = feature2{2};

pointnum1 = size(FullDistanceMatrix1,1);
pointnum2 = size(FullDistanceMatrix2,1);
similaritymatrix = zeros(pointnum1,pointnum2);
for i = 1:pointnum1
    DistanceMatrix1 = FullDistanceMatrix1(i,:);
    AngleMatrix1 = FullAngleMatrix1(i,:);
    for j = 1:pointnum2
        DistanceMatrix2 = FullDistanceMatrix2(j,:);
        AngleMatrix2 = FullAngleMatrix2(j,:);
        [mysimilarity] = f_get_similarity_angledis(DistanceMatrix1, DistanceMatrix2, AngleMatrix1, AngleMatrix2);
        similaritymatrix(i,j) = mysimilarity/2;
    end
end

similarity = sum(sum(similaritymatrix))/(pointnum1*pointnum2);

% similaritymatrix = -1 * similaritymatrix;
% [NewCostMatrix] = f_Adding_Dummy( DistanceMatrix1, DistanceMatrix2, similaritymatrix);
% [corres, dissimilarity] = f_Hungarian_Corresponding(NewCostMatrix);
% similarity = - dissimilarity;

end

