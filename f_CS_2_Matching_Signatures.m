function [ similarity ] = f_CS_2_Matching_Signatures( feature1, feature2, featype )
%f_CS_2_Matching_Signatures: this function is used to calculate the similarity 
%                            between different contour signatures.
%   input: 
%         feature1: feature of the first object
%         feature2: feature of the second object
%         featype: the feature type
%   output:
%          similarity: similarity between two contour segments
%   description:
%          type of contour segment signatures:
%          1. comcoor: complex coordinates (refer to shape_descriptors_survey_part2.pdf, page 29)
%          2. cendistance: centroid distance function (refer to shape_descriptors_survey_part2.pdf, page 30)
%          3. tangent: tangent angles (refer to shape_descriptors_survey_part2.pdf, page 31)
%          4. curvature: curvature function (refer to shape_descriptors_survey_part2.pdf, page 34)
%          5. area: area function (refer to shape_descriptors_survey_part2.pdf, page 36)
%          6. tar: triangle area representation (refer to shape_descriptors_survey_part2.pdf, page 38)
%          7. chord: chord length function (refer to shape_descriptors_survey_part2.pdf, page 41)

if strcmp(featype, 'cendistance') || strcmp(featype, 'chord') || strcmp(featype, 'area')
    %Feature is Rotation and Translation Invariant

    %in smaller scale there are less points. -> Interpolate and Sample
    %points to the count of the shorter vector
    
    [feature1 feature2] = interpol_sample_Values(feature1,feature2);
        
    %get Scale invariant values
    feature1 = feature1/norm(feature1);
    feature2 = feature2/norm(feature2);
    
    similarity = hellinger(feature1,feature2);
    return 
end

if strcmp(featype, 'tangent')
    %Feature is Translation Invariant
    
    %in smaller scale there are less points. -> Interpolate and Sample
    %points to the count of the shorter vector
    
    %to make Interpolation Work, modification of angles is needed
    feature1 = prepare_angles(feature1);
    feature2 = prepare_angles(feature2);
    
    [feature1 feature2] = interpol_sample_Values(feature1,feature2);
    
    %Feature is Scaling Invariant
    %Rotation invariance by setting mean to 0
    feature1 = feature1-mean(feature1);
    feature2 = feature2-mean(feature2);
    
    feature1 = mod(feature1,360);
    feature2 = mod(feature2,360);
    
    %Feature is Rotation Invariant
    %Calculating Similarity
    
    similarity = hellinger(feature1,feature2);
    return
end

if strcmp(featype, 'curvature') || strcmp(featype, 'tar')
    %Feature is Rotation and Translation Invariant

    %in smaller scale there are less points. -> Interpolate and Sample
    %points to the count of the shorter vector
    
    [feature1 feature2] = interpol_sample_Values(feature1,feature2);
        
    %get Scale invariant values
    feature1 = feature1/norm(feature1);
    feature2 = feature2/norm(feature2);
    
    %for hellinger only positive values -> shift values
    offset = min(min(feature1),min(feature2));
    feature1 = feature1-offset;
    feature2 = feature2-offset;
    
    similarity = hellinger(feature1,feature2);
    return
end

if strcmp(featype, 'comcoor')
    %Feature is Translation invariant
    [theta,rho] = cart2pol(real(feature1),imag(feature1));
    trans1 = [theta rho];
    [theta,rho] = cart2pol(real(feature2),imag(feature2));
    trans2 = [theta rho];
    %Make values Scale invariant
    trans1(:,2) = trans1(:,2)/norm(trans1(:,2));
    trans2(:,2) = trans2(:,2)/norm(trans2(:,2));
    
    %Make rotation invariant
    trans1(:,1) = trans1(:,1) - min(trans2(:,1));
    trans2(:,1) = trans2(:,1) - min(trans2(:,1));
    
    %interpolate
    [trans1 trans2] = interpol_sample_Values(trans1,trans2);
    
    sim1 = hellinger(trans1(:,1),trans2(:,1));
    sim2 = hellinger(trans1(:,2),trans2(:,2));
    similarity=(sim1+sim2)*0.5;
    return 
end

similarity = 0;

feature1
feature2
return
l = min([length(feature1) length(feature2)]);

feature1 = sample_Values(feature1,l);
feature2 = sample_Values(feature2,l);


%if strcmp(featype, 'comcoor')
%    feature1 = abs(feature1)
%    feature2 = abs(feature2);
%    return
%end

feature1 = abs(feature1);
feature2 = abs(feature2);

sum1 = sum(feature1);
sum2 = sum(feature2);
tempnumerator = 0;
tempdenminator = sqrt(sum1*sum2);
for i = 1:l
    tempnumerator = tempnumerator + sqrt(feature1(i)*feature2(i));
end
(tempnumerator/tempdenminator)
dissimilarity = sqrt(1-(tempnumerator/tempdenminator));
similarity = 1 - dissimilarity;

return

end

function feature = prepare_angles(feature)
    for i=1:length(feature)-1
       dist = feature(i+1)-feature(i);
       if dist>180
           %feature(i)     ->0
           %feature(i+1)   ->360
           feature(i) = feature(i)+360;
       else
           if dist <-180
               %feature2(i)     ->360
               %feature2(i+1)   ->0
               feature(i+1) = feature(i+1)+360;
           end
       end
   end
end

function value = interpolate_Value(vector,pos)
%Gives Back the interpolated Value of Position pos

%vector is standing Vector containing all Values
%pos is real number between 1 and length(vector)
    lo = floor(pos);
    up = lo+1;
    mpos = pos - lo;
    if mpos <= 1e-3
       value = vector(lo,:);
    else
        value = mpos*vector(up,:)+(1-mpos)*vector(lo,:);
    end
end

function [feature1 feature2] = interpol_sample_Values(feature1,feature2)
    if length(feature1)<length(feature2)
        tmp = feature1;
        feature1=feature2;
        feature2=tmp;
    end
    %if length is not equal, feature1 is longer and needs to be shortend
    if length(feature1)>length(feature2) %interpolate and Sample
        step = (length(feature1)-1)/(length(feature2)-1);
        pos = 1;
        nfeature1 = zeros(size(feature2))
        nfeature1(1,:) = feature1(1,:);
        for i = 1:length(feature2)-1
            pos = pos+step;
            nfeature1(i+1,:) = interpolate_Value(feature1,pos);
        end
        feature1 = nfeature1;
    end
end

function similarity = hellinger(feature1,feature2)
    sum1 = sum(feature1);
    sum2 = sum(feature2);
    tempnumerator = 0;
    tempdenminator = sqrt(sum1*sum2);
    for i = 1:length(feature1)
        tempnumerator = tempnumerator + sqrt(feature1(i)*feature2(i));
    end
    dissimilarity = sqrt(1-(tempnumerator/tempdenminator));
    similarity = 1 - dissimilarity;
end

function output = sample_Values( Values, m )
%Samples the given Values in m Points and returns this Matrix

output = zeros(m,size(Values,2));


output(1,:) = Values(1,:);
output(m,:) = Values(size(Values,1),:);

idx = 1;
step = size(Values,1)/(m-1);
for i=2:m-1
    idx = idx+step;
    output(i,:) = Values(floor(idx),:);
end


end

