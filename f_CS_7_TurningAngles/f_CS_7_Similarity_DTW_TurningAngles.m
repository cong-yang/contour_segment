function [ similarity ] = f_CS_7_Similarity_DTW_TurningAngles( feature1, feature2 )
%f_CS_7_Matching_TurningAngles: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Longbin Chen, et al., Efficient Partial Shape Matching Using
%          Smith-Waterman Algorithm, CVPR Workshops, 2008



%first step: calculate the cost matrix, the cost matrix doesn't have to be
%symmetrical
% length1 = length(feature1);
% length2 = length(feature2);
% CostMatrix = zeros(length1, length2);
% 
% for i = 1:length1
%     for j = 1:length2
%         CostMatrix(i,j) = abs(feature1(i)-feature2(j))/(abs(feature1(i))+abs(feature2(j))+1);
%     end 
% end


ns=size(feature1,1);
nt=size(feature2,1);
if size(feature1,2)~=size(feature2,2)
    error('Error in dtw(): the dimensions of the two input signals do not match.');
end
w=Inf;
w = max(w, abs(ns-nt)); % adapt window size

%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;

%% begin dynamic programming
for i=1:ns
    for j=max(i-w,1):min(i+w,nt)
        oost = abs(feature1(i)-feature2(j))/(abs(feature1(i))+abs(feature2(j))+1);
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
    end
end
d=D(ns+1,nt+1);
similarity = 1-d;

end

