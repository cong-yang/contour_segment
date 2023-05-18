function [ similarity ] = f_getDistMatrix(feature1, feature2)

%feature1 = abs(feature1);
%feature2 = abs(feature2);
distmatrix = zeros(length(feature1),length(feature2));
for i = 1:length(feature1)
    for j = 1:length(feature2)
        distmatrix(i,j) = norm(feature1(i)-feature2(j));
    end
end
similarity = distmatrix;

return

end

function [ output ] = sample_Values( Values, m )
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