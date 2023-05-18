function [ similarity ] = f_CS_17_Similarity_Hungarian_ChordDistributions( feature1, feature2 )
%f_CS_17_Matching_ChordDistributions: this function is used to calculate the 
%                                     similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          M. Donoser, et al., "Partial Shape Matching of Outer Contours" 
%          ACCV, 2009.


[costmat] = weighted0_tar_cost(feature1, feature2);
[~,dissimilarity] = f_Hungarian_Fast(costmat);
similarity = 1-dissimilarity;

end

