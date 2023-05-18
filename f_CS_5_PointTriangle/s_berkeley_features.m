%this script is used to calculate the features of MPEG7 with different
%length L1, L2, L3, L4

clear all;
close all;
foldername = 'BerkeleyCS';
filetype = '.mat';
alldata = dir(fullfile(['..\..\database\Processed\',foldername,'\',foldername,'_PL\'],['*',filetype]));
N = size(alldata,1);

%find the shortest length among all contour segments
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    mylength = size(pointlist,1);
    alllength(i) = mylength;
end

samplength = min(alllength);

sampercen = 0.25;
samlabel = 'L1';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(samplength*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-','Berkeley','-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.50;
samlabel = 'L2';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(samplength*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-','Berkeley','-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.75;
samlabel = 'L3';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(samplength*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-','Berkeley','-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 1;
samlabel = 'L4';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(samplength*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-','Berkeley','-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;
