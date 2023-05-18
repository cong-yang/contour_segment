function [ output ] = f_sample_Points( path, m )
%Samples the given path in m Points and returns this Matrix

output = zeros(m,size(path,2));


output(1,:) = path(1,:);
output(m,:) = path(size(path,1),:);

idx = 1;
step = size(path,1)/(m-1);
for i=2:m-1
    idx = idx+step;
    output(i,:) = path(floor(idx),:);
end

end

