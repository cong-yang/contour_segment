function [ similarity ] = f_CS_11_Similarity_DTW_OptPartialContours( feature1, feature2 )
%f_CS_10_Matching_ContourFlexibility: this function is used to calculate the 
%                                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Peter Kontschieder, et al., Discriminative learning of contour
%          fragments for object detection, BMVC 2011.

dissimilarity = f_dtw(feature1,feature2);

similarity = 1 - dissimilarity;

% w=Inf;
% 
% ns=length(feature1);
% nt=length(feature2);
% w=max(w, abs(ns-nt)); % adapt window size
% 
% %% initialization
% D=zeros(ns+1,nt+1)+Inf; % cache matrix
% D(1,1)=0;
% 
% %% begin dynamic programming
% for i=1:ns
%     feasegment1 = feature1{i};
%     for j=max(i-w,1):min(i+w,nt)
%         feasegment2 = feature2{j};
%         oost=(sum(sum((feasegment1 - feasegment2).^2)))/(size(feasegment1,1)^2);
%         D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
%         
%     end
% end
% d=D(ns+1,nt+1);
% 
% similarity = 1-d;
% %%
% mythres = 0.5; %setup some threshold for removing some useless segments
% mylength1 = length(feature1);
% mylength2 = length(feature2);
% 
% for i = 1:mylength1
%     feasegment1 = feature1{i};
%     for j = 1:mylength2
%         feasegment2 = feature2{j};
%         DisCost(i,j) = (sum(sum((feasegment1 - feasegment2).^2)))/(size(feasegment1,1)^2);
%     end
% end
% 
% %normalise the distance into [0,1]
% maxvalue = max(max(DisCost));
% DisCost = DisCost./maxvalue;
% 
% [Corresponding, ~] = f_Hungarian_Fast(DisCost);
% 
% 
% dissimilarity = 0;
% myindex = 0;
% for i = 1:length(Corresponding)
%     if DisCost(i,Corresponding(i)) <= mythres
%         dissimilarity = dissimilarity + DisCost(i,Corresponding(i));
%         myindex = myindex + 1;
%     end
% end
% 
% if myindex == 0
%     similarity = 0;
% else
%     similarity = 1- dissimilarity/myindex;
% end
end

