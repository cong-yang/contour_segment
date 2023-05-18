function [ similarity ] = f_CS_6_Similarity_Hungarian_ContourContext( feature1, feature2 )
%f_CS_5_Matching_PointTriangle: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Qihui Zhu, et al., Contour Context Selection for Object
%          Detection: A Set-to-Set Contour Matching Approach, ECCV 2008

[nsamp1,nbins]=size(feature1);
[nsamp2,nbins]=size(feature2);

BH1n=feature1./repmat(sum(feature1,2)+eps,[1 nbins]);
BH2n=feature2./repmat(sum(feature2,2)+eps,[1 nbins]);
tmp1=repmat(permute(BH1n,[1 3 2]),[1 nsamp2 1]);
tmp2=repmat(permute(BH2n',[3 2 1]),[nsamp1 1 1]);
CostMatrix = 0.5*sum(((tmp1-tmp2).^2)./(tmp1+tmp2+eps),3);

[CostMatrix] = f_Adding_Dummy(CostMatrix);

[~, dissimilarity] = f_Hungarian_Fast(CostMatrix);

similarity = 1-dissimilarity;

end

