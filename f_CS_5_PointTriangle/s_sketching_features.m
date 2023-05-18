%this script is used to calculate the features of MPEG7 with different
%length L1, L2, L3, L4

clear all;
close all;
foldername = 'SketchingCS';
filetype = '.mat';
alldata = dir(fullfile(['..\..\database\Processed\',foldername,'\',foldername,'_PL\'],['*',filetype]));
N = size(alldata,1);

sampercen = 0.15;
samlabel = 'L1';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-',foldername,'-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;
%%
sampercen = 0.30;
samlabel = 'L2';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-',foldername,'-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.45;
samlabel = 'L3';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-',foldername,'-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.60;
samlabel = 'L4';
for i = 1:N
    myobject = alldata(i,1).name;
    display(['feature-',num2str(i),': ',myobject]);
    %load the pointlist of CS
    load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
    pointnum = round(100*sampercen);
    pointlist = f_sample_Points(pointlist, pointnum);
    [csfeature] = f_CS_5_Feature_PointTriangle(pointlist);
    fullfeatures{i} = csfeature;
end
save(['Feature-',foldername,'-PointTriangle-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

