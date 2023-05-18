function [ savestring ] = s_run( dataset, mylength )
%s_run: this function is used for triggering the experiment
%input:
%      dataset: 
%             1: Berkeley, 2: Sketching 2: mpeg
%      mylength:
%             1: L1, 2: L2,  3: L3, 4: L4

filetype = '.mat';

if dataset == 1
    foldername = 'BerkeleyCS';
    alldata = dir(fullfile(['../../database/Processed/',foldername,'/',foldername,'_PL/'],['*',filetype]));
    N = size(alldata,1);
    datalebel = 'Berkeley';
end
if dataset == 2
    foldername = 'SketchingCS';
    N = 10;
    datalebel = 'Sketching';
end
if dataset == 3
    foldername = 'MPEG7CS_Small';
    alldata = dir(fullfile(['../../database/Processed/',foldername,'/',foldername,'_PL/'],['*',filetype]));
    N = size(alldata,1);
    datalebel = 'MPEG7';
end

if mylength == 1
    sampercen = 0.25; %percentage of sample length to the original length
    samlabel = 'L1';
end
if mylength == 2
    sampercen = 0.5; %percentage of sample length to the original length
    samlabel = 'L2';
end
if mylength == 3
    sampercen = 0.75; %percentage of sample length to the original length
    samlabel = 'L3';
end
if mylength == 4
    sampercen = 1; %percentage of sample length to the original length
    samlabel = 'L4';
end
 

%---------------------------start matching---------------------------
if dataset == 1 %retrieval for BerkeleyCS dataset
    for i =1:N
        object1 = alldata(i,1).name;
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        display([num2str(i),': ',objectname1]);
        %load the pointlist of CS
        load(['../../database/Processed/',foldername,'/',foldername,'_PL/',object1]);
        pointlist1 = pointlist;
        fullfeatures = 0; %only for temp
        [matchingresult] = f_CS_10_Matching_ContourFlexibility(pointlist1, alldata, filetype, foldername, sampercen, fullfeatures);
        TotalResults{i} = {objectname1,matchingresult};
%         TotalResults{1,1} = query;
%         TotalResults{1,2} = objectname1;
%         TotalResults{1,3} = matchingresult;
%         myfolder = ['resources/Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel];
%         if exist(myfolder, 'dir')
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'-',num2str(query),'.mat'];
%         else
%             mkdir(myfolder);
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'-',num2str(query),'.mat'];
%         end
    end
    save(['resources/Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'],'TotalResults');
    savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'];
end

if dataset == 2 %retrieval for SketchingCS dataset
    [SketchingList] = f_objects_sketching();
    for i = 1:N
        object1 = SketchingList{i,1};
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        display([num2str(i),': ',objectname1]);
        %load the pointlist of CS
        load(['../../database/Processed/',foldername,'/',foldername,'_PL/',object1]);
        pointlist1 = pointlist;
        alldata = SketchingList{i,2};
        fullfeatures = 0; %only for temp
        [matchingresult] = f_CS_10_Matching_ContourFlexibility(pointlist1, alldata, filetype, foldername, sampercen, match, fullfeatures);
        TotalResults{i} = {objectname1,matchingresult};
    end
    save(['resources/Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'],'TotalResults');
    savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'];
end

if dataset == 3 %retrieval for MPEG7CS dataset
%     %first step, calculate the features
%     for i = 1:N
%         myobject = alldata(i,1).name;
%         display(['feature-',num2str(i),': ',myobject]);
%         %load the pointlist of CS
%         load(['..\..\database\Processed\',foldername,'\',foldername,'_PL\',myobject]);
%         pointnum = round(100*sampercen);
%         pointlist = f_sample_Points(pointlist, pointnum);
%         [csfeature] = f_CS_3_Feature_HeightFunction(pointlist);
%         fullfeatures{i} = csfeature;
%     end
    
    %first step: load the features
    if mylength == 1
        load('resources/Feature-MPEG7-ContourFlexibility-L1.mat');
    end
    if mylength == 2
        load('resources/Feature-MPEG7-ContourFlexibility-L2.mat');
    end
    if mylength == 3
        load('resources/Feature-MPEG7-ContourFlexibility-L3.mat');
    end
    if mylength == 4
        load('resources/Feature-MPEG7-ContourFlexibility-L4.mat');
    end
    
    %second step, do the retrieval
    %tic;
    for i =1:N
        object1 = alldata(i,1).name;
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        display([num2str(i),': ',objectname1]);
        pointlist1 = fullfeatures{i};
        [matchingresult] = f_CS_10_Matching_ContourFlexibility(pointlist1, alldata, filetype, foldername, sampercen, fullfeatures);
        TotalResults{i} = {objectname1,matchingresult};
%         TotalResults{1,1} = query;
%         TotalResults{1,2} = objectname1;
%         TotalResults{1,3} = matchingresult;
%         myfolder = ['resources/Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel];
%         if exist(myfolder, 'dir')
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'-',num2str(query),'.mat'];
%         else
%             mkdir(myfolder);
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'-',num2str(query),'.mat'];
%         end
    end
    %toc;
    save(['resources/Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'],'TotalResults');
    savestring = ['Re-RichCS-',datalebel,'-ContourFlexibility-',samlabel,'.mat'];
end

end
