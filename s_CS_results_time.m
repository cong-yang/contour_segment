clear all;
clc

myfolder = 'f_CS_7_TurningAngles/resources';
myname = 'TurningAngles';

%load feature generation
load([myfolder,'/','T_Feature_',myname,'.mat']);
display(['Feature Generation: ',num2str(T_Feature/(60*60))]);

%load DTW
load([myfolder,'/','QueryDTW',myname,'.mat']);
alltime = 0;
for i = 1:length(QueryDTW)
    mytime = QueryDTW{i,3}*20;
    alltime = alltime + mytime;
end
mytime = alltime/(60*60);
display(['DTW: ', num2str(mytime)]);

%load DP
load([myfolder,'/','QueryDP',myname,'.mat']);
alltime = 0;
for i = 1:length(QueryDP)
    mytime = QueryDP{i,3}*20;
    alltime = alltime + mytime;
end
mytime = alltime/(60*60);
display(['DP: ', num2str(mytime)]);

%load Hungarian
load([myfolder,'/','QueryHungarian',myname,'.mat']);
alltime = 0;
for i = 1:length(QueryHungarian)
    mytime = QueryHungarian{i,3}*20;
    alltime = alltime + mytime;
end
mytime = alltime/(60*60);
display(['Hungarian: ', num2str(mytime)]);

%%
%temp
alltime = 0;
for i = 1:length(Queryhellinger)
    mytime = Queryhellinger{i,3}*20;
    alltime = alltime + mytime;
end
mytime = alltime/(60*60);
display(['Correlation: ', num2str(mytime)]);

