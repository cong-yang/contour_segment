%first step:in each class, select one object as a query
clear all;
close all;
% foldername = 'MPEG7CS_Small';
% filetype = '.mat';
% alldata = dir(fullfile(['..\..\database\Processed\',foldername,'\',foldername,'_PL\'],['*',filetype]));
% N = size(alldata,1);
% 
% tempquery = randi([1,20],1,70);
% 
% for i = 1:70
%     queryindex = 20*(i-1)+tempquery(i);
%     myobject = alldata(queryindex,1).name;
%     myquery{i,1} = queryindex;
%     myquery{i,2} = myobject;
%     display([num2str(queryindex),': ', myobject]);
% end
% QueryListTimeMPEG7{1} = myquery;

%second step: do the retrieval and estimate the time
%time for feature generation
clear all;
close all;
foldername = 'MPEG7CS_Small';
filetype = '.mat';
sampercen = 1;
alldata = dir(fullfile(['..\..\database\Processed\',foldername,'\',foldername,'_PL\'],['*',filetype]));
N = size(alldata,1);
for i = 1:10
    tic;
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
    temptime(i) = toc
end
T_Feature = sum(temptime)/10;
T_Feature = T_Feature * 1400;
save('resources/T_Feature_PointTriangle.mat','T_Feature');
%%
%time for retrieval
load('resources/QueryListTimeMPEG7.mat');
myquerys = QueryListTimeMPEG7{1}; %sample queries
alldata = QueryListTimeMPEG7{2}; %all data list
mylength = length(alldata);
%%
%runing time for DTW
QueryDTW = myquerys;
for i = 1:length(myquerys)
    myindex = myquerys{i,1};
    csfeature1 = fullfeatures{myindex};
    display([num2str(i), ': ', myquerys{i,2}]);
    tic;
    for j = 1:mylength
        display(['-->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_5_Similarity_DTW_PointTriangle(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryDTW{i,3} = mytime;
end
save('resources/QueryPointTriangleDTW.mat','QueryDTW');
clear QueryDTW;

%%
%runing time for DP
%QueryDP = myquerys;
for i = 65:length(myquerys)
    myindex = myquerys{i,1};
    csfeature1 = fullfeatures{myindex};
    display([num2str(i), ': ', myquerys{i,2}]);
    tic;
    for j = 1:mylength
        display(['-->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_5_Similarity_DP_PointTriangle(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryDP{i,3} = mytime;
end
save('resources/QueryPointTriangleDP.mat','QueryDP');
clear QueryDP;


%runing time for Hungarian
QueryHungarian = myquerys;
for i = 1:length(myquerys)
    myindex = myquerys{i,1};
    csfeature1 = fullfeatures{myindex};
    display([num2str(i), ': ', myquerys{i,2}]);
    tic;
    for j = 1:mylength
        display(['--->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_5_Similarity_Hungarian_PointTriangle(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryHungarian{i,3} = mytime;
end
save('resources/QueryPointTriangleHungarian.mat','QueryHungarian');
clear QueryHungarian;


