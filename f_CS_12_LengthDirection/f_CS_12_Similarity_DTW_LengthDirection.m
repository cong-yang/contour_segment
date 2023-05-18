function [ similarity ] = f_CS_12_Similarity_DTW_LengthDirection( feature1, feature2 )
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


w=Inf;
ns=size(FullDistanceMatrix1,1);
nt=size(FullDistanceMatrix2,1);
w=max(w, abs(ns-nt)); % adapt window size

%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;

%% begin dynamic programming
for i=1:ns
    DistanceMatrix1 = FullDistanceMatrix1(i,:);
    AngleMatrix1 = FullAngleMatrix1(i,:);
    for j=max(i-w,1):min(i+w,nt)
        DistanceMatrix2 = FullDistanceMatrix2(j,:);
        AngleMatrix2 = FullAngleMatrix2(j,:);
        oost = f_get_similarity_angledis(DistanceMatrix1, DistanceMatrix2, AngleMatrix1, AngleMatrix2);
        oost = -oost;
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
        
    end
end
d=D(ns+1,nt+1);
similarity = 1 - d;

end

