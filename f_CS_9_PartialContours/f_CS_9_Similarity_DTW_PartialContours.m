function [ similarity ] = f_CS_9_Similarity_DTW_PartialContours( feature1, feature2 )
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
%of points by the standard Dynamic Time Warping (DTW).


dissimilarity = f_dtw(feature1,feature2);

similarity = 1 - dissimilarity;

end

