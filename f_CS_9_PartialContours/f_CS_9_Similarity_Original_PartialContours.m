function [ similarity ] = f_CS_9_Similarity_Original_PartialContours( A1, A2 )
%f_CS_9_Matching_PartialContours: this function is used to calculate the 
%                                similarity between two features.
%   input: 
%         A1: feature of the first object
%         A2: feature of the second object
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Hayko Riemenschneider, et al., Using partial edge contour
%          matches for efficient object category localization, ECCV 2010.

% %in this algorithm, we assumue that N is bigger or equal than (to) M
% M = size(A1,1);
% N = size(A2,1);
% 
% %first step: build the integral images
% newlength1 = M + M - 1;
% newfeature1 = zeros(newlength1,newlength1);
% newfeature1(1:M,1:M) = A1(:,:);
% 
% newlength2 = M + N - 1;
% newfeature2 = zeros(newlength2,newlength2);
% newfeature2(1:N,1:N) = A2(:,:);
% 
% %start to creat the 3D tensor and the similarity
% myindex = 1;
% for l = 1:M
%     for r = 1:M
%         BlockA1 = newfeature1(r:r+l-1,r:r+l-1);
%         for q = 1:N
%             BlockA2 = newfeature2(q:q+l-1,q:q+l-1);
%             mysimilarity = (sum(sum((BlockA1 - BlockA2).^2)))/(l^2);
%             mytriples(myindex,1) = r;
%             mytriples(myindex,2) = q;
%             mytriples(myindex,3) = l;
%             mytriples(myindex,4) = mysimilarity;
%             myindex = myindex + 1;
%         end
%     end
% end
% 
% %reduce the number of tensors
% slim = 0.5;
% llim = round(M/2);
% myindex = 1;
% for i = 1:size(mytriples,1)
%     if mytriples(i,4) <= slim && mytriples(i,3) >= llim
%         subtensor(myindex,:) = mytriples(i,:);
%         myindex = myindex + 1;
%     end
% end
% 
% %generate (r,q) tuples (r,q) = argmax subtensor(r,q,l)
% allsimis = subtensor(:,4);
% maxvalue = min(allsimis);
% tuberq = subtensor(subtensor(:,4) == maxvalue,:);
% 
% finalset = [];
% for i = 1:size(tuberq,1)
%     if isempty(allmetrics) == 1
%         singleseg(1,:) = tuberq(i,:);
%     else
%         if tuberq(i,1) == singleseg(length)
%     end
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = size(A1,1);
N = size(A2,1);
%r = round(M/2);

%first step: build the integral images
newlength2 = M + N - 1;
newfeature2 = zeros(newlength2,newlength2);
newfeature2(1:N,1:N) = A2(:,:);

for n = 1:N
    MD{n} = A1(1:M, 1:M) - newfeature2(n:(n+M-1), n:(n+M-1));
end

for r = 1:M
    for n = 1:N
        SingleMD = MD{n};
        %calculate the similarity in the window rxr starting at any point on
        %the diagonal.
        for j = 1:(M-r+1)
            submatrix = SingleMD(j:j+r-1,j:j+r-1);
            mysim(j) = sum(sum(abs(submatrix)))/(r*r);
        end
        allsim(n,:) = mysim(:);
        mysim = [];
    end
    diffrsim{r,1} = r;
    diffrsim{r,2} = allsim;
    allsim = [];
end

mythreshold = 0.5;
for i = 1:M
    allsim = diffrsim{i,2};
    %calculate the similarity in single MD
    myindex = 1;
    alldis = [];
    for j = 1:N
        myrow = allsim(j,:);
        minmov = find(myrow<mythreshold);
        if isempty(minmov) == 0
            myvalues = myrow(minmov);
            mydis = sum(myvalues);
            alldis(myindex) = mydis;
            myindex = myindex + 1;
        end
    end
    corres(i,1) = diffrsim{i,1};
    [myvalue,myposition] = min(alldis);
    corres(i,2) = myvalue;
    corres(i,3) = myposition;
end
for i = 1:M
    partiality = 1/corres(i,1);
    dissimilarity = corres(i,2);
    mynorm = norm(partiality,dissimilarity);
    corres(i,4) = mynorm;
    corres(i,5) = partiality;
end
%mynorms = norm(corres(:,1),corres(:,2));
dissimilarity = corres(round(M/2),2);
similarity = 1-dissimilarity;




end

