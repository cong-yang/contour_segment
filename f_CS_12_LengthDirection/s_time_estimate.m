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
tic;
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_12_Feature_LengthDirection(pointlist);
    fullfeatures{i} = csfeature;
end
T_Feature = toc;
save('resources/T_Feature_LengthDirection.mat','T_Feature');
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
        %display(['--->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_12_Similarity_DTW_LengthDirection(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryDTW{i,3} = mytime;
end
save('resources/QueryDTWLengthDirection.mat','QueryDTW');
clear QueryDTW;

%%
%runing time for DP
QueryDP = myquerys;
for i = 1:length(myquerys)
    myindex = myquerys{i,1};
    csfeature1 = fullfeatures{myindex};
    display([num2str(i), ': ', myquerys{i,2}]);
    tic;
    for j = 1:mylength
        %display(['--->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_12_Similarity_DP_LengthDirection(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryDP{i,3} = mytime;
end
save('resources/QueryDPLengthDirection.mat','QueryDP');
clear QueryDP;

%%
%runing time for Hungarian
%QueryHungarian = myquerys;
for i = 16:length(myquerys)
    myindex = myquerys{i,1};
    csfeature1 = fullfeatures{myindex};
    display([num2str(i), ': ', myquerys{i,2}]);
    tic;
    for j = 1:mylength
        %display(['--->',num2str(j)]);
        csfeature2 = fullfeatures{j};
        [similarity] = f_CS_12_Similarity_Hungarian_LengthDirection(csfeature1, csfeature2);
    end
    mytime = toc;
    QueryHungarian{i,3} = mytime;
end
save('resources/QueryHungarianLengthDirection.mat','QueryHungarian');
clear QueryHungarian;


