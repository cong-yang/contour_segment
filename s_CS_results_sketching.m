clear all;
clc

%myalgorithm = 'DP'; %DTW, DP, Hungarian,
myalgorithm = 'hellinger'; %correlation, intersection, statistics, hellinger
mydataset = 'Sketching';
myfolder = 'f_CS_7_TurningAngles';
mydescriptor = 'TurningAngles';

%generate ground truth
% GT{1}: B A2    GT{6}: D F2
% GT{2}: A B2    GT{7}: C G2
% GT{3}: D C2    GT{8}: B H2
% GT{4}: A D1    GT{9}: A E1
% GT{5}: A F1    GT{10}:B J2
GT{1} = 'A2';
GT{2} = 'B2';
GT{3} = 'C2';
GT{4} = 'D1';
GT{5} = 'F1';
GT{6} = 'F2';
GT{7} = 'G2';
GT{8} = 'H2';
GT{9} = 'E1';
GT{10} = 'J2';

%load result for L1
mylength = 'L1';
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);

for i = 1:length(TotalResults)
    myresults = TotalResults{i}{2};
    firstresult = myresults{1}{1};
    groundtruth = GT{i};
    if strcmp(firstresult,groundtruth) == 1
        collected(i) = 1;
    else
        collected(i) = 0;
    end
end
similarity = (sum(collected))/10;
display(['L1 = ',num2str(similarity)]);

clear collected;
clear TotalResults;
clear mylength;
clear mypath;

%load result for L2
mylength = 'L2';
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);

for i = 1:length(TotalResults)
    myresults = TotalResults{i}{2};
    firstresult = myresults{1}{1};
    groundtruth = GT{i};
    if strcmp(firstresult,groundtruth) == 1
        collected(i) = 1;
    else
        collected(i) = 0;
    end
end
similarity = (sum(collected))/10;
display(['L2 = ',num2str(similarity)]);

clear collected;
clear TotalResults;
clear mylength;
clear mypath;

%load result for L3
mylength = 'L3';
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);

for i = 1:length(TotalResults)
    myresults = TotalResults{i}{2};
    firstresult = myresults{1}{1};
    groundtruth = GT{i};
    if strcmp(firstresult,groundtruth) == 1
        collected(i) = 1;
    else
        collected(i) = 0;
    end
end
similarity = (sum(collected))/10;
display(['L3 = ',num2str(similarity)]);

clear collected;
clear TotalResults;
clear mylength;
clear mypath;


%load result for L3
mylength = 'L4';
mypath = [myfolder,'/resources/results/Re-RichCS-',myalgorithm,'-',mydataset,'-',mydescriptor,'-',mylength];
load(mypath);

for i = 1:length(TotalResults)
    myresults = TotalResults{i}{2};
    firstresult = myresults{1}{1};
    groundtruth = GT{i};
    if strcmp(firstresult,groundtruth) == 1
        collected(i) = 1;
    else
        collected(i) = 0;
    end
end
similarity = (sum(collected))/10;
display(['L4 = ',num2str(similarity)]);

clear collected;
clear TotalResults;
clear mylength;
clear mypath;




