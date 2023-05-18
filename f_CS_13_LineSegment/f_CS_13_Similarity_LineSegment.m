function [ similarity ] = f_CS_13_Similarity_LineSegment( feature1, feature2, method )
%f_CS_10_Matching_ContourFlexibility: this function is used to calculate the 
%                                      similarity between two features.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%         method: correlation, intersection, statistics, hellinger
%   output:
%          similarity: similarity between two contour segments
%   description:
%          refer to the paper: 
%          Jarbas Joaci de, Shape classification using line segment
%          statistics, Information sciences, 2015.


n = size(feature1,1);

%dissimilarity method1: correlation
if strcmp(method,'correlation') == 1
    tempnumerator = 0;
    temp1 = 0;
    temp2 = 0;
    sum1 = sum(feature1(:,2))/n;
    sum2 = sum(feature2(:,2))/n;
    for i = 1:n
        tempnumerator = tempnumerator + (feature1(i,2) - sum1)*(feature2(i,2) - sum2);
        temp1 = temp1 + (feature1(i,2) - sum1)^2;
        temp2 = temp2 + (feature2(i,2) - sum2)^2;
    end
    tempdenminator = sqrt(temp1*temp2);
    %similarity based on mean value
    similarity1 = tempnumerator/tempdenminator;
    
    tempnumerator = 0;
    temp1 = 0;
    temp2 = 0;
    sum1 = sum(feature1(:,3))/n;
    sum2 = sum(feature2(:,3))/n;
    for i = 1:n
        tempnumerator = tempnumerator + (feature1(i,3) - sum1)*(feature2(i,3) - sum2);
        temp1 = temp1 + (feature1(i,3) - sum1)^2;
        temp2 = temp2 + (feature2(i,3) - sum2)^2;
    end
    tempdenminator = sqrt(temp1*temp2);
    %similarity based on standard diviation
    similarity2 = tempnumerator/tempdenminator;
    %final similarity
    similarity = (similarity1 + similarity2)/2;
end

%dissimilarity method2: histogram intersection
if strcmp(method,'intersection') == 1
    tempnumerator = 0;
    tempdenminator = 0;
    for i = 1:n
        tempnumerator = tempnumerator + min(feature1(i,2),feature2(i,2));
        tempdenminator = tempdenminator + max(feature1(i,2),feature2(i,2));
    end
    %similarity based on the mean value
    similarity1 = tempnumerator/tempdenminator;
    
    tempnumerator = 0;
    tempdenminator = 0;
    for i = 1:n
        tempnumerator = tempnumerator + min(feature1(i,3),feature2(i,3));
        tempdenminator = tempdenminator + max(feature1(i,3),feature2(i,3));
    end
    %similarity based on the standard diviation
    similarity2 = tempnumerator/tempdenminator;
    
    %final similarity
    similarity = (similarity1 + similarity2)/2;
end

%dissimilarity method3: x^2 statistics
if strcmp(method,'statistics') == 1
    dissimilarity = 0;
    for i = 1:n
        tempcal = ((feature1(i,2)-feature2(i,2))^2)/(feature1(i,2)+feature2(i,2));
        if isnan(tempcal)
            tempcal = 0;
        end
        dissimilarity = dissimilarity + tempcal;
    end
    %similarity based on the mean value
    similarity1 = 1 - dissimilarity;
    
    dissimilarity = 0;
    for i = 1:n
        tempcal = ((feature1(i,3)-feature2(i,3))^2)/(feature1(i,3)+feature2(i,3));
        if isnan(tempcal)
            tempcal = 0;
        end
        dissimilarity = dissimilarity + tempcal;
    end
    %similarity based on the standard diviation
    similarity2 = 1 - dissimilarity;
    
    %final similarity
    similarity = (similarity1 + similarity2)/2;
end

%dissimilarity method4: hellinger (or Bhattacharyya coefficient)
if strcmp(method,'hellinger') == 1
    sum1 = sum(feature1(:,2));
    sum2 = sum(feature2(:,2));
    tempnumerator = 0;
    tempdenminator = sqrt(sum1*sum2);
    for i = 1:n
        tempnumerator = tempnumerator + sqrt(feature1(i,2)*feature2(i,2));
    end
    dissimilarity = sqrt(1-(tempnumerator/tempdenminator));
    %similarity based on the mean value
    similarity1 = 1 - dissimilarity;
    
    sum1 = sum(feature1(:,3));
    sum2 = sum(feature2(:,3));
    tempnumerator = 0;
    tempdenminator = sqrt(sum1*sum2);
    for i = 1:n
        tempnumerator = tempnumerator + sqrt(feature1(i,3)*feature2(i,3));
    end
    dissimilarity = sqrt(1-(tempnumerator/tempdenminator));
    %similarity based on the standard diviation
    similarity2 = 1 - dissimilarity;
    
    %final similarity
    similarity = (similarity1 + similarity2)/2;
end

end

