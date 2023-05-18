function [ similarity ] = f_CS_5_Similarity_DTW_PointTriangle( feature1, feature2 )
%f_CS_5_Similarity_DTW_PointTriangle: this function is used to calculate the 
%                                similarity between two features using DTW.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          structure of feature: cell{1}: point location, cell{2}: features
%          the similarity between two contour segment is obtained by the
%          standard histogram intersection.
%          refer to the paper: 
%          ChengEn Lu, et al., Shape Guided Contour Grouping with Particle
%          Fileters, ICCV 2009.
%          http://jccaicedo.blogspot.de/2012/01/histogram-intersection.html

%similarity = 0;
% length1 = size(feature1,1);
% length2 = size(feature2,1);
% CostMatrix = zeros(length1, length2);
% for i = 1:length1
%     fp1 = feature1{i,2};
%     for j = 1:length2   
%         fp2 = feature2{j,2};
%         K = [];
%         for kk = 1:3
%             myf1 = fp1(:,kk);
%             myf2 = fp2(:,kk);
%             K(kk) = 0.5*sum(myf1 + myf2 - abs(myf1 - myf2));
%         end
%         CostMatrix(i,j) = roundn(mean(K),-4);
%         %CostMatrix(i,j) = mean(K);
%     end
% end

%CostMatrix = (CostMatrix - min2(CostMatrix))/(max2(CostMatrix) - min2(CostMatrix));
% CostMatrix = (CostMatrix-min(CostMatrix(:))) ./ (max(CostMatrix(:)-min(CostMatrix(:))));
% CostMatrix = 1-CostMatrix;

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
    fp1 = feature1{i,2};
    for j=max(i-w,1):min(i+w,nt)
        fp2 = feature2{j,2};
        K = [];
        for kk = 1:3
            myf1 = fp1(:,kk);
            myf2 = fp2(:,kk);
            K(kk) = 0.5*sum(myf1 + myf2 - abs(myf1 - myf2));
        end
        oost = mean(K);
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
    end
end
d=D(ns+1,nt+1);
similarity = d;

end

