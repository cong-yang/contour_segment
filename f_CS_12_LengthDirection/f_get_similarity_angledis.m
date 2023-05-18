function [ similarity ] = f_get_similarity_angledis( DistanceMatrix1, DistanceMatrix2, AngleMatrix1, AngleMatrix2 )
%f_get_similarity_points: this algorithm is used to calculate the 
%                         similarity between two contour segments 
%                         with the feature of point
%   input:
%         DistanceMatrix1: distance matrix for the first segment
%         AngleMatrix1:    angle matrix for the first segment
%         DistanceMatrix2: distance matrix for the second segment
%         AngleMatrix2:    angle matrix for the second segment
%   output:
%         similarity: similarity between two contour segments

mylength = length(DistanceMatrix1);
AffMatDistance = zeros(1,mylength);
AffMatAngle = zeros(1,mylength);
sigma = 0.2;
alpha = pi/4;

for i = 1:mylength
    fenzi = (DistanceMatrix1(i) - DistanceMatrix2(i)).^2;
    fenmu = (sigma*DistanceMatrix1(i)).^2;
    if fenmu == 0
        if fenmu == fenzi
            AffMatDistance(i) = 1;
        else
            fenmu = (sigma*DistanceMatrix2(i)).^2;
            AffMatDistance(i) = exp(-((fenzi)/(fenmu)));
        end
    else
        AffMatDistance(i) = exp(-((fenzi)/(fenmu)));
    end
    
    fenmu = alpha*alpha;
    fenzi = (AngleMatrix1(i) - AngleMatrix2(i)).^2;
    AffMatAngle(i) = exp(-((fenzi)/(fenmu)));
end

AffMat = AffMatDistance + AffMatAngle;
similarity = sum(sum(AffMat))/mylength;

end

