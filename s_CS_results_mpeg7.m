clear all;
clc

mylength = 'L4';
%myalgorithm = 'Hungarian'; %DTW, DP, Hungarian,
myalgorithm = 'hellinger'; %correlation, intersection, statistics, hellinger
mydataset = 'MPEG7';
myfolder = 'f_CS_7_TurningAngles';
mydescriptor = 'TurningAngles';
topcount = 40;

%load the results
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);
AllResults = TotalResults;

%calculate the bullus-eye score
[ bullseye ] = f_Data_Analyzing( AllResults, topcount);

