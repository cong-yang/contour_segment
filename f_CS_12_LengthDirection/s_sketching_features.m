%this script is used to calculate the features of MPEG7 with different
%length L1, L2, L3, L4

clear all;
close all;
foldername = 'SketchingCS';
datalabel = 'Sketching';
filetype = '.mat';
alldata = dir(fullfile(['..\..\database\Processed\',foldername,'\',foldername,'_PL\'],['*',filetype]));
N = size(alldata,1);

sampercen = 0.25;
samlabel = 'L1';
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
save(['Feature-',datalabel,'-LengthDirection-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.50;
samlabel = 'L2';
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
save(['Feature-',datalabel,'-LengthDirection-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 0.75;
samlabel = 'L3';
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
save(['Feature-',datalabel,'-LengthDirection-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

sampercen = 1;
samlabel = 'L4';
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
save(['Feature-',datalabel,'-LengthDirection-',samlabel,'.mat'],'fullfeatures');
clear fullfeatures;

