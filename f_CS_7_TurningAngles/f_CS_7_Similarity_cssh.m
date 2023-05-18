function [ similarity ] = f_CS_7_Similarity_cssh( feature1, feature2, method )
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
%          Cong Yang, et al., Shape-Based Object Retrieval by Contour Segment 
%          Matching, ICIP 2014.

n = length(feature1);

%dissimilarity method1: correlation
if strcmp(method,'correlation') == 1
    tempnumerator = 0;
    temp1 = 0;
    temp2 = 0;
    sum1 = sum(feature1)/n;
    sum2 = sum(feature2)/n;
    for i = 1:n
        tempnumerator = tempnumerator + (feature1(i) - sum1)*(feature2(i) - sum2);
        temp1 = temp1 + (feature1(i) - sum1)^2;
        temp2 = temp2 + (feature2(i) - sum2)^2;
    end
    tempdenminator = sqrt(temp1*temp2);

    similarity = tempnumerator/tempdenminator;
end

%dissimilarity method2: histogram intersection
if strcmp(method,'intersection') == 1
    tempnumerator = 0;
    tempdenminator = 0;
    for i = 1:n
        tempnumerator = tempnumerator + min(feature1(i),feature2(i));
        tempdenminator = tempdenminator + max(feature1(i),feature2(i));
    end
    similarity = tempnumerator/tempdenminator;
end

%dissimilarity method3: x^2 statistics
if strcmp(method,'statistics') == 1
    dissimilarity = 0;
    for i = 1:n
        dissimilarity = dissimilarity + ((feature1(i)-feature2(i))^2)/(feature1(i)+feature2(i));
    end
    similarity = 1 - dissimilarity;
end

%dissimilarity method4: hellinger (or Bhattacharyya coefficient)
if strcmp(method,'hellinger') == 1
    sum1 = sum(feature1);
    sum2 = sum(feature2);
    tempnumerator = 0;
    tempdenminator = sqrt(sum1*sum2);
    for i = 1:n
        tempnumerator = tempnumerator + sqrt(feature1(i)*feature2(i));
    end
    dissimilarity = sqrt(1-(tempnumerator/tempdenminator));
    similarity = 1 - dissimilarity;
end



end

