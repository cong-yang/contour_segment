function [ lengthes ] = f_collect_lengthes( N, alldata, filetype, foldername )
%f_collect_lengthes: this function is used to collect length of cs

myindex = 1;
for i =1:N
    object1 = alldata(i,1).name;
    tempname =  regexp(object1,filetype,'split');
    objectname1 = tempname{1};
    %display([num2str(i),': ',objectname1]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',object1]);
    mylength1 = round(size(pointlist,1)*0.25);
    mylength2 = round(size(pointlist,1)*0.50);
    mylength3 = round(size(pointlist,1)*0.75);
    mylength4 = size(pointlist,1);
    lengthes(myindex) = mylength1;
    myindex = myindex + 1;
    lengthes(myindex) = mylength2;
    myindex = myindex + 1;
    lengthes(myindex) = mylength3;
    myindex = myindex + 1;
    lengthes(myindex) = mylength4;
    myindex = myindex + 1;
end

lengthes = unique(lengthes);

end

