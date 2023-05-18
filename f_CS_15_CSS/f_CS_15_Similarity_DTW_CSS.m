function [ similarity ] = f_CS_15_Similarity_DTW_CSS( feature1, feature2 )
%f_CS_15_Matching_CSS: this function is used to calculate the 
%                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          A. Rattarangsi, et al., "Scale-based detection of corners of 
%          planar curves," PAMI, 1992.

w=Inf;
ns=length(feature1);
nt=length(feature2);
w=max(w, abs(ns-nt)); % adapt window size

%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;

%% begin dynamic programming
for i=1:ns
    for j=max(i-w,1):min(i+w,nt)
        oost=abs(feature1(i) - feature2(j));
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
        
    end
end
d=D(ns+1,nt+1);
similarity = 1 - d;
end

