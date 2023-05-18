clear all;
clc

mylength = 'L4';
%myalgorithm = 'Hungarian'; %DTW, DP, Hungarian,
myalgorithm = 'hellinger'; %correlation, intersection, statistics, hellinger
mydataset = 'Berkeley';
myfolder = 'f_CS_7_TurningAngles';
mydescriptor = 'TurningAngles';

toucount = 100;
appletopcount = 44;
bottletopcount = 55;
giraffetopcount = 92;
mugtopcount = 48;
swantopcount = 32;

%first step: load results
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);
AllResults = TotalResults;

%start to collect and check the results, top 100
for i = 1:length(AllResults)
    singlecell = AllResults{i};
    queryname = singlecell{1};
    queryresults = singlecell{2};
    
    %get query type
    tempcategory = regexp(queryname,'\d*','split');
    querytype = tempcategory{1};
    %check the topcount and analyze the results
    for j = 1:toucount
        resultname = queryresults{j}{1};
        tempcategory = regexp(resultname,'\d*','split');
        resulttype = tempcategory{1};
        if strcmp(querytype,resulttype) == 1
            myresults(i,j) = 1;
        else
            myresults(i,j) = 0;
        end
    end
end

%%
%start to calculate the recall and precision
%applelogo: 1-44
myindex = 1;
for i = 1:44
    numcorrect = sum(myresults(i,:));
    myrecall(myindex) = numcorrect/appletopcount;
    myprecision(myindex) = numcorrect/toucount;
    myindex = myindex + 1;
end
meanrecall(1) = mean(myrecall); 
meanprecision(1) = mean(myprecision);
clear myrecall;
clear myprecision;

%%
%bottles: 45-99
myindex = 1;
for i = 45:99
    numcorrect = sum(myresults(i,:));
    myrecall(myindex) = numcorrect/bottletopcount;
    myprecision(myindex) = numcorrect/toucount;
    myindex = myindex + 1;
end
meanrecall(2) = mean(myrecall); 
meanprecision(2) = mean(myprecision);
clear myrecall;
clear myprecision;

%%
%giraffes: 100-191
myindex = 1;
for i = 100:191
    numcorrect = sum(myresults(i,:));
    myrecall(myindex) = numcorrect/giraffetopcount;
    myprecision(myindex) = numcorrect/toucount;
    myindex = myindex + 1;
end
meanrecall(3) = mean(myrecall); 
meanprecision(3) = mean(myprecision);
clear myrecall;
clear myprecision;

%%
%mugs: 192-239
myindex = 1;
for i = 192:239
    numcorrect = sum(myresults(i,:));
    myrecall(myindex) = numcorrect/mugtopcount;
    myprecision(myindex) = numcorrect/toucount;
    myindex = myindex + 1;
end
meanrecall(4) = mean(myrecall); 
meanprecision(4) = mean(myprecision);
clear myrecall;
clear myprecision;
%%
%swans: 240-271
myindex = 1;
for i = 240:271
    numcorrect = sum(myresults(i,:));
    myrecall(myindex) = numcorrect/swantopcount;
    myprecision(myindex) = numcorrect/toucount;
    myindex = myindex + 1;
end
meanrecall(5) = mean(myrecall); 
meanprecision(5) = mean(myprecision);
clear myrecall;
clear myprecision;

%print the final recall and precision
recall = mean(meanrecall);
precision = mean(meanprecision);

display(['recall = ', num2str(recall), ' precision = ', num2str(precision)]);
